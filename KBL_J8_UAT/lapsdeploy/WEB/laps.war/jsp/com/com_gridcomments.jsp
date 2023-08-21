<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var seltype="<%=Helper.correctNull((String)hshValues.get("cg_type"))%>";
var orglevel="<%=strOrgLevel%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";

function callLink(page,bean,method)
{	
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}	
}

function placevalues()
{
	if(seltype!="")
	{
		document.forms[0].sel_level.value=seltype;

		if(document.forms[0].btnenable.value=="Y" && seltype=="<%=strOrgLevel%>")
		{
			enableButtons(false,true,true,true,true)
		}
		else
		{
			enableButtons(true,true,true,true,false)
		}
	}
	
	disableFields(true);
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
	}
}

function doEdit()
{
	var selorg=document.forms[0].sel_level.value;
	
	disableFields(false);
	document.forms[0].hideditflag.value="Y";
	if(selorg==orglevel)
	{
	enableButtons(true,false,false,false,false);
	}
	else
	{
		enableButtons(true,true,false,false,false);
	}	
	
}

function callOrgcheck()
{
	 
	var selorg=document.forms[0].sel_level.value;
	if(selorg==orglevel)
	{
	enableButtons(true,false,false,false,true);
	}
	else
	{
		enableButtons(true,true,false,false,true);
	}	
	
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getGridObservationData";
		document.forms[0].action=appUrl+"action/com_gridcomments.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function doPrint()
{
	var appno = document.forms[0].appno.value;
	var purl = appUrl+"action/com_gridobservationprint.jsp?hidBeanGetMethod=getGridObservationData&hidBeanId=executive&appno="+appno;
	prop = "scrollbars=yes,width=700,height=450,statusbar=no,menubar=yes,location=no,toolbar=no";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 650) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var title = "Corporate_preinspectionreport";
	window.open(purl,title,prop);
}
function doSave()
{
	if(document.forms[0].sel_level.value=="S")
	{
		ShowAlert('111','Grid Of');
		document.forms[0].sel_level.focus();
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateGridObservationData";
	document.forms[0].hidBeanGetMethod.value="getGridObservationData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_gridcomments.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateGridObservationData";
		document.forms[0].hidBeanGetMethod.value="getGridObservationData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_gridcomments.jsp";
		document.forms[0].submit();
	 }
}

</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
	<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	
</head>

<body onload="placevalues()">
<form name="frmevaluation" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="25" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Grid
		Observation</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<DIV ID="top">
<table width="78%" border="0" cellspacing="1" cellpadding="5"
	align="center" 
	class="shadow_1" class="outertable">

	<table width="50%" border="0" cellspacing="2" cellpadding="4" align="center" class="outertable">
		<tr>
			<td width="14%" align="right"><b>Grid of</b></td>
			<td><select name="sel_level" onChange="callOrgcheck()" tabindex="1">
				<option value="S" selected>&lt;---Select---&gt;</option>
				<option value="C">Central Office</option>
				<option value="R">FGMO</option>
				<option value="D">Regional Office</option>
				<option value="A">Branch/SARAL</option>
			</select></td>

		</tr>
		<tr>
			<td width="14%"><b>Observations</b></td>
			<td><b>Replies</b></td>

		</tr>
		<tr>
			<td width="14%"><textarea name="txt_observ" cols="65" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"
				wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("cg_observation"))%></textarea></td>
			<td><textarea name="txt_replies" cols="65" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("cg_replies"))%></textarea></td>

		</tr>

	</table>
	
</table>

</DIV>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
 <lapschoice:hiddentag /> 
 <input type="hidden" name="cattype" value="<%=strCategoryType%>"></form>
</body>
</html>

