<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="../share/directives.jsp"%>
<%
	int vecModSize = 0;
	ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
	if (vecModule != null) {
		vecModSize = vecModule.size();
	}
	String tagFlag = "", strCurModule = "";
	String strFinStatus = Helper.correctNull((String) hshValues
			.get("fin_status"));
	String strfintype = Helper.correctNull((String) hshValues
			.get("fintype"));
	String strStatus = Helper.correctNull((String) hshValues.get("status"));
	
String strUsrId=(String) session.getAttribute("strUserId");
String strAppHolder=Helper.correctNull((String)hshValues.get("fin_appholder"));
String strFreeze=Helper.correctNull((String)hshValues.get("cre_freeze"));

String strPROCESSEDBY=Helper.correctNull((String)hshValues.get("FIN_PROCESSEDBY"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<title>Financial rating Action</title>
<script type="text/javascript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var usr_dept="";
var usr_class="";
var cma="<%=strfintype%>";
var finaced_id="<%=Helper.correctNull((String) hshValues.get("finace_id"))%>";
var varusrfunction="<%=Helper.correctNull((String) hshValues.get("usrfunction"))%>";
var strRejectReasonsFlag="0";
var varStatus="<%=strStatus%>";
var varRmdUserCheckFlag="<%=Helper.correctNull((String)hshValues.get("strRmdUserCheckFlag"))%>";
var strfinalsendflag="<%=Helper.correctNull((String)hshValues.get("strfinalsendflag"))%>";
var varappStatus="<%=strFinStatus%>";
var varOrgHead="<%=Helper.correctNull((String) hshValues.get("strOrgHead"))%>";
var varstrFreeze="<%=strFreeze%>";
var varFreezeFlag="<%=Helper.correctNull((String)hshValues.get("strFreezeFlag"))%>";
var varNonPoolEMptyRatingFlag="<%=Helper.correctNull((String)hshValues.get("strNonPoolEMptyRatingFlag"))%>";
function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6) {
	
	document.forms[0].cmdconfirm.disabled = bool1;
	document.forms[0].cmdreject.disabled = bool2;
	document.forms[0].cmdundo.disabled = bool3;
	document.forms[0].cmdsend.disabled = bool4;
	document.forms[0].cmdsave.disabled = bool5;
	document.forms[0].cmdreassign.disabled = bool6;
	
}


function callOnLoad()
{
	if(varStatus.toUpperCase()=="SUCCESS")
	{
		alert("Your application has been sent successfully");
	    {
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
	}
	else if(varStatus.toUpperCase()=="REALLOCATE")
	{
		alert("Your application has been reassigned successfully");
	    {
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
	}
	<%if (strFinStatus.equalsIgnoreCase("PR")
					|| strFinStatus.equalsIgnoreCase("PA")) {
					
			if(strPROCESSEDBY.equals(Helper.correctNull((String)session.getAttribute("strUserId")))){%>
				enableButtons(true,true,false,false,false,true);
			<%}else{%>
				enableButtons(true,true,true,false,false,true);
				
	<%}}else if (strFinStatus.equalsIgnoreCase("CR") || strFinStatus.equalsIgnoreCase("CA")) {%>
	enableButtons(true,true,true,true,true,true);
	
	<%} else {%>
	if(varRmdUserCheckFlag=="Y")
	{
		enableButtons(false,false,true,false,true,true);
	}else{
		enableButtons(true,false,true,false,true,true);
	}
	<%}%>
	if(varOrgHead=='Y')
	{
		document.forms[0].cmdreassign.disabled=false;
	}
	if(varusrfunction=="Delegated Authority")
	{
		document.all["idorgselect"].style.visibility="visible";
		document.forms[0].cmdreassign.disabled=false;
	}
	else
	{
		document.all["idorgselect"].style.visibility="hidden";
	}
	
	<%if((!strUsrId.equalsIgnoreCase(strAppHolder))&& !strAppHolder.equalsIgnoreCase("")){%>

	enableButtons(true,true,true,true,true,true);
	
   <% }%>

	if(document.forms[0].org_name.value=="HEAD OFFICE"){

		document.all.deprt1.style.visibility="visible";
		document.all.deprt1.style.position="relative";
		document.all.deprt2.style.visibility="visible";
		document.all.deprt2.style.position="relative";
	}else{
		document.all.deprt1.style.visibility="hidden";
		document.all.deprt1.style.position="absolute";
		document.all.deprt2.style.visibility="hidden";
		document.all.deprt2.style.position="absolute";
	}

	if(varstrFreeze=='Y'&& varNonPoolEMptyRatingFlag=='Y')
	{
		enableButtons(true,true,true,true,true,true);
	}
	if(varstrFreeze=='Y'||varFreezeFlag=="N")
	{
		enableButtons(true,false,true,false,true,true);
	}
	
}



function callHistroy()
{
	document.forms[0].hidBeanId.value = "financial";
	document.forms[0].hidBeanGetMethod.value = "getHistroy";
	document.forms[0].action=appUrl+"action/com_financialratingworkflow.jsp";
    document.forms[0].submit();
}

function doConfirm()
{
	if(ConfirmMsg(191))
	{
		document.forms[0].hidAction.value="approve";
		document.forms[0].hidBeanId.value="financial";
		document.forms[0].hidBeanMethod.value="updateAction";
		document.forms[0].hidBeanGetMethod.value="getHistroy";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_financialratingworkflow.jsp";
		document.forms[0].submit();
	}
}

function doReject()
{
	if(ConfirmMsg(190))
	{
		if(strRejectReasonsFlag=="0")
		{
			strRejectReasonsFlag="1";
			var appno=document.forms[0].appno1.value;
	   		var prop = "scrollbars=no,width=500,height=350,top=100,left=250";
			var url=appURL+"action/rejectreasonslist.jsp?hidBeanGetMethod=getRejectReasonMasterList&hidBeanMethod=updateReject&appno="+appno;
			window.open(url,"",prop);	
			return;	
		}
	
		document.forms[0].hidAction.value="reject";
		document.forms[0].hidBeanId.value="financial";
		document.forms[0].hidBeanMethod.value="updateAction";
		document.forms[0].hidBeanGetMethod.value="getHistroy";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_financialratingworkflow.jsp";
		document.forms[0].submit();
	}
}

function doSend()
{	
	if(strfinalsendflag!="Y" && varappStatus.toUpperCase()=="OP")
	{
		alert("Please do the rating before Send");
		return;
	}
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Recipient");
		return;
	}
	document.forms[0].hidAction.value = "send";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_financialratingaction.jsp";
	document.forms[0].submit();
}

function doUndo()
{
	document.forms[0].hidAction.value="undo";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getHistroy";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_financialratingworkflow.jsp";
	document.forms[0].submit();
}

function doSave()
{
	if(ConfirmMsg(166))
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidAction.value="save";
		document.forms[0].hidBeanId.value="financial";
		document.forms[0].hidBeanMethod.value="updateAction";
		document.forms[0].hidBeanGetMethod.value="getHistroy";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_financialratingworkflow.jsp";
		document.forms[0].submit();
	}
}


function doClose()
{
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/financialsrch.jsp";
		document.forms[0].submit();
	}
}

function getSection(modid)
{	
	document.forms[0].hidcmasno.value=cma;
	document.forms[0].hidfinanceid.value=finaced_id;
    if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert('103');
		return;
	}	
	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/com_FinancialTemp.jsp";
	document.forms[0].submit();
}

function callonlyforrating()
{
document.forms[0].hidBeanId.value = "financial";
document.forms[0].hidBeanGetMethod.value = "updateFinRating";
document.forms[0].action=appUrl+"action/FinancialOFRating.jsp";
document.forms[0].submit();
}


function callUsersHelp()
{
		usr_dept=document.forms[0].usr_department.value;
		var prop="scrollbars=no,width=400,height=350,top=100,left=250";
		var url=appURL+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value+"&usr_dept="+usr_dept;
		window.open(url,"hai",prop);
}

function callOrgHelp()
{
	var appno1="<%=Helper.correctNull((String) hshValues.get("strappno"))%>";
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appURL+"action/orgnamelist.jsp?&appno="+appno1;
		window.open(url,"",prop);
	}
}
function doReassign()
{
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Recipient");
		return;
	}
	document.forms[0].hidAction.value = "reallocate";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_financialratingaction.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body onload="callOnLoad()">
<form name="misdet" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertable">
		<tr>
		<td class="page_flow">Home -&gt;Financial / Rating-&gt;Financial/Rating Workflow-&gt;Action</td>
	</tr>
</table>
<lapschoice:finapptype appid='<%=Helper.correctNull((String) hshValues.get("appidnew"))%>' financeid='<%=Helper.correctInt((String) hshValues.get("finace_id"))%>'/> 


<table width="100%" cellspacing="0" cellpadding="0" class="outertable">				
					<tr>
						<td><%
							boolean pflag = false;
							boolean base_year = false;
							int strWidth;
							int tabWidth;
							strWidth = vecModSize;
						%>
						<table border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<%
									for (int i = 0; i < vecModSize; i++) {
										ArrayList vecVal = (ArrayList) vecModule.get(i);
										if (i == 0) {
											tagFlag = Helper.correctNull((String) vecVal.get(0));
										}
										String str1 = Helper.correctNull((String) vecVal.get(0));
										String strClass;
										if (strWidth == 1) {
											tabWidth = 5;
										} else if (strWidth == 2) {
											tabWidth = 20;
										} else {
											tabWidth = 80 / strWidth;
										}
										if (i == 0 && strCurModule.trim().equals("")) {
											str1 = "";
										}

										strClass = "sub_tab_inactive";
										if (!Helper.correctNull((String) vecVal.get(0)).equals(
												"Project Financial Input")) {
								%> <td  align="center" class="<%=strClass%>">
				<a href="#" onclick="getSection('<%=Helper.correctNull((String) vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%
										}
								%>
				</td>
								<%
									}
								%>
								<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="gototab('financial','getDataRatio','finratio.jsp','RA1&pagetype1=OFR')">FINANCIAL RATIOS</a></b></td>
								<% if(Helper.correctNull((String)hshValues.get("digiflag")).equalsIgnoreCase("Y")){ %>
								<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="getdigirating()">DIGI RATING</a></b></td>  
								<%} else {%>
								<td class="sub_tab_inactive"><a
								href="javascript:callonlyforrating()">ONLY FOR RATING</a></td>
								<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="gototab('perDeviation','getpermDocumentDetails','perm_docAttachment.jsp')">Document Attachment</a></b></td>
								<%}%>
				<td align="center" class="sub_tab_active">FINANCIAL/RATING
				WORKFLOW
			</tr>
						</table>
						</td>
					</tr>
				</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable"
			width="40%">
			<tr align="center">
			<td width="50%" class="sub_tab_inactive"><a
					href="javascript:callHistroy()">History</a></td>
				<td width="50%" class="sub_tab_active">Action</td>
				
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			class="outertable border1" align="center">
			<tr>
				<td valign="top">
								<table width="100%" border="0" cellspacing="5" cellpadding="5"
									class="outertable">
									<tr>
										<td>Select Organisation</td>
										<td><input type="text" name="org_name" size="35"
											readonly="readonly" value="<%=strOrgName%>"> <span
											id="idorgselect"> <a href="#"
											onClick="javascript:callOrgHelp()"> <img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"> </a></span></td>
											<td id="deprt1">Department<span
											class="mantatory">*&nbsp;</span></td>

										<td id="deprt2"><select name="usr_department">
											<option value="0">---Select---</option>
											<%
												String apptypecon = "20";
											%>
											<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
										</select>
										</td>
										<td>Select Recipient</td>
										<td><input type="text" name="mail_tousrid" size="37"
											readonly="readonly" value=""> <input type="hidden"
											name="hidmail_tousrid"> <a href="#"
											onClick=javascript:callUsersHelp();><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></td>

									</tr>
									
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable">
									<tr>
										<td nowrap>Sanctioning Authority Comments</td>
										<td><textarea name="txt_sanctioncomments" cols="150" onkeyup="textlimitcorp1(this,200);" onkeydown="textlimitcorp1(this,200);" wrap="VIRTUAL"
											rows="3"><%=Helper.correctNull((String) hshValues
									.get("fin_comments"))%> 
						            </textarea></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
<lapschoice:combuttonnew btnnames='Confirm_Reject_Undo_Send_Save_Reassign' btnenable=''/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="org_code" value="<%=strOrgCode%>">
<INPUT TYPE="hidden" NAME="hidfinanceid" value="<%=Helper.correctInt((String) hshValues.get("finace_id"))%>">
<INPUT TYPE="hidden" NAME="hidcmasno" value="<%=Helper.correctInt((String) hshValues
									.get("fintype"))%>">
<input type="hidden" name="hid_appid" value="<%=Helper.correctInt((String) hshValues.get("appidnew"))%>">
<input type="hidden" name="pageval">
<input type="hidden" name="mail_touserclass">
<input type="hidden" name="appno1" value="<%=Helper.correctNull((String) hshValues.get("strappno"))%>"> 
<input type="hidden" name="txt_usrid" value="<%=Helper.correctNull((String) hshValues.get("strUsrid"))%>"> 
<input type="hidden" name="AssetandLiab" value="<%=Helper.correctNull((String)hshValues.get("AssetandLiab"))%>">
<INPUT TYPE="hidden" NAME="hidfinid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
</form>
</body>
</html>