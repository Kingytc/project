<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));

	String schemetype = "";
	String maxROI = "";
	schemetype = Helper.correctNull((String) request
			.getParameter("schemetype"));
	String strCropFlag = Helper.correctNull((String) hshValues.get("strCropFlag"));
	if(strCropFlag.equalsIgnoreCase("Y"))
		maxROI = Helper.correctNull((String) hshValues.get("maxCropROI"));
	else
		maxROI = Helper.correctNull((String) hshValues.get("maxOtherCropROI"));

	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	ArrayList arrCol1 = new ArrayList();
	ArrayList arrCol2 = new ArrayList();
	ArrayList arrCol3 = new ArrayList();
	ArrayList arrCol4 = new ArrayList();

	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
	}

	if (arrRow != null && arrRow.size() > 0) {
		arrCol = (ArrayList) arrRow.get(0);
		arrCol1 = (ArrayList) arrRow.get(1);
		arrCol2 = (ArrayList) arrRow.get(2);
		arrCol3 = (ArrayList) arrRow.get(3);
		arrCol4 = (ArrayList) arrRow.get(4);
	}
%>
<html>
<head>
<title>Interest Subvention Details</title>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varschemetype="<%=schemetype%>";
var maxLimit="<%=Helper.correctNull((String) hshValues.get("maxLimit"))%>";

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

</head>
<body onload="">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form name="frmpri" method="post" class="normal"><br>
<table width="60%" border="0" cellspacing="0" cellpadding="3" class=""
	align="center">

	<tr>
		<td>
		<table>
			<tr>
				<td align="left"><b>Application No :</b></td>
				<td align="left"><%=Helper.correctNull((String) hshValues.get("strAppno1"))%></td>
			</tr>

		</table>
		</td>
	</tr>

	<tr>
		<td>

		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
			<tr>
				<td align="center" rowspan="2" width="15%">Year</td>
				<td align="center" rowspan="2" width="15%">Limit Sanctioned</td>
				<td align="center" colspan="2" width="35%">Sub limit as per SOF
				and post harvest expenses eligible for interest subvention</td>
				<td align="center" colspan="2" width="35%">Sub limit for
				ineligible amount for interest subvention</td>
			</tr>
			<tr>
				<td align="center">Amount</td>
				<td align="center">ROI %</td>
				<td align="center">Amount</td>
				<td align="center">ROI %</td>
			</tr>
			<tr>
				<td align="center"><b>I Year</b><input type="hidden"
					name="txt_year" value="I Year"></td>
				<%
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol.get(0)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol.get(3)))%></td>
				<td align="center"><%=maxROI%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol.get(5)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol.get(6)))%></td>
				<%
					} else {
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<%
					}
				%>
			</tr>
			<tr>
				<td align="center"><b>II Year</b><input type="hidden"
					name="txt_year" value="II Year"></td>
				<%
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol1.get(0)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol1.get(3)))%></td>
				<td align="center"><%=maxROI%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol1.get(5)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol1.get(6)))%></td>


				<%
					} else {
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<%
					}
				%>
			</tr>
			<tr>
				<td align="center"><b>III Year</b><input type="hidden"
					name="txt_year" value="III Year"></td>
				<%
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol2.get(0)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol2.get(3)))%></td>
				<td align="center"><%=maxROI%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol2.get(5)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol2.get(6)))%></td>


				<%
					} else {
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>


				<%
					}
				%>
			</tr>
			<tr>
				<td align="center"><b>IV Year</b><input type="hidden"
					name="txt_year" value="IV Year"></td>
				<%
					if (arrRow != null && arrRow.size() > 0) {
				%>


				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol3.get(0)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol3.get(3)))%></td>
				<td align="center"><%=maxROI%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol3.get(5)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol3.get(6)))%></td>


				<%
					} else {
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<%
					}
				%>
			</tr>
			<tr>
				<td align="center"><b>V Year</b><input type="hidden"
					name="txt_year" value="V Year"></td>
				<%
					if (arrRow != null && arrRow.size() > 0) {
				%>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol4.get(0)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol4.get(3)))%></td>
				<td align="center"><%=maxROI%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol4.get(5)))%></td>
				<td align="center"><%=Helper.checkDecimal(Helper
								.correctDouble((String) arrCol4.get(6)))%></td>
				<%
					} else {
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<%
					}
				%>
			</tr>
		</table>

		</td>
	</tr>

</table>

<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno" value=""> <input
	type="hidden" name="hidAction"> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanId"> <input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidBeanGetMethod"> <input
	type="hidden" name="strAppno"
	value="<%=Helper.correctNull((String) hshValues.get("appno"))%>">
<input type="hidden" name="hidschemetype" value="<%=schemetype%>">
<input type="hidden" name="hid_subvention"
	value="<%=Helper.correctNull((String) request
							.getParameter("hid_subvention"))%>">
</form>
</body>
</html>

