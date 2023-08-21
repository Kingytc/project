<%@include file="../share/directives.jsp"%>
<%
	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	int vecsize = 0;
	if (hshValues != null) {
		vecData = (ArrayList) hshValues.get("vecData");
	}
%>
<html>
<head>
<title>Educationa Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/per/edueducational.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull(request.getParameter("appstatus"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method=post class="normal"><iframe height="0"
	width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top" colSpan=5><jsp:include
					page="../share/Applurllinkper.jsp" flush="true">
					<jsp:param name="pageid" value="1" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="99%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt; Loan Particulars -&gt; Details for Educational Loan
		-&gt; Educational Details</td>
		<lapschoice:application />
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="7" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr align="center">
				<!-- <td id="prm" class="sub_tab_inactive" WIDTH="20%"><b><a
					href="javascript:callLink('edustudent.jsp','edustudent','getData')">Particulars
				of Student</a></b></td> -->
				<td id="prm" class="sub_tab_active" WIDTH="20%"><b>Educational
				Details</b></td>
				<td id="com2" class="sub_tab_inactive" WIDTH="20%"><a
					href="javascript:callLink('eduscholarship.jsp','eduscholar','getData')"><b>Scholarship
				</b></a></td>
				<td id="com2" class="sub_tab_inactive" WIDTH="20%"><a
					href="javascript:callLink('eduparticulars.jsp','eduparticulars','getData')"><b>Course
				Details </b></a></td>
				<td id="com2" class="sub_tab_inactive" WIDTH="20%"><a
					href="javascript:callLink('educourse.jsp','eduscholar','getDataExp')"><b>Course
				Expenses </b></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr class="dataheader">
										<td align="center" width="29%">Examination</td>
										<td align="center" width="29%">Institution</td>
										<td align="center" width="9%">Year of passing</td>
										<td align="center" width="9%">Attempts made</td>
										<td align="center" width="14%">Percentage of marks(%)</td>
										<td align="center" width="10%">Class obtained</td>
									</tr>
									<tr align="center" class="datagrid">
										<td width="29%"><input type="hidden" name="idno" value="">
										</td>
										<td valign="middle" align="center" width="29%">&nbsp;</td>
										<td width="9%">&nbsp;</td>
										<td width="9%">&nbsp;</td>
										<td width="14%">&nbsp;</td>
										<td width="10%">&nbsp;</td>
									</tr>
									<tr align="center" class="datagrid">
										<td width="29%"><input type="text" name="selyear"
											size="50" onKeyPress="notAllowSplChar()" maxlength="50" >
										</td>
										<td width="29%" valign="middle" align="center"><input
											type="text" name="tution" value="" maxlength="75" size="50"
											onKeyPress="notAllowSplChar()"></td>
										<td width="9%"><input type="text" name="exam" value=""
											onKeyPress="allowNumber(this)" size="6" maxlength="4"
											onBlur="checkcurrentyear(this,currdate)"
											style="text-align: right"></td>
										<td width="9%"><input type="text" name="books" value=""
											onKeyPress="allowNumber(this)" size="4" maxlength="3"
											style="text-align: right"></td>
										<td width="14%"><input type="text" name="lodge" value=""
											onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)"
											size="10" maxlength="8" style="text-align: right">
										</td>
										<td width="10%"><input type="text" name="lab" value=""
											onKeyPress="notAllowSplChar()" size="10" maxlength="3"
											style="text-align: right"></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><lapschoice:combuttonnew
									btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
									btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									
									<tr class="dataheader">
										<td width="3%">&nbsp;</td>
										<td width="29%" align="center">Examination</td>
										<td align="center" width="29%">Institution</td>
										<td align="center" width="8%">
										<p>Year of passing</p>
										</td>
										<td width="8%" align="center">Attempts made</td>
										<td width="10%" align="center">Percentage of marks(%)</td>
										<td width="9%" align="center">Class obtained</td>
									</tr>
									<%
									if (vecData != null) {
										
										vecsize = vecData.size();
											//out.println("vecsize"+vecsize);
										}
										String strSno = "";

										java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
										jtn.setMaximumFractionDigits(2);
										jtn.setMinimumFractionDigits(2);
										jtn.setGroupingUsed(false);

										for (int i = 0; i < vecsize; i++) {
											vecRow = (ArrayList) vecData.get(i);
											if (vecRow != null) {
												strSno = Helper.correctNull((String) vecRow.get(0));
									%>
									<tr class="datagrid">
										<td ALIGN="center"><input type="radio" name="sno"
											style="border-style: none"
											onClick="selectValues(<%=strSno%>)"> <input
											type="hidden" name="hid" value="<%=strSno%>"></td>
										<td>&nbsp;<%=Helper.correctNull((String) vecRow.get(1))%>
										</td>
										<td valign="middle">&nbsp;<%=Helper.correctNull((String) vecRow.get(2))%>
										&nbsp; &nbsp; &nbsp; &nbsp;</td>
										<td valign="middle" ALIGN="center">&nbsp; <%=Helper.correctNull((String) vecRow.get(3))%></td>
										<td valign="middle" ALIGN="center">&nbsp; <%=Helper.correctNull((String) vecRow.get(4))%></td>
										<td valign="middle" ALIGN="RIGHT">&nbsp;<%=Helper.correctDouble((String) vecRow
											.get(5))%></td>
										<td valign="middle" ALIGN="center">&nbsp; <%=Helper.correctNull((String) vecRow.get(6))%></td>
									</tr>
									<%
										}
										}
									%>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="selsno" value=""> <INPUT TYPE="hidden" name="radLoan"
	value="Y"></form>
</body>
</html>
