<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
%>
<html>
<head>
<title>LAPS Application Parameters</title>

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
	<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"> </script>

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

function callonLoad()
{		
	disablefields(true);
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}	
	}
}

function doSave()
{	
	disablefields(false);
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updatenpaprovcoverpercnt";
	document.forms[0].hidBeanGetMethod.value="getnpaprovcoverpercnt";
	document.forms[0].hidSourceUrl.value="/action/npa_prov_coverage_master.jsp";	
	document.forms[0].action=appURL+"controllerservlet";	
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getnpaprovcoverpercnt";
		document.forms[0].action=appURL+"action/npa_prov_coverage_master.jsp";	
		document.forms[0].submit();
	}
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update";
	enableButtons(true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

</SCRIPT>
</head>
<body onload="callonLoad()">

<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; NPA -&gt; NPA Provisioning Coverage Percentage</td>
	</tr>
</table>
<table width="60%" border="0" cellpadding="5" cellspacing="0"
	 align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">

			<tr>
				<td valign="top">
				<table width="85%" border="0" cellspacing="0" cellpadding="5"
					align="center" class="outertable">
					<tr>
						<td valign="top" height="100px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
								class="outertable"	>
									<tr height="25" align="center" class="dataheader">
										<td nowrap colspan="3"><b>Coverage Percentage for each Norm status of Provisioning</b></td>
									</tr>
									<tr height="25" class="datagrid">
										<td nowrap width="60%"><b>Parameters</b></td>
										<td nowrap align="center" width="20%"><b>Secured(%)</b></td>
										<td nowrap align="center" width="20%"><b>Unsecured(%)</b></td>
									</tr>
									<tr>
										<td><b>Sub Standard (SS)</b>&nbsp;</td>
										<td align="center"><input type="text" name="txt_ss_sec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ss_sec")) %>" style="text-align:right" size="10" maxlength="3"></td>
										<td align="center"><input type="text" name="txt_ss_unsec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ss_unsec")) %>" style="text-align:right" size="10" maxlength="3"></td>
									</tr>
									<tr>
										<td><b>ABINITIO</b>&nbsp;</td>
										<td align="center"><input type="text" name="txt_ab_sec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ab_sec")) %>" style="text-align:right" size="10" maxlength="3"></td>
										<td align="center"><input type="text" name="txt_ab_unsec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ab_unsec")) %>" style="text-align:right" size="10" maxlength="3"></td>
									</tr>
									<tr>
										<td><b>Doubtful Standard 1 (DS1)</b>&nbsp;</td>
										<td align="center"><input type="text" name="txt_ds1_sec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ds1_sec")) %>" style="text-align:right" size="10" maxlength="3"></td>
										<td align="center"><input type="text" name="txt_ds1_unsec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ds1_unsec")) %>" style="text-align:right" size="10" maxlength="3"></td>
									</tr>
									<tr>
										<td><b>Doubtful Standard 2 (DS2)</b>&nbsp;</td>
										<td align="center"><input type="text" name="txt_ds2_sec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ds2_sec")) %>" style="text-align:right" size="10" maxlength="3"></td>
										<td align="center"><input type="text" name="txt_ds2_unsec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ds2_unsec")) %>" style="text-align:right" size="10" maxlength="3"></td>
									</tr>
									<tr>
										<td><b>Doubtful Standard 3 (DS3)</b>&nbsp;</td>
										<td align="center"><input type="text" name="txt_ds3_sec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ds3_sec")) %>" style="text-align:right" size="10" maxlength="3"></td>
										<td align="center"><input type="text" name="txt_ds3_unsec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_ds3_unsec")) %>" style="text-align:right" size="10" maxlength="3"></td>
									</tr>
									<tr>
										<td><b>LOSS</b>&nbsp;</td>
										<td align="center"><input type="text" name="txt_loss_sec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_loss_sec")) %>" style="text-align:right" size="10" maxlength="3"></td>
										<td align="center"><input type="text" name="txt_loss_unsec" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("txt_loss_unsec")) %>" style="text-align:right" size="10" maxlength="3"></td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidfrom" value="LP">
</form>
</body>
</html>
