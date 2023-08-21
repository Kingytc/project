<%@include file="../share/directives.jsp"%>
<lapschoice:handleerror />
<%
	String[] strMonth={"04","05","06","07","08","09","10","11","12","01","02","03"};
	String strcurrmonth=Helper.getCurrentDateTime().substring(3,5);
	
	%>	

<html>
<head>
<title>Status Note Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script>

var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varcurrmonth="<%=strcurrmonth%>";
var varOrgLevel="<%=strOrgLevel%>";
var varClass = "<%=Helper.correctNull((String)request.getParameter("classid"))%>";

function resetme()
	{
		document.forms[0].reset();
		document.all.insframe.src=appUrl+'action/blank.jsp';
	}

function doSearch()
{
    var varmoduletype=document.forms[0].hidmoduletype.value;
    var varappid=document.forms[0].appid.value;
	var varapptype=document.forms[0].hidapptype.value;
	var varyear=document.forms[0].txt_year.value;
	var varquarter=document.forms[0].selquarter.value;
	
	if(varyear=="")
	{
		alert("Enter the Year");
		return;
	}
	else
	{
		document.all.insframe.src=appUrl+"action/npaiframeresult.jsp?&hidBeanId=npa&hidBeanGetMethod=getNPAapplicationno&hidapplicantid=<%=Helper.correctNull((String)request.getParameter("hidapplicantid"))%>&moduletype=<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>&apptype=<%=Helper.correctNull((String)request.getParameter("apptype"))%>&borrowername=<%=Helper.correctNull((String)request.getParameter("borrowername"))%>&year="+varyear+"&quarter="+varquarter+"&hidtype=EXI";
	}
}


function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
		
	}
}
function doNew()
{
	var varyear=document.forms[0].txt_year.value;
	var varquarter=document.forms[0].selquarter.value;
	var strToday="<%=(String)Helper.getCurrentDateTime()%>";
	var yy="";
	var canprepare="N";
	

	yy=strToday.substring(6,10);
	if(varClass == "001")
	{
		alert("You Cannot Create Report For Regular Type of Customer");
		return false;
	}
	if(varyear=="")
	{
		alert("Enter the Year");
		return;
	}
	else if(varquarter=="")
	{
		alert("Select the Quarter");
		return;
	}
	
	if(varquarter=="1")
	{
		if("<%=strMonth[3]%>"==varcurrmonth || "<%=strMonth[4]%>"==varcurrmonth || "<%=strMonth[5]%>"==varcurrmonth)
		{
			canprepare="Y";
		}
		else
		{
			alert("You cannot Prepare the Report for 1st Quater");
		}
	}
	else if(varquarter=="2")
	{
		if("<%=strMonth[6]%>"==varcurrmonth || "<%=strMonth[7]%>"==varcurrmonth || "<%=strMonth[8]%>"==varcurrmonth)
		{
			canprepare="Y";
		}
		else
		{
					alert("You cannot Prepare the Report for 2nd Quater");
		}
	}
	else if(varquarter=="3")
	{
		if("<%=strMonth[9]%>"==varcurrmonth || "<%=strMonth[10]%>"==varcurrmonth || "<%=strMonth[11]%>"==varcurrmonth)
		{
			canprepare="Y";
		}
		else
		{
					alert("You cannot Prepare the Report for 3rd Quater");
		}
	}
	else if(varquarter=="4")
	{
		if("<%=strMonth[0]%>"==varcurrmonth || "<%=strMonth[1]%>"==varcurrmonth || "<%=strMonth[2]%>"==varcurrmonth)
		{
			canprepare="Y";
		}
		else
		{
					alert("You cannot Prepare the Report for 4th Quater");
		}
	}
	if(canprepare=="Y")
	{
		document.all.insframe.src=appUrl+"action/npaiframeresult.jsp?&hidBeanId=npa&hidBeanGetMethod=getNPAapplicationno&hidapplicantid=<%=Helper.correctNull((String)request.getParameter("hidapplicantid"))%>&moduletype=<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>&apptype=<%=Helper.correctNull((String)request.getParameter("apptype"))%>&borrowername=<%=Helper.correctNull((String)request.getParameter("borrowername"))%>&year="+varyear+"&quarter="+varquarter+"&hidtype=NEW";
	}
}

function placevalues()
{
	if(document.forms[0].readFlag.value.toUpperCase()=='R' || "<%=strOrgLevel%>"!="A")
	{
		document.forms[0].cmd_new.disabled=true;
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" class="page_flow">Home -&gt;NPA</td>
	</tr>
</table>
<div align="center"><br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td>
										<table width="60%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
											<tr>
												<td width="10%" align="right"><b>Year</b></td>
												<td width="10%"><input type="text" name="txt_year" size="5"
													maxlength="4" onKeyPress="allowInteger()"
													onBlur="checkcurrentyear(this)">
												</td>
												<td width="10%" align="right"><b>Quarter</b></td>
												<td width="10%"><select name="selquarter">
													<option value="" selected>&lt;--Select --&gt;</option>
													<option value="1">Quarter- I</option>
													<option value="2">Quarter- II</option>
													<option value="3">Quarter- III</option>
													<option value="4">Quarter- IV</option>
												</select></td>
												<td width="10%"><input type="button" name="cmd_new"
													value="New" class="buttonStyle" onClick="doNew()"></td>
												<td width="10%"><input type="button" name="cmd_search"
													value="Search" class="buttonStyle" onClick="doSearch()"></td>
											</tr>
											<tr>
												<td colspan="6">
												<table width="60%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
													<tr class="dataheader">
														<td align="left" width="60%"><b>Application No.</b></td>
 														<td align="left" width="40%"><b>Quarter</b></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr align="center">
												<td colspan="6"><iframe width="60%" id="insframe"></iframe></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td>
		<table width="0%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr valign="top">
				<td><input type="button" name="cmdreset" value="Reset"
					class="buttonStyle" onClick="resetme()"></td>
				<td align="center"><input type="button" name="cmdClose"
					value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag  pageid='<%=PageId%>'/>
<br>
</div>
<input type="hidden" name="appid" value="<%=Helper.correctNull((String)request.getParameter("hidapplicantid"))%>">
<input type="hidden" name="hidborrowername" value="<%=Helper.correctNull((String)request.getParameter("borrowername"))%>">
<input type="hidden" name="hidmoduletype" value="<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>"> 
<input type="hidden" name="hidapptype" value="<%=Helper.correctNull((String)request.getParameter("apptype"))%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">

</form>
</body>
</html>
