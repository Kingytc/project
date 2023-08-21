<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
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
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varorglevel="<%=Helper.correctNull((String)hshValues.get("recmds_orglevel"))%>";

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
	//disableCommandButtons("load");
	if(varorglevel!="")
	{
		document.forms[0].sel_orglevel.value=varorglevel;
	}
	else
	{
		document.forms[0].sel_orglevel.value="S";
	}
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
		document.forms[0].hidBeanGetMethod.value="getorganisationrecmmendations";
		document.forms[0].action=appUrl +"action/npa_suitrecommendations.jsp";
		document.forms[0].submit(); 		
	}	
}
function doDelete()
{
if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/npa_suitrecommendations.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateorganisationrecommendations";
		document.forms[0].hidBeanGetMethod.value="getorganisationrecmmendations";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}


}
function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/npa_suitrecommendations.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateorganisationrecommendations";
	document.forms[0].hidBeanGetMethod.value="getorganisationrecmmendations";
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
function callLink(page,bean,method)
		{
		
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}
function getValues()
{
	document.forms[0].hidBeanId.value="npacommon"
	document.forms[0].hidBeanGetMethod.value="getorganisationrecmmendations";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/npa_suitrecommendations.jsp";
	document.forms[0].submit();
}	



function doPrint()
{		
		var npa_appno=document.forms[0].appno.value;
		var hidmoduletype=document.forms[0].hidmoduletype.value;
		var selPrint="Get";
		var CompanyName=document.forms[0].appname.value;						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/34PointsFormat_print.jsp?hidBeanGetMethod=printget34pointspageData&hidBeanId=npa&npa_appno="+npa_appno+"&borrowername="+CompanyName+"&hidmoduletype="+hidmoduletype+"&cbsid="+document.forms[0].cbsid.value+"&selPrint="+selPrint;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}
</script>

</head>


<body onload="onLoading()">
<form name="proposalpage4" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><lapstab:suiturltag pageid="14" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Sarfaesi
				Proposal -&gt;Recommendations</td>
			</tr>
			<tr>
				<td><lapschoice:npaapplication /> <INPUT type="hidden"
					name="npa_appno"
					value="<%=(String)request.getParameter("npa_appno")%>" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
			<tr>
				<td width="14%">Select Organisation</td>
				<td><select name="sel_orglevel" onChange="getValues()" tabindex="1">
					<option value="S" selected>&lt;---Select---&gt;</option>
					<option value="C">C.R.L.D., Central Office Recommendations</option>
					<option value="R">FGMO Recommendations</option>
					<option value="D">Regional Office Recommendations</option>
					<option value="A">Branch Recommendations</option>
				</select></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td align="center"><textarea name="txt_recommendations" rows="10"
					cols="80" tabindex="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"
					wrap="VIRTUAL"><%=Helper.correctNull((String) hshValues
							.get("recommendation"))%></textarea>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Print"
btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />  
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>