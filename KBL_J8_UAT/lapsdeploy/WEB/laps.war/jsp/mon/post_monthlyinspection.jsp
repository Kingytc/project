<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
function doReset()
	{
		document.forms[0].reset();
		document.all.insframe.src=appUrl+'action/blank.jsp';
	}

function doSearch()
{
    var cbsname=document.forms[0].cbsname.value;
	var cbsid=document.forms[0].cbsid.value;
	var varyear=document.forms[0].txt_year.value;
	var varname=document.forms[0].cbsname.value;
	if(varyear =="")
	{
		alert("Select the Year");
		return;
	}
	else
	{
		document.all.insframe.src=appUrl+"action/postinspectioniframeresult.jsp?&hidBeanId=postinspection&hidBeanGetMethod=getPostInspecSearch&cbsid="+cbsid+"&postinspec_year="+varyear+"&cbsname="+cbsname;
		
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
	var vartype=document.forms[0].seltype.value;
	var cbsname=document.forms[0].cbsname.value;
	var solid=document.forms[0].solid.value;
	if(vartype=="S")
	{
		alert("Select the Inspection Type");
	}
	
	else
	{
		if(vartype=="A")
		{
			document.forms[0].action=appUrl+"action/followupInspectionReport.jsp?hidreviewtype="+vartype+"&cbsname="+cbsname;
		}
		else if(vartype=="R")
		{
			document.forms[0].action=appUrl+"action/postinspection_retail_report.jsp?hidreviewtype="+vartype+"&cbsname="+cbsname;
		}
		else if(vartype=="C")
		{
			document.forms[0].action=appUrl+"action/mon_inspectionreport.jsp?hidreviewtype="+vartype+"&cbsname="+cbsname;
		}
		document.forms[0].hidBeanId.value="postinspection";
		document.forms[0].hidBeanGetMethod.value="getNewPostInspectionReport";
	    document.forms[0].submit();	
	}	
}


</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>				
            <td class="page_flow">Home -&gt;Post / Followup Inspection -&gt; Report</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
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
										<table width="60%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center">
											<tr>
												<td width="10%" align="right"><b>Year</b></td>
												<td width="10%"><input type="text" name="txt_year" size="5"
													maxlength="4" onKeyPress="allowInteger()"></td>
														<td width="10%"><input type="button" name="cmd_search"
													value="Search" class="buttonStyle" onClick="doSearch()"></td>
													<td width="10%"><input type="button" name="cmd_new"
													value="New" class="buttonStyle" onClick="doNew()"></td>
												<td width="10%" align="right"><b>Inspection Type</b></td>
												<td width="10%"><select name="seltype">
													 	<option value="S" selected>&lt;---Select---&gt;</option>
													  	<option value="R">Retail</option>
													    <option value="A">Agriculture</option>
													  	<option value="C">Corporate/ SME/ Tertiary</option>													
												</select></td>											
											</tr>
											<tr>
												<td colspan="6">
												<table width="50%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
													<tr class="dataheader">														
                                            <td width="100%" align="center"><b>Post / Followup Inspection Held On</b></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr align="center">
												<td colspan="6"><iframe width="60%" height="200" id="insframe"></iframe></td>
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
<lapschoice:combuttonnew btnnames='Reset_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="solid" value="<%=Helper.correctNull((String)request.getParameter("solid"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>"> 
</form>
</body>
</html>

