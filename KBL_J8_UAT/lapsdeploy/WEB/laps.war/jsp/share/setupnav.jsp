<%@include file="../share/directives.jsp"%>
<%
	String grpRights = (String) session.getAttribute("strGroupRights");
%>
<html>
<head>
<TITLE>Laps Navigation</TITLE>
<script type="text/javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
	
<script type="text/javascript">
function doClose()
{
	document.forms[0].action=appURL+"action/mainnav.jsp";
	document.forms[0].submit();	
}
</script>
<style>
	tr.dataheader td{
		border-bottom: 1px solid #8d61aa !important;
	}
.menubackflowmon a:link {
	color: #666677;
}

.menubackflowmon a:visited {
	color: #666677;
}

.menubackflowmon a:hover {
	color: #ffffff;
	background: #6699CC;
	border-color: #DA251C;
	border-top: 1px solid #ffffff;
	border-bottom: 1px solid #2a55ff;
}

#slide-mon {
	background-color: olive;
	border-bottom-style: outset;
	width: auto;
	display: none;
	height: 50px;
	margin: auto;
}

.btn-slidemon:hover {
	color: #000000
}

.btn-slidemon:link,.btn-slidemon:visited {
    color: #000000;
    float: center;
    display: block;
    font-size: 11px;
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}
.btn-slidegen, .btn-slideretail, .btn-slideoth, .btn-slidemis, .btn-slidecorp, .btn-sliderat, .btn-slideralc{
	/* border-bottom: 1px solid #f1f1f1; */
}
.menubackflow a:hover {
    color: #942188;
}
.btn-slidecorp:hover {
	color: #000000
}

.btn-slidecorp:link,.btn-slidecorp:visited {
    color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}

.btn-slidegen:hover {
	color: #fd6a15;
}

.btn-slidegen:link,.btn-slidegen:visited {
    color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}

.btn-slideretail:hover {
	color: #000000
}

.btn-slideretail:link,.btn-slideretail:visited {
    color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}

.btn-slideoth:hover {
	color: #000000
}

.btn-slideoth:link,.btn-slideoth:visited {
    color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}

.btn-slideter:hover {
	color: #000000
}

.btn-slideter:link,.btn-slideter:visited {
    color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}

.btn-slidenpa:hover {
	color: #000000
}

.btn-slidenpa:link,.btn-slidenpa:visited {
    color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}
.btn-slidemis:hover {
	color: #000000
}

.btn-slidemis:link,.btn-slidemis:visited {
    color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}

.btn-sliderat:hover {
	color: #000000
}

.btn-sliderat:link,.btn-sliderat:visited {
    color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}
.btn-slideralc:hover {
	color: #000000
}

.btn-slideralc:link,.btn-slideralc:visited {
	color: #000000;
    float: center;
    display: block;
    /* font-size: 11px; */
    text-transform: uppercase;
    font-weight: bold;
    /* height: 26px; */
    padding: 10px 10px;
    /* line-height: 22px; */
    /* text-align: center; */
    text-decoration: none;
    width: auto;
    background-color: #dccada;
    font-family: Trebuchet MS;
    text-align: left;
}
</style>
<script type="text/javascript">
$(document).ready(function(){

$(".btn-slidemon").click(function(){
$(".menubackflowmon").slideToggle("slow");
});

$(".btn-slidecorp").click(function(){
$(".menubackflowcorp").slideToggle("slow");
});

$(".btn-slidegen").click(function(){
$(".menubackflowgen").slideToggle("slow");
});

$(".btn-slideretail").click(function(){
	$(".menubackflowretail").slideToggle("slow");
	});

$(".btn-slideoth").click(function(){
	$(".menubackflowoth").slideToggle("slow");
	});

$(".btn-slideter").click(function(){
	$(".menubackflowter").slideToggle("slow");
	});

$(".btn-slidenpa").click(function(){
	$(".menubackflownpa").slideToggle("slow");
	});

$(".btn-slidemis").click(function(){
	$(".menubackflowmis").slideToggle("slow");
	});

$(".btn-sliderat").click(function(){
	$(".menubackflowrat").slideToggle("slow");
	});
$(".btn-slideralc").click(function(){
	$(".menubackflowralc").slideToggle("slow");
	});
	 
});
</script>

<script language="JavaScript">

var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function dohlp()     
{
  	var hlpvar = appURL+"phlp/setup.html";
  	var title = "SetupSearch";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}
function doExcelExport()
{
	if(confirm("Do you want to download the Excel file?"))
	{
		var qryString=appURL+"action/ProductSpreadDetails.xlsx?&hidBeanId=excelfunction&hidBeanGetMethod=doExportProductSpread";
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"FinancialFormat",prop);
	}
}


function viewSelectedDocument()
{

	/*document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].hidBeanGetMethod.value="getBulkDocView";
	document.forms[0].action=appURL+"action/setdeviation.jsp";	
	document.forms[0].submit();*/
	
	
	document.forms[0].action=appURL+"action/setBulkDocuments.jsp";	
	document.forms[0].submit();	
		
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css"
	type="text/css">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmltrnav" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" class="page_flow">Home -&gt; Setup</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td valign="top" align="center">
		<table width="40%" border="0" align="center" cellpadding="0"
			class="outertable" cellspacing="0">
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="0"
					class="outertable" cellspacing="0">
					<tr class="dataheader">
						<td>
						<div><a href="#" class="btn-slidegen">General Setup</a></div>
						</td>
					</tr>
					<tr style="display: none" class="menubackflowgen">
						<td>
						<table width="100%" cellpadding="0" cellspacing="0" border="0"
							class="outertable">
							<tr class="menubackflow">
								
								<%
									if (grpRights.charAt(0) == '1') {
								%> <td valign="top"><a href="javascript:gotoTab(appURL,'setglpoptions','getData','setglp.jsp')">Global Options</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">GlobalOptions</td><%
									}
								%>
								
							</tr>
							<tr class="menubackflow">
								
								<%
									if (grpRights.charAt(0) == '1') {
								%><td valign="top"> <a
									href="javascript:gotoTab(appURL,'setorg','getData','setorg.jsp')">Organisation</a></td>
								<%
									} else {
								%>
								<td valign="middle" class="disabledmenu">Organisation</td><%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(0) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTab(appURL,'setgrouplimits','getData','setgrouplimits.jsp')">Lending
								Powers</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Lending
								Powers</td><%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(0) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTab(appURL,'setgroups','getData','setgroups.jsp')">Groups</a></td>
								<%
									} else {
								%>
								<td valign="middle" class="disabledmenu">Groups</td><%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(0) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTab(appURL,'setusers','getData','setusers.jsp')">Users</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Users</td> <%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(0) == '1') {
								%><td valign="top"> <a
									href="javascript:gotoTab(appURL,'bobinterest','getDataHelp','bobinterest.jsp')">Interest
								Index</a></td>
								<%
									} else {
								%>
								<td valign="middle" class="disabledmenu">Interest Index</td><%
									}
								%>
							</tr>
							<%-- <tr class="menubackflow">
								<%
									if (grpRights.charAt(0) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTab(appURL,'tdocdocuments','getData','documents.jsp')">Documents</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Documents</td><%
									}
								%>
							</tr>--%>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(0) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTab(appURL,'workflowmaster','getData','workflow.jsp')">Workflow
								Master</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">
								Workflow Master </td><%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTab(appURL,'setstatecity','getData','interfacenav.jsp')">Interface</a></td>
								<%
									} else {
								%>
								<td valign="middle" class="disabledmenu">Interface</td><%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%><td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getDataHouseParameters','houseparamaster.jsp')">Other Parameters</a></td>
								<%
									} else {
								%>
								<td valign="middle" class="disabledmenu">Other Parameters</td> <%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTab(appURL,'staticdata','getRejectReasonMasterList','rejectreasonsmaster.jsp')">Rejection Reasons</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Rejection
								Reasons</td><%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTabpage(appURL,'setuprepnav.jsp')">Reports</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Reports</td><%
									}
								%>
								
							</tr>
								<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%> <td valign="top"><a href="javascript:gotoTab(appURL,'setproducts','getSolKpowerData','solandkpowerflowpoint.jsp')">
									Solvency / Kpower /Banker Certificate/ Deviation Flow point</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Solvency / Kpower /Banker Certificate/ Deviation Flow point</td><%
									}
								%>
								
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%> <td valign="top"><a href="javascript:gotoTab(appURL,'comsolvency','getProcessData','solvencyprodprocesscharges.jsp')">
									Solvency / Banker Certificate/Procesing Charges & Delegated Power</td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Solvency / Banker Certificate/Procesing Charges & Delegated Power</td><%
									}
								%>
								
							</tr>
						
							<tr style="display: none" class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%><td valign="top"> <a
									href="javascript:gotoTabpage(appURL,'audit_trial_search.jsp')">Audit
								Trial Report</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Audit
								Trial Report</td> <%
									}
								%>
							</tr>
							<tr  class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%><td valign="top"> <a
									href="javascript:gotoTabpage(appURL,'setrbiguidelines_restructuring.jsp')">
									RBI Guidelines for Restructuring
									</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">
								RBI Guidelines for Restructuring</td> <%
									}
								%>
							</tr>
							<tr  class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%><td valign="top"> <a
									href="javascript:gotoTab(appURL,'setinterest','getMCLRMaster','setMCLRMaster.jsp')">
									Reference Rate Master
									</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">
								MCLR Master</td> <%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTabpage(appURL,'setdeviationassmaster.jsp')">Deviation Assessment Master</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Deviation Assessment</td><%
									}
								%>
								
							</tr>
							<tr  class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%><td valign="top"> <a
									href="javascript:gotoTab(appURL,'setinterest','getMCLRSpreadMaster','setMCLRSpreadMaster.jsp')">
									Corp &amp; Agri - Interest Spread Master
									</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">
								Corp &amp; Agri - Interest Spread Master</td> <%
									}
								%>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				if (grpRights.charAt(0) == '1') {
			%>
			<tr>
				<td valign="top">
				<table border="0" cellspacing="0" cellpadding="0" width="100%"
					class="outertable">
					<tr class="dataheader">
						<td>
						<div><a href="#" class="btn-slideretail">Retail Products</a></div>
						</td>
					</tr>
					<tr style="display: none" class="menubackflowretail">
						<td>
						<table width="100%" cellpadding="0" cellspacing="0" border="0"
							class="outertable">
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTab(appURL,'productcat','getData','categorymaster.jsp')">Category
								Master</a></td>
							</tr>
							<tr valign="top" class="menubackflow">
								<td valign="top"><a href="javascript:gotoTabpage(appURL,'setcomtermscondition.jsp?prdtype=R')">General Terms and Conditions</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTab(appURL,'setmodtermscond','getData','setmodtermscond.jsp')">Product Terms
								and Conditions</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTab(appURL,'setsearchproducts','getData','setsearchproducts.jsp')">Products</a></td>
							</tr>
							<tr class="menubackflow" style="display: none">
								<td valign="top"><a
									href="javascript:gotoTab(appURL,'setstatecity','getData','setagriparam.jsp')">Agri
								Parameters</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTab(appURL,'staticdata','getgeneralinfoData','generalinformation.jsp?hidAction=Onload')">Appraisal
								Questionnaire</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'govtsponsorinfo.jsp')">Govt
								Sponsor Questionnaire</a></td>
							</tr>
							<tr class="menubackflow" style="display: none">
								<td valign="top"><a
									href="javascript:gotoTab(appURL,'prdsanclimit','getDelegate','prod_delegatedPowers.jsp')">Delegated Powers</a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
			%>

			<tr>
				<td valign="top">
				<table width="100%" cellpadding="0" cellspacing="0" border="0"
					class="outertable">
					<tr class="dataheader">
						<td>
						<div><a href="#" class="btn-slideoth">Other Setup</a></div>
						</td>
					</tr>
					<tr style="display: none" class="menubackflowoth">
						<td>
						<table width="100%" cellpadding="0" cellspacing="0" border="0"
							class="outertable">
							<!-- <tr class="menubackflow">
								<td valign="top">
								<%
									if (grpRights.charAt(1) == '1') {
								%> <a
									href="javascript:gotoTabpage(appURL,'undelapp.jsp')">Restore
								Deleted Applications</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">
								Undelete Applications <%
									}
								%>
								</td> 
							</tr>-->
							<tr class="menubackflow">
								
								<%
									if (grpRights.charAt(1) == '1') {
								%>
								<td valign="top"> <a
									href="javascript:gotoTabpage(appURL,'mastersearch.jsp')">Static
								Data Master</a></td>
								<%
									} else {
								%><td valign="top" class="disabledmenu">Static
								Data Master <%
									}
								%>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%> 
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'cbs_datamaster.jsp')">CBS
								Data Master</a>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">CBS
								Data Master <%
									}
								%>
								</td>
							</tr>
						
							<tr class="menubackflow">
								
								<%
									if (grpRights.charAt(1) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTab(appURL,'staticdata','getInstructionsData','Instructions.jsp')">Bulletin Info</a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">
								Bulletin Info <%
									}
								%>
								</td>
							</tr>
							<tr class="menubackflow">
							<%
									if (grpRights.charAt(0) == '1') {
								%>
								<td valign="top">
								<a
									href="javascript:gotoTabpage(appURL,'dynamicdocumentmaster.jsp')">Dynamic Document Master </a>
								</td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Documents</td><%
									}
								%>
								
							</tr>
							<!--<tr class="menubackflow">
								<td valign="top">
								<%
									if (grpRights.charAt(0) == '1') {
								%> <a
									href="javascript:gotoTabpage(appURL,'printPDFdocument.jsp')">Attach
								Document For Print </a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Attach
								Document For Print <%
									}
								%>
								</td>
							</tr>
							--><tr class="menubackflow">
								<%
									if (grpRights.charAt(0) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTabpage(appURL,'setschemedocument.jsp')">Checklist
								for Document </a></td>
								<%
									} else {
								%><td valign="middle" class="disabledmenu">Checklist
								for Document <%
									}
								%>
								</td>
							</tr>
							<tr class="menubackflow">
								<%
									if (grpRights.charAt(1) == '1') {
								%> <td valign="top"><a
									href="javascript:gotoTabpage(appURL,'setstatecity.jsp')">State-City</a></td>
								<%
									} else {
								%>
								<td valign="middle" class="disabledmenu">State-City<%
									}
								%>
								</td>
							</tr>
							
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTabpage(appURL,'com_extcreditrating.jsp')">
								External Credit Rating Particulars</a></td>
							</tr>
							
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTab(appURL,'securitymaster','getSecurityMaster','setsecuritymaster.jsp')">
								Security Master</a></td>
							</tr>
							
							
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTab(appURL,'perDeviation','getPermissionMaster','setpermissionmaster.jsp')">
								Permission Master</a></td>
							</tr>
							
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTabpage(appURL,'set_PMAYMaster.jsp')">
								PMAY Master</a></td>
							</tr>
							
							
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTab(appURL,'staticdata','getInterfaceSchemeData','setintrfschemes.jsp')">
								Scheme Codes</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTab(appURL,'staticdata','','freecode.jsp')">
								Free Codes</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTabpage(appURL,'setafomaster.jsp')">
								AFO set Branch</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:doExcelExport();">
								Retail/Agriculture/Corporate Spread Excel Download</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTabpage(appURL,'prdspreadexcelupload.jsp')">
								Retail/Agriculture/Corporate Spread Excel Upload</a></td>
							</tr>	
							
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTab(appURL,'securitymaster','getAgriunitcostMaster','Agricultureunitcostsetup.jsp')">
								Agriculture Unit Cost</a></td>
							</tr>	
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:viewSelectedDocument();">
								SHG Bulk Excel Upload</a></td>
							</tr>					
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		<%-- 	<%
				if (grpRights.charAt(0) == '1') {
			%>
			<tr>
				<td valign="top">
				<table width="100%" cellpadding="0" cellspacing="0" border="0"
					class="outertable">
					<tr class="dataheader">
						<td>
						<div><a href="#" class="btn-slideter">Tertiary Products</a></div>
						</td>
					</tr>
					<tr style="display: none" class="menubackflowter">
						<td>
						<table width="100%" cellpadding="0" cellspacing="0" border="0"
							class="outertable">
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'ops_limitmaster.jsp?prdtype=T')">Limit
								Master</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'setprdworkflowcom.jsp?prdtype=T')">Flow
								points</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'ops_processcharge.jsp?prdtype=T')">Charges</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'facilitiesdoc.jsp')">Documents</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'setcomtermscondition.jsp')">Terms
								and Conditions</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'ops_interest.jsp?prdtype=T')">Interest</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'ops_margin.jsp?prdtype=T')">Margin</a></td>
							</tr>
							<tr class="menubackflow">
								<td valign="top"><a
									href="javascript:gotoTabpage(appURL,'set_govtspons_parameters.jsp?prdtype=T')">Govt.
								Sponsor Schemes Parameter</a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
			%> --%>
	<!-- Created by Venkata Prasad chowdary for MIS Setup on 23-07-2013 -->		
 <%if (grpRights.charAt(0) == '1') {%>
 <tr>
	<td valign="top">
		<table width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">
			<tr class="dataheader"><td><div><a href="#" class="btn-slidemis">MIS Setup</a></div></td></tr>
			<tr style="display: none" class="menubackflowmis">
			<td>
			 <table width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">
			<tr class="menubackflow">
				<td valign="top"><a href="javascript:gotoTabpage(appURL,'mis_datamaster.jsp')">MIS Data Master</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><a href="javascript:gotoTabpage(appURL,'set_mismainsubactivity.jsp')">Main & Sub Activity</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><a href="javascript:gotoTabpage(appURL,'set_misactivity.jsp')">Activity Code</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><a href="javascript:gotoTab(appURL,'mis','getMisClassification','mis_classification_master.jsp')">MIS Classification Master</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><a href="javascript:gotoTab(appURL,'mis','getFarmerCategoryData','misfarmercategory.jsp')">MIS Farmer's Category</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><a href="javascript:gotoTab(appURL,'mis','getClassificationActivityMaster','misclassiActivity_master.jsp')">MIS Classification Activity Master</a></td>
			</tr>
			<!--<tr class="menubackflow">
				<td valign="top"><A HREF="javascript:gotoTab(appURL,'npasetup','getRealisible','Realisible_value.jsp')">Realisible values</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><A HREF="javascript:gotoTab(appURL,'npasetup','getAgeofNpa','ageofnpa.jsp')">Age of NPA</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><A HREF="javascript:gotoTabpage(appURL,'npainterest.jsp')">NPA Interest Master</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><A HREF="javascript:gotoTab(appURL,'npasetup','getMethodology','npamethodology.jsp')">Methodology</a></td>
			</tr>
			<tr class="menubackflow">
				<td valign="top"><A HREF="javascript:gotoTabpage(appURL,'legal_position.jsp')">Legal Position</a></td>
			</tr>-->
			</table>
			</td>
			</tr>
		</table>
	</td></tr>		<%}%>			

			
 <%if (grpRights.charAt(0) == '1') {%>
<!-- <tr>-->
<!--	<td valign="top">-->
<!--		<table width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">-->
<!--			<tr class="dataheader"><td><div><a href="#" class="btn-slidenpa">NPA</a></div></td></tr>-->
<!--			<tr style="display: none" class="menubackflownpa">-->
<!--			<td>-->
<!--			 <table width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">-->
<!--			 	<tr class="menubackflow" height="25">-->
<!--					<td valign="top"><A HREF="javascript:gotoTab(appURL,'staticdata','getnpaprovcoverpercnt','npa_prov_coverage_master.jsp')">Provisioning Coverage Percentage master</a></td>-->
<!--				</tr>-->
<!--			<tr class="menubackflow">-->
<!--				<td valign="top"><a href="javascript:gotoTabpage(appURL,'setprdworkflowcomnpa.jsp')">Flowpoints</a></td>-->
<!--			</tr>-->
<!--			<tr class="menubackflow">-->
<!--				<td valign="top"><a href="javascript:gotoTabpage(appURL,'npadelegatepower.jsp')">Delegated Powers</a></td>-->
<!--			</tr>-->
<!--			<tr class="menubackflow">-->
<!--				<td valign="top"><A HREF="javascript:gotoTab(appURL,'npasetup','getaggregatemeansData','aggregate_means.jsp')">Aggregate Means</a></td>-->
<!--			</tr>-->
<!--			<tr class="menubackflow">-->
<!--				<td valign="top"><A HREF="javascript:gotoTab(appURL,'npasetup','getRealisible','Realisible_value.jsp')">Realisible values</a></td>-->
<!--			</tr>-->
<!--			<tr class="menubackflow">-->
<!--				<td valign="top"><A HREF="javascript:gotoTab(appURL,'npasetup','getAgeofNpa','ageofnpa.jsp')">Age of NPA</a></td>-->
<!--			</tr>-->
<!--			<tr class="menubackflow">-->
<!--				<td valign="top"><A HREF="javascript:gotoTabpage(appURL,'npainterest.jsp')">NPA Interest Master</a></td>-->
<!--			</tr>-->
<!--			<tr class="menubackflow">-->
<!--				<td valign="top"><A HREF="javascript:gotoTab(appURL,'npasetup','getMethodology','npamethodology.jsp')">Methodology</a></td>-->
<!--			</tr>-->
<!--			<tr class="menubackflow">-->
<!--				<td valign="top"><A HREF="javascript:gotoTabpage(appURL,'legal_position.jsp')">Legal Position</a></td>-->
<!--			</tr>-->
<!--			</table>-->
<!--			</td>-->
<!--			</tr>-->
<!--		</table>-->
<!--	</td></tr>		<%}%>-->
<%if (grpRights.charAt(0) == '1') {%>
<tr>
<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="dataheader">
			<td><div><a href="#" class="btn-slidecorp">Corporate &amp;
						Agriculture Products</a></div></td>
		</tr>	
		<tr style="display: none" class="menubackflowcorp">
		<td>
		<table width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">
		<tr valign="top" class="menubackflow">		
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'com_indus_master.jsp')">Industry Master</a></td>
		</tr>
	
		<tr valign="top" class="menubackflow" style="display: none">
			<td valign="top"><a href="javascript:gotoTab(appURL,'formula','getCMA','com_cma_master.jsp?hidMode=new')">CMA Index</a></td>
		</tr> 
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'com_finmaster.jsp')">CMA Master</a></td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'com_formula.jsp?val=cma')">Formula Definition </a></td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'com_benchmarkRatio.jsp')">Benchmark Ratio</a></td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'com_facilitymaster.jsp')">Facility Master</a></td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'com_limitmaster.jsp?prdtype=C')">Limit Master</a></td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'comfacilityhome.jsp')">Facility Creation</a></td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'setprdworkflowcom.jsp?prdtype=C')">Flow points</a></td>
		</tr>
		<tr valign="top" class="menubackflow" style="display: none">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'setexposure.jsp')">Exposure</a></td>
		</tr> 
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'facilitiesdoc.jsp')">Documents</a></td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'setcomtermscondition.jsp')">Terms and Conditions</a></td>
		</tr>
		<tr valign="top" class="menubackflow" style="display: none">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'netownedfunds.jsp')">Net Owned Funds</a></td>
		</tr> 
		<tr valign="top" class="menubackflow" style="display: none">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'notecom_finmaster.jsp')">Note to MCB Financials</a></td>
		</tr>
		<tr valign="top" class="menubackflow" style="display: none">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'combst_main.jsp')">Broad Terms Proposal</a></td>
		</tr>
		<tr valign="top" class="menubackflow" style="display: none">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'setmst_mainnav.jsp')">Modification in Sanction Terms</a> </td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'rbiupload.jsp')">RBI Defaulters List Upload</a></td>
		</tr>
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'settakeovernorms.jsp')">Take Over Norms Master</a></td>
		</tr>
			<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTab(appURL,'facilitymaster','getexposureindustry','setexposureindustry.jsp')">Exposure To Industry</a></td>
		</tr>
		
		<!-- 
		<tr valign="top" class="menubackflow">
			<td valign="top"><a href="javascript:gotoTabpage(appURL,'com_extcreditrating.jsp')">External Credit Rating Particulars</a></td>
		</tr> -->
		</table>
		</td>
		</tr>
		</table>
		</td>	
			</tr>	
		<%} %>
			<%
			//	if (grpRights.charAt(0) == '1') {
			%>
		<!-- 	<tr style="display: none">
				<td valign="top">
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr class="dataheader">
						<td>
						<div><a href="#" class="btn-slidemon">Monitoring</a></div>
						</td>
					</tr>
					<tr style="display: none" class="menubackflowmon">
						<td>
						<table width="100%" cellpadding="0" cellspacing="0" border="0"
							class="outertable">
							<tr>
								<td valign="top" class="menubackflow"><a
									href="javascript:gotoTabpage(appURL,'monitoring_alerts.jsp')">Monitoring
								Alerts</a></td>
							</tr>
							<tr>
								<td valign="top" class="menubackflow"><a
									href="javascript:gotoTabpage(appURL,'setprdworkflowcommon.jsp')">Flowpoints</a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>  -->
			<%
			//	}
			%>
			
			<%if (grpRights.charAt(0) == '1') {%>
			<tr>
				<td valign="top">
				<table width="100%" cellpadding="0" cellspacing="0" border="0"
					class="outertable">
					<tr class="dataheader">
						<td>
						<div><a href="#" class="btn-sliderat">Rating</a></div>
						</td>
					</tr>
					<tr style="display: none" class="menubackflowrat">
						<td>
						<table width="100%" cellpadding="0" cellspacing="0" border="0"
							class="outertable">							
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTab(appURL,'securitymaster','getScoringParameters','setriskparameters.jsp')">
								Business Rule</a></td>
							</tr>
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getDataHouseParameters','set_ratingParameters.jsp')">Rating Parameters</a></td>
							</tr>	
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getRatingCode','set_ratingCodes.jsp')">Rating Codes</a></td>
							</tr>				
							
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%} %>
			<%if (grpRights.charAt(0) == '1') {%>
			<tr>
				<td valign="top">
				<table width="100%" cellpadding="0" cellspacing="0" border="0"
					class="outertable">
					<tr class="dataheader">
						<td>
						<div><a href="#" class="btn-slideralc">Admin Level Controls</a></div>
						</td>
					</tr>
					<tr style="display: none" class="menubackflowralc">
						<td>
						<table width="100%" cellpadding="0" cellspacing="0" border="0"
							class="outertable">							
							<tr class="menubackflow">
								<td valign="top"><a href="javascript:gotoTabpage(appURL,'setapplicationtransfer.jsp')">
								Application Transfer</a></td>
							</tr>
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getDataHouseParameters','setlapsParameters.jsp?hidfrom=LP')">LAPS Application Parameters</a></td>
							</tr>
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getUserPageControl','setUserPageAccess.jsp')">User Page Access Controls</a></td>
							</tr>
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTabpage(appURL,'set_ucic.jsp')"> UCIC </a></td>
							</tr>
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getSMSMaster','smssetupmaster.jsp?hidPageFrom=L');"> SMS Template for BSA/DSA/Other Leads</a></td>
							</tr>
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getSMSMaster','smssetupmaster.jsp?hidPageFrom=O');"> SMS Configuration Master for Others</a></td>
							</tr>
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getPostSancParameters','set_postSancParam.jsp?hidParam=P');"> Post Sanction Retail Parameter</a></td>
							</tr>
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getPostSancParameters','set_postSancParam.jsp?hidParam=C');"> Post Sanction Corporatre/Agri Parameter</a></td>
							</tr>
<!--							<tr class="menubackflow">-->
<!--							<td valign="top"> <a-->
<!--									href="javascript:gotoTab(appURL,'staticdata','getMCLRMSMEmasterdata','set_MCLRMSMEmaster.jsp')">MCLR MSME Exposure master</a></td>-->
<!--							</tr>-->
							<tr class="menubackflow">
							<td valign="top"> <a
									href="javascript:gotoTab(appURL,'staticdata','getmiborbranchlist','miborscodesel.jsp');"> MIBOR Branch selection</a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnenable='Y' /> <lapschoice:hiddentag
	pageid='<%=PageId%>' /> <input type="hidden" name="prdtype" value="">
	<input type="hidden" name="wrk_flowtype" value="p">
	<input type="hidden" name="hidprdcode" value="<%=Helper.correctNull((String)hshValues.get("strPrdCode"))%>">
</form>


</body>
</html>