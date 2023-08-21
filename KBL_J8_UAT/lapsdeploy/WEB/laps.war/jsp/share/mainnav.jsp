<%@include file="../share/directives.jsp"%>
<%
	String grpRights = Helper.correctNull((String) session
			.getAttribute("strGroupRights"));
	session.setAttribute("TotalLandHolding", "");
	session.setAttribute("strappno", "");
	session.setAttribute("perapp_employment", "");
	session.setAttribute("perapp_dob", "");
	session.setAttribute("perapp_status", "");
	session.setAttribute("perapp_eduothers", "");
	session.setAttribute("Salaryrouted", "");
	session.setAttribute("bowname", "");
	session.setAttribute("bowid", "");
	session.setAttribute("MarginPercent", "");
	session.setAttribute("strProductType", "");
	session.setAttribute("prdcode", "");
	session.setAttribute("InterestCharged", "");
	session.setAttribute("comm_appno", "");
	session.setAttribute("strCategoryType", "");
	session.setAttribute("sessionModuleType","");
	session.setAttribute("strappno","");
	session.setAttribute("strappstatus","");
	session.setAttribute("strBtnnenable","");
	
	session.setAttribute("strpremission_freezeflag","");


	session.removeAttribute("TotalLandHolding");
	session.removeAttribute("strappno");
	session.removeAttribute("perapp_employment");
	session.removeAttribute("perapp_dob");
	session.removeAttribute("perapp_status");
	session.removeAttribute("perapp_eduothers");
	session.removeAttribute("Salaryrouted");
	session.removeAttribute("bowname");
	session.removeAttribute("bowid");
	session.removeAttribute("MarginPercent");
	session.removeAttribute("strProductType");
	session.removeAttribute("prdcode");
	session.removeAttribute("InterestCharged");
	session.removeAttribute("comm_appno");
	session.removeAttribute("strCategoryType");
	session.removeAttribute("cattype");
	session.removeAttribute("strappno");
	session.removeAttribute("strappstatus");
	session.removeAttribute("strBtnnenable");
	session.removeAttribute("com_facintdef");
	session.removeAttribute("strAppType");
	session.removeAttribute("strPageID_PS");
	session.removeAttribute("strModifyterms");
	session.removeAttribute("strProductType");
	session.removeAttribute("schemeCode");
	session.removeAttribute("appno");
	session.removeAttribute("strConstitution");
	session.removeAttribute("strfacslno");
	session.removeAttribute("strCategory");
	session.removeAttribute("hidAppno");
	session.removeAttribute("PRD_CGTMSE");
	session.removeAttribute("strEduDate");
	session.removeAttribute("strAppCreateDate");
	session.removeAttribute("HouseEdit_Flag");
	session.removeAttribute("valuationFlag");
	session.removeAttribute("VehicleEdit_Flag");
	session.removeAttribute("StrDigiLoanType");
	session.removeAttribute("strECFlag");
	
	
	session.removeAttribute("strpremission_freezeflag");



	String strIRBpassword = IRB_Encryption.cEncrypt_Base64(Helper
			.correctNull((String) session.getAttribute("c_password")));
	
	String strUserDesignation=Helper.correctNull((String)session.getAttribute("strUserDesignation"));
	String strClassrights=Helper.correctNull((String)session.getAttribute("strUserClass"));
	
	String strNPA = Helper.correctNull((String)session.getAttribute("NPA"));
	String strFVC = Helper.correctNull((String)session.getAttribute("FVC"));
	String strNSDL = Helper.correctNull((String)session.getAttribute("NSDL"));
	String strRRM = Helper.correctNull((String)session.getAttribute("RRM"));
	String strSHG = Helper.correctNull((String)session.getAttribute("SHG"));
	String inwadroutwardorg = Helper.correctNull((String) session.getAttribute("strOrgCode"));
	
	String strCurrDate = Helper.getCurrentDateTime();
	String strEduDate = "20/07/2018";
	long diff_intime = 0;
	if (!strCurrDate.equals("") && !strEduDate.equals(""))
		diff_intime = Helper.dateDiff(strCurrDate, strEduDate);
	if(diff_intime>=0)
	{
		session.setAttribute("strEduDate", "Y");
	}
%>
<HTML>
<HEAD>
<TITLE>LAPS Navigation</TITLE>
<script language="JavaScript">
var grpRights = "<%=Helper.correctNull((String) session.getAttribute("strGroupRights"))%>";
var varadminrights = "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(0)%>";
var irburl="<%=Helper.correctNull((String) session.getAttribute("irb_desc"))%>";
var varOnlineURL  = "<%=ApplicationParams.getStrOnlineIp()%>";
var varuserid="<%=strUserId%>"
var varstrIRBpassword = "<%=strIRBpassword%>";
var varOrgCode = "<%=Helper.correctNull((String) session.getAttribute("strOrgCode"))%>";
var varOrgLevel = "<%=Helper.correctNull((String) session.getAttribute("strOrgLevel"))%>";
var varUserName = "<%=Helper.correctNull((String)session.getAttribute("strUserName"))%>";
var varUserId = "<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varorgregion=varOrgCode.substring(0,9);
var varExcelUploadFlag="<%=Helper.correctNull((String)hshValues.get("strExcelUploadFlag"))%>";
var varKalypto="<%=Helper.correctNull((String)session.getAttribute("strKalypto"))%>";
var varDMSURL="<%=Helper.correctNull((String)hshValues.get("StrURLDMSUpload"))%>";
var varDigiloan="<%=Helper.correctNull((String)hshValues.get("StrURLDigiloan"))%>";
var varTMS="<%=Helper.correctNull((String)hshValues.get("StrURLTMS"))%>";
function callFunction1(pagename)
{
	if(pagename=="securitiesSearch.jsp")
	{
		document.forms[0].action = appURL+"action/"+pagename+"?linkFrom=sec";
	}
	else if(pagename=="Bureau_link_Search.jsp"){
		document.forms[0].action = appURL+"action/"+pagename+"?hidCategoryType=BUR";
	}
	else
	{
		document.forms[0].action = appURL+"action/"+pagename;
	}
	document.forms[0].submit();
}
function callMail(mailtype,mailvalue)
{
	if(mailtype=="")
	{
		document.forms[0].workflow.value="Y";
		document.forms[0].action = appURL+"action/inboxmails.jsp?fromlink=mailbox";
		document.forms[0].submit();
	}
	else if(mailtype=="Mon" && mailvalue=="alerts")
	{
		document.forms[0].workflow.value="Y";
		document.forms[0].action = appURL+"action/mon_alertapp.jsp";
		document.forms[0].submit();
	}
	else if(mailtype=="S")
	{
		document.forms[0].workflow.value="Y";
		document.forms[0].action = appURL+"action/inboxmails.jsp?optformtype=S&fromlink=mailbox";
		document.forms[0].submit();
	}
	else if(mailtype=="Mon" && mailvalue=="")
	{
		document.forms[0].workflow.value="Y";
		document.forms[0].action = appURL+"action/inboxmails.jsp?fromlink=mailbox&hidBeanGetMethod=getMonData";
		document.forms[0].submit();
	}	
	else if(mailtype=="Branch_MB")
	{
		document.forms[0].workflow.value="Y";
		document.forms[0].action = appURL+"action/branchinboxhome.jsp";
		document.forms[0].submit();
	}	
}

function WindowClosing()
{
    document.forms[0].hidPage.value = "Navigation";
	document.forms[0].hidusr_id.value = "<%=session.getAttribute("strUserId")%>";
	document.forms[0].action=appURL+"action/hidlogin.jsp?val=exit";
	document.forms[0].submit();
	window.close();
}

function showDuplicateQueries()
{
	var FileName='Duplicate Queries.txt';
	var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
	var url=appURL+"action/"+FileName+"?hidBeanGetMethod=getData&hidBeanId=duplicatequeries";
	window.open(url,"remarks",prop);
}
	
function callFunctionMon(page,mon)
{
	document.forms[0].hidmontype.value = mon;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}	

function callFunction(pagename, linktype)
{
	if(linktype=="LAD")
	{
		document.forms[0].hidCategoryType.value = linktype;
		document.forms[0].action = appURL+"action/"+pagename+"?hidCategoryType="+linktype+"&strExcelUploadFlag="+varExcelUploadFlag;
		document.forms[0].submit();
	}
	else if(linktype=="COF")
	{
		document.forms[0].hidCategoryType.value = linktype;
		document.forms[0].action = appURL+"action/"+pagename+"?hidCategoryType="+linktype+"&srcPage=FC";
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].hidCategoryType.value = linktype;
		document.forms[0].action = appURL+"action/"+pagename+"?hidCategoryType="+linktype;
		document.forms[0].submit();
	}
}


function callOnline()
{
	var sOptions ='status=yes,menubar=yes,scrollbars=yes,resizable=yes,toolbar=yes,maximize=1'
		sOptions = sOptions + ',width=' + (screen.availWidth).toString();
		sOptions = sOptions + ',height=' + (screen.availHeight).toString();
		sOptions = sOptions + ',screenX=0,screenY=0,left=0,top=0';
	var request = varOnlineURL;
	if(request!="")
	{
		var win=window.open(request+"?PAGE_TYPE=B&LAPSFLAG=Y&USER="+varuserid+"&OrgCode="+varOrgCode+"&OrgLevel="+varOrgLevel+"&varUserName="+varUserName+"&varUserId="+varUserId,"",sOptions);
	}
	else
	{
		alert("Specify IP address in Static data Master");
	}
}

function callKalypto()
{
	var sOptions ='status=yes,menubar=yes,scrollbars=yes,resizable=yes,toolbar=yes,maximize=1'
		sOptions = sOptions + ',width=' + (screen.availWidth).toString();
		sOptions = sOptions + ',height=' + (screen.availHeight).toString();
		sOptions = sOptions + ',screenX=0,screenY=0,left=0,top=0';
	var request = varKalypto;
	if(request!="")
	{
		var win=window.open(request);
	}
	else
	{
		alert("Kalypto Address is not yet defined. Please contact the Administrator");
	}
}
function callDMS()
{
	var sOptions ='status=yes,menubar=yes,scrollbars=yes,resizable=yes,toolbar=yes,maximize=1'
		sOptions = sOptions + ',width=' + (screen.availWidth).toString();
		sOptions = sOptions + ',height=' + (screen.availHeight).toString();
		sOptions = sOptions + ',screenX=0,screenY=0,left=0,top=0';
	var request = varDMSURL;
	if(request!="")
	{
		var win=window.open(request);
	}
	else
	{
		alert("DMS URL is not yet defined. Please contact the Administrator");
	}
}
function callDigiloan()
{
	var sOptions ='status=yes,menubar=yes,scrollbars=yes,resizable=yes,toolbar=yes,maximize=1'
		sOptions = sOptions + ',width=' + (screen.availWidth).toString();
		sOptions = sOptions + ',height=' + (screen.availHeight).toString();
		sOptions = sOptions + ',screenX=0,screenY=0,left=0,top=0';
	var request = varDigiloan;
	if(request!="")
	{
		var win=window.open(request);
	}
	else
	{
		alert("DIGI Loan URL is not yet defined. Please contact the Administrator");
	}
}

function callChat()
{
	var varQryString = appURL+"action/LAPSchatRecipients.jsp?hidBeanId=Register&hidBeanGetMethod=getChatRecipients&userId="+varUserId;
	var title1 = "StaffChat";
	var prop1 = "scrollbars=yes,width=250,height=400,menubar=no,address=no,status=yes,left=1050,top=450";	
	window.open(varQryString,title1,prop1);
}

function navigateSolvency()
{
	document.forms[0].action = appURL + "action/com_searchsolvency.jsp";
	//document.forms[0].action = appURL+"action/com_solvency.jsp?hidBeanGetMethod=getSolvencyData&hidBeanId=comsolvency";
	
	document.forms[0].submit();
}

function navigateAddkpower()
{
	document.forms[0].action = appURL + "action/com_searchaddkpowerdetails.jsp";
	document.forms[0].submit();
}
function callNSDLReceive(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].hidBeanGetMethod.value="getNsdlRecvApplication";
	document.forms[0].hidBeanId.value="nsdl";
	document.forms[0].submit();
}
function callMonitoring()
{
       /*var strUserId=varUserId;
	   var WshShell= new ActiveXObject("WScript.Shell");
	   WshShell.run("cmd.exe /c start chrome http://172.16.202.62:9085/lms/action/hidlogin.jsp?txtusr_id="+strUserId, 0, false);*/
	   
	   document.all.ifrm.src=appURL+"action/iframeMultiLogins.jsp?hidBeanId=authenticate&hidBeanGetMethod=RedirectMonitoring&userId="+varUserId;
}
function callMSMEPROP(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].hidBeanGetMethod.value="getmsmeproposal";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].submit();
}

function navigateBankers()
{
	document.forms[0].action = appURL + "action/com_searchbankers.jsp";
	document.forms[0].submit();
}


function callSmsTrigger(pagename){
	document.forms[0].action = appURL+"action/"+pagename;
	//document.forms[0].hidBeanGetMethod.value="updsmsTrigger";
	//document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].submit();
}

function callECSCheck(pagename){
	document.forms[0].action = appURL+"action/"+pagename;
	//document.forms[0].hidBeanGetMethod.value="updsmsTrigger";
	//document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].submit();
}
function callTMS()
{
 	var sOptions ='status=yes,menubar=yes,scrollbars=yes,resizable=yes,toolbar=yes,maximize=1'
 	sOptions = sOptions + ',width=' + (screen.availWidth).toString();
  	sOptions = sOptions + ',height=' + (screen.availHeight).toString();
  	sOptions = sOptions + ',screenX=0,screenY=0,left=0,top=0';
	 var request = varTMS;
	 if(request!="")
	 {
	  	var win=window.open(request);
	 }
	 else
	 {
		alert("Ticket Management System URL is not yet defined. Please contact the Administrator");
	 }
}
function callNationalPortal(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function mclrMaster(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].hidBeanGetMethod.value="getMCLRMaster";
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].submit();
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
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<style type="text/css">
.HILITE {
	color: #CC0000;
}

.NONHILITE {
	color: #000000;
}

DIV.announce_container {
	height: 200;
	overflow: auto;
}
body {
margin:0;padding:0;
}
</style>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css"
	type="text/css">
</HEAD>
<body onLoad="txtLoad('Home')">
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
<form name="navigation" method="post" class="normal mt30">


	 <div class="mainnav">
		<div class="navbox ">
			<table width="70%" border="0" cellspacing="0" cellpadding="0" class="nav-bor" align="left">
				<tr>
					<td valign="top" width="25%" >
						<table width="98%" border="0" cellspacing="3" cellpadding="5"
							class="outertable" align="center">
							<%
								if (grpRights.charAt(0) == '1' || grpRights.charAt(1) == '1') {
							%>
							<tr>
								<td class="menubackflow"><a href="javascript:txtLoad('Setup');callFunction1('setupnav.jsp')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/setup.png" class="imgPurple" alt="">
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/setup-h.png" class="imgWhite" alt="">
				
								Setup  </b></a></td>
							</tr>
							<%
								}
								if (grpRights.charAt(2) == '1') {
							%>
							<tr>
								<td class="menubackflow"><a
									href="javascript:txtLoad('Masters');callFunction1('lawyermaster.jsp')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/masters.png" class="imgPurple" alt="">
							<img src="<%=ApplicationParams.getAppUrl()%>img/home/masters-h.png" class="imgWhite" alt="">
								
								Masters</b></a></td>
							</tr>
							<%
								}
								if (grpRights.charAt(3) == '1') {
							%>
							<tr>
								<td class="menubackflow"><a
									href="javascript:txtLoad('Defaulters List');callFunction1('comrbidefaultersearch.jsp')"><b> 
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/defaulter-list.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/defaulter-list-h.png" class="imgWhite" alt="">
									
								Defaulters List  </b></a></td>
							</tr>
							<%
								}
								if (grpRights.charAt(22) == '1') {
							%>
							<tr>
								<td class="menubackflow">	<a
									href="javascript:callFunction1('mastersearchper.jsp')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/customer-profile.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/customer-profile-h.png" class="imgWhite" alt="">
								
								Customer Profile  </b></a></td>
							</tr>
							<%
								}
								if (grpRights.charAt(23) == '1') {
							%>
							<tr>
								<td class="menubackflow">	<a
									href="javascript:callFunction1('securitiesSearch.jsp')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/securities.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/securities-h.png" class="imgWhite" alt="">
								
								Securities  </b></a></td>
							</tr>
							<%
								}
								if (grpRights.charAt(23) == '1') {
									%>
									<tr>
										<td class="menubackflow"><a
											href="javascript:txtLoad('Permission');callFunction('com_permission.jsp','PERM')"><b>
											<img src="<%=ApplicationParams.getAppUrl()%>img/home/permission.png" class="imgPurple" alt="">
							                <img src="<%=ApplicationParams.getAppUrl()%>img/home/permission-h.png" class="imgWhite" alt="">
											
										Permission <%if((Integer.parseInt(Helper.correctInt((String)hshValues.get("strMBSentQuery")))+Integer.parseInt(Helper.correctInt((String)hshValues.get("strMBRepliedQuery"))))>0){ %>(<%=Integer.parseInt(Helper.correctInt((String)hshValues.get("strMBSentQuery"))) + Integer.parseInt(Helper.correctInt((String)hshValues.get("strMBRepliedQuery"))) %>)<%} %></b></a> </td>
									</tr>
									<%
										}
								if (grpRights.charAt(4)=='1' || grpRights.charAt(5)=='1'
									|| grpRights.charAt(6)=='1' || grpRights.charAt(7)=='1'
									|| grpRights.charAt(8)=='1' || grpRights.charAt(10)=='1' 
									|| grpRights.charAt(11)=='1' || grpRights.charAt(12)=='1' 
									|| grpRights.charAt(19)=='1' || grpRights.charAt(20)=='1' || grpRights.charAt(21)=='1'
									|| grpRights.charAt(24)=='1' || grpRights.charAt(25)=='1'
								) {
							%>
							<tr>
								<td class="menubackflow"><a
									href="javascript:txtLoad('Loan Application Register');callFunction1('appinwardno_search.jsp')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/loan-application-register.png" class="imgPurple" alt="">
							                <img src="<%=ApplicationParams.getAppUrl()%>img/home/loan-application-register-h.png" class="imgWhite" alt="">
									
								Loan Application Register  </b></a></td>
							</tr>
							<%if(Integer.parseInt(Helper.correctInt(strClassrights))>=50){ %>
							<tr>
								<td class="menubackflow"><a
									href="javascript:txtLoad('Bureau Link');callFunction1('Bureau_link_Search.jsp')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/bureau-link.png" class="imgPurple" alt="">
							                <img src="<%=ApplicationParams.getAppUrl()%>img/home/bureau-link-h.png" class="imgWhite" alt="">
									
								  Bureau Link </b></a></td>
							</tr>
		
							<%
							}}if (grpRights.charAt(24)=='1' || grpRights.charAt(25)=='1') {
							%>
							<tr>
								<td class="menubackflow"><a
									href="javascript:txtLoad('Loan Against Gold Ornaments & Deposits');callFunction('retailpge.jsp','LAD')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/loan-against-gold.png" class="imgPurple" alt="">
							                <img src="<%=ApplicationParams.getAppUrl()%>img/home/loan-against-gold-h.png" class="imgWhite" alt="">
									Loan
								Against Gold Ornaments &amp; Deposits<%if(Integer.parseInt(Helper.correctInt((String)hshValues.get("strMBSentQuery_LAD")))>0){%>(<%= Helper.correctInt((String)hshValues.get("strMBSentQuery_LAD"))%>)<%} %></b></a> </td>
							</tr>
							<%
								}
								if (grpRights.charAt(4) == '1' || grpRights.charAt(5) == '1'
										|| grpRights.charAt(6) == '1') {
							%>
							<tr>
								<td class="menubackflow"><a
									href="javascript:txtLoad('Retail');callFunction('retailpge.jsp','RET')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/retail-(Includin-shematic).png" class="imgPurple" alt="">
							                <img src="<%=ApplicationParams.getAppUrl()%>img/home/retail-(Includin-shematic)-h.png" class="imgWhite" alt="">
									
								Retail (including schematic) <%if(Integer.parseInt(Helper.correctInt((String)hshValues.get("strMBSentQuery_RET")))>0){%>(<%= Helper.correctInt((String)hshValues.get("strMBSentQuery_RET"))%>)<%} %> </b></a></td>
							</tr>
							<%
								}
								if (grpRights.charAt(19) == '1' || grpRights.charAt(20) == '1'
										|| grpRights.charAt(21) == '1') {
							%>
							<tr>
								<td class="menubackflow"><a
									href="javascript:txtLoad('Agriculture');callFunction('corppge.jsp','AGR')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/agriculture.png" class="imgPurple" alt="">
							                <img src="<%=ApplicationParams.getAppUrl()%>img/home/agriculture-h.png" class="imgWhite" alt="">
									
								Agriculture <%if(Integer.parseInt(Helper.correctInt((String)hshValues.get("strMBSentQuery_AGR")))>0){%>(<%= Helper.correctInt((String)hshValues.get("strMBSentQuery_AGR"))%>)<%} %></b></a> </td>
							</tr>
							<%
								}
							%>
							<!-- Hided by prakash since Tertiary sector is not required for KBL
							
							 <%
								if (grpRights.charAt(7) == '1' || grpRights.charAt(8) == '1') {
							%>
							<tr>
								<td class="menubackflow"><b> <a
									href="javascript:txtLoad('Tertiary');callFunction('agrpage.jsp','OPS')">Tertiary
								Sector</a> </b></td>
							</tr>
							<%
								}
							%>-->
							<%
								if (grpRights.charAt(10) == '1' || grpRights.charAt(11) == '1'
										|| grpRights.charAt(12) == '1') {
							%>
							<tr>
								<td class="menubackflow"><a
									href="javascript:txtLoad('Corporate & SME');callFunction('corppge.jsp','CORP')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/corporate-SME.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/corporate-SME-h.png" class="imgWhite" alt="">
									
								Corporate &amp; SME <%if(Integer.parseInt(Helper.correctInt((String)hshValues.get("strMBSentQuery_CORP")))>0){%>(<%= Helper.correctInt((String)hshValues.get("strMBSentQuery_CORP"))%>)<%} %></b></a> </td>
							</tr>
							<%
								}
							%>
							<!--	<tr>
								<td class="menubackflow"><b> <a
									href="javascript:txtLoad('Excel Upload');callFunction('agr_excelupload.jsp')"
									>Excel Upload</a> </b></td>
							</tr>-->
						</table>
						</td>
						<td valign="top" width="25%" >
							<table width="98%" border="0" cellspacing="3" cellpadding="5"
								class="outertable" align="center">
								<tr>
								   <td class="menubackflow"><a
									href="javascript:txtLoad('Add k- power Details');navigateAddkpower()"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/add-k-power-details.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/add-k-power-details-h.png" class="imgWhite" alt="">
									
									Add K-Power Details</b></a></td>
								  </tr>
								<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('Solvency');navigateSolvency()"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/solvency-certificate.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/solvency-certificate-h.png" class="imgWhite" alt="">
										
									Solvency Certificate </b></a></td>
									
									</tr>
									
			<!--					
								<%
									if (grpRights.charAt(14) == '1') {
								%>
								<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('Monitoring Register');callFunctionMon('mon_borrowersearch.jsp','MONIT')">
									<b>Monitoring Register</b></a></td>
								</tr>
								<%
									}
								%>
								<%
									if (grpRights.charAt(15) == '1') {
								%>
								<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('Monthly Monitoring Report');callFunctionMon('mon_borrowersearch.jsp','MONTHMONIT')">
									<b>Monthly Monitoring Report</b></a></td>
								</tr>
								<%
									}
								%>
								<%
									if (grpRights.charAt(9) == '1') {
								%>
								<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('Term Loan Review');callFunctionMon('mon_borrowersearch.jsp','MONITREVIEW')">
									<b>Term Loan - Review</b></a></td>
								</tr>
								<%
									}
								%>
								<%
									if (grpRights.charAt(13) == '1') {
								%>
								<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('Post / Followup Inspection');callFunctionMon('mon_borrowersearch.jsp','POSTINSPEC')">
									<b>Post / Followup Inspection</b></a></td>
								</tr>
								<%
									}
								%>
								Hided by prakash since for the first phase this is not required
								<tr>
									<td class="menubackflow"><A
										HREF="javascript:txtLoad('Monitoring Alerts');callMail('Mon','alerts')"
										onMouseOut="window.status='';return true;"
										onMouseOver="window.status='Monitoring Alerts';return true;"
										onmousedown="window.status='';return true;"><b>Monitoring
									Alerts </b></A></td>
								</tr>  -->
								<%
									if (grpRights.charAt(16) == '1') {
								%>
								<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('NPA');callFunction1('npa_mainlinknav.jsp')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/NPA.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/NPA-h.png" class="imgWhite" alt="">
										
									NPA </b></a></td>
								</tr>
								<%
									}
								%>
						 
								<%
									if (grpRights.charAt(17) == '1') {
								%>
								<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('Reports');callFunction1('repnav.jsp')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/reports.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/reports-h.png" class="imgWhite" alt="">
										Report
									</b></a></td>
								</tr>
								<%
									}
								%>
									<tr>
									<td class="menubackflow">	<a
										href="javascript:txtLoad('Financial/ Rating');callFunction1('financialsrch.jsp')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/financial-rating.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/financial-rating-h.png" class="imgWhite" alt="">
									Financial/ Rating
									</b></a></td>
								</tr>
								<%if (strClassrights.equalsIgnoreCase("050")||strClassrights.equalsIgnoreCase("50")||strClassrights.equalsIgnoreCase("075")||strClassrights.equalsIgnoreCase("085")||strClassrights.equalsIgnoreCase("75")||strClassrights.equalsIgnoreCase("85")||strClassrights.equalsIgnoreCase("125")||strClassrights.equalsIgnoreCase("130")||strClassrights.equalsIgnoreCase("135")||strClassrights.equalsIgnoreCase("180")||strClassrights.equalsIgnoreCase("190")||strClassrights.equalsIgnoreCase("200")){ %>
											   <tr>
							<td class="menubackflow">	<a
								href="javascript:gotoTabpage(appURL,'setapplicationtransfer.jsp?strLinkFrom=Home')"><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/application-transfer.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/application-transfer-h.png" class="imgWhite" alt="">
							 Application Transfer
									</b></a></td>
																	</tr>
								<%} %>
							<%if(strFVC.equalsIgnoreCase("Y")){ %>	
							<TR>
							<TD class="menubackflow"><A HREF="javascript:txtLoad('Fair Value Calculation');callFunction1('set_fairvaluecalc.jsp')"></A><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/fair-value-calculation.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/fair-value-calculation-h.png" class="imgWhite" alt="">
								Fair Value Calculation</b></A></TD> 
							</TR>
							<%} %>
							<%if(strClassrights.equalsIgnoreCase("10")){ %>
							<TR>
							<TD class="menubackflow" nowrap="nowrap"><A HREF="javascript:txtLoad('Customer Group Management');callFunction1('cusgrp_managementnav.jsp')"></A><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/customer-group-management.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/customer-group-management-h.png" class="imgWhite" alt="">
								Customer Group Management</b></A></TD> 
							</TR>
							<%}if(strUserDesignation.equalsIgnoreCase("009")|| strUserDesignation.equalsIgnoreCase("047")){ %>
							<TR>
							<TD class="menubackflow" nowrap="nowrap"><A HREF="javascript:txtLoad('AFO Probationary');gotoTab(appURL,'staticdata','getAFOClusterBranchSelection','afosetbranch.jsp')"></A><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/AFO-branch-selection.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/AFO-branch-selection-h.png" class="imgWhite" alt="">
								AFO Branch Selection</b></A></TD> 
							</TR>
							<%} %>
							<%
								if (grpRights.charAt(0) == '1' || grpRights.charAt(1) == '1') {
							%>
							<TR>
							<TD class="menubackflow" nowrap="nowrap"><A HREF="javascript:txtLoad('Closure of Facilities');callFunction('mastersearchper.jsp','COF')"><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/closure-of-facilities.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/closure-of-facilities-h.png" class="imgWhite" alt="">
								Closure of Facilities</b></A></TD> 
							</TR>
			
							<%}if(strNPA.equalsIgnoreCase("Y")){ %>
							<TR>
							<TD class="menubackflow" nowrap="nowrap"><A HREF="javascript:txtLoad('NPA - Account Details');callFunction('npa_mainlinknav.jsp','NPAPROV')"><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/NPA-account-details.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/NPA-account-details-h.png" class="imgWhite" alt="">
								NPA - Account Details</b></A></TD> 
							</TR>
							<%} %>
							<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('MSME');callMSMEPROP('msme_borrowersearch.jsp')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/MSME-Reclassification.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/MSME-Reclassification-h.png" class="imgWhite" alt="">
										MSME Reclassification </b></a></td>
								</tr>
							<TR>
							<TD class="menubackflow" nowrap="nowrap"><A HREF="javascript:txtLoad('SAC');callFunction1('setsacuser.jsp')"><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/SAC.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/SAC-h.png" class="imgWhite" alt="">
								SAC</b></A></TD> 
							</TR>
							<tr>
							<td class="menubackflow"><a href="javascript:txtLoad('Banker');navigateBankers()"><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/bankers-certificate.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/bankers-certificate-h.png" class="imgWhite" alt="">
								Banker's Certificate </b></a></td>
						   </tr>
						   <%if(inwadroutwardorg.equalsIgnoreCase("001000000000000")){ %>
						   <tr>
							<td class="menubackflow"><a href="javascript:txtLoad('Proposal Dashboard');callNationalPortal('inwardoutward.jsp')"><b>
								<img src="<%=ApplicationParams.getAppUrl()%>img/home/reports.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/reports-h.png" class="imgWhite" alt="">
								Proposal Dashboard
</b></a></td>
						   </tr>
						   <%} %>
							</table>
							</td>
							<td valign="top" width="25%">
								<table width="98%" border="0" cellspacing="3" cellpadding="5"
								class="outertable" align="center">
								<%
									if ( grpRights.charAt(5)=='1' || grpRights.charAt(6)=='1' 
										|| grpRights.charAt(8)=='1' || grpRights.charAt(11)=='1' 
										|| grpRights.charAt(12)=='1' || grpRights.charAt(20)=='1' 
										|| grpRights.charAt(21)=='1' || grpRights.charAt(24)=='1'
										|| grpRights.charAt(25)=='1'){
								%>
								<tr>
									<td colspan="2" class="menubackflow">	<a
										HREF="javascript:callMail('','')"
										onMouseOut="window.status='';return true;"
										onMouseOver="window.status='Retail MailBox';return true;"> <b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/loan-orgination-mailbox.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/loan-orgination-mailbox-h.png" class="imgWhite" alt="">
									Loan
									Origination MailBox</b></a></td>
								</tr>
								<%} %>
								<%
									if ( grpRights.charAt(15)=='1' || grpRights.charAt(16)=='1' 
										|| grpRights.charAt(13)=='1' || grpRights.charAt(9)=='1') {
								%>
								<tr>
								
									<td colspan="2" class="menubackflow"><a
										HREF="javascript:callMail('Mon','')"
										onMouseOut="window.status='';return true;"
										onMouseOver="window.status='Retail MailBox';return true;"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/loan-monitoring-mailbox.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/loan-monitoring-mailbox-h.png" class="imgWhite" alt="">
										 Loan
									Monitoring Mail Box</b></a></td>
								</tr>
								<%} %>
								<!-- Hided by prakash since this requirement is not required 
								<%
									if (strOrgLevel.equals("A")) {
								%>
								<tr>
									<td colspan="2" class="menubackflow"><A
										HREF="javascript:callMail('S','saral')"
										onMouseOut="window.status='';return true;"
										onMouseOver="window.status='Saral MailBox';return true;"> <b>Branch
									Activity for Saral</b></A></td>
								</tr>
								<%
									} else if (strOrgLevel.equals("D") && strIsSaral.equals("Y")) {
								%>
								<tr>
									<td colspan="2" class="menubackflow"><A
										HREF="javascript:callMail('S','saral')"
										onMouseOut="window.status='';return true;"
										onMouseOver="window.status='Saral MailBox';return true;"> <b>Saral
									Activity</b></A></td>
								</tr>
								<%
									}
								%>
								<tr>
									<td colspan="2" class="menubackflow"><A
										HREF="javascript:callOnline()"
										onMouseOut="window.status='';return true;"
										onMouseOver="window.status='Online MailBox';return true;"> <b>Online Inbox </b></A></td>
								</tr>-->
								<!-- <tr>
									<td class="menubackflow"><b> <a
										href="javascript:txtLoad('Retail');callFunction('setFinDocNonTradeable.jsp','RET')">
									Financial Documents - Non Tradeable </a> </b></td>
								</tr>
								<tr>
									<td class="menubackflow"><b> <a
										href="javascript:txtLoad('Retail');callFunction('setFinDocTradeable.jsp','RET')">
									Financial Documents - Tradeable </a> </b></td>
								</tr>
								<tr>
									<td class="menubackflow"><b> <a
										href="javascript:txtLoad('Retail');callFunction('securitiesVehicle.jsp','RET')">Securitites - Vehicles</a> </b></td>
								</tr>
								<tr>
									<td class="menubackflow"><b><a
										href="javascript:txtLoad('Retail');callFunction('securitiesBankDeposits.jsp','RET')">Securitites - Bank Deposits </a></b></td>
								</tr> -->
								<%-- 
								<tr>
									<td colspan="2" class="menubackflow"><a
										href="javascript:callonline()"><b>
											<img src="<%=ApplicationParams.getAppUrl()%>img/home/access-to-internet-module.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/access-to-internet-module-h.png" class="imgWhite" alt="">
											Access to Internet Module</b></a></td>
								</tr>--%><%if(grpRights.length()>27){
								if (grpRights.charAt(27) == '1'){ %>
								<tr>
									<td class="menubackflow"><a
										href="javascript:callOnline()"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/online-application.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/online-application-h.png" class="imgWhite" alt="">
										
									Online Applications - Login </b></a></td>
								</tr>
								
								<%}}if(strNSDL.equalsIgnoreCase("Y")){ %>
								<tr>
									<td class="menubackflow"><a
										href="javascript:txtLoad('NSDL Application Management');callFunction('nsdlnavigation.jsp')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/NSDL-application.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/NSDL-application-h.png" class="imgWhite" alt="">
										NSDL Application Management
									</b></a></td>
								</tr>
								<%} %>
								<%if(grpRights.charAt(28) == '1'){ %>
								<TR>
								<td class="menubackflow"><a
									href="javascript:txtLoad('NSDL Application Inbox');callNSDLReceive('NsdlRecvapplication.jsp')"><b>
									<img src="<%=ApplicationParams.getAppUrl()%>img/home/NSDL-Application-mailbox.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/NSDL-Application-mailbox-h.png" class="imgWhite" alt="">
									NSDL Application MailBox
									</b></a></td>
								</TR>
								<%} %>
								
								<tr>
									<td class="menubackflow">	<a
										href="javascript:callKalypto()"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/kalypto-login-page.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/kalypto-login-page-h.png" class="imgWhite" alt="">
									
									Kalypto Login Page </b></a></td>
								</tr>
								<tr>
									<td class="menubackflow"><a
										href="javascript:callDMS()"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/DMS-login-page.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/DMS-login-page-h.png" class="imgWhite" alt="">
										
									DMS Login Page </b></a></td>
								</tr>
								<tr>
									<td class="menubackflow"><a
										href="javascript:callDigiloan()"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/DIGI-login-page.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/DIGI-login-page-h.png" class="imgWhite" alt="">
										
									DIGI Login Page </b></a></td>
								</tr>
									<tr>
									<td class="menubackflow"><a
										href="javascript:callTMS()"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/internal-ticketting.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/internal-ticketting-h.png" class="imgWhite" alt="">
										
									Internal Ticketing System e-TMS  </b></a></td>
								</tr>
								<%if(grpRights.charAt(30) == '1'){ %>
								<tr>
									<td class="menubackflow">	<a
										href="javascript:callMail('Branch_MB','')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/branch-mailbox.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/branch-mailbox-h.png" class="imgWhite" alt="">
									
									Branch MailBox </b></a></td>
								</tr>
								<%} %>
									<tr>
								
									<td class="menubackflow"><a
								
										href="javascript:callMonitoring()"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/monitoring.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/monitoring-h.png" class="imgWhite" alt="">
										
								
									Monitoring </b></a></td>
								
								</tr>
								
								<!--	<tr>
									<td class="menubackflow"><b> <a
										href="javascript:callSmsTrigger('smstrigger.jsp')">
									SMS Trigger</a> </b></td>
								</tr>-->
								
								<!--					<tr>	-->
								<!--						<td class="menubackflow"><b> <a-->
								<!--							href="javascript:callChat()">Chat Corner</a> </b></td>-->
								<!--					</tr>-->
								
								
									<tr>
									<td class="menubackflow"><a
										href="javascript:callECSCheck('ecscheck.jsp')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/E-NACH.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/E-NACH-h.png" class="imgWhite" alt="">
										
									E-NACH </b></a></td>
								</tr>
								
								<tr>
									<td class="menubackflow"><a
										href="javascript:callNationalPortal('NP_Mailbox.jsp')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/E-NACH.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/E-NACH-h.png" class="imgWhite" alt="">
										
									National Portal </b></a></td>
								</tr>
								<%if(strRRM.equalsIgnoreCase("Y")){ %>
								<tr>
									<td class="menubackflow"><a
										href="javascript:mclrMaster('setMCLRMaster.jsp')"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/E-NACH.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/E-NACH-h.png" class="imgWhite" alt="">
										
									Reference Rate Master</b></a></td>
								</tr>
								<%} %>
								<%if(strSHG.equalsIgnoreCase("Y")){ %>
								<tr>
									<td class="menubackflow"><a href="javascript:viewSelectedDocument();"><b>
										<img src="<%=ApplicationParams.getAppUrl()%>img/home/financial-rating.png" class="imgPurple" alt="">
							        <img src="<%=ApplicationParams.getAppUrl()%>img/home/financial-rating.png" class="imgWhite" alt="">
										
									SHG Bulk Excel Upload</b></a></td>
								</tr>
								<%} %>
								</table>
							</td>



				</tr>
			</table>
		</div>

		<div class="lastnav">
			<table width="23%" border="0" cellspacing="0" cellpadding="0"
						class="notify-last" align="center">
						<tr>
							<!-- <th width="20%"><span><img src="/laps/img/home/notification.png"></span></th> -->
							
							<th align="center"> 
							<span class="notifyHeader"><img src="/laps/img/home/notification.png">
							<h3>Notification</h3>
						</span>
						</th>
					
						</tr>
						<tr>
							<td width="100%"><marquee direction="up" scrollamount="2"
								onmouseover="this.setAttribute('scrollamount', 0, 0);"
								onmouseout="this.setAttribute('scrollamount', 3, 0);" style="padding:5px;min-height:373px">
							<%
								ArrayList vecVal2 = (ArrayList) hshValues.get("vecData2");
							ArrayList val2 = new ArrayList();
								if (vecVal2 != null) {
									for (int i = 0; i < vecVal2.size(); i++) {
										val2 = (ArrayList) vecVal2.get(i);
							%>  <p class="mar-value"><%=Helper.formatTextAreaData((String) val2.get(1))%></p>
							
							 <%
		 }
		 }
		%> </marquee></td>
						</tr>
					</table>
					</div>


	</div> 




<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table> -->

<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
</table> -->
<!-- <br>
<table border="0" width="80%" align="center" cellpadding="4"
	align="center">

	<tr>
		<td valign="bottom">
		<table border="1" width="80%" bordercolor="#0000FF"
			bordercolorlight="#FF0000" cellpadding="4" align="center"
			class="outertable">z
			<tr>
				<td width="50%" align="center"><a href="javascript:callRAM()"><b>I
				R B</b></a></td>
				<td width="50%" align="center"><b><a href="javascript:callRAMF()">I
				R B - F</a>&nbsp;&nbsp;FOR BM (case for Corporate SME &amp; Tertiary)</b></td>
			</tr>

		</table>
		</td>
	</tr>

</table> -->
<lapschoice:hiddentag /> <input type="hidden" name="hidPage"> <input
	type="hidden" name="hidusr_id" value="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>"> <input type="hidden"
	name="workflow"> <input type="hidden" name="hidmontype" /> <input
	type="hidden" name="hidCategoryType" />
	<iframe name="ifrm" width="0" height="0" border="0"></iframe>
	</form>
</BODY>
</HTML>


