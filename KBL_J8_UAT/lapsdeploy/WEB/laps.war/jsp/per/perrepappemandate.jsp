<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<html>
	<head>
		<title>Application Status</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
		<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
		<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
		<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappemandate.js"></script>
		<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"> </script>
		<script>
			var path="<%=ApplicationParams.getAppUrl()%>";
			var param="";
			var userid ="<%=(String) session.getAttribute("strUserId")%>";
			var rights ="<%=(String) session.getAttribute("strGroupRights")%>";
		</script>
		<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	</head>

	<body onload="callonLoad()">
	<form name="perappstat" method="post" class="normal">
		<iframe height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
		<br>
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="page_flow">Home -&gt; Retail -&gt; Reports -&gt; Pending Digital Loan Application Report</td>
			</tr>
			<tr>
				<td align="right">&nbsp;</td>
			</tr>
		</table>
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="20">
			<tr>
				<td valign="middle">
				<table class="outertable" border="1" cellspacing="0" cellpadding="3" align="center" width="65%">
					<tr>
						<td>
						<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
							<tr>
								<td colspan="2" height="30">
									<table class="outertable" width="100%" border="0" cellspacing="0"
										cellpadding="3">
										<tr>
											<td width="39%" align="center">Organisation Level</td>
										</tr>
										<tr>
											<td width="39%" align="center"><select name="sellevel"
												style="width: 100" onChange="selectValues()" tabindex="1">
												<option selected>---Select---</option>
												<laps:reptag beanid="setupreport" methodname="getLevels"
													param="" />
											</select></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="75%" valign="top" colspan="2">
								<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4">
									<tr align="center">
										<td align="center" width="96%">Select Organisation</td>
									</tr>
									<tr align="center">
										<td width="96%">
											<select name="rpselect1" size="11" style="width: 230" tabindex="3" >
											</select>
										</td>
										<td valign="top">
											<select name="sel_reporttype">
													<option value="A">All Reports</option>
													<option value="F">FI Pending</option>
													<option value="K">KYC Pending</option>
													<option value="M">Mandate Pending</option>
											</select>
										</td>
										<td width="4%" style="visibility: hidden">
											<select
												name="rpselect2" size="11" style="width: 10" tabindex="4"
												multiple id="acctclass">
												<option value="app_no" selected="selected">Proposal Number</option>
												<option value="perapp_title,perapp_fname,perapp_lname">Applicant Name</option>
												<option value="perapp_cbsid">CBS Customer ID</option>
												<option value="cbs_accountno">CBS Account Number</option>
												<option value="CON_APPID, CON_COMADDR1, CON_COMADDR2, CON_COMVILLAGE, CON_COMCITY, CON_COMDIST,
												 CON_COMSTATE, CON_COMZIP, CON_COMCOUNTRY,CON_MOBILE">Address</option>
												<option value="CON_COMPHONE">Phone No.</option>
												<option value="CON_EMAIL,org_name">E-Mail</option>
											</select>
										</td>
									</tr>
									<tr align="center">
										<td align="center" colspan="2">
										<table class="outertable" width="69%" border="1" cellspacing="0"
											cellpadding="3" align="center">
											<tr>
												<td>
												<table class="outertable" width="100%" border="0"
													cellspacing="0" cellpadding="0" align="center">
													<tr>
														<td width="21%" align="center">Period</td>
														<td width="79%" align="center">&nbsp; <input
															type="text" name="txtDate" maxlength="21" readonly
															size="27" onFocus="document.forms[0].cmdrunreport.focus();">
														<a href="#" onClick="showPeriod()" tabindex="5">?</a></td>
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
				</td>
			</tr>
		</table>
		<br>
		<lapschoice:combuttonnew btnnames="Run Report_Reset_Excel Import" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
		 <input	type="hidden" name="hidOrgCode">
		 <input type="hidden" name="hidOpFields">
		 <input type="hidden" name="hidSelFields">
		 <input type="hidden" name="hidStatus">
		 <input type="hidden" name="userid">
		 <input type="hidden" name="repname" value="e-Mandate Report">
		 <input type="hidden" name="txtprofile_name">
		 <input type="hidden" name="hidParam">
		 <input type="hidden" name="hidPage" value="perrepappemandate.jsp">
		 <input type="hidden" name="hidusr_id"> 
		 <input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'> 
		 <input type="hidden" name="hidOrgName">
		</form>
	</body>
</html>
