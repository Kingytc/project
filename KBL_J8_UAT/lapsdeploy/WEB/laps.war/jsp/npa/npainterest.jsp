<%@include file="../share/directives.jsp"%>
<%	String npa_interest=Helper.correctNull((String)hshValues.get("npa_interest"));
	String npa_intsno=Helper.correctNull((String)hshValues.get("npa_intsno"));%>
<html>
<head>
<title>Interest Rate</title>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>"; 
var current="<%=Helper.getCurrentDateTime()%>";
var npa_interest="<%=npa_interest%>";
var npa_intsno="<%=npa_intsno%>";
var str_interest="<%=Helper.correctNull((String)hshValues.get("str_interest"))%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function call_page(url)
{
	document.location=appUrl+"action/"+url;
}

function showRating()
{
	document.forms[0].txtrate.readonly=true;
	document.forms[0].txtcircrefno.readonly=true;
	document.forms[0].circulartext.readonly=true;
	var purl = appUrl+"action/bobintsel.jsp?hidBeanGetMethod=getNpainterest&hidBeanId=npasetup";
	var prop = 'scrollbars=no,width=700,height=370';	
	var xpos = (screen.width - 450) / 2;
	var ypos = (screen.height - 450) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function showInterest()
{	
	document.forms[0].sel_interest.value="";
	document.forms[0].txtrate.value="";
	document.forms[0].txtcircrefno.value="";
	document.forms[0].txtcircdate.value="";
	document.forms[0].circulartext.value="";
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doNew()
{
	document.forms[0].hidAction.value="Update";
	document.forms[0].txtrate.value="";
	document.forms[0].id.value="";
	document.forms[0].txtcircrefno.value="";
	document.forms[0].txtcircdate.value="";
	document.forms[0].circulartext.value="";
	document.forms[0].dat.value="";
	document.forms[0].txtcircrefno.readOnly=false;
	document.forms[0].circulartext.readOnly=false
	document.forms[0].txtrate.readOnly=false;
	enableButtons(true,true,false,false,true,true);	
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
   		alert("Interest Rate should be with in 0 and 100")
   		document.forms[0].txtrate.value=""; 
    	return;
   		}
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	document.forms[0].txtrate.readOnly=false;
	document.forms[0].txtcircrefno.readOnly=false;
	document.forms[0].circulartext.readOnly=false
	enableButtons(true,true,false,false,false,true);

}
function doSave()
{
	if(document.forms[0].sel_interest.value=="0")
	{
		ShowAlert(111,"Interest Description");
		document.forms[0].sel_interest.focus();
		return;	
	}
	
	if(document.forms[0].txtrate.value=="")
	{
		ShowAlert(112,"Interest Rate");
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
	
	var len = document.forms[0].sel_interest.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_interest.options[i].selected==true)
		 {
			 document.forms[0].sel_interest1.value = document.forms[0].sel_interest.options[i].text; 
			break;
		 }
	}
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanMethod.value="updateNpainterest";
	document.forms[0].hidBeanGetMethod.value="getNpainterest";
	document.forms[0].hidSourceUrl.value="/action/npainterest.jsp";
	document.forms[0].submit();		
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(document.forms[0].sel_interest.value=="0")
		{
			ShowAlert(111,"Interest Description");
			document.forms[0].sel_interest.focus();	
		}
		else	
		{
			if(ConfirmMsg(101))
			{
				document.forms[0].action=appUrl+"controllerservlet";
				document.forms[0].hidBeanId.value="npasetup";
				document.forms[0].hidAction.value="delete";
				document.forms[0].hidBeanMethod.value="updateNpainterest";
				document.forms[0].hidBeanGetMethod.value="getNpainterest";
				document.forms[0].hidSourceUrl.value="/action/npainterest.jsp";
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
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanId.value="npasetup";
		document.forms[0].hidBeanMethod.value="getNpainterest";
		document.forms[0].hidBeanGetMethod.value="getNpainterest";
		document.forms[0].hidSourceUrl.value="/action/npainterest.jsp";
		document.forms[0].submit();
	
	enableButtons(false,false,true,true,true,false);
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
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function getValues()
{
if(document.forms[0].sel_interest.selectedIndex>0)
	{
      
        document.forms[0].hidsno.value=document.forms[0].hidno.value;
		document.forms[0].hidBeanId.value="npasetup"
		document.forms[0].hidBeanGetMethod.value="getNpainterest";
		document.forms[0].hidBeanMethod.value="getNpainterest";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].action=appUrl+"action/npainterest.jsp";
		document.forms[0].submit();
	}
if(document.forms[0].sel_interest.value == "0")
{
	ClearFields();
}

}	
function placeValues()
{

	if(str_interest!="")
	{
		document.forms[0].sel_interest.value=str_interest;
	}
	else
	{
		document.forms[0].sel_interest.value="0";
		document.forms[0].txtrate.value="";
		document.forms[0].txtcircrefno.value="";
		document.forms[0].txtcircdate.value="";
		document.forms[0].circulartext.value="";
	}
	enableButtons(false,false,true,true,true,false);
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

</head>
<body onload="placeValues()">
<form name="workfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; NPA Interest Master</td>
	</tr>
</table>
<br>
<table width="70%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					height="8" align="center" class="outertable">
					<tr>
						<td height="7">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td colspan="4">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td colspan="10">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
													<tr class="dataheader">
														<td  colspan="2"><b>
															Interest Rate </b></td>
													</tr>
													<tr>
														<td colspan="2">
														<table width="100%" border="0" cellspacing="0"
															onBlur="checkpercent()" cellpadding="10" class="outertable">
															<tr>

																<td nowrap="nowrap">Interest Description 
																	<span class="mantatory">*&nbsp;</span>
																</td>
																<td><select name="sel_interest" tabindex="1" onChange="getValues()">
																	<option value="0">--select--</option>
																	 <%String apptype = "30";%>
                      											<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />

																</select></td>

															</tr>
															<tr>
																<td >Interest
																Rate (%) <span class="mantatory">*&nbsp;</span>
																</td>
																<td colspan="2"><lapschoice:CurrencyTag name="txtrate"
																	maxlength="6" tabindex="2" size="15" value='<%=Helper.correctNull((String)hshValues.get("npa_intrate"))%>' 
																	onBlur="intRange()" other="readOnly" /></td>
															</tr>
															<tr>
																<td nowrap="nowrap">Circular
																Reference No
																	<span class="mantatory">*&nbsp;</span> </td>
																<td>
																<table  border="0" class="outertable">
																	<tr>
																		<td nowrap><input type="text" maxlength="30" size=35
																			tabindex="3" name="txtcircrefno" value="<%=Helper.correctNull((String)hshValues.get("npa_circrefno"))%>" 
																			onKeyPress="notAllowSplChar()" readonly>&nbsp;</td>

																		<td nowrap> Circular
																		Date <span class="mantatory">*&nbsp;</span>
																		</td>
																		<td nowrap><input type="text" name="txtcircdate"
																			size="13" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("npa_circdate"))%>" 
																			onBlur="checkDate(this);checkmaxdate(this,current)"
																			readonly></td>
																		<td><a href="#" onClick="callCalender()"
																			title="Click to view calender"><img
																			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
																			border="0" ></a></td>
																	</tr>
																</table>

																</td>

															</tr>
															<tr>
																<td width="21%"> Circular
																Details</td>
																<td colspan="2"><textarea name="circulartext" cols="90"
																	tabindex="5" rows="3" wrap="VIRTUAL" id="circulartext"
																	onkeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(this.form.circulartext,1999);" onKeyUp="textlimit(this,1999)"
																	readonly><%=Helper.correctNull((String)hshValues.get("npa_circtext"))%> </textarea></td>
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
	<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="sel_interest1">
<input type="hidden" name="id" value=""> 
<input type="hidden" name="dat" value=""> 
<input type="hidden" name="hidsno">
<input type="hidden" name="hidno" value="<%=Helper.correctNull((String)hshValues.get("npa_intsno")) %>">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
