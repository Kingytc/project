<%@include file="../share/directives.jsp"%>
<%String strStatus = "";

			ArrayList arrFlowpoint = (ArrayList) hshValues.get("arrFlowpoint");
			ArrayList arrAction = (ArrayList) hshValues.get("arrAction");
			ArrayList arrMaxclass = (ArrayList) hshValues.get("arrMaxclass");
			ArrayList arrDone = (ArrayList) hshValues.get("arrDone");
			ArrayList arrClassDesc = (ArrayList) hshValues.get("arrClassDesc");

			strStatus = Helper.correctNull((String) hshValues.get("status"));

			%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Work Flow</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var usr_class="";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var varStatus="<%=strStatus%>";
var varApproverejectBy="<%=Helper.correctNull((String)hshValues.get("ApproveRejectedby"))%>";
var userclass=<%=strUserClass%>;
var skipclass="<%=Helper.correctNull((String)hshValues.get("prd_skip"))%>";
var appclass="<%=Helper.correctNull((String)hshValues.get("prd_approval"))%>";


function callOnload()
{
	if(varStatus.toUpperCase()=="SUCCESS")
	{
		alert("Your application has been sent successfully");
	    {
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
	}
	if(document.forms[0].readFlag.value.toUpperCase()=="R")
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdundo.disabled=true;
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdactclose.disabled=true;
	}
	
	document.forms[0].cmdactclose.disabled=true;
	document.forms[0].cmdapprove.disabled=true;
	document.forms[0].cmdreject.disabled=true;
	document.forms[0].cmdundo.disabled=true;
	document.forms[0].txt_sanctioncomments.readOnly=true;
	
	if(document.forms[0].appstatus.value.toUpperCase()=="OP")
	{
		document.forms[0].txt_sanctioncomments.readOnly=false;
		document.forms[0].cmdactclose.disabled=true;
	    document.forms[0].cmdapprove.disabled=false;
	    document.forms[0].cmdreject.disabled=false;
	}
	if(document.forms[0].appstatus.value.toUpperCase()=="PA")
	{
		if(strUserId==varApproverejectBy)
		{
			document.forms[0].cmdundo.disabled=false;
		}
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].txtmail_toflowpoint[i].value<9)
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}
		document.forms[0].cmdactclose.disabled=false;
	}
	if(document.forms[0].appstatus.value.toUpperCase()=="PR")
	{
		if(strUserId==varApproverejectBy)
		{
			document.forms[0].cmdundo.disabled=false;
		}
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].txtmail_toflowpoint[i].value<9)
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}
		document.forms[0].cmdactclose.disabled=false;
	}
	
	if(document.forms[0].appstatus.value.toUpperCase()=="CA" || document.forms[0].appstatus.value.toUpperCase()=="CR")
	{
	    document.forms[0].cmdundo.disabled=true;
	    document.forms[0].cmdsend.disabled=true;
	}
	
	if(parseInt(userclass)<parseInt(appclass) && document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
	}	
	if(parseInt(userclass)<parseInt(skipclass) && document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
	}
}

function callRemarks()
{
	appno = document.forms[0].appno.value;
	var prop = "scrollbars=no,width=650,height=600,top=25,left=180";
	var url=appURL+"action/commst_workflowcomments.jsp?hiduserid="+strUserId
				  +"&hidtoUser="+document.forms[0].mail_tousrid.value
				  +"&editoption="+document.forms[0].hideditoption.value
				  +"&appno="+appno
				  +"&hidBeanId=modsancterms&hidBeanGetMethod=getMSTMailcomments";
	window.open(url,"remarks",prop);
}

function callOrgHelp()
{
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appURL+"action/orgnamelist.jsp?hidBeanGetMethod=getDataHelp";
		window.open(url,"",prop);
	}
}

function callUsersHelp()
{	
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
		{
			if(usr_class=="")
			{
				ShowAlert(111,"Flowpoint");	
				return;
			}
			var prop="scrollbars=no,width=400,height=350,top=100,left=250";
			var url=appURL+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value;
			window.open(url,"hai",prop);
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

function openWindow(pagename)
{
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+pagename;
	window.open(url,"report","scrollbars=no,toolbars=no,menubar=no,width=450,height=300,left=60,top=40");
}

function doSend()
{	
	if(document.forms[0].mail_tousrid.value=="")
	{
	ShowAlert(112,"Select Recipient");	
	return true;
	}
	
	if(document.forms[0].remarksFlag.value=="true")
	{
		document.forms[0].hidAction.value="send";
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].hidBeanMethod.value="updateMSTAction";
		document.forms[0].hidBeanGetMethod.value="getMSTAction";
		document.forms[0].hidSourceUrl.value="/action/commst_workflowaction.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].hideditoption.value="Y"
		callRemarks();
		return;
	}	
}

function FinalClose()
{
if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function doProcess(action)
{
	document.forms[0].hidAction.value=action;
	document.forms[0].hidBeanId.value="modsancterms";
	document.forms[0].hidBeanMethod.value="updateMSTAction";
	document.forms[0].action=appURL+"controllerservlet";

	if(action=="approve" || action=="reject")
	{
		if(trim(document.forms[0].txt_sanctioncomments.value)=="")
		{
			alert("Enter Comments");
			document.forms[0].txt_sanctioncomments.focus();
			return;
	 	}
	 	document.forms[0].hidBeanGetMethod.value="getMSTHistory";
		document.forms[0].hidSourceUrl.value="/action/commst_worflowhistory.jsp";
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="getMSTAction";
		document.forms[0].hidSourceUrl.value="/action/commst_workflowaction.jsp";
	}
	document.forms[0].submit();	
}

function callOtherTab(val)
{
	 if(val=="history")
	 {
 	    document.forms[0].hidBeanGetMethod.value="getMSTHistory";
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].action=appURL+"action/commst_worflowhistory.jsp";
		document.forms[0].submit();
		 
	 }
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal">
<lapstab:applurllinksmst pageid="8" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td class="page_flow">Corporate &amp; SME -&gt; Modification in sanction
		terms -&gt; Workflow -&gt; Action</td>
	</tr>
</table>
<lapschoice:MSTApplications />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td width="45%" valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
			<tr align="center">
				<td width="15%" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:callOtherTab('history')">History</a></b></td>
				<td width="15%" class="sub_tab_active"><b>Action</b></td>
				<td width="15%" class="sub_tab_inactive"><b><a href="#" onClick="javascript:callRemarks()">Remarks</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td height="161" valign="top">
										<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
											<tr class="dataheader">
												<td width="18%" align="center">Current Flowpoint</td>
												<td width="13%"></td>
												<table width="46%" border="0" cellspacing="0" cellpadding="0" class="outertable">
													<tr>
														<td align="center"><b><%=Helper.correctNull((String) hshValues
							.get("strCurrFlowPoint"))%>&nbsp;</b></td>
													</tr>
												</table>
												<td width="16%" align="center">Received On</td>
												<td width="20%"></td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td align="center"><b><%=Helper.correctNull((String) hshValues.get("strDate"))%>&nbsp;</b></td>
													</tr>
												</table>
												<td width="12%" align="center">Due On</td>
												<td width="21%"></td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td align="center"><b><%=Helper.correctNull((String) hshValues.get("strDueDate"))%>&nbsp;</b></td>
													</tr>
												</table>
											</table>
										<br>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
													<tr class="dataheader">

														<td width="7%" align="center"><b>Select</b></td>

														<td width="13%" align="center"><b>Flowpoints</b></td>

														<td width="10%" align="center"><b>Done</b></td>

														<td width="35%" align="center"><b>Min.
														Class</b></td>
														<td width="35%" align="center"><b>Actions</b></td>
													</tr>
													<tr>
														<td colspan="5" valign="top">
														<DIV CLASS="cellContainer">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="1" align="left" class="outertable">


															<%if (arrFlowpoint != null && arrFlowpoint.size() > 0) {
				for (int i = 0; i < arrFlowpoint.size(); i++) {

					%>

															<tr>
																<td width="7%"><input type="radio"
																	name="optflowpnt" value="" style="border-style:none"
																	onClick="setValues(<%=i%>,<%=arrFlowpoint.size()%>);"></td>
																<td width="13%" align="center"><input
																	type="text" name="txtmail_toflowpoint" size="5"
																	style="text-align:center;"
																	readonly="readonly" maxlength="4"
																	value="<%=Helper.correctNull((String)arrFlowpoint.get(i))%>">
																</td>
																<td width="10%" align="center"><input
																	type="text" name="txtdone" size="5"
																	style="text-align:center;"
																	readonly="readonly"
																	value="<%=Helper.correctNull((String)arrDone.get(i))%>">
																</td>
																<td width="35%" align="left"><input
																	type="hidden" name="prd_maxclass" size="10"
																	style="text-align:center;"
																	readonly="readonly"
																	value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>">
																<input type="text" name="prd_maxclass1" size="40"
																	style="text-align:left;"
																	readonly="readonly"
																	value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrClassDesc.get(i))%>">
																</td>
																<td width="35%" align="left"><input
																	type="text" name="wrk_flowname" size="75"
																	readonly="readonly"
																	value="<%=Helper.correctNull((String)arrAction.get(i))%>">
																</td>
															</tr>
															<%}
			}%>
														</table>
														</DIV>
														</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td width="52%" valign="top">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable border1">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="3" class="outertable">
															<tr>
																<td width="30%">Select Organisation</td>
																<td width="70%"><input type="text" name="org_name"
																	size="35" readonly="readonly" value="<%=strOrgName%>"><span
																	id="idorgselect"> <a href="#"
																	onClick="javascript:callOrgHelp()"><b><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </b></a></span></td>
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
																	size="37" readonly="readonly"
																	value="<%=Helper.correctNull((String)hshValues.get("apprised_by"))%>">
																<input type="hidden" name="hidmail_tousrid"> <a href="#"
																	onClick="javascript:callUsersHelp()"><b><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </b></a></td>
																<td width="16%" align="center">&nbsp;</td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td colspan="2">
												<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
													<tr>
														<td nowrap="nowrap">Sanctioning Authority Comments</td>
														<td><textarea name="txt_sanctioncomments" cols="150"
															rows="3"><%=Helper.correctNull((String) hshValues
							.get("Sanction_Comments"))%></textarea></td>
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
<br>
<table width="0%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr valign="top">
		<td height="2"><input type="button" name="cmdapprove" value="Approve"
			class="buttonStyle" style="width:60" disabled="disabled" onClick="doProcess('approve')">
		</td>
		<td height="2"><input type="button" name="cmdreject" value="Reject"
			class="buttonStyle" style="width:60" disabled="disabled"
			onClick="doProcess('reject')"></td>
		<td height="2"><input type="button" name="cmdundo" value="Undo"
			class="buttonStyle" disabled="disabled" onClick="doProcess('undo')"></td>
		<td height="2"><input type="button" name="cmdsend" value="Send"
			class="buttonStyle" onClick="doSend()"></td>
		<td height="2"><input type="button" name="cmdactclose"
			value="Freeze Application" class="buttonStyle"
			disabled="disabled" onClick="doProcess('freeze')"></td>
		<td height="2" align="center"><input type="button" name="cmdclose"
			value="Close" class="buttonClose" onclick="FinalClose()"></td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="mail_touserclass">
<input type="hidden" name="org_code"
	value="<%=strOrgCode%>"> <input type="hidden" name="mail_fromflowpoint"
	value="<%=Helper.correctNull((String)hshValues.get("strCurrFlowPoint"))%>">
<input type="hidden" name="mail_toflowpoint"> <input type="hidden"
	name="cmdapply" style="visibility:hidden" disabled="disabled"> <input
	type="hidden" name="remarksFlag" value="false"> <input type="hidden"
	name="hideditoption" value="N"> <input type="hidden" name="txt_usrid"
	value="<%=session.getAttribute("strUserId") %>"></form>
</body>
</html>

