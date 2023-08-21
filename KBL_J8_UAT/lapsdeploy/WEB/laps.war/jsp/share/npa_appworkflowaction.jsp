<%@include file="../share/directives.jsp"%>
<%

			String strStatus = strStatus = Helper.correctNull((String) hshValues.get("status"));
			ArrayList arrFlowpoint = (ArrayList) hshValues.get("arrFlowpoint");
			ArrayList arrAction = (ArrayList) hshValues.get("arrAction");
			ArrayList arrMaxclass = (ArrayList) hshValues.get("arrMaxclass");
			ArrayList arrDone = (ArrayList) hshValues.get("arrDone");
			ArrayList arrClassDesc = (ArrayList) hshValues.get("arrClassDesc");
			String strmoduletype = Helper.correctNull((String) request.getParameter("hidmoduletype"));
			String strUsrClass = Helper.correctNull((String)session.getAttribute("strUserClass"));
			String app_class=Helper.correctNull((String)hshValues.get("app_class"));
			String rej_class=Helper.correctNull((String)hshValues.get("rej_class"));
			String skip_class=Helper.correctNull((String)hshValues.get("skip_class"));
			String strCurrFlowPoint=Helper.correctNull((String) hshValues.get("strCurrFlowPoint"));
			String approveflag=Helper.correctNull((String) hshValues.get("approveflag"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title>Work Flow</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varPageType = "<%=Helper.correctNull((String)session.getAttribute("link"))%>";
var strRemarksFlag="0";
var strRejectReasonsFlag="0";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var appno ="<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var varStatus="<%=strStatus%>";
var usr_class="";
var userclass=<%=strUsrClass%>;
var min_appclass="<%=app_class%>";
var min_rejclass="<%=rej_class%>";
var skipclass="<%=skip_class%>";
var undoflag="";
var currflowpoint="<%=strCurrFlowPoint%>";
var approveflag="<%=approveflag%>";
var varusrfunction="<%=Helper.correctNull((String)hshValues.get("usrfunction"))%>";
var varApproverejectBy="<%=Helper.correctNull((String)hshValues.get("processedby"))%>";

function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}
function doReject()
{
	if(min_rejclass!="")
	{
		if(userclass >= min_rejclass)
		{
			document.forms[0].hidAction.value="reject";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanMethod.value="updateNPAAction";
			document.forms[0].hidBeanGetMethod.value="getNPAAction";
			document.forms[0].hidSourceUrl.value="/action/npa_appworkflowaction.jsp";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
		else
		{
			ShowAlert(163);
			return;
		}
	}
	else
	{
		ShowAlert(162);
		return;
	}
}

function callOnload()
{
	if(varStatus.toUpperCase()=="SUCCESS")
	{
		alert("Your application has been sent successfully");
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	}
	else if(varStatus.toUpperCase()=="APPROVE")
	{
		alert("Your application is Approved");
	}
	else if(varStatus.toUpperCase()=="REJECT")
	{
		alert("Your application is Rejected");
	}
	if(document.forms[0].hidmoduletype.value=="STAT")
	{
		document.forms[0].cmdreject.disabled=true;
	}
	
	if(document.forms[0].readFlag.value.toUpperCase()=="R" || document.forms[0].appstatus.value.toUpperCase()=='CA' || document.forms[0].appstatus.value.toUpperCase()=='CR')
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdundo.disabled=true;
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdsave.disabled=true;
	}
	else
	{
		if(document.forms[0].appholder.value!=strUserId)
		{
			document.forms[0].cmdapprove.disabled=true;
			document.forms[0].cmdreject.disabled=true;
			document.forms[0].cmdundo.disabled=true;
			document.forms[0].cmdsend.disabled=true;
			document.forms[0].cmdsave.disabled=true;
		}
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

if(document.forms[0].hidmoduletype.value=="STAT")
{
	appno = document.forms[0].appno.value;
	var prop = "scrollbars=no,width=650,height=600,top=25,left=180";
	var url=appUrl+"action/npa_workflowcomments.jsp?npa_appno="+appno+"&hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+
	"&editoption="+document.forms[0].hideditoption.value+"&year="+document.forms[0].year.value+"&quarter="+document.forms[0].quarter.value+
	"&appstatus="+document.forms[0].appstatus.value+"&hidmoduletype="+document.forms[0].hidmoduletype.value+
	"&appname="+document.forms[0].appname.value+"&hidBeanId=npa&hidBeanGetMethod=getNPAMailComments";
	window.open(url,"remarks",prop);
}
else
{
	appno = document.forms[0].appno.value;
	var prop = "scrollbars=no,width=650,height=600,top=25,left=180";
	var url=appUrl+"action/npa_workflowcomments.jsp?npa_appno="+appno+"&hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+
	"&editoption="+document.forms[0].hideditoption.value+
	"&appstatus="+document.forms[0].appstatus.value+"&hidmoduletype="+document.forms[0].hidmoduletype.value+
	"&appname="+document.forms[0].appname.value+"&hidBeanId=npa&hidBeanGetMethod=getNPAMailComments";
	window.open(url,"remarks",prop);
}

}
function callOrgHelp()
{
	if(document.forms[0].cmdsend.disabled==false)
	{
	var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
	var url=appUrl+"action/orgnamelist.jsp?hidBeanGetMethod=getDataHelp";
	window.open(url,"",prop);
	}
}
function callUsersHelp()
{	
	if(document.forms[0].cmdsend.disabled==false)
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

function placeValues()
{	
	if(document.forms[0].appstatus.value.toUpperCase()=="OP" || document.forms[0].appstatus.value.toUpperCase()=="PP")
	{
		document.forms[0].cmdapprove.disabled=false;
		document.forms[0].cmdreject.disabled=false;
		document.forms[0].cmdsend.disabled=false;
		
		document.forms[0].cmdsave.disabled=true;
	
	}
	else if(document.forms[0].appstatus.value.toUpperCase()=="PA")
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdsend.disabled=false;
		document.forms[0].cmdsave.disabled=false;
		if(strUserId==varApproverejectBy)
		{
		document.forms[0].cmdundo.disabled=false;
		}
	}
	else if(document.forms[0].appstatus.value.toUpperCase()=="PR")
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdsend.disabled=false;
		document.forms[0].cmdsave.disabled=false;
		if(strUserId==varApproverejectBy)
		{
		document.forms[0].cmdundo.disabled=false;
		}
	}
	if(document.forms[0].appstatus.value.toUpperCase()!="OP" && document.forms[0].appstatus.value.toUpperCase()!="PP")
	{	
		if(currflowpoint==9 || currflowpoint==17)
		{
			if(strUserId==varApproverejectBy)
			{
				document.forms[0].cmdundo.disabled=false;
			}
		}
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].txtmail_toflowpoint[i].value<9)
			{			
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}
		for(i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].optflowpnt[i].checked == true)
			{
				document.forms[0].cmdactclose.disabled=false;
				break;
			}
		}
	}
}

function openWindow(pagename)
{
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+pagename;
	window.open(url,"report","scrollbars=no,toolbars=no,menubar=no,width=450,height=300,left=60,top=40");
}

function doSend()
{	
	
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
	if(parseInt(userclass)<parseInt(skipclass))
			{
			if(parseInt(currflowpoint)+1<parseInt(document.forms[0].mail_toflowpoint.value))
				{
					ShowAlert(132);
					return;
				}
			}
		
	if(document.forms[0].remarksFlag.value=="true")
	{
		document.forms[0].hidAction.value="send";
		document.forms[0].hidmoduletype.value="<%=strmoduletype%>";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanMethod.value="updateNPAAction";
		document.forms[0].hidBeanGetMethod.value="getNPAAction";
		document.forms[0].hidSourceUrl.value="/action/npa_appworkflowaction.jsp";
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
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	 }
}

function doapprove()
{
	if(approveflag!="")
	{
		if(approveflag=="Y")
		{
			doconfirm();
		}
		else
		{
			alert("Delegeated power is not within Range to Approve this application");
			return;
		}
	}
	else
	{
		alert("Delegated Power is 0.00");
		return;
	}
}

function doconfirm()
{
	if(min_appclass!="")
		{
			if(userclass>=min_appclass)
			{
				if(undoflag=="1")
				{
					document.forms[0].hidAction.value="undo";
				}
				else
				{
					document.forms[0].hidAction.value="approve";
				}	
				document.forms[0].hidBeanId.value="commworkflow";
				document.forms[0].hidBeanMethod.value="updateNPAAction";
				document.forms[0].hidBeanGetMethod.value="getNPAAction";
				document.forms[0].hidSourceUrl.value="/action/npa_appworkflowaction.jsp";
				document.forms[0].action=appUrl+"controllerservlet";
				document.forms[0].submit();
			}
			else
			{
				ShowAlert(164);
				return;
			}
		}
		else
		{
			ShowAlert(165);
			return;
		}
}

function doSave()
{
	if(ConfirmMsg(167))
	{
		if(document.forms[0].hidmoduletype.value=="STAT")
		{
			if(min_appclass!="")
			{
				if(userclass>=min_appclass)
				{
					document.forms[0].cmdsave.disabled = true;
					document.forms[0].hidAction.value="save";
					document.forms[0].hidBeanId.value="commworkflow";
					document.forms[0].hidBeanMethod.value="updateNPAAction";
					document.forms[0].hidBeanGetMethod.value="getNPAAction";
					document.forms[0].hidSourceUrl.value="/action/npa_appworkflowaction.jsp";
					document.forms[0].action=appUrl+"controllerservlet";
					document.forms[0].submit();
				}
				else
				{
					alert("You are not eligible to freeze any Proposal");
					return;
				}
			}
			else
			{
				ShowAlert(165);
				return;
			}

		}
		else
		{
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].hidAction.value="save";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanMethod.value="updateNPAAction";
			document.forms[0].hidBeanGetMethod.value="getNPAAction";
			document.forms[0].hidSourceUrl.value="/action/npa_appworkflowaction.jsp";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
}

function doUndo()
{
	undoflag="1";
	doconfirm();
}

function callOtherTab(val)
{
	 if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getNPAHistory";
		 document.forms[0].action=appUrl+"action/npa_appworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
}

function enableSave()
{
	
}
 
function dohlp()     
{
  	var hlpvar = appUrl+"phlp/loan_appretail_workflow_action.htm";
  	var title = "Action";
  	var prop = "scrollbars=yes,width=600,height=450";	
 	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
  
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 160;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css"
	type="text/css">
</head>

<body 
	onLoad="placeValues();callOnload()">
<jsp:include page="../share/help.jsp" flush="true"/>


<form name="frmworkflow" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
					<%if(strmoduletype.equalsIgnoreCase("PAWO"))
						{%>
						<lapstab:pwourltag pageid="8"/>
						<%}
						else if(strmoduletype.equalsIgnoreCase("SUIT"))
						{
						%>
						<lapstab:suiturltag pageid="11"/>
						<%}
						else if(strmoduletype.equalsIgnoreCase("OTSCO"))
						{
						%>
						<lapstab:otscourltag pageid="9"/>
						<%}
						else if(strmoduletype.equalsIgnoreCase("STAT"))
						{
						%>
						<lapstab:staturltag pageid="11"/>
						<%}else if(strmoduletype.equalsIgnoreCase("SARFI"))
						{
						%>
						<lapstab:sarfiurltag pageid="6"/>
						<%}%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> <%if(strmoduletype.equalsIgnoreCase("PAWO"))
						{%>
						 <td valign="top" colspan=5 class="page_flow">
						 Home -&gt; NPA-&gt;Prudential Write Off -&gt;Work Flow  -&gt;Action
						 </td>
						<%}
						else if(strmoduletype.equalsIgnoreCase("SUIT"))
						{
						%>
						 <td valign="top" colspan=5 class="page_flow">
						 Home -&gt; NPA-&gt; Filing Of Suit   -&gt;Work Flow  -&gt;Action
						 </td>
						<%}
						else if(strmoduletype.equalsIgnoreCase("OTSCO"))
						{
						%>
						 <td valign="top" colspan=5 class="page_flow">
						 Home -&gt; NPA-&gt; Compromise Proposal   -&gt;Work Flow  -&gt;Action
						 </td>
						<%}
						else if(strmoduletype.equalsIgnoreCase("STAT"))
						{
						%>
						 <td valign="top" colspan=5 class="page_flow">
						 Home -&gt; NPA-&gt; Status Note   -&gt;Work Flow  -&gt;Action
						</td>
						<%}else if(strmoduletype.equalsIgnoreCase("SARFI"))
						{
						%>
						 <td valign="top" colspan=5 class="page_flow">
						 Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt;Work Flow  -&gt;Action
	 					</td>
						<%}%>
          </tr>
        </table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td width="50%" valign="bottom">
		<table width="28%" border="0" cellspacing="3" cellpadding="3"
			align="left" class="outertable">
          <tr align="center">
				
            <td width="50%" class="sub_tab_inactive"><b>
					<a href="javascript:callOtherTab('history')"
					>History</a></b></td>
				
            <td width="50%" class="sub_tab_active"><b>
					Action</b></td>
					
			<td width="15%" class="sub_tab_inactive"><b><a href="#"
						onClick="javascript:callRemarks()">Remarks</a></b></td>
			</tr>
		</table>
		</td>

	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="8"
	height="370" 
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%" class="outertable">
			
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="8"
					height="100%" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="4"
									
									height="285" class="outertable border1">
									<tr>
										<td height="161" valign="top">
										
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <td width="18%" align="center">
													Current 
                                      Flowpoint</td>
                                    <td width="13%"> 
                                      <table width="46%" border="0" cellspacing="0"
													cellpadding="0" 
													 class="outertable border1">
                                        <tr> 
                                          <td align="center">
														<b><%=Helper.correctNull((String) hshValues
							.get("strCurrFlowPoint"))%>&nbsp;</b></td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td width="16%" align="center">
                                      On</td>
                                    <td width="20%"> 
                                      <table width="100%" border="0" cellspacing="0"
													cellpadding="0" 
												class="outertable border1">
                                        <tr> 
                                          <td align="center">
															<b><%=Helper.correctNull((String) hshValues.get("strDate"))%>&nbsp;</b></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                </table>
										<br>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											
											height="0"  class="outertable border1">
											<tr >


												<td height="81" valign="top">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3"  class="outertable">
													<tr class="dataheader">
														<td width="4%" align="left">
														Select</td>
														<td width="8%" align="center">
															Flowpoints</td>
														<td width="6%" align="center">
															Done</td>
														<td width="20%" align="center">
															Min. Class</td>
														
														<td width="40%"  align="center">
														Actions</td>
													</tr>
													<tr class="datagrid">
														<td colspan="6" valign="top">
														<DIV CLASS="cellContainer">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="1"
															align="left" class="outertable border1">


															<%for (int i = 0; i < arrFlowpoint.size(); i++) {

				%>

															<tr>
																<td width="5%" bgcolor=""><input type="radio"
																	name="optflowpnt" value=""
																	onClick="setValues(<%=i%>,<%=arrFlowpoint.size()%>);enableSave()"
																	style="border-style:none"></td>
																<td width="8%" bgcolor="" align="center"><input
																	type="text" name="txtmail_toflowpoint" size="5"
																	style="border-style:groove;border:0;text-align:center;background-color:#F2F9FF"
																	readOnly maxlength="4"
																	value="<%=Helper.correctNull((String)arrFlowpoint.get(i))%>">
																</td>
																<td width="2%" bgcolor="" align="center"><input
																	type="text" name="txtdone" size="5"
																	style="border-style:groove;border:0;text-align:center;background-color:#F2F9FF"
																	readOnly
																	value="<%=Helper.correctNull((String)arrDone.get(i))%>">
																</td>
																<td width="20%" bgcolor="" align="left"><input
																	type="hidden" name="prd_maxclass" size="10"
																	style="border-style:groove;border:0;text-align:center;background-color:#F2F9FF"
																	readOnly
																	value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>">
																<input type="text" name="prd_maxclass1" size="40"
																	style="border-style:groove;border:0;text-align:left;background-color:#F2F9FF"
																	readOnly
																	value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrClassDesc.get(i))%>">
																</td>
																
																<td width="40%" bgcolor="" align="left"><input
																	type="text" name="wrk_flowname" size="75"
																	style="border-style:groove;border:0;background-color:#F2F9FF"
																	readOnly
																	value="<%=Helper.correctNull((String)arrAction.get(i))%>">
																</td>
															</tr>
															<%}%>
														</table>
														</div>
														</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
											<tr>
												
                                    <td align="center" colspan="3">&nbsp; </td>
											</tr>
											<tr>
												<td width="52%" valign="top">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" 
												 height="100%" class="outertable">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="3" class="outertable">
															<tr>
																<td width="30%">Select
																Organisation</td>
																<td width="70%"><input type="text" name="org_name"
																	size="35" readonly value="<%=strOrgName%>"><span id="idorgselect"> <a href="#"
																	onClick="javascript:callOrgHelp()"><b ><img
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
													cellpadding="0"
												height="100%" class="outertable">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="3" class="outertable">
															<tr>
																<td width="32%" align="center">
																	Select Recipient</td>
																<td width="52%"><input type="text" name="mail_tousrid"
																	size="37" readonly
																	value="<%=Helper.correctNull((String)hshValues.get("apprised_by"))%>">
																<input type="hidden" name="hidmail_tousrid"> <a href="#"
																	onClick="javascript:callUsersHelp()"><b
																	><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </b></a></td>
																<td width="16%" align="center" class="redfont"><font
																	size="1" face="MS Sans Serif">&nbsp;</td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td colspan="2">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td nowrap>Sanctioning
														Authority Comments</td>
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

<table width="0%" border="0" cellspacing="1" cellpadding="1"
	align="center" class="outertable">
	<tr valign="top">
		<td><input type="button" name="cmdapprove" value="Approve"
			class="buttonStyle" style="width:65" disabled="disabled" onClick="doapprove()"></td>
		<td><input type="button" name="cmdreject" value="Reject"
				class="buttonStyle"disabled="disabled" onClick="doReject()"></td>
		<td><input type="button" name="cmdundo" value="Undo"
			class="buttonStyle" disabled="disabled" onClick="doUndo()">
		</td>
		<td><input type="button" name="cmdsend" value="Send"
			class="buttonStyle" onClick="doSend()"></td>
		<td><input type="button" name="cmdsave" value="Freeze Application"
			class="buttonStyle" style="width:125" disabled="disabled" onClick="doSave()"></td>
		<td><input type="button" name="cmdaudit" value="Audit Trail"
			class="buttonStyle" style="width:125" onClick="doAuditTrial()"></td>
	
		<td>
		<input type="button" name="cmdclose"
			value="Close" class="buttonClose" onclick="FinalClose()">
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="mail_touserclass">
<input type="hidden" name="remarksFlag" value="false">
<input type="hidden" name="org_code" value="<%=strOrgCode%>"> 
<input type="hidden" name="mail_fromflowpoint"	value="<%=Helper.correctNull((String)hshValues.get("strCurrFlowPoint"))%>">
<input type="hidden" name="mail_toflowpoint">
<input type="hidden" name="hidcurrflowpoint" value="<%=Helper.correctNull((String)hshValues.get("strCurrFlowPoint"))%>">
<input type="hidden" name="hideditoption" value="N"> 
</form>
</body>
</html>
