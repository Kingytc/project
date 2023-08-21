<%@include file="../share/directives.jsp"%>
<%
	String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
	if(!stryear.equalsIgnoreCase(""))
	{
		stryear=Helper.correctNull((String)hshValues.get("mon_year"));
	}
	String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));
	
	if(!strmonth.equalsIgnoreCase(""))
	{
		strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
	}
%>
<HTML>
<HEAD>
<TITLE>Monitoring General Info</TITLE>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varacctclassification="<%=Helper.correctNull((String)hshValues.get("acc_categorization"))%>";
var varstress="<%=Helper.correctNull((String)hshValues.get("acc_stress"))%>";
var varrestructered="<%=Helper.correctNull((String)hshValues.get("acc_restructered"))%>";
var varrestructterms="<%=Helper.correctNull((String)hshValues.get("acc_restructterms"))%>";
var vardocumentobtained="<%=Helper.correctNull((String)hshValues.get("documentobtained"))%>";
var vardocumentvetted="<%=Helper.correctNull((String)hshValues.get("documentvetted"))%>";
var varorglevel="<%=strOrgLevel%>";

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function onloading()
{
	disableFields(true);
	if(varacctclassification!="")
	{
		document.forms[0].sel_acctclassification.value=varacctclassification;
	}
	if(varstress!="")
	{
		document.forms[0].sel_stress.value=varstress;
	}
	if(varrestructered!="")
	{
		document.forms[0].sel_restucture.value=varrestructered;
	}
	if(varrestructterms!="")
	{
		document.forms[0].sel_restruc_termscompiled.value=varrestructterms;
	}
	if(vardocumentobtained!="")
	{
		document.forms[0].sel_docstipulated.value=vardocumentobtained;
	}
	if(vardocumentvetted!="")
	{
		document.forms[0].sel_docvetted.value=vardocumentvetted;
	}
	
	showStress();
	showRestrucured();
	docvetted();

	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
		document.forms[0].cmddelete.disabled=true;	
	}
	else
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
		document.forms[0].cmddelete.disabled=true;	
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
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

function doSave()
{		
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidBeanMethod.value="updateGeneralInfo";
	document.forms[0].hidBeanGetMethod.value = "getGeneralInfo";
	document.forms[0].hidSourceUrl.value="/action/mon_generalinfo.jsp";
	document.forms[0].submit();
} 
function doCancel()
{	
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidSourceUrl.value="mon_generalinfo.jsp";
		document.forms[0].hidBeanGetMethod.value="getGeneralInfo";
		document.forms[0].hidBeanMethod.value="updateGeneralInfo";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_generalinfo.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doEdit()
{
	document.forms[0].hidAction.value="insert";
	disableCommandButtons("edit");
	disableFields(false);
}

function disableCommandButtons(val)
{
	if(val=="edit")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;	
		document.forms[0].cmddelete.disabled=false;	 
	}	
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateGeneralInfo";
		document.forms[0].hidBeanGetMethod.value = "getGeneralInfo";
		document.forms[0].hidSourceUrl.value="/action/mon_generalinfo.jsp";
		document.forms[0].submit();
	}
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function showStress()
{
	if(document.forms[0].sel_stress.value=='Y')
	{
		document.all.l1.style.visibility="visible";
		document.all.l2.style.visibility="visible";		
	}
	else
	{
		document.all.l1.style.visibility="hidden";
		document.all.l2.style.visibility="hidden";
		document.forms[0].txt_stressreasons.value="";
	}
}

function showRestrucured()
{
	if(document.forms[0].sel_restucture.value=='Y')
	{
		document.all.restruct1.style.visibility="visible";
		restructCompiledterms();
	}
	else
	{
		document.all.restruct1.style.visibility="hidden";
		document.forms[0].sel_restruc_termscompiled.value="S";		
	}
}

function restructCompiledterms()
{
	if(document.forms[0].sel_restruc_termscompiled.value=='N')
	{
		document.all.restruct2.style.visibility="visible";
		document.all.restruct3.style.visibility="visible";		
	}
	else
	{
		document.all.restruct2.style.visibility="hidden";
		document.all.restruct3.style.visibility="hidden";
		document.forms[0].txt_restructterms_reasons.value="";
	}
}

function docvetted()
{
	if(document.forms[0].sel_docvetted.value=='N')
	{
		document.all.document2.style.visibility="visible";
		document.all.document3.style.visibility="visible";
		document.all.name.style.visibility="hidden";
		document.all.name.style.position="absolute";
		document.forms[0].txt_lawyername.value="";
	}
	else if(document.forms[0].sel_docvetted.value=='Y')
	{
		document.all.document2.style.visibility="hidden";
		document.all.document3.style.visibility="hidden";
		document.all.name.style.visibility="visible";
		document.all.name.style.position="relative";
		document.forms[0].txt_docvettedreason.value="";
	}
	else
	{
		document.all.document2.style.visibility="hidden";
		document.all.document3.style.visibility="hidden";
		document.all.name.style.visibility="hidden";
		document.all.name.style.position="absolute";
	}
}

</SCRIPT>
</head>
<body onload="onloading()">
<form name="" method="post" class="normal">
						<lapschoice:monthlymonitortag pageid="13"/>
  <span class="page_flow">Home -&gt; Monitoring-&gt; Monthly Monitoring Reports-&gt;General Info </span><br>		
								<lapschoice:MonthlyMonitor />
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
		<tr> 
			<td valign="top" width="80%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
								<tr>
						                  <td  width="50%" align="center"> 
						                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td>
													<table width="97%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
														<tr>
															<td>
																<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
																	<tr width="50%"> 
																		<td>																			
                                      <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                        <tr valign="top"> 
                                          <td width="25%">The account categorized as </td>
                                          <td width="25%"> 
                                            <select name="sel_acctclassification">
                                              <option value="S" selected>&lt;---Select---&gt;</option>
                                              <option value="1">Standard</option>
                                              <option value="2">EAS-I</option>
                                              <option value="3">EAS-II</option>
                                              <option value="4">SMA</option>
                                            </select>
                                          </td>
                                          <td width="25%">&nbsp;</td>
                                          <td width="25%">&nbsp;</td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td width="25%">If account is Under Stress</td>
                                          <td width="25%"> 
                                            <select name="sel_stress" onChange="showStress()">
                                              <option value="S" selected>&lt;---Select---&gt;</option>
                                              <option value="Y">Yes</option>
                                              <option value="N">No</option>
                                            </select>
                                          </td>
                                          <td width="25%" id="l1">Reasons</td>
                                          <td width="25%" id="l2"> 
                                            <textarea name="txt_stressreasons" rows="2" cols="40" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("acc_stress_reason")) %></textarea>
                                          </td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td width="25%">Whether the account is Restructured one</td>
                                          <td width="25%"> 
                                            <select name="sel_restucture" onChange="showRestrucured()">
                                              <option value="S" selected>&lt;---Select---&gt;</option>
                                              <option value="Y">Yes</option>
                                              <option value="N">No</option>
                                            </select>
                                          </td>
                                          <td width="25%">&nbsp;</td>
                                          <td width="25%">&nbsp;</td>
                                        </tr>
                                        <tr valign="top" id="restruct1"> 
                                          <td>whether all the terms of restructuring complied with.</td>
                                          <td> 
                                            <select name="sel_restruc_termscompiled" onChange="restructCompiledterms()">
                                              <option value="S" selected>&lt;---Select---&gt;</option>
                                              <option value="Y">Yes</option>
                                              <option value="N">No</option>
                                            </select>
                                          </td>
                                          <td id="restruct2">Reasons</td>
                                          <td id="restruct3"> 
                                            <textarea name="txt_restructterms_reasons" rows="2" cols="40" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("acc_restructtermsreasons")) %></textarea>
                                          </td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td>Credit Ratings</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp; </td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td>Present Year Rating</td>
                                          <td> 
                                            <input type="text" name="txt_prevrating" size="15" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("presentrating"))%>">
                                          </td>
                                          <td>Previous Year Rating</td>
                                          <td> 
                                            <input type="text" name="txt_presentrating" size="15" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("prevrating"))%>">
                                          </td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td>Reasons for down gradation, if any</td>
                                          <td> 
                                            <textarea name="txt_downgrade_reason" rows="2" cols="40" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("downgradereason"))%></textarea>
                                          </td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp; </td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td >Whether documents as stipulated are obtained</td>
                                          <td > 
                                            <select name="sel_docstipulated">
                                              <option value="S" selected>&lt;---Select---&gt;</option>
                                              <option value="Y">Yes</option>
                                              <option value="N">No</option>
                                            </select>
                                          </td>
                                          <td >Date of Credit Process Audit conducted (If applicable)</td>
                                          <td > 
                                            <input type="text" name="txt_creditauditdate" size="15" 
                                            maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("creditauditdate")) %>"
                                            onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
                                            <a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_creditauditdate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
                                          </td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td >Deviation / Non - compliance, if 
                                            any, whether approved by the Competent 
                                            Authority</td>
                                          <td > 
                                            <textarea name="txt_deviation" rows="2" cols="40"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("mon_deviation"))%></textarea>
                                          </td>
                                          <td>&nbsp;Permitted date for compliance</td>
                                          <td>&nbsp;
                                            <input type="text" name="txt_permittedcompliance" size="15" 
                                            maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("mon_compliance")) %>"
                                            onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
                                            <a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_permittedcompliance')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
                                          </td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td >Whether the above Documents are 
                                            vetted by the Law Officer / Advocate 
                                          </td>
                                          <td > 
                                            <select name="sel_docvetted" onChange="docvetted()">
                                              <option value="S" selected>&lt;---Select---&gt;</option>
                                              <option value="Y">Yes</option>
                                              <option value="N">No</option>
                                            </select>
                                          </td>
                                          <td id="document2">If no, give reasons</td>
                                          <td id="document3"> 
                                            <textarea name="txt_docvettedreason" rows="2" cols="40" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("docvettedreasons"))%></textarea>
                                          </td>
                                        </tr>
                                        <tr valign="top" id="name">
                                          <td >Law Officer / Advocate Name </td>
                                          <td ><input type="text" name="txt_lawyername" size="50" maxlength="80" value="<%=Helper.correctNull((String)hshValues.get("lawyer_name"))%>"></td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                        </tr>
                                        <tr valign="top"> 
                                          <td >Whether any deficiencies pointed 
                                            out in Documentation and rectification 
                                            action initiated</td>
                                          <td > 
                                            <textarea name="txt_docdeficiences" rows="2" cols="40" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("docdeficiencies"))%></textarea>
                                          </td>
                                          <td >Date of last meeting with the borrower</td>
                                          <td >&nbsp; 
                                            <input type="text" name="borrower_Date" size="15" 
                                            maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("borrower_Date")) %>"
                                            onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
                                            <a alt="Select date from calender" href="#"
																	onClick="callCalender('borrower_Date')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a></td>
                                        </tr>
                                        <%if(Helper.correctNull((String)hshValues.get("checkString")).equals("y"))
										{%>
                                        <tr valign="top"> 
                                          <td >Reason for not adequate charges 
                                            stipulated are registered with ROC 
                                          </td>
                                          <td > 
                                            <textarea name="roc_reasons" rows="2" cols="40" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("roc_reasons"))%></textarea>
                                          </td>
                                          <td >&nbsp;</td>
                                          <td >&nbsp;</td>
                                        </tr>
                                        <%}%>
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
		</table></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br/>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>  
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=stryear%>">
<input type="hidden" name="mon_month" value="<%=strmonth%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
 <input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
</form>
</body>
</HTML>