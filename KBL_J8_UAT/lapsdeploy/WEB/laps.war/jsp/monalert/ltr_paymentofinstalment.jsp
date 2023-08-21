<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
HashMap hshComprogeneral=new HashMap();

hshComprogeneral=(HashMap)hshValues.get("hshgeneral");

String strborrowername = Helper.correctNull((String) request
		.getParameter("borrowername"));
String strprocesseddate = Helper.correctNull((String) hshValues.get("processeddate"));
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
				<td align="center"><B><%=Helper.correctNull((String)hshComprogeneral.get("strOrgName"))%></B></td>
			</tr>
			<tr>
				<td align="center">&nbsp;</td>
			</tr>
			<tr>
				<td ALIGN="RIGHT">DATE:<%=strprocesseddate%></td>
			</tr>
			<tr>
				<td align="center"><U><b>&nbsp;</b></U></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td valign="top">TO :<br>
M/s. (<Name & Address of the Borrower>),
Customer I.D. </td>
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
				<td>&nbsp;Dear sir,</td>
			</tr>
			<tr>
				<td align="center"><U><b>&nbsp;Payment of Installments under DPGL </b></U></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>	The installment of Rs._______ (Rupees ______________) for the ________ (period) in respect of DPGL No. _______ issued on your behalf has already fallen due. You are requested to make immediate arrangement for payment of the aforesaid amount immediately along with interest and cost.
	The installment of Rs._______ (Rupees ______________) for the ________ (period) in respect of DPGL No. _______ issued on your behalf is due on ________. You are requested to make immediate arrangement for payment of the aforesaid amount on the due date. </td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thanking you,  </td>
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
								<td WIDTH="49%"><b> </b></td>
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
