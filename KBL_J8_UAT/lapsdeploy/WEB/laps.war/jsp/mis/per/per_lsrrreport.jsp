<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String str_report = Helper.correctNull((String) request.getParameter("hidreportmis"));
	String str_multiple = "";
	if (str_report.equalsIgnoreCase("C")) {
		str_multiple = "multiple";
	} else {
		str_multiple = "";
	}
%>
<html>
<head>
<title>LSRR</title>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/mis/per/per_lsrrreport.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String) session.getAttribute("strUserId")%>";
var rights ="<%=(String) session.getAttribute("strGroupRights")%>";
var report = "<%=str_report%>";

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

</head>

<body onload="callonLoad();enabledept();">
<form name="perappstat" method="post" class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<%if(str_report.equalsIgnoreCase("ADHOC")){ %>
	<tr>
		<td class="page_flow">Home  -&gt; Reports -&gt;
		ADHOC REPORT</td>
	</tr>
	<%}else{ %>
	<tr>
	<td class="page_flow">Home  -&gt; Reports -&gt;
		 Limit Sanction Resolution Register</td>
		</tr>
	<%} %>
		<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable border1 tableBg" border="0" cellspacing="0" cellpadding="3"
			align="center" width="65%">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="5" align="center">
					<tr>
						<td colspan="2" height="30">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="3">
							<tr>
								<td width="39%" align="center">Organisation Level</td>
								<td width="39%" align="center" id="hiddept">Department</td>
								<td width="39%" align="center" id="hiddesignaion">Designation</td>
							</tr>
							<tr>
								
								<td width="39%" align="center"><select name="sellevel"
									style="width: 100px;" onChange="selectValues();enabledept();" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getOrgLevels"
										param="" />
								</select></td>
								<td width="39%" align="center" id="hiddept1"><select name="seldepartment"
									style="width: 125px;" onchange="enabledept();">
									<option value="S"><-- Select --> </option>
                          				<lapschoice:CBSStaticDataNewTag apptype="20" /></td>
								<td width="39%" align="center" id="hiddesignaion1"><select name="seldesignaion"
									style="width: 200px">
									<option value="S"><-- Select --> </option>
									<lapschoice:CBSStaticDataNewTag apptype="15"/>
							</tr>
							<%
								if ("C".equals((String) request.getParameter("report"))) {
							%>
							<tr id="state">
								<td width="36%" align="center" height="35"><select
									name="sel_state" onchange="LoadcityValues()">
									<option value="0" selected>--Select--</option>
									<laps:stateflexmaster />
								</select></td>
							</tr>
							<%
								}
							%>
						</table>
						</td>
					</tr>
					<tr>
						<td width="75%" valign="top" colspan="2">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="4">
							<tr align="center">
								<td align="center" width="96%">Select Organisation</td>
								<td align="center" width="4%">&nbsp;</td>
							</tr>
							<tr align="center">
								<td width="96%"><select name="rpselect1" size="11"
									style="width: 230" tabindex="3" <%=str_multiple%>>
								</select></td>
								</tr>
							
						</table>
						</td>
					</tr>
					<tr align="center">
								<td align="center" colspan="2">
								<table class="outertable border1" width="69%" border="0" cellspacing="0"
									cellpadding="3" align="center">
									<tr>
										<td>
										<table class="outertable" width="100%" border="0"
											cellspacing="0" cellpadding="0" align="center">
											<tr>
												<td width="35%" align="center">Period From</td>
												<td width="20%" align="center">&nbsp; <input
													type="text" name="txtFromDate" maxlength="21" readonly
													size="20" onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmaxdate(this,document.forms[0].txtToDate.value);">&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtFromDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
													<td width="21%" align="center">To</td>
												<td width="20%" align="center">&nbsp; <input
													type="text" name="txtToDate" maxlength="21" readonly
													size="20" onBlur="checkDate(this);checkmindate(this,document.forms[0].txtFromDate.value);">&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtToDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
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
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Run Report_Reset" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input	type="hidden" name="hidOrgCode">
 <input	type="hidden" name="report" value="<%=str_report %>"> 
 <input type="hidden"
	name="userid">  <input type="hidden"
	name="hidusr_id"> <input type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'> <input type="hidden"
	name="hidOrgName">
	<iframe height="0" width="0" name="ifrmsancauthority" frameborder="0" style="border:0"></iframe>
	
	</form>
</body>
</html>
