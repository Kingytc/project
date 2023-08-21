<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%ArrayList arrRow=new ArrayList();
ArrayList arrData=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");



%>
<html>
<head>
<title>Declaration History </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>

<body>
<h3>
<center>Audit Trail Report</center>
</h3>
<form name="frmaudittrail" method="post">
<table width="95%" border="0" cellspacing="0" cellpadding="0"
	align="center">
		<tr>

		<td height="3">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			align="left">



			
				
			<tr align="left" class="tblhead">
				<td nowrap="nowrap" valign="top">S.No</td>				
				<td nowrap="nowrap" valign="top">Customer ID</td>
				<td nowrap="nowrap" valign="top">Customer Name</td>
				<td nowrap="nowrap" valign="top">Proposal Number</td>
				<td nowrap="nowrap" valign="top">CIN Number</td>
				<td nowrap="nowrap" valign="top">Staff ID</td>
				<td nowrap="nowrap" valign="top">Organisation Code</td>
				<td nowrap="nowrap" valign="top">Organisation Department</td>
				<td nowrap="nowrap" valign="top">Modified Date</td>
				
				
			</tr>
			<%
			if (arrRow != null && arrRow.size() > 0)
			{
				if (arrRow.size() > 0) 
				{
					int count = 0;
					for (int k = 0; k < arrRow.size(); k++) 
					{
						arrData = (ArrayList) arrRow.get(k);
				{%>
			<tr>
			<td >&nbsp;<%=k+1%></td>
			<td >&nbsp;<%=Helper.correctNull((String)arrData.get(0))%></td>
			<td >&nbsp;<%=Helper.correctNull((String)arrData.get(1))%></td>
			<td >&nbsp;<%=Helper.correctNull((String)arrData.get(2))%></td>
			<td >&nbsp;<%=Helper.correctNull((String)arrData.get(3)).toUpperCase()%></td>
			<td >&nbsp;<%=Helper.correctNull((String)arrData.get(4))%></td>
			<td >&nbsp;<%=Helper.correctNull((String)arrData.get(5))%></td>
			<td >&nbsp;<%=Helper.correctNull((String)arrData.get(6))%></td>
			<td >&nbsp;<%=Helper.correctNull((String)arrData.get(7))%></td>
			</tr>
														
													
														

			<%}}
			}
		}%>
		</table>
		</div>
		</td>

	</tr>
</table>
</form>
</body>
</html>