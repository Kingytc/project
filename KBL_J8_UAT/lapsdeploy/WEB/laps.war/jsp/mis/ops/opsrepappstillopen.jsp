<%@include file="../../share/directives.jsp"%><html>
<head>
<title>Application Status Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}

</STYLE>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/mis/opsrepappstillopen.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script>
<!--

var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

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
//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>
<form name="repappstill" method="post" class="normal">
<iframe height="0" width="0"
	id="ifrm" frameborder=0 style="border:0"></iframe> <br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">
Home -&gt; Tertiary-&gt;Reports -&gt;Turnaround time Report</td>
	</tr>
	
</table>

		<table class="outertable border1"  border="0" cellspacing="0" cellpadding="3" align="center"
			width="65%">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5"
					align="center">
					<tr>
						<td width="69%" valign="top">
						<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr align="center">
								<td>Organisation Level</td>
								<td>Process Status</td>
							</tr>
							<tr align="center">
								<td><select name="sellevel" style="width:100"
									onChange="selectValues()" tabindex="1">
									<option selected>---Select---</option>
									<lapschoice:reptag beanid="setupreport" methodname="getLevels"
										param="" />
								</select></td>
								<td><select name="cmbstatus" style="width:100" tabindex="2">
									<option selected>---Select---</option>
									<option value="P">Pending</option>
									<option value="A">Approved</option>
									<option value="R">Rejected</option>
								</select></td>
								
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="69%" valign="top">
						<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr align="center">
								
                          <td align="center" width="94%">Select Organisation</td>
								
                          <td align="center" width="6%">&nbsp;</td>
							</tr>
							<tr align="center">
								
                          <td width="94%"> 
                            <select name="rpselect1" size="11"
									style="width:250" tabindex="3">
								</select></td>
								
                          <td width="6%" style="visibility:hidden;"> 
                            <select name="rpselect2" size="11" style="width:10" multiple tabindex="4">
									<option value="app_no">Application Number</option>
									  <option value="perapp_fname,perapp_lname">Applicant Name</option>
									<option value="to_char(APP_CREATEDATE,'DD/MM/YYYY') as app_createdate,to_char(INWARD_DOCRECEIVEDON,'DD/MM/YYYY') as inward_date">Applied Date</option>
									<option value="(SELECT SUM(FACILITY_PROPOSED) FROM FACILITIES WHERE  facility_group='0' and facility_appno=app_no )as facility_proposed">Amount</option>
									<option	value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate,to_char(app_deldate,'DD/MM/YYYY') as app_deldate">Date</option>
									<option value="(select sum(prd_duration) from prd_workflow where prd_flowpoint<9 and  prd_code=app_prdcode) as prd_duration">Assured Turnaround Time(Days)</option>
									<option value="round(to_date(app_processdate,'dd/mm/yyyy')-to_date(APP_CREATEDATE,'dd/mm/yyyy')) as exception_hours,
									round(to_date(app_processdate,'dd/mm/yyyy')-to_date(INWARD_DOCRECEIVEDON,'dd/mm/yyyy'))as inwardexception_hours,
									round(to_date(sysdate,'dd/mm/yyyy')-to_date(APP_CREATEDATE,'dd/mm/yyyy')) as pending_hours,
									round(to_date(sysdate,'dd/mm/yyyy')-to_date(INWARD_DOCRECEIVEDON,'dd/mm/yyyy'))as inwardpending_hours">Actual Time taken(Days)</option>
									<option value="orgs.org_name as rorg_name">Branch</option>
									<option value="usr_lname,usr_fname">Application with</option>
									<option value="organisations.org_name as org_name1">Office</option>
								</select></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="69%" valign="top">
						<table class="outertable" width="80%" border="0" cellspacing="0" cellpadding="3"
							align="center" >
							<tr>
								<td height="37">
								<table class="outertable" width="100%" border="0" cellspacing="5" cellpadding="0"
									align="center">
									<tr>
										<td width="21%" align="center">Amount</td>
										 <td width="79%" align="center"> 
                                        From <lapschoice:CurrencyTag name="txtfromamt" maxlength="15" size="18"  tabindex="6"/> 
                                      	To &nbsp; <lapschoice:CurrencyTag name="txttoamt" maxlength="15" size="18"  tabindex="7"/>
                                      </td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="37">
								<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0"
									align="center">
									<tr>
										<td width="21%" align="center">Period</td>
										<td width="79%" align="center"><input type="text"
											name="txtDate" maxlength="21" readonly size="25"
											onFocus="document.forms[0].rprunreport.focus();"> <a href="#"
											onClick="showPeriod()" class="blackfont" tabindex="5"><b>?</b></a>
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
<table class="outertable border1" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="top">
				<td width="16%">
				<div align="center"><input type="button" name="rprunreport"
					value="Run Report"
					class="buttonothers"
					onClick="runrep()" tabindex="5"></div>
				</td>
			
				<td width="15%">
				<div align="center"><input type="reset" name="rpreset" value="Reset"
				class="buttonothers"
					onClick="JavaScript:resetValues()" tabindex="7"></div>
				</td>
			
				<td width="21%">
				<div align="center"><input type="button" name="rpclose"
					value="Close"
					class="buttonClose"
					onClick="JavaScript:closeWindow()" tabindex="9"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<script language="javascript">
	function disp()
	{
	  var hidValue=document.forms[0].hidOpFields.value;
	}
  </script> <input type="hidden" name="hidBeanId"
	value="repappstillopen"> <input type="hidden" name="hidOrgCode"> <input
	type="hidden" name="hidOpFields"> <input type="hidden"
	name="hidSelFields"> <input type="hidden" name="hidStatus"> <input
	type="hidden" name="userid"> <input type="hidden" name="repname"
	value="Personal Application Still Open Report"> <input type="hidden"
	name="txtprofile_name"> <input type="hidden" name="hidParam"> <input
	type="hidden" name="hidPage" value="perrunappstillopen.jsp"> <input
	type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'>
	<input type="hidden" name="hidOrgName">
	</form>
</body>
</html>
