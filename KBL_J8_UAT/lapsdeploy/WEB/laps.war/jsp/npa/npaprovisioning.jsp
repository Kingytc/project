<%@include file="../share/directives.jsp"%>
<% 
	ArrayList arrRow=null;
	ArrayList arrCol=null;
	arrRow = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<title>NPA Provisioning</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varUserFlag="<%=Helper.correctNull((String)hshValues.get("strAvailUsersFlag"))%>";
var varPendingExists="<%=Helper.correctNull((String)hshValues.get("pending_fileexists"))%>";
var varPendingFileName="<%=Helper.correctNull((String)hshValues.get("pending_filename"))%>";
var varradval="<%=Helper.correctNull((String)hshValues.get("txt_radval"))%>";
var varexception="<%=Helper.correctNull((String)hshValues.get("EXE_EXCEPTION"))%>";
var LastRunDate="<%=Helper.correctNull((String)hshValues.get("strQEndDate")) %>";
function doInitiateRun()
{

	if(document.forms[0].txt_qenddate.value=="")
	{
		alert("Select Provision Run upto the Date");
		document.forms[0].txt_qenddate.focus();
		return;
	}
	if(confirm("Do you want to Initiate the Calculation process"))
	{
		document.forms[0].btn_run.disabled = true;
		document.all.file_exists.style.display = "none";
		document.all.init_upload.style.display = "none";
		document.all.init_calculate.style.display = "table-row";
		
		document.forms[0].hidAction.value="Calculate";
		document.forms[0].hidBeanId.value="borrowersearch";
		document.forms[0].hidBeanMethod.value="updateNPAprovisioning";
		document.forms[0].hidBeanGetMethod.value="getNPAProvisioning";
		document.forms[0].action = appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value = "/action/npaprovisioning.jsp";
		document.forms[0].submit();
	}
}

function doUploadFile()
{
	if(confirm("Do you want to Upload the NPA data file stored in server location"))
	{
		document.forms[0].btn_upload.disabled = true;
		document.all.file_exists.style.display = "none";
		document.all.init_upload.style.display = "table-row";
		document.all.init_calculate.style.display = "none";
		
		document.forms[0].hidAction.value="UploadFile";
		document.forms[0].hidBeanId.value="borrowersearch";
		document.forms[0].hidBeanMethod.value="updateNPAprovisioning";
		document.forms[0].hidBeanGetMethod.value="getNPAProvisioning";
		document.forms[0].action = appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value = "/action/npaprovisioning.jsp";
		document.forms[0].submit();
	}
}

function doRevertFile()
{
	if(confirm("Do you want to Revert the uploaded NPA data file -->"+varPendingFileName))
	{
		document.forms[0].hidAction.value="RevertFile";
		document.forms[0].hidBeanId.value="borrowersearch";
		document.forms[0].hidBeanMethod.value="updateNPAprovisioning";
		document.forms[0].hidBeanGetMethod.value="getNPAProvisioning";
		document.forms[0].action = appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value = "/action/npaprovisioning.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function dobtnDisable()
{
	if(varPendingExists == "Y")
	{
		document.all.file_exists.style.display = "table-row";
		document.all.init_upload.style.display = "none";
		document.all.init_calculate.style.display = "none";
		document.forms[0].btn_upload.disabled = true;
		document.forms[0].btn_revert.disabled = false;
		document.forms[0].btn_run.disabled = false;
	}
	else
	{
		document.all.file_exists.style.display = "none";
		document.all.init_upload.style.display = "none";
		document.all.init_calculate.style.display = "none";
		document.forms[0].btn_upload.disabled = false;
		document.forms[0].btn_revert.disabled = true;
		document.forms[0].btn_run.disabled = true;
	}
}

function onload()
{
	if(varradval == "C")
		document.forms[0].rad_value[0].checked = true;
	if(varradval == "O")
		document.forms[0].rad_value[1].checked = true;
	if(varradval == "N")
		document.forms[0].rad_value[2].checked = true;
	if(varradval == "L")
		document.forms[0].rad_value[3].checked = true;

	/*if(document.forms[0].rad_value[0].checked)
	{
		document.all.span_desc.innerHTML = "Customer ID";
	}
	else if(document.forms[0].rad_value[1].checked)
	{
		document.all.span_desc.innerHTML = "Organizations";
	}
	else if(document.forms[0].rad_value[2].checked)
	{
		document.all.span_desc.innerHTML = "Norm Status";
	}
	else if(document.forms[0].rad_value[3].checked)
	{
		document.all.span_desc.innerHTML = "Loan Type";
	}*/
	if(varexception != "")
	{
		alert(varexception);
	}

	document.forms[0].txt_qenddate.readOnly=true;
}
</script>

<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="dobtnDisable();onload();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}

function changeOptions()
{
	if(document.forms[0].rad_value[0].checked)
	{
		document.forms[0].txt_radval.value = "C";
	}
	else if(document.forms[0].rad_value[1].checked)
	{
		document.forms[0].txt_radval.value = "O";
	}
	else if(document.forms[0].rad_value[2].checked)
	{
		document.forms[0].txt_radval.value = "N";
	}
	else if(document.forms[0].rad_value[3].checked)
	{
		document.forms[0].txt_radval.value = "L";
	}
	document.forms[0].hidBeanId.value="borrowersearch";
	document.forms[0].hidBeanGetMethod.value="getNPAProvisioning";
	document.forms[0].action = appURL + "action/npaprovisioning.jsp";
	document.forms[0].submit();
}

function doExcelReport()
{
	if(document.forms[0].hid_execsno.value != "")
	{
		var FileName="EXE_"+document.forms[0].hid_execsno.value;
		var qryString=appURL+"action/"+FileName+".xls?hidBeanId=excelfunction&hidBeanGetMethod=doExportNPAProvOutput&hid_execsno="+document.forms[0].hid_execsno.value;
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"NPAprovisioning",prop);
	}
}
function callCalender(name)
{
	showCal(appURL,name);
}
function doExcelReport1()
{
	if(document.forms[0].npaorghelp.value == "")
	{
		alert("Select Organization");
		document.forms[0].npaorghelp.focus();
		return;
	}
	if(document.forms[0].hid_execsno.value != "")
	{
		var FileName="NPAEXE_"+document.forms[0].hid_execsno.value;
		var qryString=appURL+"action/"+FileName+".xlsx?hidBeanId=excelfunction&hidBeanGetMethod=doExportNPAProvReport&hid_execsno="+document.forms[0].hid_execsno.value+"&npaorg="+document.forms[0].npaorghelp.value;
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"NPAprovisioning",prop);
	}
}
function doHtmlReport1()
{
	if(document.forms[0].npaorghelp.value == "")
	{
		alert("Select Organization");
		document.forms[0].npaorghelp.focus();
		return;
	}
	if(document.forms[0].hid_execsno.value != "")
	{
		var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
		var url=appURL+"action/app_npaProvReport.jsp?hidBeanId=excelfunction&hidBeanGetMethod=getNpaProvisioningReport&hid_execsno="+document.forms[0].hid_execsno.value+"&npaorg="+document.forms[0].npaorghelp.value;
		window.open(url,"NPAprovisioning",prop);	
	}
}

</script>
</div></div>
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA Provisioning -&gt; NPA Down gradation / Provisioning
 				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	 align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%" class="outertable border1">
			<tr>
				<td valign="top">
				<table width="95%" border="0" cellspacing="0" cellpadding="5"  class="outertable" align="center">
					<tr>
					<td align="center" colspan="2" class="dataheader"><b>NPA ACCOUNT DOWNGRADING AND PROVISIONING PROCESS</b></td>
					</tr>
					<tr><td colspan="2">
						<table width="100%" align="center" cellpadding="5" cellspacing="2" class="outertable">
							<tr>
								<td colspan="6" class="datagrid"><b>Details of Execution</b></td>
							</tr>
							<tr>
							<td width="10%" class="datagrid">Execution Number</td>
							<td width="20%"><%=Helper.correctNull((String)hshValues.get("exec_sno"))%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onClick="doExcelReport()" value="Export the Excel report"  class="buttonStyle" ></td>
							<td width="10%" class="datagrid">Executed By</td>
							<td width="20%"><%=Helper.correctNull((String)hshValues.get("exec_by"))%></td>
							<td width="10%" class="datagrid">Executed On</td>
							<td width="15%"><%=Helper.correctNull((String)hshValues.get("exec_date"))%></td>
							</tr>
							<tr>
							<td class="datagrid">No. of Customers</td>
							<td>
								<table width="100%"  border="0" align="center" cellpadding="5" cellspacing="2" class="outertable">
									<tr>
									<td>
										<%=Helper.correctNull((String)hshValues.get("customer_count"))%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
									<td>	
										<select name="npaorghelp">
										<option value="" selected>----Select Organization----</option>
												<%
													String s1 = "001" + "^R";
												%>
												<lapschoice:choiceOrg value='<%=s1%>' />
										</select>
									</td>
									 
									<td align="center">
										<input type="button" onClick="doExcelReport1()" value="NPA Provisioning Report Excel Format"  class="buttonStyle" >
									</td>
									<td align="center">
										<input type="button" onClick="doHtmlReport1()" value="NPA Provisioning Report HTML Format"  class="buttonStyle" >
									</td>
									</tr>
								</table>
							</td>
							<td class="datagrid">No. of Accounts</td>
							<td><%=Helper.correctNull((String)hshValues.get("account_count"))%></td>
							<td class="datagrid">Total Value Provisioned (Rs.)</td>
							<td align="right"><%=Helper.correctNull((String)hshValues.get("tot_prov_val"))%></td>
							</tr>
							<tr>
								<td colspan="6" class="datagrid">&nbsp;</td>
							</tr>
						</table>
					</td></tr>
					<tr>
					<td>&nbsp;</td>
					<td valign="top"><b>Run Provisioning upto the Date</b>&nbsp; <input type="text" name="txt_qenddate"  onblur="checkDate(this);checkmindate(this,LastRunDate);"
					value="<%=Helper.correctNull((String)hshValues.get("strQEndDate")) %>" size="10"> &nbsp;<a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_qenddate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	></a></td>
					</tr>
					<tr>
						<td valign="top" align="center">
							<b>Click to upload a NPA data file</b>&nbsp;&nbsp;<input type="button" name="btn_upload" width="100%" value="Upload NPA accounts File" class="buttonStyle" onclick="doUploadFile();"/>
						</td>
						<td valign="top">
							<b>Click to initiate the NPA downgrading and Provisioning</b>&nbsp;&nbsp;<input type="button" name="btn_run" width="100%" value="Do Account Downgradation and Calculate Provisioning" class="buttonStyle" onclick="doInitiateRun();"/>
						</td>
					</tr>
					<tr id="file_exists">
						<td valign="top" colspan="2" align="center">
							<h3><font color="red">Warning:</font> File name <b>"<%=Helper.correctNull((String)hshValues.get("pending_filename"))%>"</b> is uploaded and not yet initiated for the calculation.</h3>&nbsp;&nbsp;&nbsp;<input type="button" name="btn_revert" width="100%" value="Revert Uploaded File" class="buttonStyle" onclick="doRevertFile();"/>
						</td>
					</tr>
					<tr id="init_upload">
						<td valign="top" colspan="2" align="center">
							<h1><font color="red"><b>File is Uploading... Please Wait...</b></font></h1>
						</td>
					</tr>
					<tr id="init_calculate">
						<td valign="top" colspan="2" align="center">
							<h1><font color="red"><b>Calculating NPA provisioning... Please Wait...</b></font></h1>
						</td>
					</tr>
					
						<tr><td colspan="2">&nbsp;</td></tr>			
					<tr><td colspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="5"  class="outertable" 
						align="center">
						<tr>
						<td width="8%" class="dataheader"><b>Group By</b></td>
						<td width="45%" class="datagrid"><input type="radio" name="rad_value" onclick="changeOptions();" style="border: none;">&nbsp;Customer ID
<!--						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rad_value" onclick="changeOptions();" style="border: none;">&nbsp;Accounts-->
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rad_value" onclick="changeOptions();" style="border: none;">&nbsp;Organizations
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rad_value" onclick="changeOptions();" style="border: none;">&nbsp;Norm Status
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rad_value" onclick="changeOptions();" style="border: none;">&nbsp;Loan Type
						<input type="hidden" name="txt_radval" value=""<%=Helper.correctNull((String)hshValues.get("txt_radval"))%>"">
						</td>
						<td colspan="2" class="datagrid">&nbsp;</td>
<!--						<td width="15%" class="dataheader"><b>Filter By <span id="span_desc">&nbsp;</span></b></td>-->
<!--						<td width="32%" class="datagrid">-->
<!--							<input type="text" maxlength="45" size="50" name="txt_search" value="">&nbsp;&nbsp;&nbsp;-->
<!--						</td>-->
						</tr>
						</table>
					</td></tr>
					 <%if(arrRow!=null && arrRow.size()>0){%>
					<tr><td colspan="2">
					<table width="100%" border="0" cellspacing="0" cellpadding="5"  class="outertable border1"  align="center">
					  <%if(arrRow!=null && arrRow.size()>0){ 
					  for(int i=0;i<arrRow.size();i++){
						  arrCol=(ArrayList)arrRow.get(i);
						  if(i==0){%>
						  <tr class="dataheader">
						  <td align="center">&nbsp;</td>
						   <%}else{ %>
						   <tr class="datagrid">
						   <td align="center"><%=i%>&nbsp;</td>
						<% } for(int j = 0;j<arrCol.size();j++){ 
						if(i == 0){%>
      						<td align="center"><%=Helper.correctNull((String)arrCol.get(j))%>&nbsp;</td>
      						<%}else{ %>
      						<td><%=Helper.correctNull((String)arrCol.get(j))%>&nbsp;</td>
      						<%} }%>
       					</tr>
					  <%}}} %>
					</table>
				</td></tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:combuttonnew btnnames='' btnenable='N' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String) request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hid_rowcount" value="" />
<input type="hidden" name="hid_execsno" value="<%=Helper.correctNull((String)hshValues.get("exec_sno"))%>" />
</form>
</body>
</html>
