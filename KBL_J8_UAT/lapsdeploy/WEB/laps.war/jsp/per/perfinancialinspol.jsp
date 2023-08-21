<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
	ArrayList arryRow = (ArrayList) hshValues.get("arryRow");%>
<html>
<head>
<title>Personal - Financial Insurance Policies</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/perfinancialinspol.js"></script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var varApptype="<%=Helper.correctNull((String) hshValues.get("strAppValue"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function checkColl()	
{	
	document.all.ifrinsur.src = appURL+"action/iframefinancialinsur.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getFinancialInsuranceCheck&hidid="+document.forms[0].txtinsu_policyno[i].value;
}
function assignData()
{
  try
  {
	document.forms[0].hid_choinsu_applnt.value=document.forms[0].choinsu_applnt.option[document.forms[0].choinsu_applnt.selectedIndex].text;
  }
  catch(er)
  {
    document.forms[0].hid_choinsu_applnt.value=document.forms[0].choinsu_applnt.option[document.forms[0].choinsu_applnt.selectedIndex].text;
  }
}
</SCRIPT>
</head>
<body onload="callOnload()">
<form name="frmfininspol" action="finDBase.jsp" method="post" class="normal">
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="3" /></jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">	
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Securities -&gt; Insurance Policies</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callInvestment()"> Securities</a> </b></td>
				<td align="center" class="sub_tab_active" width="15%"><b> Insurance Policies</b></td>				
				<td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callLiabilities()">Liabilities</a> </b></td>
				<td align="center" class="sub_tab_inactive" width="15%"><b> <a href="JavaScript:callLifeStyle()">LifeStyle</a> </b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="3" cellpadding="3" align="center" class="outertable">
			<tr>
				<td align="right"><a href="JavaScript:callApplicant()"></a>Applicant Type</td>
				<td><select name="selapptype" onChange="getCollData()">
					<option value="">&lt;---- Select ----&gt;</option>
					<lapschoice:fincoappguarantor />
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
					<tr class="dataheader">
						<td align="center">Policy Number</td>
						<td align="center">Maturity Date</td>
						<td align="center">Last Premium Paid upto</td>
						<td align="center">Surrender/Paidup Value</td>
						<td align="center">Insurance Company Name</td>
						<td align="center">Sum Assured</td>
						<td align="center">Collateral</td>
					</tr>
					<tr class="datagrid">
						<td><input type="text" name="txtinsu_policyno" size="23"
							maxlength="20"></td>
						<td align="center">
						<table width="40%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td><input type="text" name="txtinsu_matdate" size="15"
									maxlength="10"
									onBlur="checkDate(this);checkmindate(this,currentDate)"></td>
								<td><a alt="Select date from calender" href="#"
									onClick="callCalender('txtinsu_matdate')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;">&nbsp;<img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
									alt="Select date from calender"></a></td>
							</tr>
						</table>
						</td>
						<td align="center">
						<table width="40%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td><input type="text" name="txtinsu_prepaid" size="15"
									onBlur="checkDate(this)" maxlength="10"></td>
								<td><a alt="Select date from calender" href="#"
									onClick="callCalender('txtinsu_prepaid')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;">&nbsp;<img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
									alt="Select date from calender"></a></td>
							</tr>
						</table>
						</td>
						<td align="center">Rs.<lapschoice:CurrencyTag
							name="txtinsu_surrenderval" size="12" maxlength="12" /></td>
						<td align="center"><input type="text"
							name="txtinsu_agencyname" size="35" maxlength="99"
							onKeyPress="notAllowSingleQuote()"></td>
						<td align="center">Rs.<lapschoice:CurrencyTag
							name="txtinsu_agencyphone" size="12" maxlength="10"  onBlur="roundtxt(this)"/></td>
						<td align="center"><select name="hidinsu_iscoll"
							style="width: 80">
							<option value="s">--Select--</option>
							<option value="Y">Yes</option>
							<option value="n">No</option>
						</select></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
					<tr class="dataheader">
						<td align="center">&nbsp;</td>
						<td align="center" valign="top">Policy Number</td>
						<td align="center" valign="top">Maturity Date</td>
						<td align="center" valign="top">Last Premium Paid upto</td>
						<td align="center" valign="top">Surrender/Paidup Value</td>
						<td align="center" valign="top">Insurance Company Name</td>
						<td align="center" valign="top">Sum Assured</td>
						<td align="center" valign="top">Collateral</td>
					</tr>
					<%
						if (arryRow != null && arryRow.size() > 0) {
							for (int i = 0; i < arryRow.size(); i++) {
								arryCol = (ArrayList) arryRow.get(i);
					%>
					<tr valign="top" class="datagrid">
						<td><input type="radio" name="selradio" style="border: none"
							onclick="SelectValues('<%=Helper.correctNull((String) arryCol.get(0))%>',
							'<%=Helper.correctNull((String) arryCol.get(1))%>', '<%=Helper.correctNull((String) arryCol.get(2))%>', 
							'<%=Helper.correctNull((String) arryCol.get(3))%>', '<%=Helper.correctNull((String) arryCol.get(4))%>',
							'<%=Helper.correctNull((String) arryCol.get(5))%>', '<%=Helper.correctNull((String) arryCol.get(6))%>',
							'<%=Helper.correctNull((String) arryCol.get(7))%>')">
						</td>
						<td><%=Helper.correctNull((String) arryCol.get(1))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(2))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(3))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(4))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) arryCol.get(5))%>&nbsp;</td>
						<td align="right"><%=Helper.correctNull((String) arryCol.get(6))%>&nbsp;</td>
						<%if(Helper.correctNull((String) arryCol.get(7)).equalsIgnoreCase("Y")){%>
						<td>Yes &nbsp;</td>
						<%}else if(Helper.correctNull((String) arryCol.get(7)).equalsIgnoreCase("n")){ %>
						<td>No &nbsp;</td>
						<%} %>
					</tr>
					<%}// End of arryCol
						}%>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag  pageid='<%=PageId%>'/> 
<INPUT TYPE="hidden" name="hidsno"> 
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="hid_choinsu_applnt" /> 
<iframe src="" name="ifrinsur" style="visibility: hidden"></iframe>
</form>
</body>
</html>