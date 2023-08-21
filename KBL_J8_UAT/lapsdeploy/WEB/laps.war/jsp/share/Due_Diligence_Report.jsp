
<%@include file="../share/directives.jsp"%>
<html>
<head>
<%
	String strvargua = Helper.correctNull((String) hshValues
			.get("DD_G_DEMOTYPE"));
	String strvarcob = Helper.correctNull((String) hshValues
			.get("DD_O_DEMOTYPE"));
	String strappbank = Helper.correctNull((String) hshValues
			.get("appbank"));

	ArrayList arrrow = (ArrayList) hshValues.get("arrKYCDet");
	ArrayList arrcol = new ArrayList();

	ArrayList arrrow2 = (ArrayList) hshValues.get("arrVerifiDet");
	ArrayList arrcol2 = new ArrayList();

	ArrayList arrrow3 = (ArrayList) hshValues
			.get("arrConstDet");
	ArrayList arrcol3 = new ArrayList();
	ArrayList arrPropDet = (ArrayList) hshValues.get("arrPropDet");
	ArrayList arrVehDet = (ArrayList) hshValues.get("arrVehDet");
	String strAmountForm=Helper.correctNull((String)request.getParameter("strAmountVal"));
	String strAmountVal="Rs.";
	if(strAmountForm.equalsIgnoreCase("L"))
		strAmountVal="Lakhs";
	else if(strAmountForm.equalsIgnoreCase("C"))
		strAmountVal="Crores";
%>
<title>Due Diligence Report</title>
<script>
var varphyinsp="<%=Helper.correctNull((String) hshValues.get("phyinsp"))%>";
var  varpartship="<%=Helper.correctNull((String) hshValues.get("partship"))%>";
var vartrust="<%=Helper.correctNull((String) hshValues.get("trust"))%>"
var varfno="<%=Helper.correctNull((String) hshValues.get("fno"))%>";
var vargua="<%=Helper.correctNull((String) hshValues
							.get("DD_G_DEMOTYPE"))%>";
var varcob="<%=Helper.correctNull((String) hshValues
							.get("DD_O_DEMOTYPE"))%>";
var url="<%=ApplicationParams.getAppUrl()%>";
</script>
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
</head>

<body>
<form>
<table width="98%" border="0" cellpadding="3" cellspacing="0"
			align="center" class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellpadding="3" cellspacing="0"
			align="center" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
						<td align="center" colspan="4"><br>
						<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
					</tr>
					<tr>
					<td align="center" colspan="4"><b>Due Diligence Report for Schematic loans</b></td>
					</tr>

				</table>
				</td>
			</tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;(A)
				KYC COMPLIANCE :</span></b> <span style="float:right;">&nbsp;&nbsp;(Mandatory for all Applicants)</span></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr>
						<th align="center"><b>S.No.</b></th>
						<th align="center"><b>Name and address of the
						Applicant/s, Co-obligant/s/ Guarantor/s</b></th>
						<th align="center"><b>Constitution*</b></th>
						<th align="center"><b>Cust. ID(UCIC)</b></th>
						<th align="center"><b>CIBIL Score**</b></th>
						<th align="center"><b>Aadhaar Number</b></th>
						<th align="center"><b>PAN Number</b></th>
					</tr>

					<%
						if (arrrow.size() > 0 && arrrow != null) {

							for (int i = 0; i < arrrow.size(); i++) {
								arrcol = (ArrayList) arrrow.get(i);

								String demotype = Helper.correctNull((String) arrcol
										.get(13));
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
								else
									demotype="&nbsp;";
					%>
					<tr>
						<td colspan="7"><b><%=demotype%> </b> <%=Helper.correctNull((String) arrcol.get(0))%></td>
					</tr>
					<tr>
						<td valign="top">1. &nbsp;</td>
						<td><%=Helper.correctNull((String) arrcol.get(1))%>,<%=Helper.correctNull((String) arrcol.get(2))%>
						<br>
						<%=Helper.correctNull((String) arrcol.get(3))%>,<%=Helper.correctNull((String) arrcol.get(4))%>
						<br>
						<br>
						<%if(!Helper.correctNull((String) arrcol.get(5)).equalsIgnoreCase("")){%> 
						Phone :<%=Helper.correctNull((String) arrcol.get(5))%> <br>
						<%} %>
						<%if(!Helper.correctNull((String) arrcol.get(7)).equalsIgnoreCase("")){%> 
						Mobile :<%=Helper.correctNull((String) arrcol.get(7))%> <br>
						<%} %>
						<%if(!Helper.correctNull((String) arrcol.get(6)).equalsIgnoreCase("")){%> 
						Email ID: <%=Helper.correctNull((String) arrcol.get(6))%>&nbsp;</td>
						<%} %>
						<td><%=Helper.correctNull((String) arrcol.get(8))%> &nbsp;</td>
						<td><%=Helper.correctNull((String) arrcol.get(9))%> &nbsp;</td>
						<td><%=Helper.correctNull((String) arrcol.get(10))%> &nbsp;</td>
						<td><%=Helper.correctNull((String) arrcol.get(11))%> &nbsp;</td>
						<td><%=Helper.correctNull((String) arrcol.get(12))%> &nbsp;</td>
					</tr>
					<tr>
					<td colspan="7">* Should be supported by photostat copy of partnership deed/Certificate of Incorporation/ Trust Registration certificate/Affidavit from Karta etc., as required to be obtained and verified with original in case of non individuals for certification by Branch Head.</td>
					</tr>
					<tr>
						<td>2.</td>
						<td>Applicant banking with us since &amp; Conduct of the
						account</td>
						<td colspan="5"><%=Helper.correctNull((String) arrcol.get(14))%>
						<%if(!Helper.correctNull((String) arrcol.get(14)).equalsIgnoreCase("")){ %>
						 <%=Helper.correctNull((String) arrcol.get(15)).replace("2013","")%> 
						<%} %>
						&nbsp;</td>
					</tr>
					<tr>
						<td>3.</td>
						<td colspan="6"><b>Particulars of the Introducer</b></td>
					</tr>
					<tr>
						<td>a.</td>
						<td>Name of the introducer &amp; Customer ID</td>
						<td colspan="5"><%=Helper.correctNull((String) arrcol.get(16))%> 
						<%if(!Helper.correctNull((String) arrcol.get(21)).equalsIgnoreCase("")){%>
						- <%=Helper.correctNull((String) arrcol.get(21)) %>
						<%} %>
						&nbsp;</td>
					</tr>
					<tr>
					<tr>
						<td>b.</td>
						<td>Since banking with us</td>
						<td colspan="5"><%=Helper.correctNull((String) arrcol.get(17))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>c.</td>
						<td>Conduct of the account</td>
						<td colspan="5"><%=Helper.correctNull((String) arrcol.get(18))%>
						&nbsp;</td>
					<tr>
						<td>d.</td>
						<td>If not account holder, reputation/status of introducer
						in Society</td>
						<td colspan="5"><%=Helper.correctNull((String) arrcol.get(19))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>e.</td>
						<td>Self introduced with relevant documents</td>
						<td colspan="5"><%=Helper.correctNull((String) arrcol.get(20))%>
						&nbsp;</td>
					</tr>

					<%
						}
						}
					%>
				</table>
				** non mandatory  
				</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;(B)
				RE-VERIFICATION OF PERSONAL DETAILS :</span></b> <span style="float:right;">&nbsp;&nbsp;(Mandatory for all Applicants)</span></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">

					<%
						if (arrrow2 != null && arrrow2.size() > 0) {
							for (int i = 0; i < arrrow2.size(); i++) {
								arrcol2 = (ArrayList) arrrow2.get(i);

								String demotype = Helper.correctNull((String) arrcol2
										.get(1));
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
								else
									demotype="&nbsp;";
					%>

					<tr>
						<td colspan="6"><b><%=demotype%> </b> <%=Helper.correctNull((String) arrcol2.get(0))%></td>
					</tr>
					<tr>
						<td width="5%">1.</td>
						<td width="38%">Whether physical inspection of address of
						residence/unit is done **</td>
						<td width="50%" colspan="4">
						<%
							if (Helper.correctNull((String) arrcol2.get(2)).equals("Y")) {
						%> Yes
						<%
							} else {
						%> No <%
							}
						%>
						</td>
					</tr>
					<%
						if (Helper.correctNull((String) arrcol2.get(2)).equals("Y")) {
					%>
					<tr>
						<td>a.</td>
						<td>Name of the official who has confirmed the address by
						physical verification **</td>
						<td colspan="4">Name: <%=Helper.correctNull((String) arrcol2.get(4))%>
						<br>
						Designation: <%=Helper.correctNull((String) arrcol2.get(5))%>
						&nbsp;</td>
					</tr>
					<%
						} else {
					%>
					<tr>
						<td>a.</td>
						<td>Reason for not physically verifying the address to be
						justified **</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol2.get(6))%>
						&nbsp;</td>
					</tr>
					<%
						}
					%>
					<tr>
					<td colspan="6">** Mandatory for empanelled Agency </td>
					</tr>
					<tr>
						<td>2.</td>
						<td align="center"><b>Document&nbsp; </b></td>
						<td colspan="2" width="5%" align="center"><b> Number</b></td>
						<td width="15%" align="center"><b>Expiry date</b></td>
						<td width="15%" align="center"><b>Issued at (Place) </b></td>
					</tr>
					<%
						String[] strtemp = Helper.correctNull(
										(String) arrcol2.get(7)).split("@");
					%>
					<tr>
						<td>i.</td>
						<td>Passport</td>
						<%
							if (strtemp.length > 2) {
						%>
						<td colspan="2"><%=strtemp[0]%> &nbsp;</td>
						<td><%=strtemp[1]%> &nbsp;</td>
						<td><%=strtemp[2]%> &nbsp;</td>
						<%
							} else {
						%>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%
							}
						%>
					</tr>
					<%
						strtemp = Helper.correctNull((String) arrcol2.get(8))
										.split("@");
					%>
					<tr>
						<td>ii.</td>
						<td>Driving Licence</td>
						<%
							if (strtemp.length > 2) {
						%>
						<td colspan="2"><%=strtemp[0]%> &nbsp;</td>
						<td><%=strtemp[1]%> &nbsp;</td>
						<td><%=strtemp[2]%> &nbsp;</td>
						<%
							} else {
						%>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%
							}
						%>
					</tr>
					<%
						strtemp = Helper.correctNull((String) arrcol2.get(9))
										.split("@");
					%>
					<tr>
						<td>iii.</td>
						<td>Election Card</td>
						<%
							if (strtemp.length > 2) {
						%>
						<td colspan="2"><%=strtemp[0]%> &nbsp;</td>
						<td><%=strtemp[1]%> &nbsp;</td>
						<td><%=strtemp[2]%> &nbsp;</td>
						<%
							} else {
						%>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%
							}
						%>
					</tr>
					<tr>
						<td>iv.</td>
						<td>Other Valid Documents</td>
						<td colspan="4">&nbsp;</td>
					</tr>
					<%
						strtemp = Helper.correctNull((String) arrcol2.get(10))
										.split("@");
					%>
					<%
							if (strtemp.length > 3) {
						%>
					<tr>
						<td>a.&nbsp;</td>
						
						<td><%=strtemp[0]%> &nbsp;</td>
						<td colspan="2"><%=strtemp[1]%> &nbsp;</td>
						<td><%=strtemp[2]%> &nbsp;</td>
						<td><%=strtemp[3]%> &nbsp;</td>
					</tr>
						<%
							}
						%>
						
					<%
						strtemp = Helper.correctNull((String) arrcol2.get(11))
										.split("@");
					%>
					<%
							if (strtemp.length > 3) {
						%>
					<tr>
						<td>b. &nbsp;</td>
						
						<td><%=strtemp[0]%> &nbsp;</td>
						<td colspan="2"><%=strtemp[1]%> &nbsp;</td>
						<td><%=strtemp[2]%> &nbsp;</td>
						<td><%=strtemp[3]%> &nbsp;</td>
					</tr>
						<%
							}
						%>
					<%
						strtemp = Helper.correctNull((String) arrcol2.get(12))
										.split("@");
					%>
					<%
							if (strtemp.length > 3) {
						%>
					<tr>
						<td>c.&nbsp;</td>
						
						<td><%=strtemp[0]%> &nbsp;</td>
						<td colspan="2"><%=strtemp[1]%> &nbsp;</td>
						<td><%=strtemp[2]%> &nbsp;</td>
						<td><%=strtemp[3]%> &nbsp;</td>
					</tr>
						<%
							}
						%>
					<tr>
					<td colspan="6">Note : Particulars of the document furnished by the applicant need to be verified with the Original. </td>
					</tr>

					<tr>
						<td>3.</td>
						<td>Residing in</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol2
											.get(13))%>&nbsp;
						</td>
					</tr>
					<tr>
						<td>4.</td>
						<td>Residing in the above address since</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol2
											.get(14))%>
						&nbsp; Years</td>
					</tr>
					<tr>
						<td>5.</td>
						<td>If applicant is residing for less than one year, details of residence to be mentioned.</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol2
											.get(15))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>6.</td>
						<td>Name of the branch nearest to the residence of the
						applicant</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol2
											.get(16))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td rowspan="2">7.</td>
						<td rowspan="2">Additional documents obtained duly verified
						with the originals as a proof of present residence</td>
						<td colspan="2">PARTICULARS &nbsp;</td>
						<td colspan="2">DATE OF DOCUMENT &nbsp;</td>
					</tr>
					<tr>
						<td colspan="2"><%=Helper.correctNull((String) arrcol2
											.get(17))%>
						&nbsp;</td>
						<td colspan="2"><%=Helper.correctNull((String) arrcol2
											.get(18))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>8.</td>
						<td>Name of the official with staff number who has complied
						with KYC at the time of opening the operative account of the
						applicant</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol2
											.get(19))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>9.</td>
						<td  colspan="5"><span style="float: left;">Present Bankers:</span><span style="float: right"><b>(Amount in <%=strAmountVal %>)</b></span><br/><br/>
						<div id="top">
						<table width="100%" border="0" align="center" cellpadding="3"
							cellspacing="0" class="outertable">
							<tr align="center" valign="top">
								<td width="2%" rowspan="2">Sl.no</td>
								<td width="7%" rowspan="2">Bank Name</td>
								<td width="7%" rowspan="2">Bank Address</td>
								<td width="7%" rowspan="2">Banking since</td>
								<td width="7%" colspan="2" rowspan="2">Statement of account verified (Financial Year)</td>
								<td width="7%" rowspan="2">Number of cheque returns during FY #</td>
								<td width="14%" colspan="2">If SB/Current account (in previous 12 months) #</td>
							</tr>
							<tr valign="top">
							<td>Maximum Balance</td>
							<td>Minimum Balance</td>
							</tr>
							<tr align="center" valign="top">
								<td width="2%">&nbsp;</td>
								<td width="7%">Total credit turnover in the account#</td>
								<td width="7%">Difference in sales and credit turnover in
								the account#</td>
								<td width="14%" colspan="2">Reasons for more than 10% variation (If
								applicable)#</td>
								<td width="7%">Whether confidential report obtained in case
								of takeover</td>
								<td width="7%">Date of confidential report obtained from
								above bank</td>
								<td width="14%" colspan="2">Reasons for not obtaining confidential
								opinion</td>
							</tr>

							<%
								if (!((String) arrcol2.get(20)).equals("")) {

											if (((String) arrcol2.get(20)).contains("@")) {
												String[] strbankname = ((String) arrcol2.get(20))
														.split("@");
												String[] DDR_PRESBANK_ADDRESS = ((String) arrcol2
														.get(21)).split("@");
												String[] DDR_PRESBANK_BANKSINCE = ((String) arrcol2
														.get(22)).split("@");
												String[] DDR_PRESBANK_ACCVER_FROM = ((String) arrcol2
														.get(23)).split("@");
												String[] DDR_PRESBANK_ACCVER_TO = ((String) arrcol2
														.get(24)).split("@");
												String[] DDR_PRESBANK_CHEQUERETURN = ((String) arrcol2
														.get(25)).split("@");
												String[] DDR_PRESBANK_MAXBAL = ((String) arrcol2
														.get(26)).split("@");
												String[] DDR_PRESBANK_MINBAL = ((String) arrcol2
														.get(27)).split("@");
												String[] DDR_PRESBANK_TOTCTO = ((String) arrcol2
														.get(28)).split("@");
												String[] DDR_PRESBANK_DIFINSALES = ((String) arrcol2
														.get(29)).split("@");
												String[] DDR_PRESBANK_VARIATIONRSN = ((String) arrcol2
														.get(30)).split("@");
												String[] DDR_PRESBANK_WHT_CONFREPOBT = ((String) arrcol2
														.get(31)).split("@");
												String[] DDR_PRESBANK_CONFREPDATE = ((String) arrcol2
														.get(32)).split("@");
												String[] DDR_PRESBANK_RSN_CONFREPOBT = ((String) arrcol2
														.get(33)).split("@");

												for (int j = 0; j < strbankname.length; j++) {
							%>
							<tr align="center">
								<td width="2%"><%=j + 1%> &nbsp; &nbsp;</td>
								<td width="7%"><%=strbankname[j]%>&nbsp;</td>
								<%if(DDR_PRESBANK_ADDRESS.length>j){ %>
								<td width="7%"><%=DDR_PRESBANK_ADDRESS[j]%> &nbsp;</td>
								<%}else{ %>
								<td width="7%"> &nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_BANKSINCE.length>j){ %>
								<td width="7%"><%=DDR_PRESBANK_BANKSINCE[j]%>&nbsp;</td>
								<%}else{ %>
								<td width="7%"> &nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_ACCVER_FROM.length>j){ %>
								<td width="7%"><%=DDR_PRESBANK_ACCVER_FROM[j]%>
								&nbsp;</td>
								<%}else{ %>
								<td width="7%"> &nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_ACCVER_TO.length>j){ %>
								<td width="7%"><%=DDR_PRESBANK_ACCVER_TO[j]%>
								&nbsp;</td>
								<%}else{ %>
								<td width="7%"> &nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_CHEQUERETURN.length>j){ %>
								<td width="7%"><%=DDR_PRESBANK_CHEQUERETURN[j]%>&nbsp;</td>
								<%}else{ %>
								<td width="7%"> &nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_MAXBAL.length>j){ %>
								<td width="7%" align="right"><%=Helper.converAmount(Helper.correctDouble(DDR_PRESBANK_MAXBAL[j]),strAmountForm)%>&nbsp;</td>
								<%}else{ %>
								<td width="7%" align="right"> 0.00&nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_MINBAL.length>j){ %>
								<td width="7%" align="right"><%=Helper.converAmount(Helper.correctDouble(DDR_PRESBANK_MINBAL[j]),strAmountForm)%>&nbsp;</td>
								<%}else{ %>
								<td width="7%" align="right"> 0.00&nbsp;</td>
								<%} %>
							</tr>
							<tr align="center">
								<td width="2%">&nbsp;</td>
								<%if(DDR_PRESBANK_TOTCTO.length>j){ %>
								<td width="7%" align="right"><%=Helper.converAmount(Helper.correctDouble(DDR_PRESBANK_TOTCTO[j]),strAmountForm)%>&nbsp;</td>
								<%}else{ %>
								<td width="7%" align="right"> 0.00&nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_DIFINSALES.length>j){ %>
								<td width="7%" align="right"><%=Helper.converAmount(Helper.correctDouble(DDR_PRESBANK_DIFINSALES[j]),strAmountForm)%> &nbsp;</td>
								<%}else{ %>
								<td width="7%" align="right"> 0.00&nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_VARIATIONRSN.length>j){ %>
								<td width="14%" colspan="2"><%=DDR_PRESBANK_VARIATIONRSN[j]%> &nbsp;</td>
								<%}else{ %>
								<td width="14%" colspan="2"> &nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_WHT_CONFREPOBT.length>j){ %>
								<td width="7%">
								<%
									if (DDR_PRESBANK_WHT_CONFREPOBT[j].equals("Y")) {
								%> Yes <%
									} else {
								%>
								No <%
									}
								%> &nbsp;</td>
								<%}else{ %>
								<td width="7%"> &nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_CONFREPDATE.length>j){ %>
								<td width="7%"><%=DDR_PRESBANK_CONFREPDATE[j]%> &nbsp;</td>
								<%}else{ %>
								<td width="7%"> &nbsp;</td>
								<%} %>
								<%if(DDR_PRESBANK_RSN_CONFREPOBT.length>j){ %>
								<td width="7%" colspan="2"><%=DDR_PRESBANK_RSN_CONFREPOBT[j]%> &nbsp;</td>
								<%}else{ %>
								<td width="7%" colspan="2"> &nbsp;</td>
								<%} %>
							</tr>
							<%
								}
											} else {
												String strbankname = ((String) arrcol2.get(20));
												String DDR_PRESBANK_ADDRESS = ((String) arrcol2
														.get(21));
												String DDR_PRESBANK_BANKSINCE = ((String) arrcol2
														.get(22));
												String DDR_PRESBANK_ACCVER_FROM = ((String) arrcol2
														.get(23));
												String DDR_PRESBANK_ACCVER_TO = ((String) arrcol2
														.get(24));
												String DDR_PRESBANK_CHEQUERETURN = ((String) arrcol2
														.get(25));
												String DDR_PRESBANK_MAXBAL = ((String) arrcol2
														.get(26));
												String DDR_PRESBANK_MINBAL = ((String) arrcol2
														.get(27));
												String DDR_PRESBANK_TOTCTO = ((String) arrcol2
														.get(28));
												String DDR_PRESBANK_DIFINSALES = ((String) arrcol2
														.get(29));
												String DDR_PRESBANK_VARIATIONRSN = ((String) arrcol2
														.get(30));
												String DDR_PRESBANK_WHT_CONFREPOBT = ((String) arrcol2
														.get(31));
												String DDR_PRESBANK_CONFREPDATE = ((String) arrcol2
														.get(32));
												String DDR_PRESBANK_RSN_CONFREPOBT = ((String) arrcol2
														.get(33));
							%>
							<tr align="center">
								<td width="2%">1. &nbsp;</td>
								<td width="7%"><%=strbankname%>&nbsp;</td>
								<td width="7%"><%=DDR_PRESBANK_ADDRESS%> &nbsp;</td>
								<td width="7%"><%=DDR_PRESBANK_BANKSINCE%>&nbsp;</td>
								<td width="7%"><%=DDR_PRESBANK_ACCVER_FROM%>&nbsp;</td>
								<td width="7%"> <%=DDR_PRESBANK_ACCVER_TO%> &nbsp;</td>
								<td width="7%"><%=DDR_PRESBANK_CHEQUERETURN%></td>
								<td width="7%"><%=Helper.converAmount(Helper.correctDouble(DDR_PRESBANK_MAXBAL),strAmountForm)%>&nbsp;</td>
								<td width="7%"><%=Helper.converAmount(Helper.correctDouble(DDR_PRESBANK_MINBAL),strAmountForm)%>&nbsp;</td>
							</tr>
							<tr align="center">
								<td width="2%">&nbsp;</td>
								<td width="7%"><%=Helper.converAmount(Helper.correctDouble(DDR_PRESBANK_TOTCTO),strAmountForm)%>&nbsp;</td>
								<td width="7%"><%=Helper.converAmount(Helper.correctDouble(DDR_PRESBANK_DIFINSALES),strAmountForm)%> &nbsp;</td>
								<td width="14%" colspan="2"><%=DDR_PRESBANK_VARIATIONRSN%> &nbsp;</td>
								<td width="7%">
								<%
									if (DDR_PRESBANK_WHT_CONFREPOBT.equals("Y")) {
								%> Yes <%
									} else {
								%>
								No <%
									}
								%> &nbsp;</td>
								<td width="7%"><%=DDR_PRESBANK_CONFREPDATE%> &nbsp;</td>
								<td width="7%" colspan="2"><%=DDR_PRESBANK_RSN_CONFREPOBT%> &nbsp;</td>
							</tr>

							<%
								}
							%>
							<%
								} else {
							%>
							<tr>
								<td colspan="9" align="center">- Nil -&nbsp;</td>
							</tr>
							<%
								}
							%>
							<tr>
							<td colspan="9"># Mandatory for MSE clients, if the applicant has operative account with other Bank.</td>
							</tr>
						</table></div>
						</td>
					</tr>
					<%
						}
						}
					%>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp; C.
				CONSTITUTION DETAILS :</span></b></td>
			</tr>
			<%boolean bflag1=true;
			boolean bflag=true;
			if (arrrow3 != null && arrrow3.size() > 0) {

				for (int i = 0; i < arrrow3.size(); i++) {
					arrcol3 = (ArrayList) arrrow3.get(i);
					if(Helper.correctNull((String)arrcol3.get(33)).equalsIgnoreCase("P")){
			%>
			<%if(bflag){
				bflag=false;
				bflag1=false;%>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp; I.
				Partnership/LLPs: </span><span style="float: right;">&nbsp;&nbsp; (Mandatory for all partnership firms)</span></b></td>
			</tr>
			<%} %>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">

					<%
						

								String demotype = Helper.correctNull((String) arrcol3
										.get(1));
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
								else
									demotype="&nbsp;";
					%>
					<tr>
						<td colspan="6"><b><%=demotype%> </b>  <%=Helper.correctNull((String) arrcol3.get(0))%></td>
					</tr>
					<tr>
						<td width="5%">1.</td>
						<td>Partnership</td>
						<td colspan="4">
						<%
							if (Helper.correctNull((String) arrcol3.get(2)).equals("R")) {
						%>
						Registered <br>
						Registration No. : <%=Helper.correctNull((String) arrcol3.get(36))%>
						<%
							} else if (Helper.correctNull((String) arrcol3.get(2))
											.equals("U")) {
						%>
						Un-Registered <%
							}
						%> &nbsp;</td>
					</tr>
					<tr>
						<td>2.</td>
						<td>Latest Partnership Deed dated</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3.get(3))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>3.</td>
						<td colspan="5">We confirm the names of the partners stated
						in partnership deed are matching with the names of partners stated
						in application.</td>
					</tr>

					
				</table>
				</td>
			</tr>
			
			<tr>
				<td>Note: The original deed, certificate to be verified.&nbsp;</td>
			</tr>
			<%
						}
						}
			}
			bflag=true;
			if (arrrow3 != null && arrrow3.size() > 0) {

				for (int i = 0; i < arrrow3.size(); i++) {
					arrcol3 = (ArrayList) arrrow3.get(i);	
					if(Helper.correctNull((String)arrcol3.get(33)).equalsIgnoreCase("C")){%>
			
			<%if(bflag){
				bflag=false;
				bflag1=false;%>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp; II.
				Company/Corporate: </span></b></td>
			</tr>
			<%} %>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">

					<%
						

								String demotype = (String) arrcol3.get(1);
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
								else
									demotype="&nbsp;";
					%>
					<tr>
						<td colspan="6"><b><%=demotype%> </b>  <%=Helper.correctNull((String) arrcol3.get(0))%></td>
					</tr>
					<tr>
						<td width="5%">1.</td>
						<td width="38%">The CIN No. of the company</td>
						<td width="50%"><%=Helper.correctNull((String) arrcol3.get(4))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td width="5%">2.</td>
						<td width="38%">Latest search report dated</td>
						<td width="50%"><%=Helper.correctNull((String) arrcol3.get(5))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td width="5%">3.</td>
						<td width="38%">The charge on assets of the company observed
						</td>
						<td width="50%">
						<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr align="center">
					<td width="30%">Name of the assets&nbsp;</td>
					<td width="30%">Charge Holder&nbsp;</td>
					<td width="30%">Date of Charge&nbsp;</td>
					</tr>
						<%ArrayList arrCol1=(ArrayList)arrcol3.get(35);
						if(arrCol1!=null && arrCol1.size()>0){
						for(int a=0;a<arrCol1.size();a++){
						ArrayList arrcol5=(ArrayList)arrCol1.get(a);%>
						<tr>
						<td><%=Helper.correctNull((String)arrcol5.get(0)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrcol5.get(1)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrcol5.get(2)) %>&nbsp;</td>
						</tr>
						
						<%}}else{ %>
						<tr>
						<td colspan="3"></td>
						</tr>
						<%} %>
						</table>
						&nbsp;</td>
					</tr>
					<tr>
						<td width="5%">4.</td>
						<td width="38%">Capital as per search report</td>
						<td width="50%">(a)Authorised Capital: (<%=strAmountVal%>) &nbsp;<%=Helper.converAmount(Helper.correctDouble((String) arrcol3.get(6)),strAmountForm)%> 
						<br>
						(b)Paid up Capital: (<%=strAmountVal%>)&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) arrcol3.get(7)),strAmountForm)%>
						&nbsp;</td>
					</tr>
					<tr>
						<td width="5%">5.</td>
						<td width="38%">Name of the directors as per search report</td>
						<td width="50%"><%=Helper.correctNull((String) arrcol3
											.get(10))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td colspan="6">Note: Name of Directors as per search report
						and as given by the Company should be similar. Any change in the
						Directors shall be supported by valid documents.</td>
					</tr>
					<tr>
						<td width="5%">6.</td>
						<td width="38%">MOA/AOA - Powers to borrow by the company &
						to mortgage the asset verified</td>
						<td width="50%">
						<%
							if (Helper.correctNull((String) arrcol3.get(8)).equals("Y")) {
						%>
						Yes <%
							} else {
						%> No <%
							}
						%> &nbsp;</td>
					</tr>
					<%
						if (Helper.correctNull((String) arrcol3.get(8)).equals("N")) {
					%>
					<tr>
						<td width="5%">7.</td>
						<td width="38%">Amended MOA/AOA need to be submitted</td>
						<td width="50%"><%=Helper.correctNull((String) arrcol3.get(9))%>
						&nbsp;</td>
					</tr>
					<%
						}
					%>
					
				</table>
				</td>
			</tr>
			<%
						}
						}
			}
					%>
					
			<%bflag=true;
			if (arrrow3 != null && arrrow3.size() > 0) {

				for (int i = 0; i < arrrow3.size(); i++) {
					arrcol3 = (ArrayList) arrrow3.get(i);
					if(Helper.correctNull((String)arrcol3.get(33)).equalsIgnoreCase("T")||Helper.correctNull((String)arrcol3.get(33)).equalsIgnoreCase("H")){
			if(bflag){
				bflag=false;
				bflag1=false;%>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp; III.
				TRUST/HUF: </span><span style="float: right;">&nbsp;&nbsp; (Mandatory for all Trust/HUF)</span></b></td>
			</tr>
			<%} %>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">

					<%
								String demotype = Helper.correctNull((String) arrcol3
										.get(1));
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
								else
									demotype="&nbsp;";
					%>
					<tr>
						<td colspan="6"><b><%=demotype%> </b> <%=Helper.correctNull((String) arrcol3.get(0))%></td>
					</tr>
					<%if(Helper.correctNull((String)arrcol3.get(33)).equalsIgnoreCase("T")){ %>
					<tr>
						<td width="5%">1.</td>
						<td width="38%">Trust deed dated</td>
						<td width="50%" colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(11))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>2.</td>
						<td>Trust type</td>
						<td colspan="4">
						<%
							if (Helper.correctNull((String) arrcol3.get(12)).equals("R")) {
						%>
						Registered Trust <%
							} else if (Helper.correctNull((String) arrcol3.get(12))
											.equals("U")) {
						%>
						Un-Registered Trust <%
							}
						%>&nbsp;
					</tr>
					<tr>
						<td>3.</td>
						<td>Permission ref number for opening trust account (in case
						SB/Current account is already opened)</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(13))%>
						&nbsp;</td>
					</tr>
					<%}else{ %>

					<tr>
						<td>1.</td>
						<td>In case of HUF:</td>
						<td colspan="4">
						&nbsp;</td>
					</tr>
					<tr>
						<td>a.</td>
						<td>Karta Details</td>
						<td colspan="4">
						<table width="100%" border="0" align="center" cellpadding="3"
							cellspacing="0" class="outertable border1">
							<tr>
								<td>Karta Name</td>
								<td>Customer ID</td>
								<td>PAN Number@</td>
								<td>Aadhar No@</td>
							</tr>
							<%
								ArrayList arrtemp = (ArrayList) arrcol3.get(14);
										ArrayList arrcoltemp = new ArrayList();
										if (arrtemp.size() > 0 && arrtemp != null) {
											for (int l = 0; l < arrtemp.size(); l++) {

												arrcoltemp = (ArrayList) arrtemp.get(l);
							%>
							<tr>
								<td><%=Helper.correctNull((String) arrcoltemp
											.get(0))%>&nbsp;</td>
								<td><%=Helper.correctNull((String) arrcoltemp
											.get(1))%>&nbsp;</td>
								<td><%=Helper.correctNull((String) arrcoltemp
											.get(2))%>&nbsp;</td>
								<td><%=Helper.correctNull((String) arrcoltemp
											.get(3))%>&nbsp;</td>
							</tr>
							<%
								}
										} else {
							%>
							<tr>
								<td colspan="4" align="center">- Nil -&nbsp;</td>
							</tr>
							<%
								}
							%>

						</table>
						</td>
					</tr>
					<tr>
						<td>b.</td>
						<td>Other Member/s of HUF@</td>
						<td colspan="4">
						<table width="100%" border="0" align="center" cellpadding="3"
							cellspacing="0" class="outertable border1">
							<tr>
								<td>Member Name</td>
								<td>Customer ID</td>
								<td>PAN Number</td>
								<td>Aadhar No</td>
							</tr>
							<%
								ArrayList arrtemp2 = (ArrayList) arrcol3.get(15);
										ArrayList arrcoltemp2 = new ArrayList();
										if (arrtemp2.size() > 0 && arrtemp2 != null) {
											for (int l = 0; l < arrtemp2.size(); l++) {

												arrcoltemp2 = (ArrayList) arrtemp2.get(l);
							%>
							<tr>
								<td><%=Helper.correctNull((String) arrcoltemp2
											.get(0))%>&nbsp;</td>
								<td><%=Helper.correctNull((String) arrcoltemp2
											.get(1))%>&nbsp;</td>
								<td><%=Helper.correctNull((String) arrcoltemp2
											.get(2))%>&nbsp;</td>
								<td><%=Helper.correctNull((String) arrcoltemp2
											.get(3))%>&nbsp;</td>
							</tr>
							<%
								}
										} else {
							%>
							<tr>
								<td colspan="4" align="center">- Nil -&nbsp;</td>
							</tr>
							<%
								}
							%>
						</table>
						</td>
					</tr>
					<tr>
					<td colspan="6">@ Non Mandatory for other Members</td>
					</tr>
				<%} %>
					
				</table>
				</td>
			</tr>
			<%
						}
						}
			}
					%>
					<%if(bflag1){ %>
					<tr>
				<td align="center">- Nil -&nbsp;</td>
			</tr>
					<%} %>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp; D.
				INCOME VERIFICATION :</span><span style="float: right;">&nbsp;&nbsp; (mandatory for all applicants)</span></b></td>
			</tr>
			<tr>
			<td><span style="float: right;">(Amount in <%=strAmountVal %>)</span></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">

					<%
						if (arrrow3 != null && arrrow3.size() > 0) {

							for (int i = 0; i < arrrow3.size(); i++) {
								arrcol3 = (ArrayList) arrrow3.get(i);

								String demotype = Helper.correctNull((String) arrcol3
										.get(1));
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
								else
									demotype="&nbsp;";
					%>
					<tr>
						<td colspan="6"><b><%=demotype%> </b> <%=Helper.correctNull((String) arrcol3.get(0))%></td>
					</tr>
					<tr>
						<td width="5%">1.</td>
						<td width="38%">Documents collected in support of income</td>
						<td width="50%" colspan="4">
						<%=Helper.correctNull((String) arrcol3.get(19)) %>
						 &nbsp; <br/><br/><br/>
						Note: Copy to be verified with the originals</td>
					</tr>
					<tr>
						<td>2.</td>
						<td><b>Discuss Source of annual income:</b></td>
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr>
						<td>a.</td>
						<td>Salary</td>
						<td colspan="4" align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrcol3
											.get(20)),strAmountForm)%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>b.</td>
						<td>Profit from business/profession</td>
						<td colspan="4" align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrcol3
											.get(18)),strAmountForm)%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>c.</td>
						<td>Income from capital gains</td>
						<td colspan="4" align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrcol3
											.get(16)),strAmountForm)%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>d.</td>
						<td>Agriculture (In case of agriculturist, farm budget to be verified)</td>
						<td colspan="4" align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrcol3
											.get(17)),strAmountForm)%>
						&nbsp;</td>
					</tr>

					<%
						}
						}
					%>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp; E.
				AGRICULTURISTS/PLANTERS :</span><span style="float: right;">&nbsp;&nbsp; (Mandatory where applicants are agriculturists)</span></b></td>
			</tr>
			<tr>
				<td>
				<%bflag=true;
				if (arrrow3 != null && arrrow3.size() > 0) {
					for (int i = 0; i < arrrow3.size(); i++) {
						arrcol3 = (ArrayList) arrrow3.get(i);
						if(Helper.correctNull((String)arrcol3.get(34)).equalsIgnoreCase("4")){
							bflag=false;
				%>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<%

								String demotype = Helper.correctNull((String) arrcol3
										.get(1));
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
								else
									demotype="&nbsp;";
					%>

					<tr>
						<td colspan="6"><b><%=demotype%> </b> <%=Helper.correctNull((String) arrcol3.get(0))%></td>
					</tr>
					<tr>
						<td width="5%">1.</td>
						<td width="38%">Date of visit to the farm & extent of land</td>
						<td width="50%" colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(21))%>
						&nbsp; <br>
						Extend of land: <%=Helper.correctNull((String) arrcol3
											.get(22))%> <br>
						</td>
					</tr>
					<tr>
						<td rowspan="2">2.</td>
						<td>(a) Standing crops at the time of visit</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(23))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>(b) Crops grown during the year</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(24))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>3.</td>
						<td>Liability with Primary Agricultural Co-operative
						Society(PACS), if any (Only when second charge on property is
						proposed)</td>
						<td colspan="4">(<%=strAmountVal%>)&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) arrcol3
											.get(25)),strAmountForm)%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>4.</td>
						<td>Date of NOC obtained from PACS (if applicable)</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(26))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>5.</td>
						<td>Period of bank statement of PACS verified</td>
						<td colspan="4">From: <%if(Helper.correctNull((String) arrcol3
											.get(27)).equalsIgnoreCase("")){%>______________<%}else{%><%=Helper.correctNull((String) arrcol3
											.get(27))%><%} %>
						&nbsp; To: <%if(Helper.correctNull((String) arrcol3
											.get(28)).equalsIgnoreCase("")){%>______________<%}else{%><%=Helper.correctNull((String) arrcol3
											.get(28))%><%} %> <br>
						Status of Account: <%if(Helper.correctNull((String) arrcol3
											.get(29)).equalsIgnoreCase("")){%>______________<%}else{%><%=Helper.correctNull((String) arrcol3
											.get(29))%><%} %>
						</td>
					</tr>
					<%
						if (Helper.correctNull((String) arrcol3.get(32)).equals("")) {
					%>
					<tr>
						<td>6.</td>
						<td>F.No.60 obtained</td>
						<td colspan="4">
						<%
							if (Helper.correctNull((String) arrcol3.get(30))
												.equals("Y")) {
						%>
						Yes <%
							} else {
						%> No <%
							}
						%> &nbsp; <br>
						Date of F.No.60 : <%=Helper.correctNull((String) arrcol3.get(31))%>
						</td>
					</tr>
					<%
						}
					%>

					
				</table>
				<%}
						}
						}if(bflag){
					%>
					<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr>
					<td align="center"> - Nil - </td>
					</tr>
					</table>
					<%} %>
				</td>
			</tr>
			<tr>
			<td><b><span style="float: left;">&nbsp;&nbsp;F. PROPERTY DETAILS  -  PRIMARY/ COLLATERAL SECURITY :</span><span style="float: right;">&nbsp;&nbsp; (mandatory where mortgage of property is offered)</span></b></td>
			</tr>
			<%if(arrPropDet!=null && arrPropDet.size()>0){
				for(int i=0;i<arrPropDet.size();i++){
				arrcol=(ArrayList)arrPropDet.get(i);%>
			<tr>
			<td>
			<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
			<tr>
			<td colspan="3">Security ID :<%=Helper.correctNull((String)arrcol.get(31)) %>&nbsp;</td>
			</tr>
			<tr>
			<td width="5%" align="center">1.</td>
			<td width="40%">Observation on CERSAI verification</td>
			<td width="55%"><%=Helper.correctNull((String)arrcol.get(25)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center" rowspan="4">2.</td>
			<td rowspan="4">Legal opinion given by the panel advocate and the date of legal opinion</td>
			<td>Security Type : <%=Helper.correctNull((String)arrcol.get(2)) %></td>
			</tr>
			<tr>
			<td>Security Value :(<%=strAmountVal %>)&nbsp; <%=Helper.converAmount(Helper.correctDouble((String)arrcol.get(0)),strAmountForm) %></td>
			</tr>
			<tr>
			<td>Lawyer Name : <%=Helper.correctNull((String)arrcol.get(5)) %></td>
			</tr>
			<tr>
			<td>Legal Opinion Date : <%=Helper.correctNull((String)arrcol.get(6)) %></td>
			</tr>
			<tr>
			<td align="center">3.</td>
			<td>Search /flow of title on property conducted /obtained</td>
			<td>
			<%if(!Helper.correctNull((String)arrcol.get(7)).equalsIgnoreCase("")){ %>
			<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr align="center">
					<td>From</td>
					<td>To</td>
					</tr>
			<%bflag1=true;
			String strArr1[]=Helper.correctNull((String)arrcol.get(7)).split("@");
			for(int a=0;a<strArr1.length;a++){
			String strArr2[]=strArr1[a].split("~");
			if(strArr2.length>1){
			bflag1=false;%>
				<tr align="center">
				<td><%=strArr2[0] %></td>	
				<td><%=strArr2[1] %></td>
				</tr>	
			<%}} 
			if(bflag1){%>
			<tr align="center">
					<td colspan="2">- Nil -</td>
					</tr>
			<%} %>
			</table>
			<%} %>
			&nbsp;</td>
			</tr>
			<tr>
			<td align="center" rowspan="4">4.</td>
			<td rowspan="4">Name of Panel Valuer and date of valuation report</td>
			<td>Security Type : <%=Helper.correctNull((String)arrcol.get(2)) %></td>
			</tr>
			<tr>
			<td>Security Value :(<%=strAmountVal %>)&nbsp; <%=Helper.converAmount(Helper.correctDouble((String)arrcol.get(0)),strAmountForm) %></td>
			</tr>
			<tr>
			<td>Valuer Name : <%=Helper.correctNull((String)arrcol.get(3)) %></td>
			</tr>
			<tr>
			<td>Valuation Date : <%=Helper.correctNull((String)arrcol.get(1)) %></td>
			</tr>
			<tr>
			<td align="center">5.</td>
			<td>Due date of Valuer's empanelment in our Bank</td>
			<td><%=Helper.correctNull((String)arrcol.get(4)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">6.</td>
			<td>The description of property as per Valuer's report (including area and boundary of property)</td>
			<td><%=Helper.correctNull((String)arrcol.get(26)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">7.</td>
			<td>The description of property as per legal opinion (including measurement/location/boundary of property)</td>
			<td><%=Helper.correctNull((String)arrcol.get(27)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">8.</td>
			<td>Reason for variation(if any), pertaining to description of property</td>
			<td><%=Helper.correctNull((String)arrcol.get(28)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">9.</td>
			<td>Name of the officer with staff number who has accompanied the valuer.</td>
			<td><%=Helper.correctNull((String)arrcol.get(29)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">10.</td>
			<td>Date of which documents have been given to advocate </td>
			<td><%=Helper.correctNull((String)arrcol.get(8)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">11.</td>
			<td>Details of property acquisition</td>
			<td>
			<%String strPropAcq=Helper.correctNull((String)arrcol.get(9));
			if(strPropAcq.equalsIgnoreCase("P"))
					strPropAcq="Purchase";	
			else if(strPropAcq.equalsIgnoreCase("I"))
					strPropAcq="Inheritance/Will";	
			else if(strPropAcq.equalsIgnoreCase("G"))
					strPropAcq="Gift";	
			else if(strPropAcq.equalsIgnoreCase("T"))
					strPropAcq="Others";
			else
				strPropAcq="";
			 %><%=strPropAcq %>
			 <%
			 if(strPropAcq.equalsIgnoreCase("Others"))
			 {%>
			 <%=Helper.correctNull((String)arrcol.get(10)) %>
			 <%} %>
			&nbsp;</td>
			</tr>
			<tr>
			<td align="center">12.</td>
			<td>In case of purchase of property, details of property to be purchased:</td>
			<td>&nbsp;</td>
			</tr>
			<tr>
			<td align="center" rowspan="4">a.</td>
			<td>Plot No</td>
			<td><%=Helper.correctNull((String)arrcol.get(11)) %>&nbsp;</td>
			</tr>
			<tr>
			<td>Survey No</td>
			<td><%=Helper.correctNull((String)arrcol.get(12)) %>&nbsp;</td>
			</tr>
			<tr>
			<td>Street No</td>
			<td><%=Helper.correctNull((String)arrcol.get(13)) %>&nbsp;</td>
			</tr>
			<tr>
			<td>Ward No</td>
			<td><%=Helper.correctNull((String)arrcol.get(14)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">b.</td>
			<td>Area of the flat/house/plot (<%=Helper.correctNull((String)arrcol.get(30)) %>)</td>
			<td><%=Helper.correctNull((String)arrcol.get(15)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center" rowspan="5">13.</td>
			<td>Near by landmark for identification</td>
			<td>&nbsp;</td>
			</tr>
			<tr>
			<td>East</td>
			<td><%=Helper.correctNull((String)arrcol.get(16)) %>&nbsp;</td>
			</tr>
			<tr>
			<td>West</td>
			<td><%=Helper.correctNull((String)arrcol.get(17)) %>&nbsp;</td>
			</tr>
			<tr>
			<td>North</td>
			<td><%=Helper.correctNull((String)arrcol.get(18)) %>&nbsp;</td>
			</tr>
			<tr>
			<td>South</td>
			<td><%=Helper.correctNull((String)arrcol.get(19)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">14.</td>
			<td>Age of the Building (In case of purchase of ready built House/Flat)</td>
			<td><%=Helper.correctNull((String)arrcol.get(20)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">15.</td>
			<td>Area as per sale agreement</td>
			<td><%=Helper.correctNull((String)arrcol.get(15)) %> (<%=Helper.correctNull((String)arrcol.get(30)) %>)&nbsp;</td>
			</tr>
			<tr>
			<td align="center">16.</td>
			<td>Sale amount </td>
			<td>(<%=strAmountVal%>)&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)arrcol.get(21)),strAmountForm) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">17.</td>
			<td>Name of the builder/project</td>
			<td><%=Helper.correctNull((String)arrcol.get(22)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">18.</td>
			<td>Reference no. of the approval approving the project</td>
			<td><%=Helper.correctNull((String)arrcol.get(23)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">19.</td>
			<td>No. of floors</td>
			<td><%=Helper.correctNull((String)arrcol.get(24)) %>&nbsp;</td>
			</tr>
			</table>
			</td>
			</tr>
			<%}}else{ %>
			<tr>
			<td>
			<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr>
					<td align="center"> - Nil - </td>
					</tr>
					</table>
			</td>
			</tr>
			<%} %>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp; G.
				SALARIED EMPLOYEES :</span><span style="float: right;">(Mandatory where salary is not paid through our Bank)</span></b></td>
			</tr>
			<tr>
				<td>
				<%arrrow3=(ArrayList)hshValues.get("arrEmpDet");
				bflag=true;
				if (arrrow3 != null && arrrow3.size() > 0) {
					for (int i = 0; i < arrrow3.size(); i++) {
						arrcol3 = (ArrayList) arrrow3.get(i);
						if(Helper.correctNull((String)arrcol3.get(24)).equalsIgnoreCase("1")){
						bflag=false;%>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<%
								String demotype = Helper.correctNull((String) arrcol3
										.get(1));
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
					%>

					<tr>
						<td colspan="6"><b><%=demotype%> </b> <%=Helper.correctNull((String) arrcol3.get(0))%></td>
					</tr>
					<tr>
						<td width="5%">1.</td>
						<td width="35%">Name and Address of the employer(with telephone number/contact number of salary disbursing authority, Email ID)</td>
						<td colspan="4" width="60%"><%=Helper.correctNull((String) arrcol3.get(2))%>
						&nbsp; <br>
						<%=Helper.correctNull((String) arrcol3.get(3))%> <br>
						<%=Helper.correctNull((String) arrcol3.get(4))%>, <%=Helper.correctNull((String) arrcol3.get(5))%>
						<br>
						Phone :<%=Helper.correctNull((String) arrcol3.get(6))%> <br>
						Email id<%=Helper.correctNull((String) arrcol3.get(7))%></td>
					</tr>
					<tr>
						<td>2.</td>
						<td>Whether employer is listed and name of the stock exchange
						</td>
						<td colspan="4">
						<%if(Helper.correctNull((String)arrcol3.get(29)).equalsIgnoreCase("Y")){ %>Yes<%}
						else if(Helper.correctNull((String)arrcol3.get(29)).equalsIgnoreCase("N")){%>No<%} %>
						
						<%if(!Helper.correctNull((String)arrcol3.get(30)).equalsIgnoreCase("")){  %>
						- <%=Helper.correctNull((String)arrcol3.get(30)) %>
						<%} %>
						&nbsp;</td>
					</tr>
					<tr>
						<td>3.</td>
						<td>Employer's latest sales turnover and Profit:</td>
						<td colspan="4">Sales Turnover: (<%=strAmountVal%>)&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) arrcol3.get(8)),strAmountForm)%>
						&nbsp; <br>
						Profit: (<%=strAmountVal%>)&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) arrcol3.get(9)),strAmountForm)%></td>
					</tr>
					<tr>
						<td>4.</td>
						<td>Number of years in present employment as permanent
						employee</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3.get(27))%>&nbsp;</td>
					</tr>
					<tr>
						<td>5.</td>
						<td>Designation of the employee</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3.get(26))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>6.</td>
						<td>Present bank, branch and A/c No. where salary is being
						credited at present</td>
						<td colspan="4">Bank : <%=Helper.correctNull((String) arrcol3
											.get(10))%>
						&nbsp; <br>
						Branch: <%=Helper.correctNull((String) arrcol3
											.get(11))%> <br>
						Account number <%=Helper.correctNull((String) arrcol3
											.get(12))%></td>
					</tr>
					<tr>
						<td>7.</td>
						<td>installment/interest proposed to be serviced to the loan
						account</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(13))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>8.</td>
						<td>If the institution/employer is not in the approved list
						as per circular, the reference number of permission obtained from
						credit department:</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(14))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>9.</td>
						<td>Salary as per Salary slip</td>
						<td colspan="4">(<%=strAmountVal%>)&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) arrcol3
								.get(28)),strAmountForm)%></td>
					</tr>
					<tr>
						<td>10.</td>
						<td>Salary as per bank statement of account</td>
						<td colspan="4">(<%=strAmountVal%>)&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) arrcol3
											.get(15)),strAmountForm)%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>11.</td>
						<td>Reasons for variations if any in salary slip and bank
						statement of account</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3
											.get(16))%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>12.</td>
						<td colspan="5">Genuineness of the undertaking letters have
						been independently verified contacting the employer
						company/Office/Institution/Dept. on <%=Helper.correctNull((String) arrcol3.get(17))%> <br>
						<br>
						Contacted Person is<%if(Helper.correctNull((String) arrcol3
								.get(18)).equalsIgnoreCase("")){ %>____________________<%}else{ %> <%=Helper.correctNull((String) arrcol3
											.get(18))%><%} %>
						(& Designation) <%if(Helper.correctNull((String) arrcol3
								.get(19)).equalsIgnoreCase("")){ %> ____________________<%}else{ %><%=Helper.correctNull((String) arrcol3
											.get(19))%> <%} %><br>
						<br>
						Contact No. /Mobile No.<%if(Helper.correctNull((String) arrcol3
								.get(20)).equalsIgnoreCase("")){ %> ____________________<%}else{ %> <%=Helper.correctNull((String) arrcol3
											.get(20))%><%} %>
						&nbsp;</td>
					</tr>
				</table>
				<%}
						}
						}
					if(bflag){
					%>
					<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr>
					<td align="center"> - Nil - </td>
					</tr>
					</table>
					<%}%>
				</td>
			</tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;H. VEHICLE LOANS/MACHINERY LOANS</span>
				<span style="float: right;">(mandatory where purchase of vehicle/machinery is proposed)</span></b></td>
			</tr>
			<%if(arrVehDet!=null && arrVehDet.size()>0){
				for(int i=0;i<arrVehDet.size();i++){
				arrcol=(ArrayList)arrVehDet.get(i);%>
			<tr>
			<td>
			<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
			<tr>
			<td colspan="3">Security ID :<%=Helper.correctNull((String)arrcol.get(24)) %>&nbsp;</td>
			</tr>
			<tr>
			<td width="5%" align="center">1.</td>
			<td width="30%">Name and address details of the Vehicle/Machinery dealer with contact No. and Email id</td>
			<td width="40%">
			<%=Helper.correctNull((String)arrcol.get(0)) %><br/>
			<%if(!Helper.correctNull((String)arrcol.get(1)).equalsIgnoreCase("")){ %>
			<%=Helper.correctNull((String)arrcol.get(1)) %>,<br/>
			<%} %>
			<%if(!Helper.correctNull((String)arrcol.get(2)).equalsIgnoreCase("")){ %>
			<%=Helper.correctNull((String)arrcol.get(2)) %>,<br/>
			<%} %>
			<%if(!Helper.correctNull((String)arrcol.get(3)).equalsIgnoreCase("")){ %>
			<%=Helper.correctNull((String)arrcol.get(3)) %>,<br/>
			<%} %>
			<%if(!Helper.correctNull((String)arrcol.get(4)).equalsIgnoreCase("")){ %>
			<%=Helper.correctNull((String)arrcol.get(4)) %>,<br/>
			<%} %>
			<%if(!Helper.correctNull((String)arrcol.get(5)).equalsIgnoreCase("")){ %>
			<%=Helper.correctNull((String)arrcol.get(5)) %>,<br/>
			<%} %>
			<%if(!Helper.correctNull((String)arrcol.get(6)).equalsIgnoreCase("")){ %>
			<%=Helper.correctNull((String)arrcol.get(6)) %>,<br/>
			<%} %>
			<%if(!Helper.correctNull((String)arrcol.get(7)).equalsIgnoreCase("")){ %>
			Mail :<%=Helper.correctNull((String)arrcol.get(7)) %><br/>
			<%} %>
			<%if(!Helper.correctNull((String)arrcol.get(8)).equalsIgnoreCase("")){ %>
			Contact No :<%=Helper.correctNull((String)arrcol.get(8)) %><br/>
			<%} %>
			&nbsp;</td>
			</tr>
			<tr>
			<td align="center">2.</td>
			<td>Whether dealer's name is appearing in the list of authorised dealers of the manufacturing company of the vehicle/machinery (Verify from the website of the Mfg.Company)</td>
			<td>
			<%if(Helper.correctNull((String)arrcol.get(15)).equalsIgnoreCase("y")){ %>
			Yes
			<%}else if(Helper.correctNull((String)arrcol.get(15)).equalsIgnoreCase("n")){ %>
			No
			<%} %>
			&nbsp;</td>
			</tr>
			<tr>
			<td align="center" rowspan="2">3.</td>
			<td>Authorized dealer code:</td>
			<td> <%=Helper.correctNull((String)arrcol.get(9)) %>&nbsp;</td>
			</tr>
			<tr>
			<td>TIN No:</td><td> <%=Helper.correctNull((String)arrcol.get(10)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">4.</td>
			<td>Date, when genuineness of the Invoice/Advance payment receipts produced have been ascertained by contacting the dealer</td>
			<td><%=Helper.correctNull((String)arrcol.get(16)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">5.</td>
			<td>Whether Dealer is Sub Dealer?</td>
			<td>
			<%if(Helper.correctNull((String)arrcol.get(17)).equalsIgnoreCase("y")){ %>
			Yes
			<%}else if(Helper.correctNull((String)arrcol.get(17)).equalsIgnoreCase("n")){ %>
			No
			<%} %>
			&nbsp;
			</td>
			</tr>
			<%if(Helper.correctNull((String)arrcol.get(17)).equalsIgnoreCase("y")){ %>
			<tr>
			<td align="center">&nbsp;</td>
			<td>Main Dealer Name</td>
			<td><%=Helper.correctNull((String)arrcol.get(18)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">&nbsp;</td>
			<td>Contact Details of the Main Dealer</td>
			<td><%=Helper.correctNull((String)arrcol.get(19)) %>&nbsp;</td>
			</tr>
			<%} %>
			<tr>
			<td align="center">6.</td>
			<td>Date of Confirmation obtained from main dealer about the sub dealer</td>
			<td><%=Helper.correctNull((String)arrcol.get(20)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">7.</td>
			<td>TIN No. of the sub dealer</td>
			<td><%=Helper.correctNull((String)arrcol.get(21)) %>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">8.</td>
			<td>How the mode of repayment is independently ascertained( In case of reimbursement)</td>
			<td><%=Helper.correctNull((String)arrcol.get(22)) %>&nbsp;</td>
			</tr>
			<tr>
			<td rowspan="4" align="center">9.&nbsp;</td>
			<td rowspan="3">In case of purchase of used vehicle, </td>
			<td>Vehicle No :<%=Helper.correctNull((String)arrcol.get(11)) %>&nbsp;</td>
			</tr>
			<tr>
			<td>Tax Paid upto :<%=Helper.correctNull((String)arrcol.get(12)) %></td>
			</tr>
			<tr>
			<td>Insurance Paid upto :<%=Helper.correctNull((String)arrcol.get(13)) %></td>
			</tr>
			<tr>
			<td>Documents as verified with the originals</td>
			<td>
			<%if(!Helper.correctNull((String)arrcol.get(14)).equalsIgnoreCase("")){ 
			String strArr[]=Helper.correctNull((String)arrcol.get(14)).split("@");
			if(strArr.length>1)
			{
			for(int a=0;a<strArr.length;a++){
				if(strArr[a].equalsIgnoreCase("RC")){%>
				Copy of RC<br/>
				<%}else if(strArr[a].equalsIgnoreCase("TPR")){%>
				Tax paid receipt<br/>
				<%} else if(strArr[a].equalsIgnoreCase("VR")){%>
				Valuation report<br/>
				<%} else if(strArr[a].equalsIgnoreCase("CND")){%>
				Charge noted details<br/>
				<%} else if(strArr[a].equalsIgnoreCase("IP")){%>
				Insurance policy<br/>
				<%}%>
			<%}}} %>
			&nbsp;</td>
			</tr>
			<tr>
			<td align="center">10.</td>
			<td>The Vehicle No., Chassis No. and Engine No. mentioned in the RC Book and valuation report shall be duly verified </td>
			<td>Date of Verification: <%=Helper.correctNull((String)arrcol.get(23)) %></td>
			</tr>
			</table>
			</td>
			</tr>
			<%}}else{ %>
			<tr>
			<td>
			<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr>
					<td align="center"> - Nil - </td>
					</tr>
					</table>
			</td>
			</tr>
			<%} %>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp; I. FOR SELF EMPLOYED</span><span style="float: right;"> (Mandatory for all self employed persons/professionals)</span></b></td>
			</tr>
			<tr>
				<td>
				<%arrrow3=(ArrayList)hshValues.get("arrEmpDet");
				bflag=true;
				if (arrrow3 != null && arrrow3.size() > 0) {
					for (int i = 0; i < arrrow3.size(); i++) {
						arrcol3 = (ArrayList) arrrow3.get(i);
						if(Helper.correctNull((String)arrcol3.get(24)).equalsIgnoreCase("2")||Helper.correctNull((String)arrcol3.get(24)).equalsIgnoreCase("3")){
						bflag=false;%>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<%
								String demotype = Helper.correctNull((String) arrcol3
										.get(1));
								if (demotype.equals("a"))
									demotype = "Applicant -";
								else if (demotype.equals("o"))
									demotype = "Co-Obligant -";
								else if (demotype.equals("c"))
									demotype = "Co-applicant -";
								else if (demotype.equals("g"))
									demotype = "Guarantor -";
								else
									demotype="&nbsp;";
					%>

					<tr>
						<td colspan="6"><b><%=demotype%> </b> - <%=Helper.correctNull((String) arrcol3.get(0))%></td>
					</tr>
					<tr>
						<td width="5%">1.</td>
						<td width="35%">No. of years applicant is in the present business/profession/activity</td>
						<td colspan="4" width="60%"><%=Helper.correctNull((String) arrcol3.get(27))%>&nbsp;</td>
					</tr>
					<tr>
						<td>2.</td>
						<td>Name of the nearest branch of our bank to the unit/employer
						</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3.get(21))%>&nbsp;</td>
					</tr>
					<tr>
						<td>3.</td>
						<td>The applicant is carrying out the activity in</td>
						<td colspan="4">
						<%if(Helper.correctNull((String) arrcol3.get(22)).equalsIgnoreCase("O")){ %>
						Owned premises
						<%}else if(Helper.correctNull((String) arrcol3.get(22)).equalsIgnoreCase("R")){ %>
						Rented premises
						<%}else if(Helper.correctNull((String) arrcol3.get(22)).equalsIgnoreCase("L")){ %>
						Leased premises
						<%}%>
						&nbsp;</td>
					</tr>
					<tr>
						<td>4.</td>
						<td>Place and address of the business</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3.get(23))%>&nbsp;</td>
					</tr>
					<tr>
						<td>5.</td>
						<td>Date of visit to the unit/office</td>
						<td colspan="4"><%=Helper.correctNull((String) arrcol3.get(25))%>&nbsp;</td>
					</tr>
				</table>
				<%}
						}
						}
					if(bflag){
					%>
					<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr>
					<td align="center"> - Nil - </td>
					</tr>
					</table>
					<%}%>
				</td>
			</tr>

			<tr>
				<td><b>J. GENERAL OPINION (Market Intelligence Report)&nbsp;</b></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr>
					<td align="center" width="5%">1.</td>
					<td width="40%">Market report about the borrower</td>
					<td width="50%"><%=Helper.correctNull((String)hshValues.get("strMarketReport")) %>&nbsp;</td>
					</tr>
					<tr>
					<td align="center">i) &nbsp;</td>
					<td>Enquiries made with whom &amp; contact No. (If available)&nbsp;</td>
					<td><%=Helper.correctNull((String)hshValues.get("strEnquiremadewith")) %><br/>
					<%if(!Helper.correctNull((String)hshValues.get("strContactno")).equalsIgnoreCase("")) {%>
					Contact No: <%=Helper.correctNull((String)hshValues.get("strContactno")) %>
					<%} %>
					&nbsp;</td>
					</tr>
					<tr>
					<td align="center">ii)&nbsp;</td>
					<td>Opinion about the borrower/s</td>
					<td><%=Helper.correctNull((String)hshValues.get("stropionionabtbor")) %>&nbsp;</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable border1">
					<tr>
					<td colspan="2"><b>Due Diligence Conducted by</b></td>
					</tr>
					<tr>
					<td width="30%">Name</td>
					<td width="60%"><%=Helper.correctNull((String)hshValues.get("strDDRcontactedbyName")) %>&nbsp;</td>
					</tr>
					<tr>
					<td>Designation</td>
					<td><%=Helper.correctNull((String)hshValues.get("strDDRUserDesignation")) %>&nbsp;</td>
					</tr>
					<tr>
					<td>Staff No</td>
					<td><%if(Helper.correctNull((String)hshValues.get("strDDRcontactedby")).startsWith("K")){ %>
					<%=Helper.correctNull((String)hshValues.get("strDDRcontactedby")).subSequence(1,Helper.correctNull((String)hshValues.get("strDDRcontactedby")).length()) %>
					<%}else{ %>
					<%} %>
					&nbsp;</td>
					</tr>
					<tr>
					<td>Signature</td>
					<td>&nbsp;</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
					<td align="center"><b>CERTIFICATE</b></td>
					</tr>
					<tr>
					<td>
					<p align="justify">
					Certified that the informations furnished above are true and correct, copies of all such documentary proofs, duly verified with the originals are held at the branch and we are satisfied about the credit worthiness of the borrower/s.
					</p>
					</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
					<td>Place :</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
					<td>Date :</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
					<td><b>Branch Head Name :</b></td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
					<td>PA No. :</td>
					</tr>
					</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
