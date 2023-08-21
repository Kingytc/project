<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@include file="../share/directives.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>NPA Reports Account Wise/Security Wise</title>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function onload()
{
	
}
</script>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onload();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
function doExcelReport()
{
	if(document.forms[0].txt_qenddate.value != "")
	{
		var FileName="NPAEXE_"+document.forms[0].txt_qenddate.value;
		var qryString=appURL+"action/"+FileName+".xls?hidBeanId=excelfunction&hidBeanGetMethod=doExportNPAProv_Accountwise&txt_qenddate="+document.forms[0].txt_qenddate.value;
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"NPAprovisioning",prop);
	}else
	{
		alert("Please Enter date First !!");
	}
}


function callCalender(name)
{
	showCal(appURL,name);
}
function allowalwysOldDate(obj,mindate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) >= Date.parse(mindt))
		{
			alert("Date always be less than " +mindate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}
</script></div>
</div>
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA Provisioning
				-&gt; NPA Reports - Account Wise/Security Wise</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%" class="outertable border1">
			<tr>
				<td valign="top">
				<table width="95%" border="0" cellspacing="0" cellpadding="5"
					class="outertable" align="center">
					<tr>
						<td align="center" colspan="2" class="dataheader"><b>
						NPA Reports - Account Wise/Security Wise</b></td>
					</tr>
					<tr>
						<td colspan="2">
						<table width="100%" align="center" cellpadding="5" cellspacing="2"
							class="outertable">
							<tr align="center">
								<td valign="top" ><b>Select Date</b>&nbsp;
								<input type="text" name="txt_qenddate"
									onblur="checkDate(this);allowalwysOldDate(this,currentDate);"
									value="<%=Helper.correctNull((String) hshValues
									.get("strQEndDate"))%>"
									size="10"> &nbsp;<a alt="Select date from calender"
									href="#" onClick="callCalender('txt_qenddate')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0" alt="Select date from calender"></a></td>
							</tr>
							<tr align="center">
								<td width="20%"><input
									type="button" onClick="doExcelReport()"
									value="Export the Excel report" class="buttonStyle"></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>

					</tr>

				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:combuttonnew btnnames='' btnenable='N' /> <lapschoice:hiddentag
	pageid='<%=PageId%>' /> <input type="hidden" name="hidCategoryType"
	value="<%=Helper.correctNull((String) request
							.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hid_rowcount" value="" /> 
</form>

</body>
</html>