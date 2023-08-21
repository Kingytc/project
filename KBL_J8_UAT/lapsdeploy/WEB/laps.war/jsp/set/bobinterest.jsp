<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Interest Rate</title>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>"; 
var appURL="<%=ApplicationParams.getAppUrl()%>"; 
var current="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function call_page(url)
{
	document.location=appUrl+"action/"+url;
}
function showRating()
{
	document.forms[0].txtinterest.readonly=true;	
	document.forms[0].txtrate.readonly=true;
	document.forms[0].txtcircrefno.readonly=true;
	document.forms[0].circulartext.readonly=true;
	document.forms[0].selactive.disabled=true;
	var purl = appUrl+"action/bobintsel.jsp?hidBeanGetMethod=getDataHelp&hidBeanId=bobinterest";
	var prop = 'scrollbars=no,width=700,height=370';	
	var xpos = (screen.width - 450) / 2;
	var ypos = (screen.height - 450) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}

function enableButtons1(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool6;
}

function doNew()
{
	document.all.link.style.visibility="hidden";
	document.forms[0].txtinterest.value="";
	document.forms[0].txtrate.value="";
	document.forms[0].id.value="";
	document.forms[0].txtcircrefno.value="";
	document.forms[0].txtcircdate.value="";
	document.forms[0].circulartext.value="";
	document.forms[0].dat.value="";
	document.forms[0].txtinterest.readOnly=false;
	document.forms[0].txtcircrefno.readOnly=false;
	document.forms[0].circulartext.readOnly=false
	document.forms[0].txtrate.readOnly=false;
	document.forms[0].selactive.disabled=false;
	enableButtons1(true,true,false,false,true,true);
	document.forms[0].txtinterest.focus();
}

function callCalender()
{
	if(document.forms[0].cmdedit.disabled)
	{
		showCal(appUrl,'txtcircdate');
	}
}
function intRange()
{
	if(document.forms[0].txtrate.value>100  || document.forms[0].txtrate.value==0 )
	{
		alert("Interest Rate should be with in 0 and 100");
		document.forms[0].txtrate.value=""; 
	   	document.forms[0].txtrate.focus(); 
	   	return;
  	}
}
function doEdit()
{
	document.forms[0].txtinterest.readOnly=false;
	document.forms[0].txtrate.readOnly=false;
	document.forms[0].txtcircrefno.readOnly=false;
	document.forms[0].circulartext.readOnly=false
	document.forms[0].selactive.disabled=false;
	enableButtons1(true,true,false,false,false,true);
}
function doSave()
{
	if(trim(document.forms[0].txtinterest.value)=="")
	{
		ShowAlert(112,"Interest Description");
		document.forms[0].txtinterest.focus();
		return;		
	}
	if(document.forms[0].txtrate.value=="")
	{
		ShowAlert(112,"Interest Rate");
		document.forms[0].txtrate.focus();
		return;
	}
	if(document.forms[0].txtrate.value>100  || document.forms[0].txtrate.value==0 )
	{
		alert("Interest Rate should be with in 0 and 100");
		document.forms[0].txtrate.value=""; 
	   	document.forms[0].txtrate.focus(); 
	   	return;
  	}
	if(trim(document.forms[0].txtcircrefno.value)=="")
	{
		ShowAlert(112,"Circular Reference Number");
		document.forms[0].txtcircrefno.focus();
		return;
	}	
	if(document.forms[0].txtcircdate.value=="")
	{
		ShowAlert(111,"Circular Date");
		document.forms[0].txtcircdate.focus();
		return;
	}	
	
	var msg="";
	if(document.forms[0].txtrate.value == document.forms[0].txtrate_old.value)
	{
		msg ="";
	}
	else
	{
		msg = "You want to change the Interest rate from "+document.forms[0].txtrate_old.value+"% to "+document.forms[0].txtrate.value+"% and this will change the interest rate in all the products as well as the open/pending proposals. Do you want to Continue?";
		document.forms[0].hidIdChange.value="Y";	
	}
	
	if (document.forms[0].id.value!="" && msg!="")
	{
		if(confirm(msg))
		{
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].hidBeanId.value="bobinterest";
			document.forms[0].hidAction.value="update";
			document.forms[0].hidRecordflag.value=varRecordFlag;
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanGetMethod.value="getDataHelp";
			document.forms[0].hidSourceUrl.value="/action/bobinterest.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].hidIdChange.value="";
			return false;
		}			
	}
	else if (document.forms[0].id.value!="")
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanId.value="bobinterest";
		document.forms[0].hidAction.value="update";
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getDataHelp";
		document.forms[0].hidSourceUrl.value="/action/bobinterest.jsp";
		document.forms[0].submit();			
	}
	else if(document.forms[0].id.value=="")
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanId.value="bobinterest";
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getDataHelp";
		document.forms[0].hidSourceUrl.value="/action/bobinterest.jsp";
		document.forms[0].submit();
	}		
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(document.forms[0].txtinterest.value=="")
		{
			ShowAlert(111,"Interest Description");
			document.forms[0].txtinterest.focus();	
		}
		else	
		{
			if(ConfirmMsg(101))
			{
				document.forms[0].action=appUrl+"controllerservlet";
				document.forms[0].hidBeanId.value="bobinterest";
				document.forms[0].hidAction.value="delete";
				document.forms[0].hidBeanMethod.value="updateData";
				document.forms[0].hidBeanGetMethod.value="getDataHelp";
				document.forms[0].hidSourceUrl.value="/action/bobinterest.jsp";
				document.forms[0].submit();
			}
		}
	}
	else
	{		
		ShowAlert(158);
	}
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.all.link.style.visibility="visible";
		document.forms[0].txtinterest.value="";
		document.forms[0].txtrate.value="";
		document.forms[0].txtcircrefno.value="";
		document.forms[0].txtcircdate.value="";
		document.forms[0].circulartext.value="";	
		document.forms[0].txtinterest.readOnly=true;
		document.forms[0].txtrate.readOnly=true;
		document.forms[0].txtcircrefno.readOnly=true;
		document.forms[0].circulartext.readOnly=true;
		document.forms[0].selactive.disabled=true;
		enableButtons1(false,true,true,true,true,false);
	}
}
function checkpercent()
{
	if(document.forms[0].txtrate.value>100  || document.forms[0].txtrate.value==0 )
 	{
	  	alert("Interest Rate should be with in 100 Percentage or not eual to zero")
	  	document.forms[0].txtrate.value=""; 
	   	document.forms[0].txtrate.focus(); 
	   	return;
  	} 
}
function doClose()
{
	if (ConfirmMsg(100))
	{
		call_page('setupnav.jsp');
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
</head>
<body>	
<form name="workfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">	
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Interest Index</td>
	</tr>
</table>
<br>
<table width="70%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1 tableBg">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td colspan="4" >
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td colspan="10">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
													<tr>
														<td  colspan="2" class="setuphead"><b>Interest Rate </b></td>
													</tr>
													<tr>
														<td colspan="2">
														<table width="100%" border="0" cellspacing="0" onBlur="checkpercent()" cellpadding="10" class="outertable">
															<tr>																
                                                <td width="21%" >Interest Description<b><span class="mantatory">*&nbsp;</span></b></td>
																<td><input type="text" maxlength="100"
																	size="70" name="txtinterest" tabindex="1"
																	onkeypress="notAllowSplChar()" readonly>
																<span onClick="showRating()" style="cursor:hand" id="link"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
																</td>
															</tr>
															<tr>																
                                                <td width="21%">Interest Rate (%) <b><span class="mantatory">*&nbsp;</span></b> 
                                                  </td>
																<td colspan="2">																	
																	<input type="text" name="txtrate"  maxlength="5" onBlur="checkPercentage(this)" tabindex="2" size="15" style= "text-align:right;"> 																	
																	<input type="hidden" name="txtrate_old" value=""> 																	
																	</td>
															</tr>
															<tr>																
                                                <td>Circular Reference No <b><span class="mantatory">*&nbsp;</span></b> 
                                                  </td>
																<td>
																<table width="250" border="0" class="outertable">
																	<tr>
																		<td nowrap><input type="text" maxlength="30" size=35 tabindex="3"
																			name="txtcircrefno"
																			onKeyPress="notAllowSplChar()" readonly>&nbsp;</td>
																		
                                                      <td nowrap>Circular 
                                                        Date <b><span class="mantatory">*&nbsp;</span></b> 
                                                        </td>
																		<td nowrap><input type="text" name="txtcircdate" 
																			size="13" maxlength="10"
																			onBlur="checkDate(this);checkmaxdate(this,current)"
																			readonly></td>
																		<td><a href="#" onClick="callCalender()"
																			title="Click to view calender" border=0><img
																			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
																			border="0" tabindex="4"></a></td>
																	</tr>
																</table>

																</td>

															</tr>
															<tr>
																<td width="21%">Circular
																Details </td>
																<td colspan="2"><textarea name="circulartext" cols="90" tabindex="5"
																	rows="3" wrap="VIRTUAL" id="circulartext" onkeyPress="notAllowSingleQuote();textlimit(this,250)" onkeyup="checkTextArealimit(this,250)" readonly></textarea></td>
															</tr>
															
															<tr>
																<td width="21%">Active<b><span class="mantatory">*&nbsp;</span></b></td>
																<td colspan="2"><select name="selactive" disabled>
							                                      	<option value="Y" selected>Yes</option>
							                                      	<option value="N">No</option>
							                                      </select></td>
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

		</td>
	</tr>
</table>
<br>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="dat" value="">
 <input type ="hidden" name ="hidkeyid" value="set">
 <input type="hidden" name="id">
 <input type="hidden" name="cmddelete">
 <input type="hidden" name="hidIdChange">
 </form>
</body>
</html>
