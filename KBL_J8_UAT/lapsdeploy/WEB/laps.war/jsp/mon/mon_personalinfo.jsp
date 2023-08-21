<%@include file="../share/directives.jsp"%>
<%String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
	if(!stryear.equalsIgnoreCase(""))
	{
		stryear=Helper.correctNull((String)hshValues.get("mon_year"));
	}
	String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));
	
	if(!strmonth.equalsIgnoreCase(""))
	{
		strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
	}%>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strbankarr="<%=Helper.correctNull((String)hshValues.get("arrange"))%>";
var personal_leadbankvetted="<%=Helper.correctNull((String)hshValues.get("personal_leadbankvetted"))%>";
var personal_stipdocuments ="<%=Helper.correctNull((String)hshValues.get("personal_leadbankvetted"))%>";
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
	document.all["consortium_button"].style.display="none";
	if(strbankarr!="")
   {
   		document.forms[0].txt_bankarrange.value=strbankarr;
		if(strbankarr=="2")
		{
			document.all["consortium_button"].style.display="block";
		}
   }
   else
   {
   		document.forms[0].txt_bankarrange.value="s";
   }
   changeArrangement();
   if(personal_leadbankvetted=='1')
   {
   	 document.forms[0].jointdocument.value = personal_leadbankvetted;
   }
   if(personal_stipdocuments=='1')
   {
   	  document.forms[0].stipulateddocument.value = personal_stipdocuments;
   }
   	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
   		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
   	else
   	{
   		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
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
		document.forms[0].hidBeanMethod.value="updateBorrowerinfo";
		document.forms[0].hidBeanGetMethod.value = "getBorrowerinfo";
		document.forms[0].hidSourceUrl.value="/action/mon_personalinfo.jsp";
		document.forms[0].submit();
} 
function doCancel()
{	
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidSourceUrl.value="mon_personalinfo.jsp";
		document.forms[0].hidBeanGetMethod.value="getBorrowerinfo";
		document.forms[0].hidBeanMethod.value="getBorrowerinfo";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_personalinfo.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doEdit()
{
	document.forms[0].hidAction.value="Edit";
	disableCommandButtons("edit");
	disableFields(true);
	document.forms[0].txt_bankarrange.disabled=false;
	document.forms[0].txt_contactname.readOnly=false;
	document.forms[0].txt_contact_per_design.readOnly=false;
	document.forms[0].txt_contact_landline.readOnly=false;
	document.forms[0].txt_contact_mobile.readOnly=false;
	document.forms[0].jointdocument.disabled=false;
	document.forms[0].stipulateddocument.disabled=false;
	changeArrangement();	
}
function doConsortum()
{
	var purl ="<%=ApplicationParams.getAppUrl()%>action/mon_consortium.jsp?hidBeanGetMethod=getConsortium&hidBeanId=mmrcommon&cbsid="+document.forms[0].hidcbsid.value+"&mon_year="+document.forms[0].strYear.value+"&mon_month="+document.forms[0].mmr_month.value+"&cbsname="+document.forms[0].strcbsname.value+"&statusflag="+document.forms[0].statusflag.value+"&mmrno="+document.forms[0].mmrno.value;
	var prop = 'scrollbars=yes,menubar=yes,width=1000,height=600';	
	var xpos = (screen.width - 1000) / 2;
	var ypos = (screen.height - 700) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Consortium_Details',prop);
}

function disableCommandButtons(val)
{
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;	
		//document.forms[0].cmddelete.disabled=false;	
}  
function changeArrangement()
{
	if(document.forms[0].txt_bankarrange.value=="2")
	{
		document.all["documentationId"].style.display="table-row";
		document.all["stipulateddoc"].style.display="table-row";
		document.all["consortium_button"].style.display="block";		
		if(document.forms[0].cmdsave.disabled==false)
		{
			document.forms[0].consortium_name.disabled=true;
		}		
	}
	else
	{
		document.all["documentationId"].style.display="none";
		document.all["stipulateddoc"].style.display="none";
		document.all["consortium_button"].style.display="none";		
	}	
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
</SCRIPT>
</head>
<body onload="onloading()">
<form name="" method="post" class="normal">
						<lapschoice:monthlymonitortag pageid="2"/>
  <span class="page_flow">Home -&gt; Monitoring-&gt; Monthly Monitoring Reports -&gt; Borrower Info</span><br>
										<lapschoice:MonthlyMonitor />							
	<br>
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
															<td >
																<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
																	<tr width="50%">																		
                                    <td width="52%"> 
                                      <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                        <tr> 
                                          <td width="42%">Banking Arrangement</td>
                                          <td width="58%"> 
                                            <table class="outertable">
                                              <tr> 
                                                <td width="115"> 
                                                  <select name="txt_bankarrange" onChange="changeArrangement()">
                                                    <option value="s">--Select--</option>
                                                    <option value="1">Sole</option>
                                                    <option value="2">Consortium</option>
                                                    <option value="3">Multiple</option>
                                                  </select>                                                  
                                                </td>
                                                <td width="110"><span id="consortium_button"> 
                                                  <input type='button' name='consortium_name' value='Consortium' onClick="doConsortum()" class="buttonStyle">
                                                  </span></td>
                                              </tr>
                                            </table>
                                           
                                          </td>
                                        </tr>
										<tr id="documentationId">
										  <td>In case of joint documentation whether 
                                            lead bank has obtained and got vetted 
                                            the stipulated documents</td>
										<td>
                                            <select name="jointdocument">
                                              <option value="0">Yes</option>
                                              <option value="1">NO</option>
                                            </select>
                                          </td>
										</tr>
										<tr id="stipulateddoc">
										  <td> whether branch is holding confirmation 
                                            to that effect</td>
										<td>
                                            <select name="stipulateddocument">
                                              <option value="0">Yes</option>
                                              <option value="1">NO</option>
                                            </select>
                                          </td>
										</tr>
                                        <tr> 
                                          <td width="42%">Phone</td>
                                          <td width="58%"> 
                                            <input type="text" name="txt_phno" maxlength="15" size="20" value="<%=Helper.correctNull((String)hshValues.get("phoneno"))%>" />
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="42%">Mobile number</td>
                                          <td width="58%"> 
                                            <input type="text" name="txt_mobile" maxlength="15" size="20" value="<%=Helper.correctNull((String)hshValues.get("mobile"))%>" />
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="42%">Constitution</td>
                                          <td width="58%"> 
                                            <input type="text"  name="txt_const" maxlength="30" size="20" value="<%=Helper.correctNull((String)hshValues.get("constitution"))%>" />
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="42%" >Banking Since</td>
                                          <td width="58%" > 
                                            <input type="text"  name="txt_sincedate" maxlength="15" size="20" value="<%=Helper.correctNull((String)hshValues.get("since"))%>" />
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="42%" >Contact Person Name</td>
                                          <td width="58%" > 
                                            <input type="text" name="txt_contactname" maxlength="50" 
											onKeyPress="notAllowSplChar()" size="20" value="<%=Helper.correctNull((String)hshValues.get("contactname"))%>">
                                          </td>
                                        </tr>
                                        <tr>
                                          <td width="42%" >Contact Person Land 
                                            line Number</td>
                                          <td width="58%" > 
                                            <input type="text" name="txt_contact_landline" maxlength="25" 
											onKeyPress="allowPhone()" size="20" value="<%=Helper.correctNull((String)hshValues.get("contact_landline"))%>">
                                          </td>
                                        </tr>
                                      </table>
																		</td>																		
                                    <td  width="48%" valign="top"> 
                                      <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                        <tr> 
                                          <td >Nature of activity</td>
                                          <td > 
                                            <input type="text" name="txt_natureactive" maxlength="60" size="60" value="<%=Helper.correctNull((String)hshValues.get("activity"))%>" />
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td >Address</td>
                                          <td > 
                                            <input type="text" name="txt_address" maxlength="60" size="60" value="<%=Helper.correctNull((String)hshValues.get("address"))%>" />
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td >Address 1</td>
                                          <td > 
                                            <input type="text"  name="txt_address1" maxlength="60" size="60"  value="<%=Helper.correctNull((String)hshValues.get("address1"))%>"/>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td >City</td>
                                          <td > 
                                            <input type="text"  name="txt_city" maxlength="30" size="20"  value="<%=Helper.correctNull((String)hshValues.get("city"))%>"/>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td >State</td>
                                          <td > 
                                            <input type="text"  name="txt_state" maxlength="30" size="20"  value="<%=Helper.correctNull((String)hshValues.get("state"))%>"/>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td >Pincode</td>
                                          <td > 
                                            <input type="text"  name="txt_pincode" maxlength="30" size="20"  value="<%=Helper.correctNull((String)hshValues.get("pincode"))%>"/>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td >Contact Person Designation</td>
                                          <td >
                                            <input type="text" name="txt_contact_per_design" maxlength="50" 
											onKeyPress="notAllowSplChar()"
											size="20" value="<%=Helper.correctNull((String)hshValues.get("contact_per_design"))%>">
                                          </td>
                                        </tr>
                                        <tr>
                                          <td >Contact Person Mobile</td>
                                          <td >
                                            <input type="text" name="txt_contact_mobile" maxlength="15" size="20" 
											onKeyPress="allowPhone()" value="<%=Helper.correctNull((String)hshValues.get("contact_mobile"))%>">
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