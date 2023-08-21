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
<title>Education Scholarship Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/per/eduscholarship.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
//var varpageid="<%=Helper.correctNull((String) hshValues
									.get("PageId"))%>";
function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method=post class="normal"><iframe height="0" width="0"
	id="ifrm" frameborder=0 style="border: 0"></iframe>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td id="mainlnk" colspan="2"><jsp:include
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
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt;
		Loan Particulars -&gt; Details for Educational Loan -&gt; Scholarship</td>
		<lapschoice:application />
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0"
			class="outertable" align="left">
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
			class="outertable" align="left">
			<tr align="center">
				<!--  <td width="20%" class="sub_tab_inactive" id="prm"><b> <a
					href="javascript:callLink('edustudent.jsp','edustudent','getData')">Particulars
				of Student</a></b></td>-->
				<td width="20%" class="sub_tab_inactive" id="com2"><a
					href="javascript:callLink('edueducational.jsp','edudetails','getData')"><b>Educational
				Details</b></a></td>
				<td width="20%" class="sub_tab_active" id="com2"><b>Scholarship</b></td>
				<td width="20%" class="sub_tab_inactive" id="com2"><a
					href="javascript:callLink('eduparticulars.jsp','eduparticulars','getData')"><b>Course
				Details </b></a></td>
				<td width="20%" class="sub_tab_inactive" id="com2"><a
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
										<td width="16%" align="center">Examination</td>
										<td align="center" WIDTH="16%">Academic Distinction</td>
										<td align="center" WIDTH="16%">Name of Scholarship</td>
										<td align="center" WIDTH="16%">Amount</td>
										<td align="center" WIDTH="16%">Duration From</td>
										<td align="center" WIDTH="16%">Duration To</td>
									</tr>
									<tr align="center" class="datagrid">
										<td width="25%">&nbsp;</td>
										<td valign="middle" align="center" width="25%"><input
											type="hidden" name="idno" value=""></td>
										<td width="25%">&nbsp;</td>
										<td width="8%">&nbsp;</td>
										<td width="8%">&nbsp;</td>
										<td width="8%">&nbsp;</td>
									</tr>
									<tr align="center" class="datagrid">
										<td width="25%"><input type="text" name="selyear"
											size="40" maxlength="40" onKeyPress="notAllowSplChar()"></td>
										<td width="25%" valign="middle" align="center"><input
											type="text" name="tution" value="" maxlength="40" size="40"
											onKeyPress="notAllowSplChar()"></td>
										<td width="25%"><input type="text" name="exam" value=""
											onKeyPress="notAllowSplChar()" size="40" maxlength="40"
											style="text-align: left"></td>
										<td width="8%"><input type="text" name="books" size="10"
											onKeyPress="allowNumber(this)" onBlur="roundtxt(this)"
											maxlength="9" style="text-align: right"></td>
										<td width="8%">
										<table class="outertable">
											<tr>
												<td><input type="text" name="lodge" value="" size="12"
													maxlength="10" style="" onBlur="checkDate(this)"></td>
												<td><a alt="Select date from calender" href="#"
													onClick="callCalender('lodge')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border=0 alt="Select date from calender"></a></td>
											</tr>
										</table>
										</td>
										<td width="8%">
										<table class="outertable">
											<tr>
												<td><input type="text" name="lab" value="" size="12"
													maxlength="12" style=""
													onBlur="checkDate(this);checkFileDate(this)"></td>
												<td><a alt="Select date from calender" href="#"
													onClick="callCalender('lab')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border=0 alt="Select date from calender"></a></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<lapschoice:combuttonnew
								btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
								btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<%
										if (vecData != null) {
									%>
									<tr class="dataheader">
										<td width="3%">&nbsp;</td>
										<td width="16%" align="CENTER">Examination</td>
										<td align="CENTER" width="16%">Academic Distinction</td>
										<td align="CENTER" width="16%">
										<p>Name of Scholarship</p>
										</td>
										<td width="16%" align="CENTER">Amount</td>
										<td width="16%" align="CENTER" nowrap>Duration From</td>
										<td width="16%" align="CENTER">Duration To</td>
									</tr>
									<%
										vecsize = vecData.size();
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
										<td valign="middle">&nbsp; <%=Helper.correctNull((String) vecRow.get(3))%></td>
										<td align="right">&nbsp; <%=Helper.correctNull((String) vecRow.get(4))%></td>
										<td valign="middle" ALIGN="center"><%=Helper.correctNull((String) vecRow.get(5))%></td>
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
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <INPUT TYPE="hidden"
	name="radLoan" value="Y"> <input type="hidden" name="selsno"
	value=""></form>
</body>
</html>

