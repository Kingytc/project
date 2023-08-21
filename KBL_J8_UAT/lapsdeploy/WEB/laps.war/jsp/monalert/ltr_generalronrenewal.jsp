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
										<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>ãäÌãÓã¾ã : ‚ãã¹ã‡ãŠãñ ÔÌããè‡ãðŠ¦ã ¨ãÉ¥ã ÔãìãäÌã£ãã‚ããò ‡ãŠã ¶ãÌããè‡ãŠÀ¥ã</b></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">‚ãã¹ã‡ãŠãñ ÔÌããè‡ãðŠ¦ã ãä¶ã½¶ããäÊããäŒã¦ã ¨ãÉ¥ã ÔãìãäÌã£ãã‚ããò ‡ãŠã
											<b><%=Helper.correctNull((String)hshValues.get("revdate"))%></b> ½ããÖ ½ãò ¶ãÌããè‡ãŠÀ¥ã ãä‡ãŠ¾ãã •ãã¶ãã Öõ.  </font></td>
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
												<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>‰ãŠ.Ôãâ.</b></font></td>
												<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>¨ãÉ¥ã Ôããè½ãã ‡ãŠã ÔÌãÁ¹ã</b></font></td>
												<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>Á. ÊããŒã ½ãò</b></font></td>
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
                         Ö½ã ‚ãã¹ãÔãñ ‚ã¶ãìÀãñ£ã ‡ãŠÀ¦ãñ Öö ãä‡ãŠ „‡ã‹¦ã ¨ãÉ¥ã 
                          ÔãìãäÌã£ãã‚ããò ‡ãñŠ ¶ãÌããè¶ããè‡ãŠÀ¥ã ‡ãñŠ ãäÊã† ãä¶ã½¶ããäÊããäŒã¦ã 
                          ªÔ¦ããÌãñ•ã ãäª¶ããâ‡ãŠ --------- ‡ãŠãñ ¾ãã „ÔãÔãñ ¹ãÖÊãñ 
                          Ö½ãò ¹ãÆÔ¦ãì¦ã ‡ãŠÀ ªò.
                        <ol>
                          <li> ãä¹ãœÊãñ ÌãÓãÃ ‡ãŠã ÊãñŒãã¹ãÀãèãäàã¦ã ¦ãìÊã¶ã ¹ã¨ã 
                            †Ìãâ „Ôã‡ãñŠ ¶ããñ› ¦ã©ãã ¹ããäÀãäÍãÓ›. </li>
                          <li> ãä¹ãœÊãñ ÌãÓãÃ ‡ãŠã ÊãñŒãã¹ãÀãèãäàã¦ã Êãã¼ã Öããä¶ã 
                            Œãã¦ãã †Ìãâ „Ôã‡ãñŠ ¶ããñ› ¦ã©ãã ¹ããäÀãäÍãÓ›. </li>
                          <li> ãä¹ãœÊãñ ÌãÓãÃ ‡ãŠãè ‚ãã¾ã‡ãŠÀ ãäÀ›¶ãÃ ‡ãŠãè ¹ãÆãä¦ã¾ããâ 
                            (¹ãŠ½ãÃ/‡ãâŠ., ãä¶ãªñÍã‡ãŠ/¼ããØããèªãÀ, ¹ãÆãñ¹ãÆãƒ›À) 
                          </li>
                          <li> Ôãâºã® / ÔãÖã¾ã‡ãŠ ‡ãâŠ¹ããä¶ã¾ããò ‡ãŠã ãä¹ãœÊãñ 
                            ÌãÓãÃ ‡ãŠã ¦ãìÊã¶ã¹ã¨ã †Ìãâ Êãã¼ã Öããä¶ã Œãã¦ãã. </li>
                          <li> Ôããè†½ã† ¡ã›ã. </li>
                          <li> ‚ã¶¾ã ºããäÖ¾ããò / ÔãâãäÌãªã‚ããò ‡ãŠãè ãäÔ©ããä¦ã 
                            / ‚ããªñÍããò ‡ãñŠ Ôããà¾ã (ãä¶ã¾ããÃ¦ã‡ãŠãò ‡ãñŠ ¹ãõãä‡ãâŠØã 
                            ¨ãÉ¥ã / †¹ãŠ¡ãèºããè¹ããè). </li>
                          <li> ãä¹ãœÊãñ ÌãÓãÃ ‡ãŠã ‚ãã¾ã ‡ãŠÀ / ãäºã‰ãŠãè ‡ãŠÀ 
                            ãä¶ã£ããÃÀ¥ã ¹ãÆ½ãã¥ã¹ã¨ã. </li>
                          <li> ‡ãâŠ¹ã¶ããè / ¹ãŠ½ãÃ ‡ãñŠ Ôãã©ã Öãè Ôãã©ã ãä¶ãªñÍã‡ãŠãò 
                            / ¼ããØããèªãÀãò ‡ãŠãè ãäÌããä£ãÌã¦ã ¼ãÀãè ÖìƒÃ ÔããŒã 
                            ÔãîÞã¶ãã. </li>
                          <li> .ÔããâãäÌããä£ã‡ãŠ ‚ãªñ¾ã¦ãã ¹ãÆ½ãã¥ã¹ã¨ã ( ãä•ã¶ã 
                            ¨ãÉãä¥ã¾ããò ¶ãñ ÔãÀ‡ãŠãÀãè †•ãòãäÔã¾ããò / ÔãâÔ©ãã‚ããò 
                            Ôãñ ¼ããè ¨ãÉ¥ã Êãñ ÀŒãã Öõ, „¶Öò Ôãâºãâãä£ã¦ã ÔãâÔ©ãã 
                            Ôãñ ‡ãŠãñƒÃ ‚ããä¦ãªñ¾ã ÀããäÍã ¶ã Öãñ¶ãñ ‡ãŠã ¹ãÆ½ãã¥ã¹ã¨ã 
                            ¹ãÆÔ¦ãì¦ã ‡ãŠÀ¶ãã ÖãñØãã. ) </li>
                          <li> ¹ãÆ½ãìŒã ºãö‡ãŠ ‡ãŠã Ìããâãäœ¦ã ¨ãÉ¥ã ÀããäÍã ãä¶ã£ããÃÀ¥ã 
                            ¶ããñ› (ÔãâÜããè¾ã ¨ãÉ†ã Œãã¦ããò ½ãò). </li>
                          <li> ÔÌããè‡ãðŠ¦ã Íã¦ããô ‡ãñŠ ‚ã¶ãìÔããÀ ºããè½ãã ¹ãããäÊãÔããè. 
                          </li>
                          <li> &THORN;&atilde;&atilde;&Ecirc;&atilde;&icirc; &Igrave;&atilde;&Oacute;&atilde;&Atilde; 
                            <%=salesdate%>  ‡ãñŠ ‚ããÀâ¼ã Ôãñ ‚ãºã ¦ã‡ãŠ ‡ãŠãè ŒãÀãèª-ãäºã‰ãŠãè ‡ãŠã ãäÌãÌãÀ¥ã. </li>
                          <li> ¾ããäª ÌãÓãÃ ‡ãñŠ ªãõÀã¶ã Ô©ãã¾ããè Ôãâ¹ããä¦¦ã¾ããò ½ãò ‡ãŠãñƒÃ ‡ãŠ½ããè / ºãü¤ãñ¦¦ãÀãè ÖìƒÃ Öãñ, ¦ããñ „Ôã‡ãŠãè ÔãîÞã¶ãã.</li>
                        </ol>
                         ãäÌããäÓãÓ› ÔãâÌãØãÃ / àãñ¨ã ´ãÀã ãä¶ã½¶ããäÊããäŒã¦ã ‚ããä¦ããäÀ‡ã‹¦ã •ãã¶ã‡ãŠããäÀ¾ããâ ¹ãÆÔ¦ãì¦ã ‡ãŠãè •ãâã†: 
                        
                        <ol>
                          <li> ãî¥ãÃ †Ìãâ ÞããÊãî ¹ããäÀ¾ãã•ã¶ãã‚ããò ‡ãŠãè ÔãîÞããè (•ã½ããè¶ã-•ãã¾ãªãª ‡ãŠãè ¡ãèãäÊãâØã ‡ãŠÀ¶ãñ ÌããÊãñ Ì¾ãÌãÔãã¾ããè) </li>
                          <li>‚ã¶ãì½ãããä¶ã¦ã ¶ã‡ãŠªãè ‚ããÌãÍ¾ã‡ãŠ¦ãã / ºã•ã› ( •ã½ããè¶ã-•ãã¾ãªãª, Ÿãè‡ãñŠªãÀãè Ì¾ãÌãÔãã¾ã, ‚ããƒÃ›ãè, ãä¹ãŠÊ½ã †Ìãâ Þããè¶ããè ãä½ãÊããò Ôãñ Ôãâºãâãä£ã¦ã ¨ãÉ¥ã ¹ãÆÔ¦ããÌããò ½ãò) 
                          </li>
                          <li> ¼ãããäÀºãö. ‡ãŠã ¹ãâ•ããè¾ã¶ã ( †¶ãºããè†¹ãŠÔããè ‡ãñŠ ½ãã½ãÊãñ ½ãò).</li>
                          <li> •ã¶ã¦ãã Ôãñ ãä¶ããä£ã ÔÌããè‡ãŠãÀ ‡ãŠÀ¶ãñ Ôãâºãâ£ããè ÜããñÓã¥ãã¹ã¨ã (†¶ãºããè†¹ãŠÔããè ‡ãñŠ ½ãã½ãÊãñ ½ãò). </li>
                        </ol>
                        ‡ãðŠ¹ã¾ãã ¶ããñ› ‡ãŠÀò ãä‡ãŠ „¹ãÀ Ìããä¥ãÃ¦ã ÔãîÞã¶ãã‚ããò / ‚ããâ‡ãŠü¡ãò ‡ãŠã ¹ãÆñÓã¥ã ãä¶ã£ããÃãäÀ¦ã ãä¦ããä©ã ‡ãñŠ „¹ãÀãâ¦ã ãä‡ãŠ† •ãã¶ãñ ¹ãÀ ‚ãã¹ã ´ãÀã „¹ã¼ãñØã ‡ãŠãè •ãã ÀÖãè Ôã¼ããè ¨ãÉ¥ã Ôããè½ãã‚ããò ¹ãÀ 1% ‡ãŠãè ªÀ Ôãñ ªããä¥¡‡ãŠ º¾ãã•ã ‡ãŠã ¼ãìØã¦ãã¶ã ºãö‡ãŠ ‡ãŠãñ ‡ãŠÀ¶ãã ÖãñØãã, •ããñ ãä‡ãŠ ‚ãã¹ã‡ãñŠ ½ãã½ãÊãñ ½ãò ÊãØã¼ãØã Á.______________________________ ¹ãÆãä¦ã ½ããÖ Öãñ¦ãã Öõ.
                        </font></td>
									</tr>
									<tr><td>&nbsp;</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">ºãñÖ¦ãÀ ÔãñÌãã‚ããò ‡ãñŠ ‚ããÍÌããÔã¶ã ÔããäÖ¦ã. </font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">£ã¶¾ãÌããª ÔããäÖ¦ã</font></td>
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
