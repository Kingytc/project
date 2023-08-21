<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css" />
</head>
<body bgcolor="#FFFFFF">
<form name="frminspection" method="post">
<table width="80%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
			</tr>
			<tr>
				<td align="center"><b>Branch - <%=Helper.correctNull((String) hshValues.get("orgname"))%></b></td>
			</tr>
			<tr>
				<td align="center"><%=Helper.correctNull((String) hshValues.get("orgadd1"))%>,&nbsp;
				<%=Helper.correctNull((String) hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String) hshValues.get("orgcity"))%>,&nbsp;
				<%=Helper.correctNull((String) hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String) hshValues
									.get("orgzip"))%>&nbsp;
				<hr />
				</td>
			</tr>


		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left">
			<tr>
				<td align="center"><b>AGRICULTURAL FINANCE - FOLLOW-UP INSPECTION
				REPORT</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="2" cellpadding="3">
	<tr>
		<td width="3%">&nbsp;</td>
		<td width="43%">&nbsp;</td>
		<td width="4%"><b></b></td>
		<td width="50%">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>1.</b></td>
		<td width="43%"><b>Name of the borrower </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
							.get("personal_custname"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>2.</b></td>
		<td width="43%"><b>Address (village,taluk,etc.) </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
							.get("personal_address"))%><br>
		<%=Helper.correctNull((String) hshValues
							.get("personal_address1"))%><br>
		<%=Helper.correctNull((String) hshValues.get("city_name"))%><br>
		<%=Helper.correctNull((String) hshValues.get("state_name"))%><br>
		<%=Helper.correctNull((String) hshValues
							.get("personal_pincode"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>3.</b></td>
		<td width="43%"><b>Date of present inspection</b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
									.get("inspec_date"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b></b></td>
		<td width="43%"><b>Name of Inspection official </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
							.get("inspec_official1"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>4.</b></td>
		<td width="43%"><b>Date of previous inspection </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
							.get("previous_inspecdate"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b></b></td>
		<td width="43%"><b>Name of Inspection offical</b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
							.get("inspec_official2"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>5.</b></td>
		<td width="43%"><b>Sanction of loan :</b></td>
		<td width="4%"><b></b></td>
		<td width="50%">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td width="3%">&nbsp;</td>
		<td colspan="3">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td><b>Limit</b></td>
				<td><b>Amount</b></td>
				<td><b>Purpose/s</b></td>
				<%-- <td width="18%"><b>Amount released</b></td>--%>
				<td><b>Amount Outstanding</b></td>
				<td><b>Overdue If any</b></td>
			</tr>
			<%arrCol = new ArrayList();

			arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
			<tr valign="top">
				<td><%=Helper.correctNull((String) arrCol.get(1))%></td>
				<td><%=Helper.correctNull((String) arrCol.get(3))%></td>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
				<%--  <td width="18%">&nbsp;</td>--%>
				<td><%=Helper.correctNull((String) arrCol.get(4))%></td>
				<td><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
			</tr>
			<%}
			}

			%>
		</table>
		</div>
		</td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>6.</b></td>
		<td width="43%"><b>Has the amount been utilised for the purpose/s for
		which it was advanced? If not, mention the deviations. </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
							.get("official_observation"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>7.</b></td>
		<td width="43%"><b>In case of loan for development purposes like
		reclamation, levelling and bunding of land, laying of pipelines,
		construction of storage tank etc., mention whether the required work
		has been carried out in full and whether the outlay incurred is
		realistic and keeping with the estimates </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
									.get("development"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>8.</b></td>
		<td width="43%"><b>In case of loan for sinking of, or repairs to,
		well, verify and give particulars of the work done, with your comments
		on the availability of adequate water etc. </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues.get("sinking"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>9.</b></td>
		<td width="43%"><b>In case of loan for purpose of machinery like
		tractors, pumpsets etc. verify the make, H.P., etc. and state whether
		it is same as given in the application. State whether the machinery is
		recently purchased and is in working condition. </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues.get("machinery"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>10.</b></td>
		<td width="43%"><b>In case of loans for seasonal operations, check up
		whether the crops and acreage under various crops tally with the
		cropping pattern for which we have sanctioned crop loan. Give comments
		</b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
							.get("seasonalcrops"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>11.</b></td>
		<td width="43%" colspan="3"><b>Give particulars of the standing crops
		on the borrower's farm in the following table.</b></td>
	</tr>
	<tr valign="top">
		<td width="3%">&nbsp;</td>
		<td colspan="3">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="9%"><b>Sno.</b></td>
				<td width="32%"><b>Name of the crop</b></td>
				<td width="30%"><b>Approximate acerage</b></td>
				<td width="29%"><b>Condition of the crop</b></td>
			</tr>
			<%arrCol = new ArrayList();
			arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrCrops");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
			<tr valign="top">
				<td width="9%"><%=i + 1%></td>
				<td width="32%"><%=Helper.correctNull((String) arrCol.get(1))%></td>
				<td width="30%"><%=Helper.correctNull((String) arrCol.get(2))%></td>
				<td width="29%"><%=Helper.correctNull((String) arrCol.get(3))%></td>
			</tr>
			<%}
			}

			%>
		</table>
		</div>
		</td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>12.</b></td>
		<td width="43%"><b>If the borrower has availed of only medium term
		loan from us, mention the arrangements he has made to meet the
		cultivation expenses. </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues
							.get("mediumtermloan"))%></td>
	</tr>
	<tr valign="top">
		<td width="3%"><b>13.</b></td>
		<td width="43%"><b>Give comments on any other aspect observed during
		the inspection: </b></td>
		<td width="4%"><b>:</b></td>
		<td width="50%"><%=Helper.correctNull((String) hshValues.get("shortfall"))%></td>
	</tr>
	<tr valign="top">
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td width="3%">&nbsp;</td>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="1" cellpadding="2">
			<tr>
				<td width="8%"><b>Place :</b></td>
				<td width="52%"><%=Helper.correctNull((String) hshValues.get("from_place"))%></td>
				<td width="14%"><b>(Signature)</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="8%"><b>Date :</b></td>
				<td width="52%"><%=Helper.correctNull((String) hshValues
									.get("filled_date"))%></td>
				<td width="14%"><b>Name:</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("user_name"))%></td>
			</tr>
			<tr>
				<td width="8%">&nbsp;</td>
				<td width="52%">&nbsp;</td>
				<td width="14%"><b>Designation:</b></td>
				<td><%=Helper.correctNull((String) hshValues.get("user_desig"))%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%"><b>Comments / observations of the Approving Authority:</b></td>
      <td width="4%">&nbsp;</td>
      <td width="50%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="3"><%=Helper.formatTextAreaData((String)hshValues.get("sanccomments")) %></td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="43%"><b>Date : <%=Helper.correctNull((String)hshValues.get("approvedate")) %> </b></td>
      <td width="4%">&nbsp;</td>
      <td width="50%" align="center"> <b>Signature of Approving Authority</b></td>
    </tr>
</table>

</form>
</body>
</html>

