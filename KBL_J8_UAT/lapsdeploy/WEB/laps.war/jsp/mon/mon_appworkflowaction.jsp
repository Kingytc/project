<%@include file="../share/directives.jsp"%>
<%String strStatus = Helper.correctNull((String) hshValues.get("status"));
			ArrayList arrFlowpoint = (ArrayList) hshValues.get("arrFlowpoint");
			ArrayList arrAction = (ArrayList) hshValues.get("arrAction");
			ArrayList arrMaxclass = (ArrayList) hshValues.get("arrMaxclass");
			ArrayList arrDone = (ArrayList) hshValues.get("arrDone");
			ArrayList arrClassDesc = (ArrayList) hshValues.get("arrClassDesc");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Work Flow</title>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var strRemarksFlag="0";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var mon_observationdetails ="<%=Helper.correctNull((String)hshValues.get("mon_observationdetails"))%>";
var varStatus="<%=strStatus%>";
var usr_class="";
var brchhead_flag ="<%=Helper.correctNull((String)hshValues.get("strflag"))%>";
var varusrfunction="<%=Helper.correctNull((String)hshValues.get("usrfunction"))%>";
var varusrorgname="<%=session.getAttribute("strOrgName")%>";
function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}
function callOnload()
{
	if(varStatus.toUpperCase()=="SUCCESS")
	{
		alert("Report has been sent successfully");
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	}	
	if(document.forms[0].statusflag.value=="P")
	{
		if("<%=Helper.correctNull((String)hshValues.get("sendenable"))%>"=="yes")
		{
			document.forms[0].cmdsend.disabled=false;
		}
		else
		{
			document.forms[0].cmdsend.disabled=true;
		}
	}
	else if(document.forms[0].statusflag.value=="C")
	{
		document.forms[0].cmdsend.disabled=true;
	}
	if(document.forms[0].readFlag.value.toUpperCase()=="R")
	{
		document.forms[0].cmdsend.disabled=true;
	}	
	if(varusrfunction=="Delegated Authority")
	{
		document.all["idorgselect"].style.visibility="visible";
	}
	else
	{
		document.all["idorgselect"].style.visibility="hidden";
	}
}
function callRemarks()
{
	var cbsid = document.forms[0].cbsid.value;
	var mon_month = document.forms[0].mmr_month.value;
	var mon_year = document.forms[0].strYear.value;
	var cbsname= document.forms[0].strcbsname.value;
	var varmmrno=document.forms[0].mmrno.value;
	var statusflag=document.forms[0].statusflag.value;
	var prop = "scrollbars=yes,width=650,height=500,top=25,left=180";
	var url=appUrl+"action/mon_workflowcom.jsp?cbsid="+cbsid+"&mon_month="+mon_month+"&mon_year="+mon_year+"&hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+"&editoption="+document.forms[0].hideditoption.value+"&hidBeanId=mailboxcomments"+"&hidBeanGetMethod=getMMRComments&cbsname="+cbsname+"&statusflag="+statusflag+"&mmrno="+varmmrno;
	window.open(url,"remarks",prop);
}
function callOrgHelp()
{
	if(document.forms[0].statusflag.value!="C" && document.forms[0].readFlag.value.toUpperCase()=="W")
	{
	var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
	var url=appUrl+"action/orgnamelist.jsp?hidBeanGetMethod=getDataHelp";
	window.open(url,"",prop);
	}
}
function callUsersHelp()
{	
	if(document.forms[0].statusflag.value!="C" && document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		if(usr_class=="")
		{
			ShowAlert(111,"Flowpoint");	
			return;
		}
		var prop="scrollbars=no,width=400,height=350,top=100,left=250";
		var url=appUrl+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value;
		window.open(url,"NPA",prop);
	}
}
function setValues(idx,size)
{	
	if(size>1)
	{
		usr_class=document.forms[0].prd_maxclass[idx].value;	
		document.forms[0].mail_tousrid.value="";
		document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint[idx].value;
	}
	else
	{
		usr_class=document.forms[0].prd_maxclass.value;	
		document.forms[0].mail_tousrid.value="";
		document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint.value;
	}
}
function doSend()
{	
	if(mon_observationdetails=="" && varusrorgname!=document.forms[0].org_name.value)
	{
		alert("Data not enter in Branch Head Comments Tab");
		return;
	}
	if(usr_class=="" )
	{
		ShowAlert(111,"Flowpoint");
		return;
	}
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Recipient");
		return;
	}	
		
	if(document.forms[0].remarksFlag.value=="true")
	{
		document.forms[0].hidAction.value="send";
		document.forms[0].cbsid.value=document.forms[0].cbsid.value;
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanMethod.value="updateMONAction";
		document.forms[0].hidBeanGetMethod.value="getMONAction";
		document.forms[0].hidSourceUrl.value="/action/mon_appworkflowaction.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		strRemarksFlag="1";
		document.forms[0].hideditoption.value="Y"
		callRemarks();
		return;
	}
}
function FinalClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	 }
}

function callOtherTab(val)
{
	 if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getMONHistory";
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].action=appUrl+"action/mon_appworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal">
<lapschoice:monthlymonitortag pageid="11" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Monitoring&nbsp;-&gt;&nbsp;Monthly Monitoring
		Reports&nbsp;-&gt;&nbsp;Work Flow&nbsp;-&gt;&nbsp;Action</td>
	</tr>
</table>
<lapschoice:MonthlyMonitor />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td width="50%" valign="bottom">
		<table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="sub_tab_inactive"><b><a href="javascript:callOtherTab('history')">History</a></b></td>
				<td class="sub_tab_active"><b>Action</b></td>
				<td class="sub_tab_inactive"><b><a href="#" onClick="javascript:callRemarks()">Remarks</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="8" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="8" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable border1">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="18%" align="center">Current Flowpoint</td>
												<td width="13%">
												<table width="46%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
													<tr>
														<td align="center"><b><%=Helper.correctNull((String) hshValues.get("strCurrFlowPoint"))%>&nbsp;</b></td>
													</tr>
												</table>
												</td>
												<td width="16%" align="center">Received On</td>
												<td width="20%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
													<tr>
														<td align="center"><b><%=Helper.correctNull((String) hshValues.get("strDate"))%>&nbsp;</b></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<br>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
													<tr class="dataheader">
														<td width="4%">Select</td>
														<td width="8%" align="center">Flowpoints</td>
														<td width="6%" align="center">Done</td>
														<td width="20%" align="center">Min. Class</td>
														<td width="40%" align="center">Actions</td>
													</tr>
													<%for (int i = 0; i < arrFlowpoint.size(); i++) {%>
															<tr class="datagrid">
																<td width="5%"><input type="radio"
																	name="optflowpnt" value=""
																	onClick="setValues(<%=i%>,<%=arrFlowpoint.size()%>);"
																	style="border-style:none"></td>
																<td width="8%" align="center"><input
																	type="text" name="txtmail_toflowpoint" size="5"
																	style="border-style:groove;border:0;text-align:center;background-color:#ECF1F9"
																	readOnly maxlength="4"
																	value="<%=Helper.correctNull((String)arrFlowpoint.get(i))%>">
																</td>
																<td width="2%" align="center"><input
																	type="text" name="txtdone" size="5"
																	style="border-style:groove;border:0;text-align:center;background-color:#ECF1F9"
																	readOnly
																	value="<%=Helper.correctNull((String)arrDone.get(i))%>">
																</td>
																<td width="20%" ><input
																	type="hidden" name="prd_maxclass" size="10"
																	style="border-style:groove;border:0;text-align:center;background-color:#ECF1F9"
																	readOnly
																	value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>">
																<input type="text" name="prd_maxclass1" size="40"
																	style="border-style:groove;border:0;text-align:left;background-color:#ECF1F9"
																	readOnly
																	value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrClassDesc.get(i))%>">
																</td>
																<td width="40%" ><input
																	type="text" name="wrk_flowname" size="75"
																	style="border-style:groove;border:0;background-color:#ECF1F9"
																	readOnly
																	value="<%=Helper.correctNull((String)arrAction.get(i))%>">
																</td>
															</tr>
															<%}%>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td align="center" colspan="3">&nbsp;</td>
											</tr>
											<tr>
												<td width="52%" valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0" class="outertable" cellpadding="3">
															<tr>
																<td width="30%">Select Organisation</td>
																<td width="70%"><input type="text" name="org_name"
																	size="35" readonly value="<%=strOrgName%>"><span
																	id="idorgselect"> <a href="#"
																	onClick="javascript:callOrgHelp()"><b><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0" tabindex="1"> </b></a></span></td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
												<td align="right" valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
															<tr>
																<td width="32%" align="center">Select Recipient</td>
																<td width="52%"><input type="text" name="mail_tousrid"
																	size="37" readonly
																	value="<%=Helper.correctNull((String)hshValues.get("apprised_by"))%>">
																<input type="hidden" name="hidmail_tousrid"> <a href="#"
																	onClick="javascript:callUsersHelp()"><b
																	><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0" tabindex="2"> </b></a></td>
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
<table width="0%" border="0" cellspacing="1" cellpadding="1" class="outertable" align="center">
	<tr valign="top">
		<td><input type="button" name="cmdsend" value="Send" tabindex="3"
			class="buttonStyle" style="width:60" onClick="doSend()"></td>
		<td><input type="button" name="cmdclose" tabindex="4" value="Close"
			class="buttonClose" onclick="FinalClose()"></td>
	</tr>
</table>
<input type="hidden" name="appstatus" value=""> 
<input type="hidden" name="borrowername" value="<%=Helper.correctNull((String)request.getParameter("borrowername"))%>">
<input type="hidden" name="remarksFlag" value="false"> 
<input type="hidden" name="cbsid" value="<%=(String)request.getParameter("cbsid")%>"> 
<input type="hidden" name="org_code" value="<%=strOrgCode%>"> 
<input type="hidden" name="mail_fromflowpoint" value="<%=Helper.correctNull((String)hshValues.get("strCurrFlowPoint"))%>">
<input type="hidden" name="mail_toflowpoint">
<input type="hidden" name="mail_touserclass"> 
<input type="hidden" name="hidcurrflowpoint" value="<%=Helper.correctNull((String)hshValues.get("strCurrFlowPoint"))%>">
<input type="hidden" name="hideditoption" value="N"> 
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)hshValues.get("stryear"))%>"> 
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)hshValues.get("strmonth"))%>"> 
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("strcbsname"))%>">
<input type="hidden" name="cbsnames" value="<%=Helper.correctNull((String)request.getParameter("cbsnames"))%>">
<input type="hidden" name="statusflag">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
