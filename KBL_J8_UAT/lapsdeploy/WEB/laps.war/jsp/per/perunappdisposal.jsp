<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<%
	ArrayList vecOrg = new ArrayList();
	vecOrg = (ArrayList) hshValues.get("vecValues");
	String align = "left";
	ArrayList vecVal = null;
	//	out.println(hshValues);
	String Prodtype = Helper.correctNull((String) hshValues
			.get("strProdType"));
	if (Prodtype.equalsIgnoreCase("p")) {
		Prodtype = "Retail";
	} else {
		Prodtype = "Agriculture";
	}
%>


<html>
<head>
<title>Productwise Disposal of loan application</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var outlabel="<%=hshValues.get("labels")%>";
var textlabel="";
var datalen ="<%=vecOrg.size()%>";
</script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td align="center"><img
			src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	</tr>
	<tr>
		<td align="center"><%=Helper.correctNull((String) hshValues.get("OrgName"))%></td>
	</tr>
	<tr>
		<td align="center"><b>Productwise Disposal of loan
		application <%=Helper.correctNull((String) hshValues.get("prodcat"))%></b></td>
	</tr>
</table>
<%
	if (vecOrg.size() > 0) {
%>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td width="12%"><b>Organisation</b></td>
		<td width="38%"><%=(String) hshValues.get("OrgName")%></td>
		<td width="16%"><b>Generated By</b></td>
		<td width="34%"><%=(String) hshValues.get("genby")%></td>
	</tr>
	<tr>
		<td width="12%"><b>Period</b></td>
		<td width="38%"><%=(String) hshValues.get("txtDate")%></td>
		<td width="16%"><b>Generated On</b></td>
		<td width="34%"><%=(String) hshValues.get("txtSaveDate")%></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td colspan="5">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="16%"><b>Category</b></td>
				<td width="84%"><%=Prodtype%></td>
			</tr>
			<tr>
				<td width="16%"><b>Sub Category</b></td>
				<td width="84%"><%=(String) hshValues.get("strProdcat")%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="4">
	<tr class="dataheader">
		<td width="23%" align="center"><b>Product</b></td>
		<td width="18%" align="center"><b>No of Loans Applications
		secured</b></td>
		<td width="21%" align="center"><b>No of loans Applications
		Sanctioned</b></td>
		<td width="19%" align="center"><b>No of Loans Applications
		Rejected</b></td>
		<td width="19%">
		<div align="center"><b>No of Loans Applications in Process</b></div>
		</td>
		<td width="19%">
		<div align="center"><b>No of Loans Applications in Lodged Status</b></div>
		</td>
	</tr>
	<%
		for (int i = 0; i < vecOrg.size(); i++) {

				vecVal = new ArrayList();
				vecVal = (ArrayList) vecOrg.get(i);
	%>
	<tr class="datagrid">
		<td width="23%" align="left"><%=(String) vecVal.get(1)%></td>
		<td width="17%" align="center">
		<%=(String)vecVal.get(7)
		%>
		</td>
		<td width="20%" align="center">
		<%=(String)vecVal.get(8)
		%>
		</td>
		<td width="19%" align="center">
		<%=(String)vecVal.get(9)
		%>
		</td>
		<td width="21%" align="center">
		<%=(String)vecVal.get(10)
		%>
		</td>
		<td width="21%" align="center">
		<%=(String)vecVal.get(11)
		%>
		</td>
	</tr>
	<%
		}
	%>
	<tr>
		<td width="22%" height="20" align="center"><b>Total : </b></td>
		<td width="17%" height="20" align="center"><b><%=hshValues.get("grandtot")%></b></td>
		<td width="20%" align="center" height="20"><b><%=hshValues.get("grandtot1")%></b></td>
		<td width="22%" height="20" align="center"><b><%=hshValues.get("grandtot2")%></b></td>
		<td width="19%" height="20" align="center"><b><%=hshValues.get("grandtot3")%></b></td>
		<td width="19%" height="20" align="center"><b><%=hshValues.get("grandtot4")%></b></td>
	</tr>
</table>
</table>
<%
	} else {
%>
<h2>
<center>No Data Found</center>
</h2>
<%
	}
%>
<br>
</body>
</html>

