<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var strUserId='<%=(String) session.getAttribute("strUserId")%>';
var status = "<%=Helper.correctNull((String) hshValues.get("tlr_status"))%>";
var bankingarrangement = "<%=Helper.correctNull((String) hshValues
							.get("tlr_bankarrangement"))%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}
function callCalender(fname)
 {
	 if(document.forms[0].cmdsave.disabled==false)
	 {
	 	showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	 }
 }


function onLoading()
{
	
	if(status != "")
	{
	 document.forms[0].status_account.value=status;
	}
	else
	{
	 document.forms[0].status_account.value="1";
	}
	if(bankingarrangement != "")
	{
	 document.forms[0].mulbank.value=bankingarrangement;
	}
	else
	{
	 document.forms[0].mulbank.value="0";
	}
	disableFields(true);
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateBankingArrangementData";
			document.forms[0].hidBeanGetMethod.value="getBankingArrangementData";
			document.forms[0].hidBeanId.value="reviewtermloantwo";
			document.forms[0].hidSourceUrl.value="action/tlr_bankdetails.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	
	disableFields(false);
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
	
		document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidBeanGetMethod.value="getBankingArrangementData";
		document.forms[0].action=appURL +"action/tlr_bankdetails.jsp";
	    document.forms[0].submit();	
	}	
}

function doSave()
{
	document.forms[0].hidAccountStatus.value = document.forms[0].status_account[document.forms[0].status_account.selectedIndex].text;
	document.forms[0].hidMulBank.value = document.forms[0].mulbank[document.forms[0].mulbank.selectedIndex].text;
    document.forms[0].hidBeanId.value="reviewtermloantwo";
	document.forms[0].hidBeanMethod.value="updateBankingArrangementData";
	document.forms[0].hidBeanGetMethod.value="getBankingArrangementData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/tlr_bankdetails.jsp";
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}
	document.forms[0].txt_reviewdate.readOnly=true;
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
	
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
		
	}
}

function showLeadbank()
{
	if(document.forms[0].mulbank.value=="0" || document.forms[0].mulbank.value=="1" || document.forms[0].mulbank.value=="3" || document.forms[0].mulbank.value=="5")
	{
		document.all.idleadbank.style.visibility="hidden";
		
		document.all.idbnkname.style.visibility="hidden";
		document.all.idourshare.style.visibility="hidden";
		document.all.idleadbank.style.position="absolute";
		document.all.idbnkname.style.position="absolute";
		document.all.idourshare.style.position="absolute";
		
		document.forms[0].leadbank.value="";
		document.forms[0].txt_ourshare.value="";
	
	}
	else
	{
		document.all.idleadbank.style.visibility="visible";
		document.all.idbnkname.style.visibility="visible";
		document.all.idourshare.style.visibility="visible";
		
		document.all.idleadbank.style.position="relative";
		document.all.idbnkname.style.position="relative";
		document.all.idourshare.style.position="relative";
	}
}
function callOtherLink(page,bean,method)
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


</script>

</head>
<body onload="onLoading();showLeadbank();">
<form name="frmtlrbanking" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><lapschoice:tlrtag pageid="5"
			reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>'
			valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>' />
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Term Loan - Review -&gt; Banking Details</td>
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
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td align="center">
		<table width="70%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1" >
		<tr>
		   <td align="center" width="72%">
		<table width="80%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
			<tr>
				<td width="45%">Group</td>
				<td width="45%"><input type="text" name="txt_group" size="30"
					maxlength="50"
					value="<%=Helper.correctNull((String) hshValues.get("tlr_group"))%>"
					tabindex="8"></td>
			</tr>
			<tr>
				<td width="45%">Status of Account</td>
				<td width="45%"><select name="status_account">
					<option value="1" selected="selected">Regular</option>
					<option value="2">EAS - I</option>
					<option value="3">EAS - II</option>
					<option value="4">SMA</option>
					<option value="5">Not Applicable</option>
				</select></td>
			</tr>
			<tr>
				<td width="35%">Month of Review</td>
				<td width="60%"><input type="text" name="txt_reviewdate"
					size="15"
					value="<%=Helper.correctNull((String) hshValues
							.get("tlr_reviewdate"))%>"
					onBlur="checkDate(txt_reviewdate)" readOnly="readonly"> <a
					alt="Select date from calender"
					href="javascript:callCalender('txt_reviewdate')"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
			</tr>
		</table>
		</td>
		</tr>
	</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td colspan="2"><b>Banking Arrangement</b></td>
			</tr>
			<tr class="dataheader">
				<td width="35%" align="center"><b>Sole/Consortium/Multiple Banking</b></td>
				<td width="35%" align="center" id="idbnkname"><b>Lead Bank</b></td>
			</tr>
			<tr>
				<td width="35%" align="center"><b> <select
					name="mulbank" onChange="showLeadbank()">
					<option value="0" selected="selected">--select--</option>
					<option value="1">Sole</option>
					<option value="2">Consortium</option>
					<option value="3">Multiple</option>
					<option value="4">Sole/Consortium</option>
					<option value="5">Sole/Multiple</option>
					<option value="6">Consortium/Multiple</option>
					<option value="7">Sole/Consortium/Multiple</option>
				</select> </b></td>
				<td align="center" width="35%" id="idleadbank"><b>
				<input type="text" name="leadbank" size="25" maxlength="50"
					value="<%=Helper.correctNull((String) hshValues
									.get("tlr_leadbank"))%>">
				</b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr id="idourshare">
		<td valign="top">
		<table width="40%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
			<tr>
				<td width="30%" align="center"><b>Our Share (%)</b></td>
				<td width="35%" align="center"><b><input
					type="text" name="txt_ourshare" size="15"
					onKeyPress="allowNumber(this)"
					value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tlr_ourshare"))))%>"
					onBlur="checkPercentage(this)"> </b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
			<tr class="dataheader">
				<td rowspan="2"><b>External Credit Rating</b></td>
				<td colspan="4" align="center"><b>Agency Name</b></td>
				<td width="19%" align="center"><b>Last Year Rating</b></td>
				<td width="24%" align="center"><b>Current Year Rating</b></td>
			</tr>
			<tr>
				<td colspan="4" align="center"><input type="text"
					name="txt_agent" maxlength="100" size="30"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues
							.get("tlr_agencyname"))%>">
				</td>
				<td width="19%" align="center"><input type="text"
					name="txt_lastyear" maxlength="10" size="15"
					onKeyPress="notAllowedDouble()"
					value="<%=Helper.correctNull((String) hshValues
							.get("tlr_lastrating"))%>">
				</td>
				<td width="24%" align="center"><input type="text"
					name="txt_currentyear" maxlength="10" size="15"
					onKeyPress="notAllowedDouble()"
					value="<%=Helper.correctNull((String) hshValues
							.get("tlr_currating"))%>">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
<input type="hidden" name="hidAccountStatus">
<input type="hidden" name="hidMulBank">
</form>
</body>
</html>