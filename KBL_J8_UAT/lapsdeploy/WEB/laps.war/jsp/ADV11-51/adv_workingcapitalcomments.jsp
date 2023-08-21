<%@include file="../share/directives.jsp"%>
<%
			String strname = Helper.correctNull((String) request.getParameter("appname"));
		%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function callload() {
    disableFields(true);
}
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{		
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=one;
		}		
	} 	
}	
function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateworkingcapitalcomments";
		document.forms[0].hidBeanGetMethod.value="getworkingcapitalcomments";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidSourceUrl.value="/action/adv_workingcapitalcomments.jsp";			
		document.forms[0].submit();	
	} 
}
function callLink(page,bean,method)
{		
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();	
}
function doSave()
{	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="ADV1151";		
	document.forms[0].hidSourceUrl.value="/action/adv_workingcapitalcomments.jsp";
	document.forms[0].hidBeanMethod.value="updateworkingcapitalcomments";
	document.forms[0].hidBeanGetMethod.value="getworkingcapitalcomments";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert";	
	enableButtons(true, false, false, false, true);	
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel"; 
		document.forms[0].hidSourceUrl.value="/action/adv_workingcapitalcomments.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateworkingcapitalcomments";
		document.forms[0].hidBeanGetMethod.value="getworkingcapitalcomments";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 	
	}
}

function doPrint()
{		
		var appno="<%=Helper.correctNull((String)request.getParameter("appno"))%>";
		var appname="<%=strname%>";
		
		var purl ="<%=ApplicationParams.getAppUrl()%>action/adv_printreport.jsp?hidBeanGetMethod=getADVPrint&hidBeanId=ADV1151&appno="+appno+"&appname="+appname							
		purl+="&hidCategoryType="+document.forms[0].hidCategoryType.value+"&hidSSIType="+document.forms[0].hidSSIType.value;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callload()">
<form name="finForm" action="" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Working Capital Comments</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr class="dataheader">
		<td align="center"><b>WORKING CAPITAL COMMENTS</b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" class="outertable">
					<tr class="dataheader">
						<td colspan="2"><b>Comments for Working Capital Loan</b></td>
					</tr>
					<tr>
						<td>Whether inventory holdings are as per norms.
						<p>Give actuals vis a vis prescribed norms<br>
						</p>
						</td>
						<td><textarea name="txt_inventory" cols="50" rows="5" tabindex="1"
							maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("adv_workinventory"))%></textarea></td>
					</tr>
					<tr>
						<td>Deviations in inventory norms. If to be permitted reasons to
						be given</td>
						<td><textarea name="txt_deviation" cols="50" rows="5" tabindex="2"
							maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("adv_workdeviation"))%></textarea></td>
					</tr>
					<tr>
						<td>Method of lending to be applied</td>
						<td><textarea name="txt_lending" cols="50" rows="5" tabindex="3"
							maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("adv_worklending"))%></textarea></td>
					</tr>
					<tr>
						<td>Computation of Permissible bank finance</td>
						<td><textarea name="txt_computation" cols="50" rows="5"
							tabindex="4" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("adv_workcomputation"))%></textarea></td>
					</tr>
					<tr>
						<td>General observations / Recommendations</td>
						<td><textarea name="txt_recommendation" cols="50" rows="5"
							tabindex="5" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("adv_workrecommendation"))%></textarea></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td width="20%" ><b>&nbsp; <a
			href="javascript:callLink('adv_termloancomments.jsp','ADV1151','gettermloancomments')"
			> &lt;&lt; Previous </a>&nbsp;</b></td>
		<td width="60%" align="center"><b> <jsp:include
			page="../ADV11-51/adv_links.jsp" flush="true"/>
		</b></td>
		<td width="20%">&nbsp;
		<div align="right"><b>Pg.19/19 &nbsp;</b></div>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> <input type="hidden" name="hidsno"> <input
	type="hidden" name="appname" value="<%=strname%>"></form>
</body>
</html>


