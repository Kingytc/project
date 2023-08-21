<%@include file="../share/directives.jsp"%>
<%String strhidmontype = Helper.correctNull(request.getParameter("hidmontype"));%>
<html>
<head>
<title>Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var strhidmontype="<%=Helper.correctNull(request.getParameter("hidmontype"))%>";
var strhidprinttype="<%=Helper.correctNull(request.getParameter("hidprinttype"))%>";
var varClass = "<%=Helper.correctNull((String)request.getParameter("classid"))%>";

function callcheckyear()
{
	var  year=document.forms[0].txt_year.value;
 	if(year!="")
 	{
 		if(eval(year)<2008)
 		{
 			alert("Monitoring has started only from 2008");
 			document.forms[0].txt_year.value="";
 			document.forms[0].txt_year.focus();
 		}
 	}
}

function doReset()
	{
		document.forms[0].reset();
		document.all.insframe.src=appUrl+'action/blank.jsp';
	}

function doSearch()
{
	
    var cbsaccno=document.forms[0].cbsaccno.value;
	var cbsid=document.forms[0].cbsid.value;
	var varyear=document.forms[0].txt_year.value;
	var varmonth=document.forms[0].selmonth.value;
	var varname=document.forms[0].cbsname.value;
	if(varyear =="" && varmonth =="S")
	{
		alert("Select the month or Year");
		return;
	}
	else if(varyear =="" && varmonth !="S")
	{
		alert("Select Year");
		return;
	}
	else
	{
		
		document.all.insframe.src=appUrl+"action/moniframeresult.jsp?&hidBeanId=mmrcommon&hidBeanGetMethod=getMMRSearch&cbsid="+cbsid+"&cbsname="+varname+"&mon_year="+varyear
		+"&mon_month="+varmonth+"&strhidmontype="+strhidmontype+"&strhidprinttype="+strhidprinttype+"&cbsaccno="+cbsaccno+"&classid="+varClass;
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
		}
}
function doNew()
{
    var varcbsid=document.forms[0].cbsid.value;
	var varcbsaccno=document.forms[0].cbsaccno.value;
	var varyear=document.forms[0].txt_year.value;
	var varmonth=document.forms[0].selmonth.value;
	var cbsname=document.forms[0].cbsname.value;
	var EXI=document.forms[0].hidEXCheck.value;
	var solid=document.forms[0].solid.value;
	if(varClass != "001")
	{
		alert("Customer Type is Not Standard,Cannot Create MMR");
		return false;
	}
	if(varyear=="")
	{
		alert("Enter the Year");
	}
	else if(varmonth=="S")
	{
		alert("Select the month");
	}
	else
	{
		document.all.insframe.src=appUrl+"action/moniframeresult.jsp?&hidBeanId=mmrcommon&hidBeanGetMethod=getMonfacility&cbsid="+varcbsid+"&mon_year="+varyear+"&mon_month="+varmonth+"&mon_cbsname="+cbsname+"&hidEXCheck="+EXI+"&solid="+solid;
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td class="page_flow">Home -&gt;Monitoring -&gt; Monthly Monitoring Report</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
									<tr>
										<td>
										<table width="60%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
											<tr>
												<td width="10%" align="right"><b>Year</b><span class="mantatory">*&nbsp;</span></td>
												<td width="10%"><input type="text" name="txt_year" size="5"
													maxlength="4" onKeyPress="allowInteger()"
													onBlur="callcheckyear();"
													onChange="callcheckyear()"></td>
												<td width="10%" align="right"><b>Month</b><span class="mantatory">*&nbsp;</span></td>
												<td width="10%"><select name="selmonth">
													<option value="S" selected="selected">&lt;--Select --&gt;</option>
													<option value="1">Jan</option>
													<option value="2">Feb</option>
													<option value="3">Mar</option>
													<option value="4">Apr</option>
													<option value="5">May</option>
													<option value="6">Jun</option>
													<option value="7">Jul</option>
													<option value="8">Aug</option>
													<option value="9">Sep</option>
													<option value="10">Oct</option>
													<option value="11">Nov</option>
													<option value="12">Dec</option>
												</select></td>

												<%if (!strhidmontype.equalsIgnoreCase("MONTHMONITREPORT")) {%>
												<td width="10%"><input type="button" name="cmd_new"
													value="New" class="buttonStyle" onClick="doNew()"></td>
												<%}%>
												<td width="10%"><input type="button" name="cmd_search"
													value="Search" class="buttonStyle" onClick="doSearch()"></td>
											</tr>
											<tr>
												<td colspan="6">
												<table width="45%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
													<tr class="dataheader">
														<td width="100%" align="center"><b>Monitoring Held On</b></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr align="center">
												<td colspan="6"><iframe width="240" height="295" id="insframe"></iframe></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="solid" value="<%=Helper.correctNull((String)request.getParameter("solid"))%>">
<input type="hidden" name="hidEXCheck" value="EXI"> 
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>"> 
<input type="hidden" name="hidprinttype" value="<%=request.getParameter("hidprinttype")%>">
<input type="hidden" name="cbsaccno" value="<%=request.getParameter("cbsaccno")%>"> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
</form>
</body>
</html>
