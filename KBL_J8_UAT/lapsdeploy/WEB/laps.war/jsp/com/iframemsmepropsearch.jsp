<%@include file="../share/directives.jsp"%>
<%
ArrayList g1 = new ArrayList();
%>
<html>
<head>
<title>Msme Proposal Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
function callLink(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9)
{
	document.forms[0].hidCBSID.value=val9;
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanGetMethod.value="getMsmeProposal";
	document.forms[0].action = appURL + "action/msmeproposallink.jsp?";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="ifrmsearch" method="post" class="normal">
<table width="100%" border="0" cellpadding="3" cellspacing="0"
	class="outertable linebor">
	<tr class="dataheader">

		<td width="5%">Sl No</td>
		<td width="10%">Proposal No</td>
		<td width="10%">Facility Sl.No</td>
		<td width="10%">Facility Name</td>
		<td width="10%">Amount</td>
		<td width="10%">Activity Code</td>
		<td width="10%">MIS Classification</td>
		<td width="10%">P & M/ Equipment Value</td>
		<td width="10%">Details Fetched as on date</td>
		<td width="15%">Status of Facility</td>
	</tr>
	<%
	ArrayList v = (ArrayList) hshValues.get("arrRow");
	if (v != null) {
		int vecsize = v.size();

		if (vecsize != 0) {

			for (int l = 0; l < vecsize; l++) {

				g1 = (ArrayList) v.get(l);
%>

	<tr class="datagrid">
		
		<td width="5%"><b><%=l+1%></b></a></td>
		<td width="10%"><%=Helper.correctNull((String) g1.get(0))%></td>
		<td width="10%"><%=Helper.correctNull((String) g1.get(1))%></td>
		<td width="10%"><%=Helper.correctNull((String) g1.get(2))%></td>
		<td width="10%"><%=Helper.correctNull((String) g1.get(3))%></td>
		<td width="10%"><%=Helper.correctNull((String) g1.get(4))%></td>
		<td width="10%"><%=Helper.correctNull((String) g1.get(5))%></td>
		<td width="10%"><%=Helper.correctNull((String) g1.get(6))%></td>
		<td width="10%"><%=Helper.correctNull((String) g1.get(7))%></td>
		<td width="15%"><%=Helper.correctNull((String) g1.get(8))%></td>
	</tr>
	<%}}else {%>

	<tr class="datagrid">
		<td align="center" colspan="10"></td>
	</tr>
	<tr class="datagrid">
		<td align="center" colspan="10">No Data Found</td>
	</tr>

	<%}}%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <INPUT TYPE="hidden"
	name="hidAppType"> <input type="hidden" name="hidDemoId">
<input type="hidden" name="hidoldId"> <input type="hidden"
	name="hidModuleName" value="T"> <input type="hidden"
	name="hidCBSID"> 
</form>

</body>
</html>
