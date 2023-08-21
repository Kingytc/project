<%@include file="../share/directives.jsp"%>
<%String stramtin = "";
	if (strCategoryType.equalsIgnoreCase("OPS")) 
	{
		stramtin = "<b>in Lacs</b>";
	}
	  String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	%>
<html>
<head>
<title>Activities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varCategoryType = "<%=strCategoryType%>";

function Onloading()
{
	disablefields(true);
}

function disablefields(val)
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
}

function enablebuttons(editbool,savebool,canbool,delbool,closebool)
{
	document.forms[0].cmdedit.disabled=editbool;
	document.forms[0].cmdsave.disabled=savebool;
	document.forms[0].cmdcancel.disabled=canbool;
	document.forms[0].cmddelete.disabled=delbool;
	document.forms[0].cmdclose.disabled=closebool;
}

function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	disablefields(false);
	enablebuttons(true,false,false,false,true);
}

function doSave()
{
	if(trim(document.forms[0].txt_ason.value)=="")
	{
		ShowAlert('121', "Details As on"); 	
		document.forms[0].txt_ason.focus();
		return;	
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hid_categoryType.value = varCategoryType;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="compro"
	document.forms[0].hidBeanMethod.value="updateCapitalStructure";
	document.forms[0].hidBeanGetMethod.value="getCapitalStructure";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_capitalstructure.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getCapitalStructure";
		document.forms[0].action=appURL+"action/com_capitalstructure.jsp";
		document.forms[0].submit();
	 }
}

function doDelete()
{
	if(varRecordFlag=="Y")

{
	if(ConfirmMsg(101))
 	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateCapitalStructure";
		document.forms[0].hidBeanGetMethod.value="getCapitalStructure";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_capitalstructure.jsp";
		document.forms[0].submit();
	 }
}
else
{
	
	ShowAlert(158);
}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{ 
	if (document.forms[0].hideditflag.value=="N")
	{
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

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="Onloading()">
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
<form name="frmcapitalstructure" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<%if (strCategoryType.equalsIgnoreCase("OPS")) {%>
		<td class="page_flow">Home -&gt; Tertiary -&gt;	Application -&gt; Applicant &gt; Capital Structure</td>

		<%} else if (strCategoryType.equalsIgnoreCase("SRE")) {%>

		<td class="page_flow">Home -&gt; Corporate-&gt; Short Review
		Extension -&gt; Promoters -&gt; Capital Structure</td>
		<%} else if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Promoters -&gt; Capital Structure</td>
		<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Promoters -&gt; Capital Structure</td>
		<%} %>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%if (strCategoryType.equalsIgnoreCase("OPS")) {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_inactive"><b> 
						<a href="#" onclick="javascript:gotoTab(appURL,'facilities','getOPSFacilityData','ops_facilities.jsp')">Facilities</a>
						</b></td>
						<td class="sub_tab_inactive"><b>
						<a href="#" onclick="javascript:gotoTab(appURL,'comssiaboveten','getDataSubsidy','ops_subsidy.jsp')">Subsidy</a></b>
						</td>
						<td class="sub_tab_inactive"><b>
						<a href="#" onclick="javascript:gotoTab(appURL,'comssiaboveten','getAccountDetails','ops_accountdetails.jsp')">Account
						Details</a></b></td>
						<td class="sub_tab_active"><b>Capital Structure</b></td>
						<td class="sub_tab_inactive"><b>
						<a href="#" onclick="javascript:gotoTab(appURL,'ssidemographics','getOpsdemograph','ops_demographics.jsp')">Details
						of Promoter/Guarantor</a></b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%} else {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="2" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="sub_tab_active"><b>Capital Structure</b></td>
				<td class="sub_tab_inactive"><b><a href="javascript:callLink('compromoters.jsp','compro','getProData')">Promoters
				/ Directors</a></b></td>
				<%if (strCategoryType.equalsIgnoreCase("CORP") || strCategoryType.equalsIgnoreCase("SME")) {%>
				<td class="sub_tab_inactive"><b><b><a href="javascript:callLink('com_companybackground.jsp','compro','getCompanyBackground')">Promoter
				Company / Group Companies Background</a></b></b></td>
				<%}%>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Group
				Concerns</a></b></b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_shareholdpattern.jsp','executive','getDataShareHoldPattern')">Share Holding Pattern</a></b></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%}%>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>

		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>Details as on <span class="mantatory"><b>*</b></span></td>
				<td><input type="text" name="txt_ason"
					value="<%=Helper.correctNull((String) hshValues.get("detailsason"))%>"
					maxlength="10" size="12"
					onBlur="checkDate(this);checkmaxdate(this,currentdate);"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_ason')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Authorised Capital <%=stramtin%></td>
				<td><lapschoice:CurrencyTag name="txt_captial"
					value='<%=Helper.correctNull((String) hshValues.get("auth_capital"))%>'
					maxlength="8" size="12" /></td>
				<td>Issued/Subscribed Capital <%=stramtin%></td>
				<td><lapschoice:CurrencyTag name="txt_subcapital"
					value='<%=Helper.correctNull((String) hshValues.get("sub_capital"))%>'
					maxlength="8" size="12" /></td>
			</tr>
			<%if (strCategoryType.equalsIgnoreCase("OPS")) {%>
			<tr>
				<td>Paid Up Capital <%=stramtin%></td>
				<td><lapschoice:CurrencyTag name="comapp_totsharevalue"
					value='<%=Helper.correctNull((String) hshValues.get("paidshares"))%>'
					maxlength="15" size="18" /></td>
				<td>Reserve Capital <%=stramtin%></td>
				<td><lapschoice:CurrencyTag name="txt_reserve"
					value='<%=Helper.correctNull((String) hshValues.get("reservecapital"))%>'
					maxlength="8" size="12" /></td>
			</tr>
			<%} else {%>
			<tr>
				<td>Total no. of Paid-up Shares</td>
				<td><input type="text" name="comapp_totsharevalue" value='<%=Helper.correctNull((String) hshValues.get("paidshares"))%>'
					maxlength="15" size="18" onKeyPress="allowInteger()" /></td>
				<!-- <td><lapschoice:CurrencyTag name="comapp_totsharevalue"
					value='<%//=Helper.correctNull((String) hshValues.get("paidshares"))%>'
					maxlength="15" size="18" /></td> -->
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Book Value</td>
				<td><lapschoice:CurrencyTag name="book_value"
					value='<%=Helper.correctNull((String) hshValues.get("book_value"))%>'
					size="30" maxlength="18" /></td>
				<td>Market value</td>
				<td><lapschoice:CurrencyTag name="market_value"
					value='<%=Helper.correctNull((String) hshValues.get("market_value"))%>'
					size="30" maxlength="18" /></td>
			</tr>
			<%}%>
		</table>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="hid_categoryType" value="">
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>

</body>
</html>
