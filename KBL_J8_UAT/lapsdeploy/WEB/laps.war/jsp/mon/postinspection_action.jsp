<%@include file="../share/directives.jsp"%>
<%String strReviewtype = Helper.correctNull((String) request.getParameter("hidreviewtype"));%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Work Flow</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varusrfunction="<%=Helper.correctNull((String)hshValues.get("usrfunction"))%>";
var varsendenable="<%=Helper.correctNull((String)hshValues.get("sendenable"))%>";
var varorghead="<%=Helper.correctNull((String)hshValues.get("orghead"))%>";
function callOrgHelp()
{
	if(varsendenable=="YES" && document.forms[0].statusflag.value=="P" && varusrfunction=="Delegated Authority")
	{
		var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appURL+"action/orgnamelist.jsp?hidBeanGetMethod=getDataHelp";
		window.open(url,"Organisationselection",prop);
	}
}

function callUsersHelp()
{	
	if(varsendenable=="YES" && document.forms[0].statusflag.value=="P")
	{
		var prop="scrollbars=no,width=400,height=350,top=100,left=250";
		var url=appURL+"action/wrkflowuserlist.jsp?org_code="+document.forms[0].org_code.value;
		window.open(url,"UserSelection",prop);
	}
}
	
function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}

function callOnload()
{	
	if(varsendenable=="YES" && document.forms[0].statusflag.value=="P")
	{
		document.forms[0].cmdsend.disabled=false;
		if(varusrfunction=="Delegated Authority")
		{
			document.forms[0].txt_sanctioncomments.readOnly=false;
			document.forms[0].cmdsave.disabled=false;
			document.all["idorgselect"].style.visibility="visible";
		}
		else
		{
			document.forms[0].txt_sanctioncomments.readOnly=true;
			document.forms[0].cmdsave.disabled=true;
			document.all["idorgselect"].style.visibility="hidden";
		}
	}
	else
	{
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].txt_sanctioncomments.readOnly=true;
		document.forms[0].cmdsave.disabled=true;
		document.all["idorgselect"].style.visibility="hidden";
	}
}
function doSend()
{	
	if(document.forms[0].hidmail_tousrid.value=="")
	{
		alert('Select Recipient');
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/postinspection_history.jsp" 
	document.forms[0].hidBeanMethod.value="updatePostInspectionAction";
	document.forms[0].hidBeanGetMethod.value="getPostInspectionHistory";
	document.forms[0].hidBeanId.value="postinspection";
	document.forms[0].hidAction.value="send";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doSave()
{
	if(trim(document.forms[0].txt_sanctioncomments.value)=="")
	{
		alert("Enter Comments");
		document.forms[0].txt_sanctioncomments.focus();
		return;
	}
	if(ConfirmMsg(172))
	{
		document.forms[0].hidSourceUrl.value="/action/postinspection_history.jsp"; 
		document.forms[0].hidBeanMethod.value="updatePostInspectionAction";
		document.forms[0].hidBeanGetMethod.value="getPostInspectionHistory";
		document.forms[0].hidBeanId.value="postinspection";
		document.forms[0].hidAction.value="approve";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=POSTINSPEC";
		document.forms[0].submit();
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_inactive"><b><%if (strReviewtype.equalsIgnoreCase("R")) {%>
				<a href="JavaScript:callLink('postinspection_retail_report.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
				<%} else if (strReviewtype.equalsIgnoreCase("A")) {%>
				<a href="JavaScript:callLink('followupInspectionReport.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
				<%} else if (strReviewtype.equalsIgnoreCase("C")) {%>
				<a href="JavaScript:callLink('mon_inspectionreport.jsp','postinspection','getPostInspectionReport')">Inspection Report</a> 
				<%}%></b></td>
						<td class="sub_tab_inactive">
						<a href="JavaScript:callLink('postinspection_facility.jsp','postinspection','getPostInspectionFaclity')"><b>Facility Enjoyed</b></a></td>
						<%if (strReviewtype.equalsIgnoreCase("C")) {%>
				<td class="sub_tab_inactive">
				<a href="JavaScript:callLink('postinspection_annexure.jsp','postinspection','getPostInspectionAnnexure')"><b>Facility Annexure</b></a></td>
						<%} %>
						<td class="sub_tab_active"><b>Workflow</b></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
			<td class="page_flow">Home -&gt; Post/ Followup Inspection -&gt; Workflow -&gt; Action</td>
			</tr>
		</table>
<lapschoice:PostInspection />
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="20%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_inactive"><a href="JavaScript:callLink('postinspection_history.jsp','postinspection','getPostInspectionHistory')"><b>History</b></a></td>
						<td class="sub_tab_active"><b>Action</b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="8" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td width="52%" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
													<tr>
														<td width="30%">Select Organisation</td>
														<td width="70%"><input type="text" name="org_name"
															size="35" readonly value="<%=strOrgName%>"><span
															id="idorgselect"> <a href="#"
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
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
													<tr>
														<td width="32%" align="center">Select Recipient</td>
														<td width="52%"><input type="text" name="mail_tousrid"
															size="37" readonly
															value="<%=Helper.correctNull((String)hshValues.get("apprised_by"))%>">
														<input type="hidden" name="hidmail_tousrid"> <a href="#"
															onClick="javascript:callUsersHelp()"><b ><img
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
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td nowrap>Approving Authority Comments</td>
												<td><textarea name="txt_sanctioncomments" cols="150"
													rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("sanccomments"))%></textarea></td>
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
<lapschoice:combuttonnew btnnames='Send_Save' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<input type="hidden" name="mail_touserclass">
<input type="hidden" name="org_code" value="<%=strOrgCode%>">
<input type="HIDDEN" name="hidreviewtype" value="<%=strReviewtype%>" />
<lapschoice:hiddentag pageid='<%=PageId%>'/></form>
</body>
</html>

