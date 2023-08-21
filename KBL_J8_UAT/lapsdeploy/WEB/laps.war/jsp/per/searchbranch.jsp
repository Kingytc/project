<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrValues = new ArrayList();

	if (hshValues != null) {
		arrValues = (ArrayList) hshValues.get("arrRow");
	}

		
%>

<html>
<head>
<title>Search branch with regional office</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function setCustVal(val0,val1,val2)
{
   
		window.opener.document.forms[0].txt_solid.value = val0;
		
     	window.opener.document.forms[0].txt_BranchName.value = val1;
     	
     	window.opener.document.forms[0].txt_RegionName.value = val2;
     	
     	window.close();
    
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>Application Number Search</b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="98%" border="1" cellpadding="3" cellspacing="0"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					class="outertable">
					<!--<tr>
						<td width="5%"><input type="radio" name="radiobutton"
													value="inward" style="border-style:none"
													tabindex="1" onClick="onRadioClick()"></td>
												<td width="20%">Application No.</td>

						<td width="5%"><input type="radio" name="radiobutton"
													value="cbscustid" style="border-style:none"
													tabindex="2" onClick="onRadioClick()" checked="checked"></td>
												<td width="20%">CBS Customer ID</td>
												
												<td width="5%"><input type="radio" name="radiobutton"
													value="name" style="border-style:none"
													onClick="onRadioClick()" tabindex="3"></td>
												<td width="20%">Name</td>
						<td width="25%" align="center"><input type="text"
							name="txt_ackname" size="25" maxlength="400" value=""
							onKeyPress="notAllowSplChar();"></td>
						<td width="25%"><input type="button" name="cmdsearch"
							value="Search" class="buttonStyle" onClick="callSearch()">
						</td>  -->
					</tr>
					<tr>
						<td nowrap="nowrap" colspan="3">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">

					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="outertable">
						<tr>
							<td valign="top">
							<table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
								<tr class="dataheader">
									<td width="10%">Slno</td>
									<td width="25%">Sold ID</td>
									<td width="25%">Brach Name</td>
									<td width="40%">Regional Office</td>
									
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td valign="top" align="center">
							<DIV class="cellContainer">
							<table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
								<%
									if (arrValues != null) {
										int arrSize = arrValues.size();
										ArrayList arrCol = null;
										for (int i = 0; i < arrSize; i++) {
											arrCol = new ArrayList();
											if (arrCol != null) {
												arrCol = (ArrayList) arrValues.get(i);
										%>
								
								<tr class="datagrid">
									<td width="10%"><%=i + 1%></td>
									<td width="25%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a></td>
									<td width="25%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>
									<td width="40%"><a href="#"
										onclick="javascript:setCustVal('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>',
																		'<%=Helper.correctNull((String) arrCol.get(2))%>')"><%=Helper.correctNull((String) arrCol.get(2))%></a></td>
								</tr>
								<%
									}
										}

									}
								%>
							</table>
							</div>
							<table width="0%" border="0" cellspacing="0" cellpadding="3"
								align="center" class="outertable">
								<tr valign="top">
									<td width="20%" align="center"><input type="button"
										class="buttonClose" value="Close" name="closebtn" tabindex="25"
										onClick="window.close()"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
				<!-- end -->
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidBeanMethod" value="getInwardnoSearchList">
<input type="hidden" name="hidBeanId" value="inwardRegister"> <input
	type="hidden" name="hidBeanGetMethod" value="getInwardnoSearchList">
<input type="hidden" name="Category"
	value="<%=Helper.correctNull((String) request
							.getParameter("Category"))%>">
<input type="hidden" name="Cusprofile" value="<%=Helper.correctNull((String)hshValues.get("Cusprofile"))%>">
<input type="hidden" name="proposal"
	value="<%=Helper.correctNull((String) request
							.getParameter("proposal"))%>">
							
<input type="hidden" name="rdovalue" value="">	
<input type="hidden" name="reqpagefrom" value="<%=Helper.correctNull((String)hshValues.get("reqpagefrom"))%>">	
<br>
</form>
</body>
</html>
