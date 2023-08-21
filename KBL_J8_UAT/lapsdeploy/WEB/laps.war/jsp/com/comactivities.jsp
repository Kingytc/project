<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList vec = null;
	int vecsize = 0;
	ArrayList vec1 = null;
	int vecsize1 = 0;
	if (hshValues != null) {
		vec = (ArrayList) hshValues.get("vecVal");
		vec1 = (ArrayList) hshValues.get("vecVal1");
	}
	if (vec != null) {
		vecsize = vec.size();
	}
	if (vec1 != null) {
		vecsize1 = vec1.size();
	}
%>
<html>
<head>
<title>Activities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/com/com_activities.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strvalue="corp_prodact.htm";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="frmproactivities" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan="5"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1">
	<tr>
		<td class="page_flow">Home -&gt; Corporate & SME -&gt; Existing
		Application -&gt; Products -&gt; Activities</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="2" cellpadding="3" width="70%"
			class="outertable">
			<tr align="center">
				<td width="10%" class="sub_tab_active"><b>Activities</b></td>
				<td width="10%" class="sub_tab_inactive"><b><a
					href="javascript:callLink('comproduction.jsp','combanking','getProductData')">About
				Prod.</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')">Raw
				Materials</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comprocessdesc.jsp','combanking','getDescData')">Manf.Process
				</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')">Govt.Policy</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comtransport.jsp','combanking','getTransData')">Transportation</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('commarketing.jsp','combanking','getSegmentData')">Marketing</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="50%">
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr align="center" class="dataheader">
						<td colspan="3">Details of Manufacturing Activities</td>
					</tr>
					<%
						ArrayList g1 = null;

						for (int l = 0; l < 1; l++) {

							int colSize = 0;

							if (l < vecsize) {
								g1 = (ArrayList) vec.get(l);

								if (g1 != null) {
									colSize = g1.size();

								}
							}

							//String type=Helper.correctNull((String)g1.get(9));

							if (colSize > 0) {
					%>
					<tr align="center">
						<td colspan="3"><textarea name="manufacturing" cols="80"
							rows="10" onKeyUp="textlimit(manufacturing,3996)" onKeyPress="textlimit(this,3996)"><%=Helper.correctNull((String) g1
											.get(3))%></textarea> <input type="hidden" name="mfgtype"
							size="60" value="M"></td>
					</tr>
					<%
						} else {
					%>
					<tr align="center">
						<td colspan="3"><textarea name="manufacturing" cols="80"
							onKeyUp="textlimit(manufacturing,3996)" onKeyPress="textlimit(this,3996)" onKeyPress="" rows="10"></textarea>
						<input type="hidden" name="mfgtype" size="60" value="M"></td>
					</tr>
					<%
						}
						}
					%>
				</table>
				</td>
				<td width="50%">
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr align="center" class="dataheader">
						<td colspan="3">Details of Trading Activities</td>
					</tr>
					<%
						ArrayList g2 = null;
						//if(vecsize1!=0)
						//{
						for (int j = 0; j < 1; j++) {

							int colSize1 = 0;

							if (j < vecsize1) {
								g2 = (ArrayList) vec1.get(j);

								if (g2 != null) {
									colSize1 = g2.size();
								}
							}

							//String type1=Helper.correctNull((String)g2.get(9));

							if (colSize1 > 0) {
					%>
					<tr align="center">
						<td colspan="3" width="50%"><textarea name="trading"
							cols="80" onKeyUp="textlimit(trading,3996)" onKeyPress="textlimit(this,3996)"
							rows="10"><%=Helper.correctNull((String) g2
											.get(3))%></textarea> <input type="hidden" name="trdtype"
							size="60" value="T"></td>
					</tr>
					<%
						}

							else {
					%>
					<tr align="center">
						<td colspan="3" width="50%"><textarea name="trading"
							rows="10" cols="80" onKeyUp="textlimit(trading,3996)"
							onKeyPress="textlimit(this,3996)"></textarea> <input type="hidden" name="trdtype"
							size="60" value="T"></td>
					</tr>
					<%
						}

						}
						//}
					%>
				</table>
				</td>
			</tr>
		</table>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center"
	class="outertable">
	<tr>
		<td><lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>
