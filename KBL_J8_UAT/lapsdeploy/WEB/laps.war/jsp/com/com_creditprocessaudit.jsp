<%@include file="../share/directives.jsp"%>
<%
	if (strCategoryType.equals("CORPORATE")) {
		strCategoryType = "CORP";
	}

	String bid = Helper.correctNull((String) hshValues
			.get("borrowerid"));
	String strAppID = "";
	if (bid.trim().equals("")) {
		strAppID = request.getParameter("comapp_id");
	} else {
		strAppID = Helper.correctNull((String) hshValues
				.get("borrowerid"));
	}

	String strAppno = request.getParameter("appno");

	String strBorrowerType = Helper.correctNull((String) request
			.getParameter("hidBorrowerType"));

	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = null;
	arrRow = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<title>Credit Process Audit</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	
}
function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="")
	{
		document.forms[0].hidBeanId.value="";
	}
	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
	document.forms[0].submit();
	
}
 
function disableFields(val)
{
	
	
	for(var i=0;i<document.forms[0].length;i++)
	{
		  if(document.forms[0].elements[i].type=='select-one')
		  {
			document.forms[0].elements[i].disabled=val;
		  }	
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	  
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getCreditProcessAudit";
	document.forms[0].action=appURL+"action/com_creditprocessaudit.jsp";
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
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="edit";	
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateCreditProcessAudit";
	document.forms[0].hidBeanGetMethod.value="getCreditProcessAudit";
	document.forms[0].hidSourceUrl.value="/action/com_creditprocessaudit.jsp";
	document.forms[0].submit();
	window.opener.document.forms[0].txt_cntflag.value='Y';
}

function doDelete()
	{
	if (ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete";	
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanMethod.value="updateCreditProcessAudit";
			document.forms[0].hidBeanGetMethod.value="getCreditProcessAudit";
			document.forms[0].hidSourceUrl.value="/action/com_creditprocessaudit.jsp";	
			document.forms[0].method="post";
			document.forms[0].submit();
		}
   }		


function callOnload()
{
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmdclose.disabled=false;
	disableFields(true);
}

function doClose()
{
	if (ConfirmMsg(100))
	{
	window.close();
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
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
<body onload="callOnload()">
<form name="frmpri" method="post" class="normal"><span
	style="visibility: hidden"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<div align="left"></div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable border1">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable">
									<tr>
										<td>

										<table width="100%" border="0" align="center"
											class="outertable">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td width="60%" align="center">
														<table width="100%" border="0" cellspacing="3"
															cellpadding="3" class="outertable">
															<tr>
																<td align="center"  class="sub_tab_active"><b>Credit
																Process Audit</b></td>
																<td  class="sub_tab_inactive" align="center"><b> <a
																	href="javascript:callLink('com_creditmortgageddetail.jsp','commworkflow','getCreditMoragageDetails')"
																	class="blackfont"> Property Details </a></b></td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td align="center">Credit Process Audit</td>
											</tr>
											<tr>
												<td>
												<table width="100%" border="0" class="outertable">
													<tr>
														<td width="1%" align="center">I.</td>
														<td width="99%" height="19">As instructed by
														Regional Office/FGMO, Vide &nbsp; <input type="text"
															name="txt_vide"
															value="<%=Helper.correctNull((String) hshValues
							.get("processcondvide"))%>"
															maxlength="50"> , I have verified compliance of
														the pre-disbursement terms and conditions by the branch</td>
													</tr>
													<tr>
														<td width="1%">&nbsp;</td>
														<td width="99%">officials as per the above sanction
														advice and confirm that the branch has complied with all
														the pre-disbursement conditions, except the following (if
														any):</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td>
												<table width="75%" border="0" class="outertable">
													<tr>
														<td width="14%">&nbsp;</td>
														<td width="86%"><textarea name="txt_conditions"
															cols="100" style="text-align: left" tabindex="12"
															rows="8" onKeyPress="textlimit(txt_conditions,3998)" onKeyUp="textlimit(this,3989)"><%=Helper.correctNull((String) hshValues
							.get("processcondition"))%></textarea></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td align="center">II.</td>
														<td>I further confirm that the branch has recovered
														the applicable processing charges.</td>
													</tr>
													<tr>
														<td align="center">&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
													<tr>
														<td align="center">&nbsp;</td>
														<td><span class="mantatory">(The
														CPAO is supposed to comment on the following points
														specifically)</span></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td>

										<table width="100%" border="0" cellspacing="1" cellpadding="4"
											align="center" class="outertable">
											<tr class="dataheader">
												<td align="center" colspan="4"><b></b></td>
												<td align="center"><b>Aspects</b></td>
												<td align="center" width="13%"><b>CPAO's Observations</b></td>
												<td align="center" width="35%"><b>Comments</b></td>
											</tr>
											<%
												arrRow = (ArrayList) hshValues.get("arrRow");
												if (arrRow != null && arrRow.size() > 0) {
													for (int i = 0; i < arrRow.size(); i++) {
														arrCol = (ArrayList) arrRow.get(i);
														if (arrCol != null && arrCol.size() > 0) {
											%>
											<tr>
												<td colspan="4" align="left"><%=Helper.correctNull((String) arrCol.get(3))%>
												<input type="hidden" name="hidslno"
													value="<%=Helper.correctNull((String) arrCol.get(3))%>">
												</td>
												<td align="left"><%=Helper.correctNull((String) arrCol.get(0))%>
												<input type="hidden" name="hidnorms"
													value="<%=Helper.correctNull((String) arrCol.get(0))%>">
												</td>
												<td width="13%" align="center"><select
													name="sel_reasons">
													<%
														String strselreason = Helper
																			.correctNull((String) arrCol.get(1));
																	if (strselreason.equalsIgnoreCase("S")) {
													%>
													<option value="S" selected="selected">---Select---</option>
													<%
														} else {
													%>
													<option value="S">---Select---</option>
													<%
														}
																	if (strselreason.equalsIgnoreCase("Y")) {
													%>
													<option value="Y" selected="selected">YES</option>
													<%
														} else {
													%>
													<option value="Y">YES</option>
													<%
														}
																	if (strselreason.equalsIgnoreCase("N")) {
													%>
													<option value="N" selected="selected">NO</option>
													<%
														} else {
													%>
													<option value="N">NO</option>
													<%
														}
																	if (strselreason.equalsIgnoreCase("NA")) {
													%>
													<option value="NA" selected="selected">NA</option>
													<%
														} else {
													%>
													<option value="NA">NA</option>
													<%
														}
													%>
												</select></td>
												<td width="35%" align="center"><textarea
													name="txt_reasons" cols="50"
													tabindex="12" rows="2"
													onKeyPress="textlimit(txt_reasons['<%=i%>'],3998)" onKeyUp="textlimit(this,3998)"><%=Helper.correctNull((String) arrCol.get(2))%></textarea>
												</td>
											</tr>
											<%
												}
													}
												}
											%>
										</table>
										</td>
									</tr>

								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" class="outertable">
									<tr>

										<td width="25%">Remarks of Nominated officer</td>

										<td width="75%"><textarea name="txt_remarks" cols="50"
											style="text-align: left" tabindex="12" rows="6"
											onKeyPress="textlimit(txt_remarks,3998)" onKeyUp="textlimit(this,3998)"><%=Helper.correctNull((String) hshValues
							.get("processremarks"))%></textarea></td>
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
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="comapp_id" value="<%=strAppID%>"> <input type="hidden"
	name="ano" value="<%=strAppno%>"> <input type="hidden"
	name="cattype" value="<%=strCategoryType%>"> <input
	type="hidden" name="ssitype" value="<%=strSSIType%>"> <input
	type="hidden" name="id" value="<%=strBorrowerType%>"> <input
	type="hidden" name="txt_creditappno"
	value="<%=Helper.correctNull((String) hshValues
									.get("credit_appno"))%>">
</form>
</body>
</html>
