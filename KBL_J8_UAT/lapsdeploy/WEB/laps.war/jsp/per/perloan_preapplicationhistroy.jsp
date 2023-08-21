<%@include file="../share/directives.jsp"%>
<%
	String strhidPageType = Helper.correctNull((String) request
			.getParameter("hidPageType"));
String applicantoldid = Helper.correctNull((String) request
		.getParameter("applicantoldid"));
%>
<html>
<head>
<title>Retail- Loan History Of Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCategoryType="<%=Helper.correctNull((String) request.getParameter("hidCategoryType"))%>";
var varappname="<%=Helper.correctNull((String) request.getParameter("appname"))%>";
var appid="<%=Helper.correctNull((String) request.getParameter("hidapplicantoldid"))%>";
var appid1="<%=Helper.correctNull((String) request.getParameter("hidapplicantid"))%>";
var varapproveddAppDemoId="<%=Helper.correctNull((String) request.getParameter("varapproveddAppDemoId"))%>";

function doclose()
{
	 
	if(ConfirmMsg('100'))
	{
		document.forms[0].action="action/mainnav.jsp";
		document.forms[0].submit();
		
	}
}
function callApply()
{
	var txtSearch = document.forms[0].txtSearch.value;
	document.forms[0].method="post";
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	if(varCategoryType=="LAD")
	{
		document.forms[0].action = appURL + "action/ladloandetails.jsp?page1=nr&appno=new&compname="+varappname+"&hidCategoryType="+varCategoryType;
	}else{
		document.forms[0].action = appURL + "action/perloandetails.jsp?page1=nr&appno=new&compname="+varappname+"&hidCategoryType="+varCategoryType;
	}
	document.forms[0].method="post";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	

}
		
function callCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	document.forms[0].reset();
	document.forms[0].txtSearch.disabled = true;
	document.forms[0].cmdCancel.disabled = true;
	document.forms[0].cmdOK.disabled = true;	
	}
}
function callLoanApplied()
{
	_d=document.forms[0];
	_dall=document.all;

	if(varapproveddAppDemoId=="Y")
	{
		alert("Kindly click on modify in customer profile and update latest details before proceeding");
		return;
	}

	if(varCategoryType=="LAD")
	{
		if(_d.radLoan[0].checked)
		{
			document.forms[0].txtSearch.value="";
			document.forms[0].hidCBSAccno.value="";
			document.forms[0].txt_appinwardno.value="";
			_dall.applicationno.style.visibility="hidden";
			_dall.applicationno.style.position="absolute";
			_dall.idretail.style.visibility="hidden";
			_dall.idretail.style.position="absolute";
			callApply();		
		}
		else if(_d.radLoan[1].checked)
		{
			_dall.applicationno.style.visibility="visible";
			_dall.applicationno.style.position="relative";

			_dall.idretail.style.visibility="visible";
			_dall.idretail.style.position="relative";
		}
	}
	else
	{
		if(_d.radLoan[0].checked)
			{
				document.forms[0].txtSearch.value="";
				document.forms[0].hidCBSAccno.value="";
				document.forms[0].txt_appinwardno.value="";
				_dall.applicationno.style.visibility="hidden";
				_dall.applicationno.style.position="absolute";
				_dall.idretail.style.visibility="hidden";
				_dall.idretail.style.position="absolute";
				callApply();		
			}
		else if(_d.radLoan[3].checked)
		{
			_dall.applicationno.style.visibility="visible";
			_dall.applicationno.style.position="relative";
			_dall.idretail.style.visibility="hidden";
			_dall.idretail.style.position="absolute";
		}
		else if(_d.radLoan[1].checked || _d.radLoan[2].checked)
		{
			_dall.applicationno.style.visibility="visible";
			_dall.applicationno.style.position="relative";
			if(varCategoryType=="RET")
			{
				_dall.idretail.style.visibility="visible";
				_dall.idretail.style.position="relative";
			}
		}
	}
	document.forms[0].txtSearch.value="";
}

function callApplicationSearch(varTextControl,varTextControl2)
{			
		var varhidCategory="";
		if(document.forms[0].radLoan[0].checked)
		{
			varhidCategory="F";
		}
		else if(document.forms[0].radLoan[1].checked)
		{
			varhidCategory="R";
		}
		else if(document.forms[0].radLoan[2].checked)
		{
			varhidCategory="S";
		}
		else if(document.forms[0].radLoan[3].checked)
		{
			varhidCategory="P";
		}
		var varQryString = appURL+"action/applicationsearch.jsp?hidBeanId=perapplicant&hidBeanGetMethod=getApplicationSearchDetails"+"&hidcntrycontrol="+varTextControl+"&hidapplicantoldid="+appid+"&hidCategoryType="+varCategoryType+"&hidAppCategory="+varhidCategory+"&hidCBSAccno="+varTextControl2;
		var title = "ApplicationSearch";
		var prop = "scrollbars=no,width=750,height=500";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
		document.forms[0].cmdOK.disabled = false;
		document.forms[0].cmdCancel.disabled = false;
	
}
function callEntryForNewApplication(){
	var varPrdSelectFlag="";
	if(document.forms[0].cmdOK.disabled == false){
	document.forms[0].method="post";
	if(varCategoryType=="RET")
	{
		if(document.forms[0].radLoan[2].checked)
		{
			document.forms[0].hidAction.value="restructure";
		}
		else if(document.forms[0].radLoan[3].checked)
		{
			document.forms[0].hidAction.value="postsanction";
		}
		else if(document.forms[0].radLoan[1].checked)
		{
			document.forms[0].hidAction.value="renew";
			varPrdSelectFlag="Y";
		}
	}
	else
	{
		if(document.forms[0].radLoan[1].checked)
		{
			document.forms[0].hidAction.value="renew";
			varPrdSelectFlag="Y";
		}
	}
	document.forms[0].hidBeanId.value="perapplicant";
	//document.forms[0].hidBeanMethod.value="getRetailApplicationRenew";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	if(varCategoryType=="RET")
	{
		if(document.forms[0].radLoan[3].checked==false && document.forms[0].txt_appinwardno.value=="")
		{
		  	ShowAlert(111,'Inward No');
		  	document.forms[0].txt_appinwardno.focus();
		  	return;
		}
		if(document.forms[0].radLoan[3].checked)
		{
			document.forms[0].action = appURL + "action/com_postsanc_parameters.jsp?page1=nr&appno=new&compname="+varappname+"&hidCategoryType="+varCategoryType+"&hidDemoId="+appid+"&strPrdFlag="+varPrdSelectFlag;
		}
		else
		{
			document.forms[0].action = appURL + "action/perloandetails.jsp?page1=nr&appno=new&compname="+varappname+"&hidCategoryType="+varCategoryType+"&hidDemoId="+appid+"&strPrdFlag="+varPrdSelectFlag;
		}
	}else{

		if(document.forms[0].radLoan[1].checked==true && document.forms[0].txt_appinwardno.value=="")
		{
		  	ShowAlert(111,'Inward No');
		  	document.forms[0].txt_appinwardno.focus();
		  	return;
		}
		
		document.forms[0].action = appURL + "action/ladloandetails.jsp?page1=nr&appno=new&compname="+varappname+"&hidCategoryType="+varCategoryType+"&hidDemoId="+appid;
	}
	if(varCategoryType=="RET")
	{
		if((document.forms[0].radLoan[1].checked==true||document.forms[0].radLoan[2].checked==true) && document.forms[0].hidCBSAccno.value=="")
		{
			ShowAlert(111,'Existing Application No.');
			//document.forms[0].hidCBSAccno.focus();
			return;
		}
	}
	else
	{
		if((document.forms[0].radLoan[1].checked==true) && document.forms[0].hidCBSAccno.value=="")
		{
			ShowAlert(111,'Existing Application No.');
			//document.forms[0].hidCBSAccno.focus();
			return;
		}
	}
	document.forms[0].submit();
		
	}
}
function callInwardSearch()
{		
	var varproposaltype="p";
		var varcategory="p",cbsid="";
		cbsid=document.forms[0].hidCBSid.value;
		var varQryString = appURL+"action/searchAppinwradno.jsp?reqpagefrom=gate&hidBeanId=inwardRegister&hidBeanGetMethod=getInwardnoSearchList&Category="+varcategory+"&proposal="+varproposaltype+"&CBSid="+cbsid;
		var title = "Acknowledgement";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);

	
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colSpan=5><jsp:include page="../share/help.jsp"	flush="true"/>
				 <jsp:include page="../share/menus.jsp" flush="true"/>
				</td>
			</tr>
			<tr>
				<td class="page_flow">Home -&gt; Application(New)</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<form name="loanHistory" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	class="shadow" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="center" bordercolordark="#9EC0F5" bordercolorlight="#FFFFFF">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable"
					align="center">
					<tr>
					</tr>
					<tr>
						<td>
						<table width="100%" border="1" cellspacing="0" cellpadding="1"
							bordercolordark="#9EC0F5" bordercolorlight="#FFFFFF">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"
									align="center">
									<tr class="dataGridColor">

										<td width="30%" align="center"><b>Whether Proposal
										is ?</b></td>
										<td width="4%"><input type="radio" name="radLoan"
											value="F" style="border-style: none"
											onClick="callLoanApplied()"></td>
										<td width="18%"><b>Fresh</b></td>

										<td width="4%"><input type="radio" name="radLoan"
											value="R" style="border-style: none"
											onClick="callLoanApplied()"></td>
										<td width="16%"><b>Renew</b></td>
										<%if(!strCategoryType.equalsIgnoreCase("LAD")){ %>
										<td width="4%"><input type="radio" name="radLoan"
											value="S" style="border-style: none;"
											onClick="callLoanApplied()"></td>
										<td width="16%" nowrap><b>Restructuring / Rephasement</b></td>
										<td width="4%"><input type="radio" name="radLoan"
											value="P" style="border-style: none;"
											onClick="callLoanApplied()" ></td>
										<td width="16%" nowrap><b>Post Sanction</b></td>
										<%} %>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="applicationno"
						style="visibility: hidden; position: absolute;">
						<td width="50%">
						<table width="100%" border="1" cellspacing="0" cellpadding="1"
							bordercolordark="#9EC0F5" bordercolorlight="#FFFFFF">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr class="dataHeadColor">
										<td colspan="8">Search By</td>
									</tr>
									<tr class="dataGridColor">
										<td width="41%">Existing Proposal No.</td>
										<td colspan="4">
										<input type="hidden" name="hidCBSAccno">
										<input type="text" name="txtSearch"
											size="25" maxlength="20" tabindex="34"
											style="text-align: left" readOnly="readonly"
											value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permcountry"))%>"
											onKeyPress="">&nbsp;&nbsp;<a href="#"
											onClick="callApplicationSearch('txtSearch','hidCBSAccno')"
											style="cursor: hand" tabindex="8"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="21"></a></td>
									</tr>
									<tr class="dataGridColor" id="idretail" style="visibility: hidden; position: absolute;">
										<td width="41%">Select Inward No.</td>
										<td colspan="4"><input type="text" name="txt_appinwardno"
											size="25" maxlength="20" tabindex="34"
											style="text-align: left" readOnly="readonly"
											value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permcountry"))%>"
											onKeyPress="">&nbsp;&nbsp;<a href="#"
											onClick="callInwardSearch()"
											style="cursor: hand" tabindex="8"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" id="search"></a></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td align="right">
						<table border="1" cellspacing="0" cellpadding="0" align="center"
							bordercolordark="#9EC0F5" bordercolorlight="#FFFFFF">
							<tr>
								<td>
								<table border="0" cellspacing="0" cellpadding="1" align="center" class="outertable">
									<tr>
										<td><input type="button" name="cmdOK" class="buttonStyle"
											value="OK" disabled onClick="callEntryForNewApplication()"></td>
										<td><input type="button" name="cmdCancel"
											class="buttonStyle" value="Cancel" disabled
											onClick="callCancel()"></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr></tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table border="1" cellspacing="0" cellpadding="0" align="center"
	bordercolordark="#9EC0F5" bordercolorlight="#FFFFFF">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="1">
			<tr>
				<!--<td><input type="hidden" name="cmdHelp" value="Help"
					class="buttonHelp" onClick="doHelp('comnew.htm')"></td>
				-->
				<td><input type="button" name="cmdClose" value="Close"
					class="buttonClose" onClick="doclose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<input type="hidden" name="appnval"> <input type="hidden"
	name="hidsearch">
<input type="hidden" name="hidprinDtls"> <input type="hidden"
	name="hidcollDtls"> <input type="hidden" name="hidfinDtls">
<input type="hidden" name="hidapplicantid"
	value="<%=Helper.correctNull((String) request.getParameter("hidapplicantoldid")) %>">
<input type="hidden" name="hidPageType"
	value="<%=request.getParameter("hidPageType")%>"> <lapschoice:hiddentag
	pageid='<%=PageId%>' /> <input type="hidden" name="cattype"
	value="<%=strCategoryType%>"> <input type="hidden"
	name="ssitype" value="<%=strSSIType%>"> <INPUT TYPE="hidden"
	name="hidAppType"> <input type="hidden" name="radLoan1"
	value=""> <input type="hidden" name="orgscode"
	value="<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>">
<input type="hidden" name="orgcode"
	value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
<input type="hidden" name="orglevel"
	value="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>">
<input type="hidden" name="grouprights"
	value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights"))%>">
<input type="hidden" name="prdid1" value="">
<input type="hidden" name="hidappid"
	value="<%=Helper.correctNull((String) hshValues.get("applid")) %>">
	<input type="hidden" name="hidCBSid"
	value="<%=Helper.correctNull((String) request.getParameter("hidCBSID")) %>">
	<input type="hidden" name="txt_receivedRH">
	<input type="hidden" name="txt_receiptclpu">
</form>
</body>
</html>
