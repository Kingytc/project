<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Master Search Personal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/ops/ops_mastersearch.js"> </script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="rowCount('0')">
<form name="persearchMast" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Customer Profile Search</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top"><b>Tertiary Master Details</b><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
											<tr>
												<td colspan="7"><b>Search By</b> </td>
											</tr>
											<tr>
												<td width="3%"><input type="radio" name="radiobutton"
													value="first" style="border-style:none"
													onClick="onRadioClick()" tabindex="1"></td>
												<td width="9%">Full Name</td>
												<td width="3%"> <input type="radio"
													name="radiobutton" value="CBSID" style="border-style:none"
													onClick="onRadioClick()"> </td>
												<td width="13%">CBS Customer ID</td>
												<td width="13%"><input type="text" name="txtsearch"
													size="20" maxlength="20" readOnly
													onKeyPress="notAllowSplChar();" tabindex="2"></td>
												<td width="10%"><input type="button" name="cmdOK2"
													value="Search" class="buttonStyle" style="width:75"
													onClick="callExisting()" tabindex="3"></td>
												<td width="18%"><input type="button" name="cmdOK22"
													value="New Applicant" class="buttonStyle" style="width:100"
													onClick="callNew()"></td>
											</tr>
											<!-- for no of rows to be displayed -->
											<tr>
												<td colspan="7">
												<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
													<tr>
														<td width="19%"><b>No. of Rows to be Displayed </b>
														</td>
														<td width="81%"><input type="text" name="txt_noofrows"
															size="4" maxlength="2" value="15" onBlur="setCount()"> 
														<b>(Value should be below 100)</b></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td colspan="7">
												<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor">
													<tr class="dataheader">
														<td width="35%" align="center" ><b>Applicant Name</b>
														</td>
														<td width="10%" nowrap align="center" ><b>CBS Customer ID</b>
														</td>
														<td width="10%" nowrap align="center" ><b>Applicant ID</b>
														</td>
														<td width="10%" align="center" ><b>PAN No.</b>
														</td>
														<td width="35%" align="center" ><b>Branch Name</b>
														</td>
													</tr>												
											<tr>
												<td colspan="7"><iframe id="isearch" width="100%" height="200"
													src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp"></iframe>
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
									</td>
									</tr>
									</table>
									</td>
									</tr>
									</table>
									<!-- next and prev -->
									<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
										<tr>
											<td width="9%" nowrap><a href="javascript:rowCount('1')"
												><b>&lt;&lt;Previous</b></a></td>
											<td width="84%">&nbsp;</td>
											<td align="right" width="7%"><a
												href="javascript:rowCount('2')" ><b>Next&gt;&gt;</b></a></td>
										</tr>
									</table>
<br>
<lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidAppType" value="T">
<input type="hidden" name="hid_rowcount" value=""> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
</form>
</body>
</html>
