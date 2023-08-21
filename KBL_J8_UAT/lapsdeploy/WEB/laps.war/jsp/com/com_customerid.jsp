<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Securities Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/com/com_customerid.js"> </script>
	<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCategoryType="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
var countvar="<%=Helper.correctNull((String)request.getParameter("varCount"))%>";
var appCountvar="<%=Helper.correctNull((String)request.getParameter("appCount"))%>";

function doClose()
{	
	var con=ConfirmMsg('100');
	if(con)
	{	window.close();
	}
	
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<%
	String strLink=Helper.correctNull((String)request.getParameter("linkFrom"));
%>
<body>
<form name="persearchMast" method="post" class="normal">

						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td colspan="13"><b>Search By</b></td>
											</tr>
											<tr>
												<td width="3%"><input type="radio" name="radiobutton"
													value="MSMECBSIDSEARCH" style="border-style:none"
													onClick="onRadioClick()"></td>
												<td width="13%">CBS Customer ID</td>
												<td width="13%"><input type="text" name="txtsearch"
													size="20" maxlength="20"
													onKeyPress="notAllowSplChar();" tabindex="2"></td>
												
												<td width="10%"><input type="button" name="cmdOK2"
													value="Search" class="buttonStyle" style="width:75"
													onClick="callExisting()" tabindex="3"></td>
											</tr>
											
											<tr>
												<td colspan="8">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td width="35%"><b>No. of Rows to be Displayed </b></td>
														<td width="65%"><input type="text" name="txt_noofrows"
															size="4" maxlength="2" value="15" onBlur="setCount()"> <b>(Value
														should be below 100)</b></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td colspan="13">
												<table width="100%" border="0" cellspacing="1"
												cellpadding="3" class="outertable"  align="center">
											
													<tr class="dataheader">
														<td width="35%"  align="center">Applicant Name
														</td>
														<td width="35%"  align="center">CBS Customer ID
														</td>
														<td width="30%"  align="center">Applicant ID
														</td>
														
													</tr>
												</table>
												</td>
											</tr>
											<tr class="datagrid">
												<td colspan="13">
												<div align="left"><iframe id="isearch" width="100%"
													height="200"
													src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp"></iframe>
												</div>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
							</td>
							</tr>
						</table>

<lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidAppType" value="P"> 
<input type="hidden" name="hidPageType" value="<%=strLink%>">
<input type="hidden" name="hidDemoId"> 
<input type="hidden" name="hid_rowcount" value=""> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
</form>
</body>
</html>
