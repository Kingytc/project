<%@include file="../share/directives.jsp"%>
<%String category = Helper.correctNull((String) request.getParameter("hidcatory"));
String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strbanking = "<%=Helper.correctNull((String)hshValues.get("cb_banktype"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function callCalender(fname)
{
 	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function placevalues()
{
	disableFields(true);
	if(strbanking != "")
	{
		document.forms[0].mulbank.value=strbanking;
	}
	else
	{
		document.forms[0].mulbank.value="0";
	}
	showLeadbank();	
}
function doCancel(url,method)
{
	document.forms[0].hidBeanId.value="broadsancterms"
	document.forms[0].hidBeanGetMethod.value="getBankingArrangementData"
	document.forms[0].action=appURL+"action/combst_bankingdetails.jsp";
	document.forms[0].submit();	
}
function doClose()
{
   if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}
function doEdit()
{		
	enableButtons(true,false,false,false,true);
	disableFields(false);
	document.forms[0].hidAction.value="Update";
}
function doSave()
{
	if(document.forms[0].mulbank.value=='0')
	{
		ShowAlert(111,'Sole/Consortium/Multiple Banking');
		document.forms[0].mulbank.focus();
		return true;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="broadsancterms"
	document.forms[0].hidBeanMethod.value="updateBankingArrangementData";
	document.forms[0].hidBeanGetMethod.value="getBankingArrangementData"
	document.forms[0].hidSourceUrl.value="/action/combst_bankingdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function showLeadbank()
{
	if(document.forms[0].mulbank.value=="0" || document.forms[0].mulbank.value=="1" || document.forms[0].mulbank.value=="3" || document.forms[0].mulbank.value=="5")
	{
		document.all.idleadbank.style.visibility="hidden";
		document.all.idbnkname.style.visibility="hidden";
		document.all.idourshare.style.visibility="hidden";
		document.forms[0].leadbank.value="";
		document.forms[0].wc_existfb.value="0";
		document.forms[0].wc_propfb.value="0";
		document.forms[0].wc_existnfb.value="0";
		document.forms[0].wc_propnfb.value="0";
	}
	else
	{
		document.all.idleadbank.style.visibility="visible";
		document.all.idbnkname.style.visibility="visible";
		document.all.idourshare.style.visibility="visible";
	}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
	 	{
			document.forms[0].hidAction.value="Delete";
			document.forms[0].hidBeanId.value="broadsancterms"
			document.forms[0].hidBeanMethod.value="updateBankingArrangementData";
			document.forms[0].hidBeanGetMethod.value="getBankingArrangementData"
			document.forms[0].hidSourceUrl.value="/action/combst_bankingdetails.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
         }
	 }
	else
	{
		ShowAlert(158);
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
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
</script>
</head>
<body onload="placevalues()">
<form name="frmpri" method="post" class="normal">
<lapstab:applurllinkbst pageid='11' category='<%=category%>' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Banking Arrangement</td>
	</tr>
</table>
<lapschoice:BST/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td height="20" width="45%" valign="bottom">
		<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td align="center" class="sub_tab_active"><b>Banking Arrangement</b></td>
				<td align="center" class="sub_tab_inactive"><b><a href="javascript:callLink('combst_creditfacilities.jsp','broadsancterms','getCreditFacilitiesData')">Credit Facilities</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
					<tr>
						<td colspan="4" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="1" cellpadding="3">
									<tr class="dataheader">
										<td width="35%" align="center" ><b>Sole/Consortium/Multiple Banking </b></td>
										<td width="35%" align="center" id="idbnkname"><b>Lead Bank </b></td>
									</tr>
									<tr class="datagrid">
										<td width="35%" align="center"><b> <select
											name="mulbank" onChange="showLeadbank()">
											<option value="0" selected="selected">--select--</option>
											<option value="1">Sole</option>
											<option value="2">Consortium</option>
											<option value="3">Multiple</option>
											<option value="4">Sole/Consortium</option>
											<option value="5">Sole/Multiple</option>
											<option value="6">Consortium/Multiple</option>
											<option value="7">Sole/Consortium/Multiple</option>
										</select> </b></td>
										<td align="center" width="35%"
											id="idleadbank"><b> <input type="text" name="leadbank"
											size="25" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("cb_leadbank"))%>"> </b></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr id="idourshare">
						<td valign="top">
						<table width="50%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr class="dataheader">
										<td width="30%" align="center"><b>Our Share (%)</b></td>
										<td width="35%" align="center" ><b>Existing</b></td>
										<td width="35%" align="center" ><b>Proposed</b></td>
									</tr>
									<tr class="datagrid">
										<td width="30%"  align="center"><b>Fund Based (WC + TL)</b></td>
										<td width="35%" align="center"><b> <input
											type="text" name="wc_existfb" size="15"
											onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)"
											tabindex="3"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("cb_fundexist"))))%>">
										</b></td>
										<td align="center" width="35%"><b> <input
											type="text" name="wc_propfb" size="15"
											onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)"
											tabindex="4"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("cb_fundproposed"))))%>">
										</b></td>
									</tr>
									<tr class="datagrid">
										<td width="30%"  align="center"><b>Non Fund Based </b></td>
										<td width="35%" align="center"><input
											type="text" name="wc_existnfb" size="15"
											onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)"
											tabindex="5"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("cb_nonfundexist"))))%>"></td>
										<td align="center" width="35%"><input
											type="text" name="wc_propnfb" size="15"
											onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)"
											tabindex="6"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("cb_nonfundproposed"))))%>"></td>
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
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
