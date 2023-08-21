<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}

	ArrayList vec = null;
	int vecsize = 0;

	if (hshValues != null) {
		vec = (ArrayList) hshValues.get("vecVal");
	}
	if (vec != null) {
		vecsize = vec.size();
	}
%>

<html>
<head>
<title>About the Products Manufactured / Traded</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/comproduction.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var strvalue="corp_prodabtprod.htm";

</script>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="frmabtprod" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Products -&gt; About Prod.
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="2" cellpadding="3" class="outertable"
			WIDTH="70%">
			<tr align="center">
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comactivities.jsp','compro','getActivity')">Activities</a></b></td>
				<td width="10%" class="sub_tab_active"><b>About Prod.</b></td>
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
	class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					align="center" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr align="center" class="dataheader">
								<td width="24%">Description of the Product/s</td>
								<td width="15%">Units</td>
								<td width="15%" colspan="2">Licensed Capacity</td>
								<td width="13%" colspan="2">Installed Capacity</td>
								<td width="13%" colspan="2">Actual Capacity</td>
								<td width="32%">Main Uses / Application of the Product/s</td>
							</tr>
							<tr class="dataheader">
								<td width="24%" align="center" valign="middle">&nbsp;</td>
								<td width="15%" align="center">&nbsp;</td>
								<td width="7%" align="center">Current Year</td>
								<td width="7%" align="center">Prev year</td>
								<td width="7%" align="center">Current Year</td>
								<td width="7%" align="center">Prev year</td>
								<td width="7%" align="center">Current Year</td>
								<td width="7%" align="center">Prev year</td>
								<td width="32%" align="center">&nbsp;</td>
							</tr>
							<%
								ArrayList g1 = null;

								for (int l = 0; l < 8; l++) {

									int colSize = 0;

									if (l < vecsize) {
										g1 = (ArrayList) vec.get(l);

										if (g1 != null) {
											colSize = g1.size();
										}
									}
									if (colSize > 0) {
							%>
							<tr>
								<td width="24%" align="center" valign="middle"><input
									type="text" name="products" size="20"
									value="<%=Helper.correctNull((String) g1
											.get(2))%>"
									maxlength="99"></td>
								<td width="15%" align="center"><select name="units">
									<option value="" selected="selected">Select</option>
									<option value="Ton"
										<%if ((Helper.correctNull((String) g1.get(3)))
							.equals("Ton"))
						out.println("selected");%>>Ton</option>
									<option value="Litres"
										<%if ((Helper.correctNull((String) g1.get(3)))
							.equals("Litres"))
						out.println("selected");%>>Litres</option>
									<option value="Numbers"
										<%if ((Helper.correctNull((String) g1.get(3)))
							.equals("Numbers"))
						out.println("selected");%>>Numbers</option>
									<option value="Carat"
										<%if ((Helper.correctNull((String) g1.get(3)))
							.equals("Carat"))
						out.println("selected");%>>Carat</option>
									<option value="Metre"
										<%if ((Helper.correctNull((String) g1.get(3)))
							.equals("Metre"))
						out.println("selected");%>>Metre</option>
									<option value="Bales"
										<%if ((Helper.correctNull((String) g1.get(3)))
							.equals("Bales"))
						out.println("selected");%>>Bales</option>
									<option value="Others"
										<%if ((Helper.correctNull((String) g1.get(3)))
							.equals("Others"))
						out.println("selected");%>>Others</option>
								</select></td>
								<td width="8%" align="center"><input type="text"
									name="licenced" size="12"
									value="<%=Helper.correctNull((String) g1
											.get(4))%>"
									onKeyPress="allowNumber(this)" maxlength="15"
									style="text-align: right"></td>
								<td width="7%" align="center"><input type="text"
									name="prevlicenced" size="12" maxlength="15"
									value="<%=Helper.correctNull((String) g1
											.get(8))%>"
									onKeyPress="allowNumber(this)" style="text-align: right">
								</td>
								<td width="6%" align="center"><input type="text"
									name="installed" size="12"
									value="<%=Helper.correctNull((String) g1
											.get(6))%>"
									onKeyPress="allowNumber(this)" maxlength="15"
									style="text-align: right"></td>
								<td width="7%" align="center"><input type="text"
									name="previnstalled" size="12" maxlength="15"
									value="<%=Helper.correctNull((String) g1
											.get(10))%>"
									onKeyPress="allowNumber(this)" style="text-align: right">
								</td>
								<td width="6%" align="center"><input type="text"
									name="actual" size="12"
									value="<%=Helper.correctNull((String) g1
											.get(5))%>"
									onKeyPress="allowNumber(this)" maxlength="15"
									style="text-align: right"></td>
								<td width="7%" align="center"><input type="text"
									name="prevactual" size="12" maxlength="15"
									value="<%=Helper.correctNull((String) g1.get(9))%>"
									onKeyPress="allowNumber(this)" style="text-align: right">
								</td>
								<td width="32%" align="center"><textarea name="uses"
									cols="15" rows="2"><%=Helper.correctNull((String) g1
											.get(7))%></textarea></td>
							</tr>
							<%
								} else {
							%>
							<tr>
								<td width="24%" align="center" valign="middle"><input
									type="text" name="products" size="20" value="" maxlength="99">
								</td>
								<td width="15%" align="center"><select name="units">
									<option value="" selected="selected">Select</option>
									<option value="Ton">Ton</option>
									<option value="Litres">Litres</option>
									<option value="Numbers">Numbers</option>
									<option value="Carat">Carat</option>
									<option value="Metre">Metre</option>
									<option value="Bales">Bales</option>
									<option value="Others">Others</option>
								</select></td>
								<td width="8%" align="center"><input type="text"
									name="licenced" size="12" onKeyPress="allowNumber(this)"
									maxlength="15" style="text-align: right"></td>
								<td width="7%" align="center"><input type="text"
									name="prevlicenced" size="12" onKeyPress="allowNumber(this)"
									maxlength="15" style="text-align: right"></td>
								<td width="6%" align="center"><input type="text"
									name="installed" size="12" onKeyPress="allowNumber(this)"
									maxlength="15" style="text-align: right"></td>
								<td width="7%" align="center"><input type="text"
									name="previnstalled" size="12" onKeyPress="allowNumber(this)"
									maxlength="15" style="text-align: right"></td>
								<td width="6%" align="center"><input type="text"
									name="actual" size="12" onKeyPress="allowNumber(this)"
									maxlength="15" style="text-align: right"></td>
								<td width="7%" align="center"><input type="text"
									name="prevactual" size="12" onKeyPress="allowNumber(this)"
									maxlength="15" style="text-align: right"></td>
								<td width="32%" align="center"><textarea name="uses"
									cols="15" rows="2"></textarea></td>
							</tr>
							<%
								}
								}
							%>
						</table>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td width="16%">Shutdown and maintenance remarks</td>
						<td width="84%"><textarea name="txt_remarks" cols="75"
							onkeypress="textlimit(this,199)" onKeyUp="textlimit(this,199)" onKeyUp="textlimit(this,199)" rows="3"><%=Helper.correctNull((String) hshValues
									.get("com_remarks"))%></textarea></td>
					</tr>
				</table>
		</table>
		</td>
	</tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center"
	class="outertable">
	<tr>
		<td><lapschoice:combuttonnew
			btnnames="Edit_Save_Delete_Cancel_Audit Trail"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>
