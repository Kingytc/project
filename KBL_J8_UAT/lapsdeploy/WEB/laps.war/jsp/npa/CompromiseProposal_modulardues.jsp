<%@include file="../share/directives.jsp"%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;		 
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_modulardues.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateCompromiseModulardues";
		document.forms[0].hidBeanGetMethod.value="getCompromiseModulardues";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}
}

function onLoading()
{
	disableFields(true);
}
function doEdit()
{ 	
	disableCommandButtons(true,false,false,false,true);
    disableFields(false);
    document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="insert";
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getCompromiseModulardues";
		document.forms[0].action=appUrl+"action/CompromiseProposal_modulardues.jsp";
		document.forms[0].submit(); 	
	}	
}

function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_modulardues.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="updateCompromiseModulardues";
	document.forms[0].hidBeanGetMethod.value="getCompromiseModulardues";
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}			  
	}
	document.forms[0].txtminmoduleamt.readOnly=true;
	document.forms[0].txtmaxmoduleamt.readOnly=true;
	document.forms[0].txtsetlementamt.readOnly=true;
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

function calculatenpv()
{

}
</script>
</head>

<body onload="onLoading()">
<form name="comp1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:otscourltag pageid="11"/>
					</td>
				</tr>
				<tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA -&gt; Compromise Proposal -&gt; Modular Dues 
 </td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
<br>
<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<table width="60%" border="0" cellspacing="0" cellpadding="0" 
align="center" class="outertable border1">
	<tr>
		<td>
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr>
					<td>
						Amount Payable as per module
					</td>
					<td>
						<b><%=ApplicationParams.getCurrency()%></b>
					</td>
					<td>
						<lapschoice:CurrencyTag name="txtminmoduleamt" maxlength="12" size="16" 
						value='<%=Helper.correctNull((String)hshValues.get("moduleminamt"))%>'/>&nbsp; to &nbsp; <b> Rs. </b>
						<lapschoice:CurrencyTag name="txtmaxmoduleamt" maxlength="12" size="16" 
						value='<%=Helper.correctNull((String)hshValues.get("modulemaxamt"))%>'/>
					</td>
				</tr>
				<tr>
					<td>
						Settlement amount offered
					</td>
					<td>
						<b><%=ApplicationParams.getCurrency()%></b>
					</td>
					<td>
						<lapschoice:CurrencyTag name="txtsetlementamt" maxlength="12" size="16" 
						value='<%=Helper.correctNull((String)hshValues.get("settlementamt"))%>'/>
					</td>
				</tr>
				<%
				if(Helper.correctNull((String)hshValues.get("deviationany")).equalsIgnoreCase("Y"))
				{
					
				%>
				<tr>
					<td>
						Deviation If any
					</td>
					<td>&nbsp;
						
					</td>
					<td>
						<textarea name="txtdeviationreason" rows="5" cols="50" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("deviationreason")) %></textarea>
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
</form>
</body>
</html>
