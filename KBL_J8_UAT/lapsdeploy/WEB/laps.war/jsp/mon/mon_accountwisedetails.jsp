<%@include file="../share/directives.jsp"%>
<%request.setAttribute("_cache_refresh", "true");

			%>
<%String stryear = Helper.correctNull((String) request
					.getParameter("mon_year"));
			if (!stryear.equalsIgnoreCase("")) {
				stryear = Helper
						.correctNull((String) hshValues.get("mon_year"));
			}
			String strmonth = Helper.correctNull((String) request
					.getParameter("mon_month"));

			if (!strmonth.equalsIgnoreCase("")) {
				strmonth = Helper.correctNull((String) hshValues
						.get("mon_month"));
			}
			String strmonaccno = Helper.correctNull((String) hshValues
					.get("mon_accno"));

			if (strmonaccno.equalsIgnoreCase("")) {
				strmonaccno = Helper.correctNull((String) hshValues
						.get("mon_accwiseaccountno"));
			}
			String strmsod = Helper.correctNull((String) hshValues
					.get("mon_checkmsod"));
			String strstock = Helper.correctNull((String) hshValues
					.get("mon_checkstock"));
			String strbkdebts = Helper.correctNull((String) hshValues
					.get("mon_checkbkdebts"));
			String strqpr = Helper.correctNull((String) hshValues
					.get("mon_checkqpr"));
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">

<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="Javascript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="Javascript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var msod = "<%=strmsod%>";
var bookdebts = "<%=strbkdebts%>";
var stockassume = "<%=strstock%>";
var strqpr	=	"<%=strqpr%>";
var isTakeover="<%//=Helper.correctNull((String)hshValues.get("istakeover"))%>";   
var option = "<%=strmonaccno%>";	
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var flagapply="<%=Helper.correctNull((String)hshValues.get("flagapply"))%>";
function enableButtons(bool1,bool2,bool3,bool4)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	
	
}
function callLink(page,bean,method)
{
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
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
function call_page(url,method)
{
	if(document.forms[0].cmdsave.disabled == true)
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].method="post";

		if(url=="mon_msodestimates.jsp")
		{
			document.forms[0].hidBeanId.value="mmrcommon";
		}
		else if(url=="mon_workingcapitalfunds.jsp")
		{
			document.forms[0].hidBeanId.value="mmrcommon";
		}
		else if(url=="mon_accountwisedetails.jsp")
		{
			document.forms[0].hidBeanId.value="mmrcommon";
		}
	
		else
		{
			document.forms[0].hidBeanId.value="mmrcommon";
		}
		document.forms[0].action=appUrl+"action/"+url;
		document.forms[0].submit();
	}
	else
	{
		 ShowAlert('103');
	}
	
}
 
function disableFields(val)
{
	
	if(strqpr != "" && strqpr.toLowerCase() == "y")
	{
		document.forms[0].txt_qprdate.readOnly = val;
 		document.forms[0].txt_nextqprdue.readOnly = val;
 	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidBeanGetMethod.value="getAccountwise";
	document.forms[0].action=appUrl+"action/mon_accountwisedetails.jsp";
	document.forms[0].submit();
	}
}
function doEdit()
{
	enableButtons(true,false,false,true,false);
	disableFields(false);
	
}

function doSave()
{
	
	
	if(strqpr != "" && strqpr.toLowerCase() == "y")
	{
		if(trim(document.forms[0].txt_qprdate.value) == "")
		{
			alert("Enter Date for QPR Receipt date ");
 			document.forms[0].txt_qprdate.focus();
 			return;
 		}
 		if(trim(document.forms[0].txt_nextqprdue.value) == "")
		{
			alert("Enter Date for Next QPR due date ");
 			document.forms[0].txt_nextqprdue.focus();
 			return;
 		}
 		
	}
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidBeanGetMethod.value="updateAccountwise";
	document.forms[0].hidSourceUrl.value="/action/mon_accountwisedetails.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}


function callOnload()
{
			if(document.forms[0].statusflag.value!="C")
			{	
				if( flagapply != "" && flagapply == 1 && option != "")
				{
					document.forms[0].sel_accno.value=option;
					enableButtons(false,true,true,false)	
					disableFields(true);
				}
				else if(flagapply != "" && flagapply == 0 && option != "")
				{
					
					if( strqpr != "" && strqpr.toLowerCase() == "y" && trim(document.forms[0].txt_qprdate.value) == "" && trim(document.forms[0].txt_nextqprdue.value) == "")
					{
						document.forms[0].sel_accno.value=option;
						enableButtons(true,false,false,true);	
						disableFields(false);
					}
									
					
					else
					{
						document.forms[0].sel_accno.value=option;
						enableButtons(false,true,true,false)
						disableFields(true);
					}
				}
				else if(flagapply != "" && flagapply == 0 && option == 0)
				{
					document.forms[0].sel_accno.value=0;
					enableButtons(false,true,true,false)
					disableFields(true);
				}
			}
			else
			{
			 if(flagapply != "" && flagapply == 0 && option == 0)
				{
					document.forms[0].sel_accno.value=0;
					enableButtons(false,true,true,false)
					disableFields(true);
				}
				else
				{
					document.forms[0].sel_accno.value=option;
					enableButtons(true,true,true,false)
					disableFields(false);
				}
			}
				
} 
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}
function getData()
{
	var	sel_value	=	document.forms[0].sel_accno.value;
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].mon_accno.value=sel_value;
	document.forms[0].hidBeanGetMethod.value="getAccountwise";
	document.forms[0].hidSourceUrl.value="/action/mon_accountwisedetails.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
</script>
</head>
<body onload="callOnload()">
<form name="frmpri" method=post class="normal">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
			<tr>
				<td><lapschoice:monthlymonitortag pageid="5" /></td>
			</tr>
			<tr>
				<td class="page_flow">Home -&gt; Monitoring-&gt; Monthly Monitoring -&gt;Accountwise Details</td>
			</tr>
		</table><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			 class="outertable">
			<tr>
				<td><lapschoice:MonthlyMonitor /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>

		<td valign="bottom">
		<table width="60%" border="0" cellspacing="3" cellpadding="3"
			 class="outertable">
			<tr>
				<td width="15%" align="center"  id="prin" class="sub_tab_active"><b>
					Accountwise Details</b></td>
				<%if (Helper.correctNull((String) hshValues.get("mon_checkmsod"))
					.equalsIgnoreCase("y")) {%>
				<td width="20%" class="sub_tab_inactive" align="center" ><b>
					<a
					href="javascript:call_page('mon_msodestimates.jsp','getmsodestimate')"
					>MSOD</a></b></td>
				<%}
			if (Helper.correctNull((String) hshValues.get("mon_checkqpr"))
					.equalsIgnoreCase("y")) {%>
				<td width="20%" class="sub_tab_inactive" align="center" ><b>
					<a
					href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')"
					>QPR </a></b></td>
				<%}

			%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	class="shadow" align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="4" class="outertable">
					<Tr>
						<td>Select Account Number: <select name="sel_accno" tabindex="1"
							onchange="getData()">
							<option value="0" selected>--Select--</option>
							<lapschoice:GetMonAccountNumberTag />
						</select></td>
					</Tr>
					
					<%if (strqpr.equalsIgnoreCase("Y")) {%>
					<tr>
						<td>
						<table width="80%" cellspacing="0" cellpadding="0" border="0" class="outertable">
							<tr>
								<td width="20%">QPR Receipt date:</td>
								<td width="15%"><input type="text" name="txt_qprdate" size="16"
									value="<%=Helper.correctNull((String)hshValues.get("qprdate"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentDate)"></td>
								<td width="15%"><a href="#"
									onClick="callCalender('txt_qprdate')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0" tabindex=""></a></td>
								<td width="20%">Next QPR due date:</td>
								<td width="15%"><input type="text" name="txt_nextqprdue"
									size="16"
									value="<%=Helper.correctNull((String)hshValues.get("nextqprdue"))%>"
									onBlur="checkDate(this)"></td>
								<td width="15%"><a href="#"
									onClick="callCalender('txt_nextqprdue')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0" tabindex=""></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<%}%>
					<!-- end -->
				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
</table>
<br>

<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="mon_msod" value="<%=strmsod%>"> 
<input type="hidden" name="mon_stock" value="<%=strstock%>"> 
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>"> 
<input type="hidden" name="mon_checkqpr" value="<%=strqpr%>"> 
<input type="hidden" name="flagapply" value="<%=Helper.correctNull((String)hshValues.get("flagapply"))%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno"))%>">
</form>
</body>

</html>
