<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function callLink(page,bean,method)
	{
	if (document.forms[0].cmdsave.disabled)
			{
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
			}
			else
			{
				ShowAlert(103);
			}
	}
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

function onLoading()
{
	disableFields(true);
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
		document.forms[0].action=appUrl +"action/prudential_comments.jsp";
		document.forms[0].submit(); 		
	}	
}
function doSave()
{
	if(document.forms[0].txt_briefhistory.value=="")
	{
		alert("Enter the Brief History");
		document.forms[0].txt_briefhistory.focus();
		return;
	}
	if(document.forms[0].txt_irregularreasons.value=="")
	{
		alert("Enter the Reson for irregularities in the Account");
		document.forms[0].txt_irregularreasons.focus();
		return;
	}
	if(document.forms[0].txt_staffaccountability.value=="")
	{
		alert("Enter theStaff Accountability");
		document.forms[0].txt_staffaccountability.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/prudential_comments.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateGeneralHistoryData";
	document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
	}
}
function doClose()
{
  if(ConfirmMsg('100'))
	{
	document.forms[0].method="post";	
	document.forms[0].action=appUrl+"action/"+"npa_mainlinknav.jsp";
	document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/prudential_comments.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateGeneralHistoryData";
		document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}


</script>
</head>
<body onload="onLoading()">
<form name="prudential_comments" method="post" class="normal">
<lapstab:pwourltag pageid="3" />
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">	
			<tr>
				<td class="page_flow">Home -&gt; NPA-&gt; Prudential Write Off
				-&gt;Comments</td>
			</tr>			
		</table>
<lapschoice:npaapplication /> <INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
	<tr>
		<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top" colspan="2"><b>BRIEF HISTORY &amp; BACKGROUND <span class="mantatory">*&nbsp;</span>
		</b></td>
	</tr>
	<tr>
		<td valign="top" width="50%"><textarea name="txt_briefhistory"
			rows="14" cols="100" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("briefhistory"))%></textarea></td>
		<td align="justify" valign="middle"><span font="color:red"> <u>(Comments
		should be made on following points):</u>
		<ul>
			<li>Initial setting up/Promoter's contribution</li>
			<li>Initial finance,style and experience in conduct of account</li>
			<li>Financial position at the time of last review,present financials</li>
			<li>In case,means of Directors/Guarantors have gone down specific
			reasons for the same be ascertained and mentioned.</li>
			<li>In case,Company is in liquidation,whether the liquidation is by
			Court/Members/Creditors and whether the liquidator/liquidation
			proceedings are to our satisfaction and recovery of assets is proper.</li>
			<li>If the assets of the company in liquidation have been
			misappropriated due to omission or commission of the
			Directors/Officers of the Company,whether liquidator has proceeded
			against them under the provisions of the Companies Act and other
			Laws.</li>
		</ul>
		</span></td>
	</tr>
	<tr>
		<td colspan="2"><b>REASONS FOR ACCOUNT BECOMING NPA/CLOSURE OF
		BUSINESS:<span class="mantatory">*&nbsp;</span>
		</b></td>
	</tr>
	<tr>
		<td valign="top"><textarea name="txt_irregularreasons" rows="12" cols="100"
			wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("irregularreasons"))%></textarea>
		</td>
		<td><u>(Comments to be given on the following)</u>
		<ul>
			<li>Reasons for turning NPA.</li>
			<li>Action taken for regularizing the account</li>
			<li>When Branch noticed weaknesses in running of the unit,<br>
			(a) due to fall in turnover in account <br>
			(b) non-submission of stock statements etc. <br>
			and steps,if any, taken by Branch after getting early warning signals
			or the closure was sudden.</li>
		</ul>
		</td>
	</tr>


	<tr>
		<td colspan="2"><b>STAFF ACCOUNTABILITY <span class="mantatory">*&nbsp;</span></b></td>
	</tr>
	<tr>
		<td valign="top"><textarea rows="12" cols="100" name="txt_staffaccountability"
			wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("staffaccountability"))%></textarea></td>
		<td valign="middle" ><u>(Comments to be given on the
		following)</u>
		<ul>
			<li>Accountability for valuation lapses.</li>
			<li>If Equitable Mortage not created on any collateral.</li>
			<li>Any other lapses.</li>
		</ul>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)request.getParameter("hidclaimsettled"))%>" />
</form>
</body>
</html>
