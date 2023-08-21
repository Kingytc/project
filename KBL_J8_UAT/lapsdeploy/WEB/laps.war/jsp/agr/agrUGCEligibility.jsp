<%@include file="../share/directives.jsp"%>
<%
%>
<html>
<head>
<title>Appraisal - ELIGIBILITY Calculation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strAction ="<%=Helper.correctNull((String)hshValues.get("hidAction"))%>";
function callload()
{
	disableFields(true);
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	 
	}
}
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callload()">
<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	 class="outertable"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2"
					align="center" class="outertable border1">
					<tr>
						<td>

						<table width="98%" border="0" cellspacing="0" cellpadding="2"
							align="center" class="outertable">
							<tr>
								<td>

								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
											<tr>
												<td valign="top" align="center">
												<table width="100%%" border="0" cellspacing="0" cellpadding="4" class="outertable">
													
													<tr>
														<td>
														<table width="100%" border="0" cellspacing="0"
															cellpadding="4" class="outertable">
                                              <tr> 
                                                <td width="43%">Eligible amount based on land owned</td>
                                                <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td width="52%"> 
                                                  <input type="text" name="txt_amount_pe" size="25" style="text-align:right"
													value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("eligible_amount"))))%>"> 
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td>Loan amount requested</td>
                                                <td><b><%=ApplicationParams.getCurrency()%></b></td>
                                                <td> <input type="text" name="txt_amount_an" size="25" style="text-align:right"
													value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("amt_requested"))))%>"> 
                                                </td>
                                              </tr>                                              
                                              <tr> 
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
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
		</td>
	</tr>
</table>
<input type="hidden" name="txtloan_sancamt" value="<%=Helper.correctNull((String)request.getParameter("sancmount"))%>">
<input type="hidden" name="cmdsave" disabled>
<lapschoice:agrihiddentag />


</form>
</body>
</html>
