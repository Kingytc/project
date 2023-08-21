<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" 
    src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strbanking = "<%=Helper.correctNull((String)hshValues.get("bankingtype"))%>";
var strasset = "<%=Helper.correctNull((String)hshValues.get("asset"))%>";
var strstatus = "<%=Helper.correctNull((String)hshValues.get("accstatus"))%>";
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
		document.forms[0].selmulbank.value=strbanking;
	}
	else
	{
		document.forms[0].selmulbank.value="0";
	}
	showLeadbank();
	if(strasset != "")
	{
		document.forms[0].selassest.value=strasset;
	}
	else
	{
		document.forms[0].selassest.value="0";
	}
	if(strstatus != "")
	{
		document.forms[0].selstatus.value=strstatus;
	}
	else
	{
		document.forms[0].selstatus.value="0";
	}
}

function doCancel(url,method)
{
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanGetMethod.value="getBankingDetails"
	document.forms[0].action=appURL+"action/adc_bankingdetails.jsp";
	document.forms[0].submit();
	
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

function doEdit()
{		
	enableButtons(true,false,false,false,true);
	disableFields(false);
	document.forms[0].hidAction.value="Update";
}

function doSave()
{
	if(document.forms[0].selmulbank.value=='0')
	{
		ShowAlert(111,'Sole/Consortium/Multiple Banking');
		document.forms[0].selmulbank.focus();
		return true;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanMethod.value="updateBankingDetails";
	document.forms[0].hidBeanGetMethod.value="getBankingDetails"
	document.forms[0].hidSourceUrl.value="/action/adc_bankingdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function showLeadbank()
{

	if(document.forms[0].selmulbank.value=="2" || document.forms[0].selmulbank.value=="4" || document.forms[0].selmulbank.value=="6" || document.forms[0].selmulbank.value=="7")
	{
		document.all.txtleadbank.style.visibility="visible";
		document.all.idourshare.style.visibility="visible";
		document.all.idourshare.style.position="relative";
		document.all.idlabel1.innerText="Lead Bank"; 
		document.all.idlabel2.innerText=""; 
		 
	}
	else 
	{
		document.all.txtleadbank.style.visibility="hidden";
		document.all.idourshare.style.visibility="hidden";
		document.all.idourshare.style.position="absolute";
		document.all.idlabel1.innerText=""; 
		document.all.idlabel2.innerText="";
		document.forms[0].txtleadbank.value="";
		document.forms[0].wc_existfb.value="0";
		document.forms[0].wc_propfb.value="0";
		document.forms[0].wc_existnfb.value="0";
		document.forms[0].wc_propnfb.value="0";
					
	}
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="Delete";
			document.forms[0].hidBeanId.value="adhoc"
			document.forms[0].hidBeanMethod.value="updateBankingDetails";
			document.forms[0].hidBeanGetMethod.value="getBankingDetails"
			document.forms[0].hidSourceUrl.value="/action/adc_bankingdetails.jsp";
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
</script>
</head>
<body onload="placevalues()">
<form name="frmpri" method="post" class="normal"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="10" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
   </tr>
    <tr>
	<td  class="page_flow">
		Home -&gt; Corporate &amp; SME  -&gt; Ad hoc Limit -&gt; Banking Details 
	</td>
 </tr>
</table>

  <lapschoice:borrowertype /><lapschoice:application/>


<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1"> 
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr>
										<td colspan="4" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable border1">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                        		<tr> 
                                          <td colspan="4" class="dataheader"><b>Banking Details</b></td>
                                        </tr>
                                        <tr class="dataheader"> 
                                          <td width="35%" align="center"><b>Sole/Consortium/Multiple 
                                            Banking <span class="mantatory">*</span></b></td>
                                          <td width="17%" id="idlabel1"  align="center">
                                          <b>Lead Bank </b></td>
                                          <td width="9%" id="idlabel2" align="center">&nbsp;</td>
                                          <td width="9%" align="center">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td width="35%" align="center"><b> 
                                            <select name="selmulbank" onChange="showLeadbank()" tabindex="1">
                                              <option value="0" selected="selected">--select--</option>
                                              <option value="1">Sole</option>
                                              <option value="2">Consortium</option>
                                              <option value="3">Multiple</option>
                                              <option value="4">Sole/Consortium</option>
											  <option value="5">Sole/Multiple</option>
											  <option value="6">Consortium/Multiple</option>
											  <option value="7">Sole/Consortium/Multiple</option>
                                            </select>
                                            </b></td>
                                          <td align="center" width="17%" id="idleadbank"> 
                                            <input type="text" tabindex="2" name="txtleadbank" size="25" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("leadbank"))%>" onkeypress="allowAlphaNumericSpace()" maxlength="50">
                                          </td>
                                         <td align="center" width="9%">&nbsp;</td>
                                        </tr>
                                      </table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr id="idourshare">
										<td valign="top">
										<table width="50%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable border1">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
													
													<tr class="dataheader">
														<td width="30%" align="center"><b>Our Share (%)</b></td>
														<td width="35%" align="center"><b>Existing</b></td>
														<td width="35%" align="center"><b>Proposed</b></td>
													</tr>
													<tr>

														<td width="30%" align="center" class="dataheader"><b>Fund
														Based (WC + TL)</b></td>
														<td width="35%" align="center"><b> <input
															type="text" name="wc_existfb" size="15"
															onKeyPress="allowNumber(this)"
															onBlur="checkPercentage(this)" tabindex="3" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("WC_SHARE_FE"))))%>"> </b></td>
														<td align="center" width="35%"><b> <input
															type="text" name="wc_propfb" size="15"
															onKeyPress="allowNumber(this)"
															onBlur="checkPercentage(this)" tabindex="4" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("WC_SHARE_FP"))))%>"> </b></td>
													</tr>
													<tr>


														<td width="30%" class="dataheader" align="center"><b>Non
														Fund Based </b></td>
														<td width="35%" align="center"><input
															type="text" name="wc_existnfb" size="15"
															onKeyPress="allowNumber(this)"
															onBlur="checkPercentage(this)" tabindex="5" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("WC_SHARE_NFE"))))%>"></td>
														<td align="center" width="35%"><input
															type="text" name="wc_propnfb" size="15"
															onKeyPress="allowNumber(this)"
															onBlur="checkPercentage(this)" tabindex="6" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("WC_SHARE_NFP"))))%>"></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
										</tr>
									<tr>
										<td colspan="3">
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
													<tr align="center" class="dataheader">
														<td width="35%"><b>Asset Classification</b></td>
														<td width="36%"><b>Internal Credit Rating</b></td>
														<td width="29%"><b>Due date of Review</b></td>
													</tr>
													<tr>
														<td width="35%" align="center"><b> <select
															name="selassest" tabindex="7">
															<option value="0" selected="selected">--select--</option>
															<option value="1">Standard</option>
															<option value="2">Sub Standard</option>
															<option value="3">Loss</option>
															<option value="4">Doubtful</option>
														</select> </b></td>
														<td width="36%" align="center"><input type="text" tabindex="8"
															name="txtinrating" size="20" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("int_rating"))%>"></td>
														<td width="29%" align="center"><input type="text"
															name="txtrev_duedate" size="15" tabindex="9" onBlur="checkDate(txtrev_duedate)" value="<%=Helper.correctNull((String)hshValues.get("rev_duedate"))%>"
															readOnly> <a alt="Select date from calender"
															href="javascript:callCalender('txtrev_duedate')"><img
															src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
															width="21" border="0"></a></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
										<tr>
										<td colspan="3">
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
													<tr align="center" class="dataheader">
														<td width="35%"><b>External Credit Rating (Short Term)</b></td>
														<td width="36%"><b>External Credit Rating (Long Term)</b></td>
														<td width="29%"><b>Status of Account</b></td>
													</tr>
													<tr>
														<td width="35%" align="center"><input type="text"
															name="txtextratingst" size="20" tabindex="10" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("ext_rating_short"))%>"></td>
														<td width="36%" align="center"><input type="text"
															name="txtextratinglt" size="20" tabindex="11" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("ext_rating_long"))%>"></td>
														<td width="29%" align="center"><b> <select
															name="selstatus" tabindex="12">
															<option value="0" selected="selected">--select--</option>
															<option value="1">Regular</option>
															<option value="2">EAS I</option>
															<option value="3">EAS II</option>
															<option value="4">SMA</option>
														</select> </b></td>
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
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
