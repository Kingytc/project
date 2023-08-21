<%@include file="../share/directives.jsp"%>
<%String strmonth = Helper.correctNull((String) hshValues.get("strmonth"));
			String stryear = Helper.correctNull((String) hshValues.get("stryear"));
			ArrayList arrFromUsr = (ArrayList) hshValues.get("arrFromUsr");
			ArrayList arrToUsr = (ArrayList) hshValues.get("arrToUsr");
			ArrayList arrFromflow = (ArrayList) hshValues.get("arrFromflow");
			ArrayList arrToflow = (ArrayList) hshValues.get("arrToflow");
			ArrayList arrDate = (ArrayList) hshValues.get("arrDate");
			String strmoduletype = Helper.correctNull((String) request.getParameter("hidmoduletype"));
			String chkstatus = Helper.correctNull((String) hshValues.get("Stateflag"));%>
<html>
<head>
<title>Personal - Work Flow</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var chkstatus="<%=chkstatus%>";
function callOnload()
{
	if(chkstatus=="1" && document.forms[0].appstatus.value == "Processed/Approved")
 	{
		alert("Application is Approved");
	}
}
function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getMONAction";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].action=appUrl+"action/mon_appworkflowaction.jsp";
		document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	}
} 
function callRemarks()
{
	var cbsid = document.forms[0].cbsid.value;
	var mon_month = document.forms[0].mon_month.value;
	var mon_year = document.forms[0].mon_year.value;
	
	var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
	var url=appUrl+"action/mon_workflowcom.jsp?cbsid="+cbsid+"&mon_month="+mon_month+"&mon_year="+mon_year+"&hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+"&editoption="+document.forms[0].hideditoption.value+"&hidBeanId=mailboxcomments"+"&hidBeanGetMethod=getMMRComments";
	window.open(url,"remarks",prop);
} 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal">
<lapschoice:monthlymonitortag pageid="11" />
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td class="page_flow">Home&nbsp;-&gt;&nbsp;Monitoring&nbsp;-&gt;&nbsp;Monthly&nbsp;Monitoring&nbsp;Reports&nbsp;-&gt;&nbsp;Work&nbsp;Flow&nbsp;-&gt;&nbsp;History</td>
			</tr>
		</table>
		</td>
		</tr>
		</table>
<lapschoice:MonthlyMonitor />
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
			<tr>
				<td width="50%" valign="bottom">
				<table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_active"><b>History</b></td>
						<td id="action" class="sub_tab_inactive"><b><a href="javascript:callOtherTab('action')">Action</a></b></td>
						<td class="sub_tab_inactive" style="visibility:hidden"><b><a
							href="javascript:callOtherTab('remarks')">Remarks</a></b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
							<tr>
								<td valign="top"><b>History</b>
								<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
									<tr>
										<td width="47%" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
											<tr>
												<td valign="top">
												<table width="90%" border="0" cellspacing="0" class="outertable linebor" cellpadding="0" align="center">
													<tr class="dataheader" align="center">
														<td width="10%" align="center"> From Flowpoint </td>
														<td width="30%">Sent By</td>
														<td width="20%">Sent On</td>
														<td width="10%">To Flowpoint</td>
														<td width="30%">Sent To</td>
													</tr>
													<%if (arrFromUsr != null && arrFromUsr.size() > 0) {
				for (int i = 0; i < arrFromUsr.size(); i++) {%>
															<tr class="datagrid">
																<td  width="10%" align="center"><%=Helper.correctNull((String) arrFromflow.get(i))%></td>
																<td  width="30%">&nbsp;<%=Helper.correctNull((String) arrFromUsr.get(i))%></td>
																<td  width="20%" align="center"><%=Helper.correctNull((String) arrDate.get(i))%></td>
																<td  width="10%" align="center"><%=Helper.correctNull((String) arrToflow.get(i))%></td>
																<td  width="30%"><%=Helper.correctNull((String) arrToUsr.get(i))%></td>
															</tr>
															<%}}%>
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
		<lapschoice:combuttonnew btnnames='Help' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
		<input type="hidden" name="borrowername" value="<%=Helper.correctNull((String)request.getParameter("borrowername"))%>">
		<input type="hidden" name="hidmoduletype" value="<%=strmoduletype%>">
	<lapschoice:hiddentag pageid='<%=PageId%>'/>
		<input type="hidden" name="appno" value="<%=(String)request.getParameter("npa_appno")%>"> 
		<input type="hidden" name="cbsid" value="<%=(String)request.getParameter("cbsid")%>"> 
		<input type="hidden" name="hidborrowertype" value="<%=Helper.correctNull((String)request.getParameter("hidborrowertype"))%>">
		<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)hshValues.get("stryear"))%>"> 
		<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)hshValues.get("strmonth"))%>"> 
		<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
		<input type="hidden" name="cbsnames" value="<%=Helper.correctNull((String)request.getParameter("cbsnames"))%>">
		</form>
</body>
</html>
