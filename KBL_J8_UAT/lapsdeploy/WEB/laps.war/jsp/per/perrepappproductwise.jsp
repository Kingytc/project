<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<html>
<head>
<title>Productwise Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappproductwise.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var rights ="<%=session.getAttribute("strGroupRights")%>";
var userid ="<%=session.getAttribute("strUserId")%>";

function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
		
		function changeLoanType()
{
//document.forms[0].rpprod.length =0;
//deSelect();

 	if(document.forms[0].selprodtype.value.toUpperCase()=="A")
 	{
	 	document.forms[0].selappno.length=21;
	 	document.forms[0].selappno.options[0] = new Option('Poultry Boiler','pA');
	 	document.forms[0].selappno.options[1] = new Option('Bullock Cart','pB');
        document.forms[0].selappno.options[2] = new Option('Crop Loans','pC');
        document.forms[0].selappno.options[3] = new Option('Diary Farming','pD');
        document.forms[0].selappno.options[4] = new Option('Animal Rearing','pE');
        document.forms[0].selappno.options[5] = new Option('Farm Machinery','pF');
        document.forms[0].selappno.options[6] = new Option('Gobar Gas Plant','pG');
        document.forms[0].selappno.options[7] = new Option('Gold Loan','pH');
        document.forms[0].selappno.options[8] = new Option('Consumption Loan','pI');
        document.forms[0].selappno.options[9] = new Option('Sericulture','pJ');
        document.forms[0].selappno.options[10] = new Option('Loan Against Warehouse Receipts','pL');
        document.forms[0].selappno.options[11] = new Option('Vehicle Loan','pM');
        document.forms[0].selappno.options[12] = new Option('Fisheries','pN');
        document.forms[0].selappno.options[13] = new Option('Poultry Layering','pP');
        document.forms[0].selappno.options[14] = new Option('Plantation Term Loan','pQ');
        document.forms[0].selappno.options[15] = new Option('Loan Against deposit','pR');
		document.forms[0].selappno.options[16] = new Option('Minor Irrigation','pU');
		document.forms[0].selappno.options[17] = new Option('Common Product','pK');
		document.forms[0].selappno.options[18] = new Option('Union General Credit Card','pV');
		document.forms[0].selappno.options[19] = new Option('Purchase of fodder','pT');
		document.forms[0].selappno.options[20] = new Option('Union Bhumiheen Card','pW');
        document.forms[0].selappno.options[21] = new Option('Coffee Plantation','pO'); 
		
     }
  	if(document.forms[0].selprodtype.value.toUpperCase()=="P")
	{
		document.forms[0].selappno.length=14;
		document.forms[0].selappno.options[0] = new Option('Housing Loan','pH');
		document.forms[0].selappno.options[1] = new Option('Salaried Person','pP');
		document.forms[0].selappno.options[2] = new Option('Vehicle Loan','pA');
		document.forms[0].selappno.options[3] = new Option('Mortgage Loan','pM');
		document.forms[0].selappno.options[4] = new Option('Gold Loans','pG');
		document.forms[0].selappno.options[5] = new Option('Loan against Deposits','pR');
        document.forms[0].selappno.options[6] = new Option('Mahila Udyog','pU');
        document.forms[0].selappno.options[7] = new Option('Ravi Kiran','pK');
        document.forms[0].selappno.options[8] = new Option('Education Loan','pE');
        document.forms[0].selappno.options[9] = new Option('Leased Loan','pL');
        document.forms[0].selappno.options[10] = new Option('Instacash Loan','pI');
        document.forms[0].selappno.options[11] = new Option('Clean Loan','pC');
        document.forms[0].selappno.options[12] = new Option('NSC Loan','pN');
        document.forms[0].selappno.options[13] = new Option('Suvidha Loan','pV');
        document.forms[0].selappno.options[14] = new Option('General Loan','pJ');
 	}
}
//-->
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>
<form name="orgfrm" method="post" class="normal"><iframe height="0" width="0"
	id="ifrm" frameborder=0 style="border: 0"></iframe>
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home
		-&gt; Retail-&gt;Reports-&gt;Productwise Performance
		status </td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="20">
	<tr>
		<td valign="middle">
		<div align="left">
		<table class="outertable"  width="85%" border="1" cellspacing="0" cellpadding="5"
			align="center">
			<tr>
				<td>
				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="2"
					align="center">
					<tr>
						<td colspan="3">
						<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3"
							align="center">
							<tr>
								<td align="center" width="33%">Organisation Level</td>
								<td align="center" width="64%">Product Type</td>
								<td align="center" width="3%">&nbsp;</td>
							</tr>
							<tr>
								<td align="center" width="33%"><select name="sellevel"
									style="width: 120" onChange="selectValues()" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getLevels"
										param="" />
								</select></td>
								<td align="center" width="64%"><select name="selprodtype"
									tabindex="2" onChange="changeLoanType()">
									<option selected value="S"><---Select---></option>
									<option value="P">Retail</option>
								</select></td>
								<td align="center" width="3%"></td>
							</tr>
							<tr>
								<td align="center" width="33%">Select Organisation</td>
								<td align="center" width="64%">Select Products</td>
								<td align="center" width="3%">&nbsp;</td>
							</tr>
							<tr>
								<td align="center" valign="top" width="33%"><select
									name="rpselect1" size="11" style="width: 180" tabindex="3">
								</select></td>
								<td align="center" valign="top" width="64%"><select
									name="selappno" size="11" multiple style="width: 350"
									tabindex="4">
								</select></td>
								<td align="center" valign="top" style="visibility: hidden;"
									width="3%"><select name="rpselect2" size="11"
									style="width: 10; " multiple tabindex="5">
									<option value="(case when LOAN_PERTAINS_BRANCH is not null then (case when app_orglevel='C' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) when app_orglevel='D' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) else org_name end) else organisations.org_name end )as org_name">Branch</option>
									<option value="cat2.cat_name,prd_type">Product Name</option>
									<option value="app_status">Application Status</option>
									<option value="app_no">No Of
									Applications</option>
									<option value="loan_recmdamt">Loan
									Amount</option>
								</select></td>
							</tr>
							<tr>
								<td align="center" valign="top" colspan="3">
								<table class="outertable"  width="50%" border="1" cellspacing="0" cellpadding="3"
									align="center">
									<tr>
										<td>
										<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0"
											align="center">
											<tr>
												<td width="21%" align="center">Period</td>
												<td width="79%" align="center"><input type="text"
													name="txtDate" maxlength="21" readonly size="25"
													onFocus="document.forms[0].cmdrunreport.focus();"> <a
													href="#" onClick="showPeriod()"
													tabindex="6"><b>?</b></a></td>
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
		</div>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidOpFields"> <input type="hidden"
	name="hidSelFields"> <input type="hidden" name="hidOrgCode">
<input type="hidden" name="hidProducts"> <input type="hidden"
	name="repname" value="Personal Productwise Report"> <input
	type="hidden" name="hidParam"> <input type="hidden"
	name="txtprofile_name"> <input type="hidden" name="userid">
<input type="hidden" name="hidPage" value="perrunappproductwise.jsp">
<input type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'> <input type="hidden"
	name="hidOrgName"></form>
</body>
</html>
