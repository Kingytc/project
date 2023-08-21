<%@include file="../share/directives.jsp"%>
<%if (strBorrowerId.trim().equalsIgnoreCase("")
					|| strBorrowerId.trim().equalsIgnoreCase("null")) {
				strBorrowerId = Helper.correctNull((String) request.getParameter("comapp_id"));
			}
			if (strBorrowerId.trim().equalsIgnoreCase("")
					|| strBorrowerId.trim().equalsIgnoreCase("null")) {
				strBorrowerId = Helper.correctNull((String) hshValues.get("comappid"));
			}
			if (strSSIType.equalsIgnoreCase("")) {
				strSSIType = Helper.correctNull((String) hshValues.get("hidSSIType"));
			}
			String apptype = "";%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var sectcategory="<%=Helper.correctNull((String)hshValues.get("ops_accountsectorcategory"))%>";
var assetclassification="<%=Helper.correctNull((String)hshValues.get("ops_accountassetclassification"))%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function disableCommandButtons(val)
{
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}	  
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/ops_accountdetails.jsp";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanGetMethod.value="getAccountDetails";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}
function doSave()
{
	var len = document.forms[0].sel_assetclassification.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_assetclassification.options[i].selected==true)
		 {
			 document.forms[0].sel_assetclassification1.value = document.forms[0].sel_assetclassification.options[i].text; 
			break;
		 }
	}

	document.forms[0].hidRecordflag.value = varRecordflag;
	document.forms[0].hidSourceUrl.value="/action/ops_accountdetails.jsp";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanMethod.value="updateAccountDetails";
	document.forms[0].hidBeanGetMethod.value="getAccountDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(varRecordflag == "Y")
	{
	if(ConfirmMsg(101))
	{
		var len = document.forms[0].sel_assetclassification.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_assetclassification.options[i].selected==true)
		 {
			 document.forms[0].sel_assetclassification1.value = document.forms[0].sel_assetclassification.options[i].text; 
			break;
		 }
	}
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/ops_accountdetails.jsp";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanMethod.value="updateAccountDetails";
		document.forms[0].hidBeanGetMethod.value="getAccountDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		 
	}
}
function onLoading()
{
	if(sectcategory!="")
	{
		document.forms[0].sel_category.value=sectcategory;
	}
	else
	{
		document.forms[0].sel_category.value="0";
	}

	if(assetclassification!="")
	{
		document.forms[0].sel_assetclassification.value=assetclassification;
	}
	else
	{
		document.forms[0].sel_assetclassification.value="0";
	}
	disableFields("true");
}
function callClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
		
	}
}

function callApplicantTab(page)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		if(page=="facilities")
		{
			document.forms[0].hidBeanMethod.value="getOPSFacilityData";
			document.forms[0].hidBeanId.value="facilities";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_facilities.jsp";
		}
		if(page=="customerprofile")
		{
			document.forms[0].hidBeanMethod.value="getDemographics";
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_applicantdisp1.jsp";
		}
		if(page=="subsidy")
		{
				document.forms[0].hidBeanId.value="comssiaboveten";
				document.forms[0].hidBeanGetMethod.value="getDataSubsidy";
				document.forms[0].action=appURL+"action/ops_subsidy.jsp";
		}
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoading()">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application-&gt; Account Details
</td>
	</tr>
	
</table>
<span style="display:none"><lapschoice:borrowertype /></span>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
						<td class="sub_tab_inactive"><b> <a
							href="javascript:gotoTab(appURL,'facilities','getOPSFacilityData','ops_facilities.jsp')">Facilities</a>
						</b></td>
						<td class="sub_tab_inactive"><b><a
							href="javascript:gotoTab(appURL,'comssiaboveten','getDataSubsidy','ops_subsidy.jsp')">Subsidy</a></b>
						</td>
						<td class="sub_tab_active"><b>Account Details</b></td>
						<td class="sub_tab_inactive">
							<b><a href="javascript:gotoTab(appURL,'compro','getCapitalStructure','com_capitalstructure.jsp')">Capital Structure</a></b>
						</td>
						<td class="sub_tab_inactive"><b><a
							href="javascript:gotoTab(appURL,'ssidemographics','getOpsdemograph','ops_demographics.jsp')">Details of Promoter/Guarantor</a></b>
						</td>
					</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="middle">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="97%" border="1" cellspacing="0" cellpadding="4" class="outertable" align="center">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
											<tr>
												<td width="20%">Nature of Business</td>
												<td width="24%"><textarea name="txt_businessnature" cols="25" rows="3" onkeyup="checkTextArealimit(this,200)" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String) hshValues.get("ops_accountbusinessnature"))%></textarea>
												</td>
												<td width="19%">Sectoral Category </td>
												<td width="37%"><select name="sel_category">
													<option value="0">--select--</option>
													<option value="1">import</option>
													<option value="2">industry</option>
													<option value="3">export</option>
													<option value="4">Small scale</option>
													<option value="5">Trade &amp; COM</option>
													<option value="6">Agriculture</option>
													<option value="7">Transport operator</option>
													<option value="8">SM Trader other than Fert</option>
													<option value="9">Trader in Fert</option>
													<option value="10">Self Employed</option>
													<option value="11">SM Business</option>
													<option value="12">Others</option>
												</select></td>
											</tr>
											<tr id="s3">
												<td nowrap="nowrap" width="20%"> Asset Classification</td>
												<td nowrap="nowrap" colspan="4"><select name="sel_assetclassification">
													<option value="0">Select</option>
													<%apptype = "31";%>
													<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
												</select></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="sel_assetclassification1" /> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="hidmoduletype" /> 
 <input type="hidden" name="appid" value="<%=Helper.correctNull((String)request.getParameter("borrcomapp_idowername"))%>">
<INPUT TYPE="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidapplicantid"))%>">
</form>
</body>
</html>
