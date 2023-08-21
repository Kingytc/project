<%@include file="../share/directives.jsp"%>
<%	String strStatus = "";
	ArrayList arrFlowpoint = (ArrayList) hshValues.get("arrFlowpoint");
	ArrayList arrAction = (ArrayList) hshValues.get("arrAction");
	ArrayList arrMaxclass = (ArrayList) hshValues.get("arrMaxclass");
	ArrayList arrDone = (ArrayList) hshValues.get("arrDone");
	ArrayList arrClassDesc = (ArrayList) hshValues.get("arrClassDesc");	
	strStatus = Helper.correctNull((String) hshValues.get("status"));
	String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Work Flow</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varPageType = "<%=Helper.correctNull((String)session.getAttribute("link"))%>";
var usr_class="";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var varStatus="<%=strStatus%>";
var varApproverejectBy="<%=Helper.correctNull((String)hshValues.get("ApproveRejectedby"))%>";
var varenablesend="<%=Helper.correctNull((String)hshValues.get("enablesend"))%>";
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
		document.forms[0].cmdfreezeapplication.disabled=true;
	}
	
	document.forms[0].cmdfreezeapplication.disabled=true;
	document.forms[0].cmdapprove.disabled=true;
	document.forms[0].cmdreject.disabled=true;
	document.forms[0].cmdundo.disabled=true;
	
	if(document.forms[0].appstatus.value.toUpperCase()=="OP")
	{
		document.forms[0].cmdfreezeapplication.disabled=true;
	    document.forms[0].cmdapprove.disabled=false;
	    document.forms[0].cmdreject.disabled=false;
	    if(varenablesend=="N")
	    {
	    	document.forms[0].cmdsend.disabled=true;
	    }
	    else
	    {
	    	document.forms[0].cmdsend.disabled=false;
	    }
	}
	else if(document.forms[0].appstatus.value.toUpperCase()=="PA")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].txtmail_toflowpoint[i].value<9)
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}
		if(varenablesend=="N")
	    {
	    	document.forms[0].cmdsend.disabled=true;
	    	document.forms[0].cmdfreezeapplication.disabled=true;
	    }
	    else
	    {
	    	document.forms[0].cmdsend.disabled=false;
	    	document.forms[0].cmdfreezeapplication.disabled=false;
	    	if(strUserId==varApproverejectBy)
			{
				document.forms[0].cmdundo.disabled=false;
			}
	    }
	}
	else if(document.forms[0].appstatus.value.toUpperCase()=="PR")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
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
		if(varenablesend=="N")
	    {
	    	document.forms[0].cmdsend.disabled=true;
	    	document.forms[0].cmdfreezeapplication.disabled=true;
	    }
	    else
	    {
	    	document.forms[0].cmdsend.disabled=false;
	    	document.forms[0].cmdfreezeapplication.disabled=false;
	    	if(strUserId==varApproverejectBy)
			{
				document.forms[0].cmdundo.disabled=false;
			}
	    }
	}
	else if(document.forms[0].appstatus.value.toUpperCase()=="CA")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
	    document.forms[0].cmdundo.disabled=true;
	    document.forms[0].cmdsend.disabled=true;
	}
	else if(document.forms[0].appstatus.value.toUpperCase()=="CR")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
	    document.forms[0].cmdundo.disabled=true;
	    document.forms[0].cmdsend.disabled=true;
	}
}

function callRemarks()
{
	appno = document.forms[0].appno.value;
	var prop = "scrollbars=no,width=650,height=600,top=25,left=180";
	var url=appURL+"action/combst_workflowcomments.jsp?hiduserid="+strUserId
				  +"&hidtoUser="+document.forms[0].mail_tousrid.value
				  +"&editoption="+document.forms[0].hideditoption.value
				  +"&appno="+appno
				  +"&hidBeanId=broadsancterms&hidBeanGetMethod=getBSTComments";
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
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].hidBeanMethod.value="updateBSTAction";
		document.forms[0].hidBeanGetMethod.value="getBSTAction";
		document.forms[0].hidSourceUrl.value="/action/combst_workflowaction.jsp";
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

function doClose()
{
if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}

/*function doApprove(action)
{
	if((action=="reject") || (action=="approve"))
	{
		if(trim(document.forms[0].txt_sanctioncomments.value)=="")
		{
			alert("Enter Comments");
			document.forms[0].txt_sanctioncomments.focus();
			return;
	 	}
	 	
		document.forms[0].hidAction.value=action;
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].hidBeanMethod.value="updateBSTAction";
		document.forms[0].hidBeanGetMethod.value="getBSTHistory";
		document.forms[0].hidSourceUrl.value="/action/combst_workflowhistroy.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else if((action=="undo") || (action=="freeze"))
	{		
			document.forms[0].hidAction.value=action;
			document.forms[0].hidBeanId.value="broadsancterms";
			document.forms[0].hidBeanMethod.value="updateBSTAction";
			document.forms[0].hidBeanGetMethod.value="getBSTAction";
			document.forms[0].hidSourceUrl.value="/action/combst_workflowaction.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
	}
}*/
function doApprove()
{
	if(trim(document.forms[0].txt_sanctioncomments.value)=="")
	{
		alert("Enter Comments");
		document.forms[0].txt_sanctioncomments.focus();
		return;
 	}
	document.forms[0].hidAction.value="approve";
	document.forms[0].hidBeanId.value="broadsancterms";
	document.forms[0].hidBeanMethod.value="updateBSTAction";
	document.forms[0].hidBeanGetMethod.value="getBSTHistory";
	document.forms[0].hidSourceUrl.value="/action/combst_workflowhistroy.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doReject()
{
	if(trim(document.forms[0].txt_sanctioncomments.value)=="")
	{
		alert("Enter Comments");
		document.forms[0].txt_sanctioncomments.focus();
		return;
 	}
 	document.forms[0].hidBeanId.value="broadsancterms";
	document.forms[0].hidBeanMethod.value="updateBSTAction";
	document.forms[0].hidBeanGetMethod.value="getBSTHistory";
	document.forms[0].hidSourceUrl.value="/action/combst_workflowhistroy.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	
}
function doUndo()
{
	document.forms[0].hidAction.value="undo";
	document.forms[0].hidBeanId.value="broadsancterms";
	document.forms[0].hidBeanMethod.value="updateBSTAction";
	document.forms[0].hidBeanGetMethod.value="getBSTAction";
	document.forms[0].hidSourceUrl.value="/action/combst_workflowaction.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	
}
function doFreezeApplication()
{
	document.forms[0].hidBeanId.value="broadsancterms";
	document.forms[0].hidBeanMethod.value="updateBSTAction";
	document.forms[0].hidBeanGetMethod.value="getBSTAction";
	document.forms[0].hidSourceUrl.value="/action/combst_workflowaction.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function callOtherTab(val)
{
	 if(val=="history")
	 {
 	    document.forms[0].hidBeanGetMethod.value="getBSTHistory";
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].action=appURL+"action/combst_workflowhistroy.jsp";
		document.forms[0].submit();
	 }
}

function enableSave()
{
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		for(i=0;i<document.forms[0].txtmail_toflowpoint.length;i++)
		{
			if(document.forms[0].txtmail_toflowpoint[i].value >= 9)
		 	{
		 		if(document.forms[0].appstatus.value.toUpperCase()== "PA")
		 		{
			 		document.forms[0].cmdfreezeapplication.disabled = false;
					break;
				}
		 	}
		}
	}
}

function placeValues()
{
	if(document.forms[0].appstatus.value.toUpperCase()=="OP")
	{
	enableButtons(false,false,true,false,true,false);
	}
	else if(document.forms[0].appstatus.value.toUpperCase()=="PA")
	{
	enableButtons(true,true,true,false,false,false);
	}
	if(document.forms[0].appstatus.value.toUpperCase()=="PA")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
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
		document.forms[0].cmdfreezeapplication.disabled=false;
	}
	if(document.forms[0].appstatus.value.toUpperCase()=="PR")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
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
		document.forms[0].cmdfreezeapplication.disabled=false;
	}
}

function enableButtons(valapprove,valreject,valundo,valsend,valfreeze,valclose)
{
	document.forms[0].cmdapprove.disabled=valapprove;
	document.forms[0].cmdreject.disabled=valreject;
	document.forms[0].cmdundo.disabled=valundo;
	document.forms[0].cmdsend.disabled=valsend;
	document.forms[0].cmdfreezeapplication.disabled=valfreeze;
	document.forms[0].cmdclose.disabled=valclose;
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="callOnload();">
<form name="frmworkflow" method="post" class="normal">
<lapstab:applurllinkbst  pageid='9' category='bst' valuesin='<%=Valuesin%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td class="page_flow">
Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Workflow -&gt; Action
</td>
</tr>
</table>
<lapschoice:BST/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td width="45%" valign="bottom">
			<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
				<tr align="center">
					<td class="sub_tab_inactive"><b><a href="javascript:callOtherTab('history')">History</a></b></td>
					<td class="sub_tab_active"><b>Action</b></td>
					<td class="sub_tab_inactive"><b><a href="#" onClick="javascript:callRemarks()">Remarks</a></b></td>
			</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="8" class="outertable border1">
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
								<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable border1">
									<tr>
										<td height="161" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="18%" align="center">Current Flowpoint</td>
												<td width="13%">
												<table width="46%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
													<tr>
														<td align="center"><b><%=Helper.correctNull((String) hshValues
							.get("strCurrFlowPoint"))%>&nbsp;</b></td>
													</tr>
												</table>
												</td>
												<td width="16%" align="center">Received On</td>
												<td width="20%">
												<table width="100%" border="0" cellspacing="0" class="outertable border1" cellpadding="0">
													<tr>
														<td align="center"><b><%=Helper.correctNull((String) hshValues.get("strDate"))%>&nbsp;</b></td>
													</tr>
												</table>
												</td>
												<td width="12%" align="center">Due On</td>
												<td width="21%">
												<table width="100%" border="0" cellspacing="0" class="outertable border1" cellpadding="0" >
													<tr>
														<td align="center"><b><%=Helper.correctNull((String) hshValues.get("strDueDate"))%>&nbsp;</b></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<br>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td height="81" valign="top">
												<table width="100%" border="0" cellspacing="0" class="outertable linebor" cellpadding="3">
													<tr class="dataheader">
														<td width="5%" align="center" ><b>Select</b></td>
														<td width="15%" align="center" ><b>Flowpoints</b></td>
														<td width="10%" align="center" ><b>Done</b></td>
														<td width="10%" align="center" ><b>Min. Class</b></td>
														<%-- <td width="17%" bgcolor="#71694F" align="center">Function</td> --%>
														<td width="60%" align="center" ><b>Actions</b></td>
													</tr>
															<%if(arrFlowpoint!=null && arrFlowpoint.size()>0)
																{
															for (int i = 0; i < arrFlowpoint.size(); i++) {

																%>

															<tr class="datagrid">
																<td><input type="radio"
																	name="optflowpnt" value=""
																	onClick="setValues(<%=i%>,<%=arrFlowpoint.size()%>);enableSave()"
																	style="border-style:none"></td>
																<td align="center"><input
																	type="text" name="txtmail_toflowpoint" size="5"
																	
																	readOnly="readonly" maxlength="4"
																	value="<%=Helper.correctNull((String)arrFlowpoint.get(i))%>">
																</td>
																<td align="center"><input
																	type="text" name="txtdone" size="5"
																	
																	readOnly="readonly"
																	value="<%=Helper.correctNull((String)arrDone.get(i))%>">
																</td>
																<td align="left"><input
																	type="hidden" name="prd_maxclass" size="10"
																	
																	readOnly="readonly"
																	value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>">
																<input type="text" name="prd_maxclass1" size="5"
																	readOnly="readonly"
																	value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>&nbsp;">
																</td>
																<td align="left"><input
																	type="text" name="wrk_flowname" size="120"
																	readOnly="readonly"
																	value="<%=Helper.correctNull((String)arrAction.get(i))%>">
																</td>
															</tr>
															<%}
															}%>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td align="center" colspan="3">										
												</td>
											</tr>
											<tr>
												<td width="52%" valign="top">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable border1">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0" class="outertable" cellpadding="3">
															<tr>
																<td width="30%">Select Organisation</td>
																<td width="70%"><input type="text" name="org_name"
																	size="35" readonly="readonly" value="<%=strOrgName%>"><span id="idorgselect"> <a href="#"
																	onClick="javascript:callOrgHelp()"><b class="blackfont"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </b></a></span></td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
												<td align="right" valign="top">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable border1">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0" class="outertable" cellpadding="3">
															<tr>
																<td width="32%" align="center">Select Recipient</td>
																<td width="52%"><input type="text" name="mail_tousrid"
																	size="37" readonly="readonly"
																	value="<%=Helper.correctNull((String)hshValues.get("apprised_by"))%>">
																<input type="hidden" name="hidmail_tousrid"> <a href="#"
																	onClick="javascript:callUsersHelp()"><b
																	class="blackfont"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </b></a></td>
																<td width="16%" align="center" class="redfont">&nbsp;</td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td colspan="2">
												<table width="100%" border="0" cellspacing="0" class="outertable" cellpadding="0">
													<tr>
														<td nowrap="nowrap">Sanctioning Authority Comments</td>
														<td><textarea name="txt_sanctioncomments" cols="150"
															rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
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
<br>
<lapschoice:combuttonnew btnnames='Approve_Reject_Undo_Send_Audit Trail_Freeze Application' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="org_code" value="<%=strOrgCode%>"> 
<input type="hidden" name="mail_fromflowpoint" value="<%=Helper.correctNull((String)hshValues.get("strCurrFlowPoint"))%>">
<input type="hidden" name="mail_toflowpoint"> 
<input type="hidden" name="mail_touserclass">
<input type="hidden" name="cmdapply" style="visibility:hidden" disabled> 
<input type="hidden" name="remarksFlag" value="false"> 
<input type="hidden" name="hideditoption" value="N"> 
<input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId") %>"> 
<iframe name="ifrm" width="0" height="0" border="0"/></form>
</body>
</html>

