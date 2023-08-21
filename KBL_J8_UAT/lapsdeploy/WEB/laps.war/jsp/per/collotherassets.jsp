<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
ArrayList arryRow = (ArrayList) hshValues.get("arryRow");%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/percollotherassests.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>"; 
var appURL = "<%=ApplicationParams.getAppUrl()%>"; 
var varApptype="<%=Helper.correctNull((String) hshValues.get("strAppValue"))%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="4" /></jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Collateral Security-&gt;Other Assets</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="sub_tab_inactive" width="15%"><a href="JavaScript:callhome()"><b>Immovable Property</b></a></td>
				<td class="sub_tab_inactive" width="15%"><a href="JavaScript:callcar()"><b>Vehicle</b></a></td>
				<td class="sub_tab_active" width="15%">Other Assets</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
							<tr>
								<td>
								<table width="60%" border="0" cellspacing="3" cellpadding="3" align="center" class="outertable">
									<tr>
										<td align="right"><a href="JavaScript:callApplicant()"> </a>Applicant Type</td>
										<td><select name="selapptype" onChange="getCollData()">
											<option value="">&lt;---- Select ----&gt;</option>
											<lapschoice:fincoappguarantor />
										</select></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td valign="top" align="center">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
											<tr align="center" class="dataheader">
												<td>Security Details</td>
												<td>Particulars</td>
												<td>Purchase Price (Rs.)</td>
												<td>Market Value (Rs.)</td>
												<td>Valuation Date</td>
												<td>Valuation done by</td>
											</tr>
											<tr align="center" class="datagrid">
												<td><input type="text" name="txt_security" size="40" maxlength="30"></td>
												<td><input type="text" name="txt_particular" size="40" maxlength="30"></td>
												<td><lapschoice:CurrencyTag name="txt_purchase" size="15" maxlength="12" /></td>
												<td><lapschoice:CurrencyTag name="txt_market" size="15" maxlength="12" /></td>
												<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
													<tr>
														<td><input type="text" name="txt_valuationdate" size="11" onBlur="checkDate(this)" readOnly></td>
														<td><a alt="Select date from calender" href="#"
															onClick="callCalender('txt_valuationdate')"
															onMouseOver="window.status='Date Picker';return true;"
															onMouseOut="window.status='';return true;" tabindex="17"><img
															src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
															border=0 alt="Select date from calender"></a></td>
													</tr>
												</table>
												</td>
												<td align="center"><input type="text" name="txt_valuername" size="30" maxlength="20"></td>
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
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>				
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
			<tr class="dataheader" align="center">
				<td width="3%">&nbsp;</td>
				<td width="27%"><b>Security Details</b></td>
				<td width="25%"><b>Particulars</b></td>
				<td width="10%"><b>Purchase Price (Rs.)</b></td>
				<td width="10%"><b>Market Value (Rs.)</b></td>
				<td width="10%"><b>Valuation Date</b></td>
				<td width="15%"><b>Valuation done by</b></td>
			</tr>
			<%
				if(arryRow!=null && arryRow.size()>0)
				{
					for(int i=0;i<arryRow.size();i++)
					{
						arryCol=(ArrayList)arryRow.get(i);%>
			<tr class="datagrid">
				<td><input type="radio"
						style="border:none" name="radiobutton" value="radiobutton"
						onClick="selectValues('<%=Helper.correctNull((String)arryCol.get(0))%>',
											'<%=Helper.correctNull((String)arryCol.get(1))%>',
											'<%=Helper.correctNull((String)arryCol.get(2))%>',
											'<%=Helper.correctNull((String)arryCol.get(3))%>',
											'<%=Helper.correctNull((String)arryCol.get(4))%>',
											'<%=Helper.correctNull((String)arryCol.get(5))%>',
											'<%=Helper.correctNull((String)arryCol.get(6))%>')">
				</td>
				<td><%=Helper.correctNull((String)arryCol.get(1)) %>&nbsp;</td>
				<td><%=Helper.correctNull((String)arryCol.get(2)) %>&nbsp;</td>
				<td align="right">&nbsp;<%=Helper.correctNull((String)arryCol.get(3)) %></td>
				<td align="right">&nbsp;<%=Helper.correctNull((String)arryCol.get(4)) %></td>
				<td><%=Helper.correctNull((String)arryCol.get(5)) %>&nbsp;</td>
				<td><%=Helper.correctNull((String)arryCol.get(6)) %>&nbsp;</td>
			</tr>
			<%}}%>
			<tr class="datagrid"><td colspan="7">&nbsp;</td></tr>
		</table>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="chobank_apptype1" value="">
<input type="hidden" name="hidsno" value="">
</form>
</body>
</html>
