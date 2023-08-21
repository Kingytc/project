<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@page import="java.text.*"%>

<%


HashMap hshComprogeneral=new HashMap();
HashMap hshworkflow=new HashMap();


hshComprogeneral=(HashMap)hshValues.get("hshgeneral");
hshworkflow=(HashMap)hshValues.get("hshworkflow");






String strborrowername = Helper.correctNull((String) request
		.getParameter("borrowername"));
String strprocesseddate = Helper.correctNull((String) hshValues.get("processeddate"));
%>



<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px">
<table width="75%" border="0" class="outertable border1" cellspacing="0" cellpadding="2"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="right">&nbsp;</td>
			</tr>
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"
					width="50" height="35"></td>
			</tr>
			<tr>
				<td align="center"><b>KARNATAKA BANK LTD. </b></td>
			</tr>
			<tr>
				<td align="center"><B><%=Helper.correctNull((String)hshComprogeneral.get("strOrgName"))%></B></td>
			</tr>
			<tr>
				<td align="center">&nbsp;</td>
			</tr>
			<tr>
				<td ALIGN="RIGHT">DATE:<%=strprocesseddate%></td>
			</tr>
			<tr>
				<td align="center"><U><b>WITHOUT PREJUDICE</b></U></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td valign="top">To,</td>
			</tr>
			<tr>
				<td><%=strborrowername%></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Sub:Your OTS offer of Rs.<%=Helper.correctNull((String)hshComprogeneral.get("compro_otsamount"))%> for settlement of
				Bank's dues</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>We refer to your letter on the subject expressing your
				willingness to settle the account and your offer of Rs.<%=Helper.correctNull((String)hshComprogeneral.get("compro_otsamount"))%> as
				OTS amount for the said settlement</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;While we
						appreciate your coming forward with a OTS offer of settlement, we
						find that the offer made by you is on the lower side. If you can
						offer a minimum of around Rs.<%=Helper.correctNull((String)hshComprogeneral.get("compro_counteramount"))%>,we can take up your proposal
						for consideration, as per rules and procedures of the Bank..</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please note
						that this letter should not be treated as an offer on the part of
						the Bank to settle dues against payment of the indicated
						amount.The same is only a suggestion from our level to enable us
						to put up your proposal to the competent authority to consider the
						same.</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This letter is
						also without prejudice to the rights and contentions of the Bank
						in any pending proceedings or otherwise.</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We request you
						to submit your respose within a week's time to enable us to
						process the same. This counter offer is valid for a week's time
						only.</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><u></u></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td WIDTH="49%">&nbsp;</td>
								<td WIDTH="51%" align="center">Yours faithfully,</td>
							</tr>
							<tr align="center">
								<td WIDTH="49%"><b>REGIONAL HEAD </b></td>
								<td WIDTH="51%"><b>BRANCH MANAGER</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
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
