<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var strReviewYear = "<%=Helper.correctNull((String)hshValues.get("strReviewYear"))%>";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var strprocessby="<%=Helper.correctNull((String)hshValues.get("MON_TERMLOANREVIEW_TOUSRID"))%>";
var varApproverejectBy="<%=Helper.correctNull((String)hshValues.get("tlr_processedby"))%>";
var strstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var varStatus = "<%=Helper.correctNull((String)hshValues.get("status"))%>";

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function onLoading()
{
	if(strstatus=="pa")
	{
		document.forms[0].txt_sanctioncomments.readOnly=true;
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdfreezeapplication.disabled=true;
		
		if(strUserId==varApproverejectBy)
		{
			document.forms[0].cmdundo.disabled=false;
			document.forms[0].cmdfreezeapplication.disabled=false;
		}else
		{
			document.forms[0].cmdundo.disabled=true;
			document.forms[0].cmdfreezeapplication.disabled=true;
		}
		if(document.forms[0].appholder.value==strUserId)
		{
			document.forms[0].cmdsend.disabled=false;
		}
		document.forms[0].cmdapprove.disabled=true;
	}
	else if(strstatus=="ca")
	{
	    document.forms[0].txt_sanctioncomments.readOnly=true;
	    document.forms[0].cmdundo.disabled=true;
	    document.forms[0].cmdsend.disabled=true;
	    document.forms[0].cmdapprove.disabled=true;
	    document.forms[0].cmdfreezeapplication.disabled=true;
	}
	else if(strstatus=="op")
	{
		document.forms[0].cmdundo.disabled=true;
		document.forms[0].cmdfreezeapplication.disabled=true;
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].txt_sanctioncomments.readOnly=true;
		if(document.forms[0].appholder.value==strUserId)
		{
			document.forms[0].cmdsend.disabled=false;
			document.forms[0].cmdapprove.disabled=false;
			document.forms[0].txt_sanctioncomments.readOnly=false;
		}
	}
	
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
		document.forms[0].cmdundo.disabled=true;
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdfreezeapplication.disabled=true;
		
	}
}
function doFreezeApplication()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateTLRStatus";
	document.forms[0].hidBeanGetMethod.value="getTermLoanReviewHistory";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/reviewnoteworkflowhistroy.jsp";
	document.forms[0].submit();		
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
		
	}
}
function callLink(page,bean,method)
{
	
	 if (document.forms[0].cmdapply.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appURL+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}
function callLink1(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}

function callOrgHelp()
{
 	if(document.forms[0].cmdsend.disabled==false)
	{ 
	var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
	var url=appURL+"action/orgnamelist.jsp?hidBeanGetMethod=getDataHelp";
	window.open(url,"",prop);
	}
}
function callUsersHelp()
{	
	if(document.forms[0].cmdsend.disabled==false)
	{ 
	var prop="scrollbars=no,width=400,height=350,top=100,left=250";
	var url=appURL+"action/wrkflowuserlist.jsp?&org_code="+document.forms[0].org_code.value;
	window.open(url,"hai",prop);
	}
}

function doSend()
{
	if(document.forms[0].reviewYear.value=="")
	{
		alert("Select Year");
		return;
	}
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Recipient");
		return;
	}
	if(document.forms[0].appstatus.value.toUpperCase()=="OP" && document.forms[0].remarksFlag.value!="true")
	{			
		document.forms[0].hideditoption.value="Y"
	    callRemarks();
		return;
	}
	else
	{
		document.forms[0].hidSourceUrl.value="/action/reviewnoteworkflow.jsp";
		document.forms[0].hidBeanGetMethod.value="getTermLoanReview";
		document.forms[0].hidBeanMethod.value="updateTermLoanReview";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidAction.value="send";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function callRemarks()
{
	var prop = "scrollbars=no,width=650,height=600,top=25,left=180,status=1";
	var url=appURL+"action/mon_termloanreviewcomments.jsp?hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+"&editoption="+document.forms[0].hideditoption.value+"&hidtlrno="+document.forms[0].hidtlrno.value+"&cbsid="+document.forms[0].cbsid.value+"&reviewYear="+document.forms[0].reviewYear.value+"&cbsname="+document.forms[0].cbsname.value+"&appstatus="+document.forms[0].appstatus.value+"&hidBeanId=mailboxcomments&hidBeanGetMethod=getReviewTermLoanData";
	window.open(url,"remarks",prop);
}

function doApprove()
{
	if(trim(document.forms[0].txt_sanctioncomments.value)=="")
	{
		alert("Enter Comments");
		document.forms[0].txt_sanctioncomments.focus();
		return;
 	}
	document.forms[0].Stateflag.value="1";
	document.forms[0].hidAction.value="approve";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateTermLoanReview";
	document.forms[0].hidBeanGetMethod.value="getTermLoanReviewHistory";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/reviewnoteworkflowhistroy.jsp";
	document.forms[0].submit();	
}
function doUndo()
{
	document.forms[0].hidAction.value="undo";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateTermLoanReview";
	document.forms[0].hidBeanGetMethod.value="getTermLoanReviewHistory";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/reviewnoteworkflowhistroy.jsp";
	document.forms[0].submit();		
}

function callOtherTab(val)
{
	 if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getTermLoanReviewHistory";
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].action=appURL+"action/reviewnoteworkflowhistroy.jsp";
		 document.forms[0].submit();
	 }
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].reviewOf.disabled=false;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="termrevaction" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><lapschoice:tlrtag pageid="13"
			reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt;Workflow -&gt; Action</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td width="50%" valign="bottom">
		<table width="40%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
			<tr align="center">
				<td width="33%" class="sub_tab_inactive"><b> <a
					href="javascript:callOtherTab('history')" >History</a>
				</b></td>
				<td width="33%" class="sub_tab_active"><b>
					Action</b></td>
				<td width="33%"class="sub_tab_inactive" ><b><a href="#"
					onClick="javascript:callRemarks()">Remarks</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="80%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>
		<td width="26%" nowrap="nowrap">Select Organisation</td>
		<td width="31%" nowrap="nowrap"><input type="text" name="org_name" size="35"
			readonly="readonly" value="<%=strOrgName%>"> <a href="#"
			onClick="javascript:callOrgHelp()"><b ><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"> </b></a></td>
		<td width="23%" nowrap="nowrap">Select
		Recipient</td>
		<td width="20%" nowrap="nowrap"><input type="text" name="mail_tousrid"
			size="37" readonly="readonly"
			value="<%//=Helper.correctNull((String)hshValues.get("apprised_by"))%>">
		<input type="hidden" name="hidmail_tousrid"> <a href="#"
			onClick="javascript:callUsersHelp()"><b ><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"> </b></a></td>
	</tr>
	<tr>
		<td width="26%" nowrap="nowrap">Sanctioning Authority Comments</td>
		<td colspan="3" nowrap="nowrap"><textarea name="txt_sanctioncomments"
			cols="150" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("review_comments"))%></textarea></td>
	</tr>
</table><br>

<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable")) %>'  
btnnames="Approve_Undo_Send_Freeze Application_Audit Trail"/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="mail_touserclass">
<input type="hidden" name="org_code" value="<%=strOrgCode%>">
<input type="hidden" name="remarksFlag" value="false">
<input type="hidden" name="hideditoption" value="N">
<input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId")%>">
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
<input type="hidden" name="Stateflag">
</form>
</body>
</html>

