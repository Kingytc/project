<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
	String strcat = "";
	if (!strCategoryType.equalsIgnoreCase("")) {
		if (strCategoryType.equalsIgnoreCase("OPS")) {
			strcat = "Tertiary";
		} else {
			strcat = "Corporate";
		}
	}
%>
<html>
<head>
<title>Valuation Entry</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strsno="<%=Helper.correctNull((String) hshValues.get("strsno"))%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function doClose()
{	
	var con=ConfirmMsg('100');
	if(con)
	{		
		document.forms[0].action=appURL+"action/agrpage.jsp";
		document.forms[0].submit();		
	}
}

function callvaluerName()
{
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/valuerslist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getValuerMasterList&strfrom=ValuerEntry&hidAction=search&hidAppVal=V";
		window.open(url,"",prop);
	}
}

function onloading()
{
	disablefields(true);
	document.forms[0].hidMethod.value="getGeneralDetails";
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].value="";
		}	  
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}		
	}
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!one;
		}
	}

	if(document.forms[0].sel_branchpanel.value=="Y")
	{	
		document.all.b1.style.visibility="visible";
		document.forms[0].txt_name.readOnly=true;
		
	}
	else if(document.forms[0].sel_branchpanel.value=="N")
	{
		document.all.b1.style.visibility="hidden";
		document.forms[0].txt_name.readOnly=false;
	}	
}

function doNew() 
{	
	document.forms[0].hidAction.value="New";
	document.forms[0].hideditflag.value="Y";
	enableButtons(true, true, false, false, true);
	disablefields(false);
	ClearFields();
}

function doEdit() 
{
  disablefields(false);
  document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="Edit"
	enableButtons(true, true, false, false, true);
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="perpropertydetails";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateValuerEntryData";
		  	document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
			document.forms[0].hidSourceUrl.value="/action/ops_valuationentry.jsp";
			document.forms[0].submit();
		}		
	}
	else
	{
		ShowAlert(158);
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');	
	if(varconfirm)
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].action=appURL+"action/ops_valuationentry.jsp";	
		document.forms[0].submit();
	}
}

function doSave()
{ 	
	if(trim(document.forms[0].txt_dateofsent.value)=="")
	{
		ShowAlert('121','Date Sent');
		document.forms[0].txt_dateofsent.focus();
		return;
	}	
	if(document.forms[0].txt_name.value=="")
	{
		alert("Select the Valuer Name");
		return;
	}
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidBeanMethod.value="updateValuerEntryData";
	document.forms[0].hidBeanGetMethod.value="getValuerEntryData";
	document.forms[0].hidSourceUrl.value="/action/ops_valuationentry.jsp";	
	document.forms[0].submit();
}

function compareDate()
{
	var d1 = document.forms[0].txt_dateofsent.value;
	d1 = changeDateformat(d1);
	var d2 = document.forms[0].txt_dateofvaluation.value;
	d2 = changeDateformat(d2);
	if(document.forms[0].txt_dateofvaluation.value != "")
	{
		if( d1 > d2 )
		{
			alert("Date of Received should not less than Date of Sent");
			document.forms[0].txt_dateofvaluation.focus();	
			document.forms[0].txt_dateofvaluation.value="";
		}
	}
}

function callCalender(fname)
{
	var action  =document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled == false)
	{
		showCal(appURL,fname);
	}	
}

function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16, val17)
{	
	document.forms[0].hidslno.value=val2;
	document.forms[0].txt_dateofentry.value=val3;
	document.forms[0].hidsno.value=val4;
	document.forms[0].txt_Certificationno.value=val5;
	document.forms[0].txt_CertDate.value=val6;
	document.forms[0].txt_landvalue.value=val7;
	document.forms[0].txt_estimatedvalue.value=val9;
	document.forms[0].txt_comments.value=val10;
	document.forms[0].txt_dateofsent.value=val14;
	document.forms[0].txt_name.value=val16;	
	document.forms[0].txt_dateofvaluation.value=val11;
	document.forms[0].txt_refrate.value=val12;
	document.forms[0].txt_guirate.value=val13;
	if(val17=="Y")
	{
	val17="Y";
	}
	else
	{
		val17="N";
	}
	document.forms[0].sel_branchpanel.value=val17;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		enableButtons(true,false,true,false,false,false);
	}	
	if(document.forms[0].sel_branchpanel.value=="Y")
	{	
		document.all.b1.style.visibility="visible";
	}
	else if(document.forms[0].sel_branchpanel.value=="N")
	{
		document.all.b1.style.visibility="hidden";
	}
}

function callVehicleDetails()
{
	document.forms[0].hidBeanGetMethod.value="getAllVehicleDetails";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ops_vehicledetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callFunction(pagename,methodname,param,tabname)
{
	if(methodname=="getGeneralDetails")
	{
		document.forms[0].hidparam.value =param;
	}
	document.forms[0].method="post";	
	document.forms[0].hidTabName.value=tabname;	
	document.forms[0].hidMethod.value=methodname;	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function selLawyerNme()
{
	if(document.forms[0].sel_branchpanel.value=="Y")
	{	
		document.all.b1.style.visibility="visible";
		document.forms[0].txt_name.readOnly=true;
		
		document.forms[0].txt_name.value="";
		document.forms[0].hidsno.value="";
	}
	else if(document.forms[0].sel_branchpanel.value=="N")
	{
		document.all.b1.style.visibility="hidden";
		document.forms[0].txt_name.readOnly=false;
		
		document.forms[0].txt_name.value="";
		document.forms[0].hidsno.value="";
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
<lapschoice:borrowertype />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; <%=strcat%> -&gt;
		Application-&gt; Proposed / Offered Asset -&gt; Valuation Entry</td>
	</tr>
</table>
<lapschoice:application />
<lapschoice:ssiassestdetails tabid="6" />
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr class="dataheader">
						<td colspan="9"><b>Valuation Entry</b></td>
					</tr>
					<tr>
						<td width="15%" colspan="2">Date Sent<b><span class="mantatory">*&nbsp;</span></b>
						</td>
						<td colspan="2">
						<table border="0" cellspacing="0" cellpadding="3" width="30%" class="outertable">
							<tr>
								<td><input type="text" name="txt_dateofsent" size="11"
									maxlength="10" tabindex="1"
									value="<%=Helper.correctNull((String) hshValues.get("send_date"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentdate);"></td>
								<td><a href="#" onClick="callCalender('txt_dateofsent')"
									title="Click to view calender" border="0"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="2"></a></td>
							</tr>
						</table>
						</td>
						<td colspan="2">Date Received</td>
						<td>
						<table border="0" cellspacing="0" cellpadding="3" width="30%" class="outertable">
							<tr>
								<td><input type="text" name="txt_dateofvaluation" size="11"
									maxlength="10" tabindex="3"
									value="<%=Helper.correctNull((String) hshValues
									.get("valuation_dt"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentdate);compareDate();">
								</td>
								<td><a href="#" onClick="callCalender('txt_dateofvaluation')"
									title="Click to view calender" border="0"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="4"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2">Date of Entry</td>
						<td colspan="2">
						<table border="0" cellspacing="0" cellpadding="3" width="30%" class="outertable">
							<tr>
								<td><input type="text" name="txt_dateofentry" size="11"
									maxlength="10" tabindex="5"
									value="<%=Helper.correctNull((String) hshValues.get("entry_date"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentdate);"></td>
								<td><a href="#" onClick="callCalender('txt_dateofentry')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="6"></a></td>
							</tr>
						</table>
						</td>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width="15%" colspan="2">Reference Rate (in <%=ApplicationParams.getCurrency()%>)</td>
						<td colspan="2"><lapschoice:CurrencyTag name="txt_refrate"
							size="18" maxlength="15" tabindex="7"
							value='<%=Helper.correctNull((String) hshValues
									.get("reference_rt"))%>' />
						</td>
						<td colspan="2">Guidance Rate (in <%=ApplicationParams.getCurrency()%>)</td>
						<td><lapschoice:CurrencyTag name="txt_guirate" size="18"
							maxlength="15" tabindex="8"
							value='<%=Helper.correctNull((String) hshValues
									.get("guidance_rt"))%>' />
						</td>
					</tr>
					<tr>
						<td colspan="2" nowrap="nowrap">Whether on the branch panel?</td>
						<td nowrap="nowrap" width="31%" colspan="2"><select name="sel_branchpanel"
							tabindex="13" onChange="selLawyerNme()">
							<option value="Y" selected="selected">Yes</option>
							<option value="N">No</option>
						</select></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width="15%" colspan="2">Valuer Name <b> <span class="mantatory">*&nbsp;</span></b>
						</td>
						<td width="10%"><input type="text" name="txt_name" size="38" maxlength="50"
							tabindex="9"
							value="<%=Helper.correctNull((String) hshValues
									.get("valuers_name"))%>"
							onKeyPress="notAllowedDouble()"> <input type="hidden"
							name="hidsno" size="38" maxlength="50" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues
									.get("valuers_code"))%>">

						</td>
						<td width="5%" id="b1"><span onClick="javascript:callvaluerName()"
							style="cursor:hand"><b><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="10"></b></span></td>
						<td width="30%"  colspan="2">Letter /Certification Number</td>
						<td  width="20%">
						<table border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td><input type="text" name="txt_Certificationno" size="15"
									maxlength="10" tabindex="11"
									value="<%=Helper.correctNull((String) hshValues.get("let_cer_no"))%>"
									onKeyPress="notAllowSplChar()"></td>
								<td>
								<table border="0" cellspacing="0" cellpadding="3" width="30%" class="outertable">
									<tr>
										<td><input type="text" name="txt_CertDate" size="11"
											maxlength="10" tabindex="12"
											value="<%=Helper.correctNull((String) hshValues
									.get("let_cer_date"))%>"
											onBlur="checkDate(this);checkmaxdate(this,currentdate);"></td>
										<td><a href="#" onClick="callCalender('txt_CertDate')"
											title="Click to view calender" border="0"> <img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0" tabindex="13"></a></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>

						<td>Market Value for the Asset.</td>
						<td><%=ApplicationParams.getCurrency()%></td>
						<td colspan="2"><lapschoice:CurrencyTag name="txt_landvalue"
							size="18" maxlength="15" tabindex="17"
							value='<%=Helper.correctNull((String) hshValues
							.get("mark_val_land"))%>' />
						</td>
						<td>Estimated value on Forced Sale</td>
						<td><%=ApplicationParams.getCurrency()%></td>
						<td><lapschoice:CurrencyTag name="txt_estimatedvalue" size="18"
							maxlength="15" tabindex="19"
							value='<%=Helper.correctNull((String) hshValues
							.get("esti_val_force"))%>' />
						</td>
					</tr>
					<tr>

						<td rowspan="3" colspan="2">Remark/Note of the Value</td>
						<td rowspan="3" colspan="2"><textarea name="txt_comments"
							cols="45" tabindex="28" rows="3" wrap="VIRTUAL" onKeyPress="textlimit(this,299)" onKeyUp="textlimit(this,299)"
><%=Helper.correctNull((String) hshValues
									.get("remark_note"))%></textarea></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>
		 <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>'/> 
		<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="98.3%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
					<tr class="dataheader">
						<td width="5%"><b></b></td>
						<td width="25%" align="center" nowrap="nowrap"><b>Date Sent</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Valuer's Name</b></td>
						<td width="25%" align="center" nowrap="nowrap"><b>Certification No.</b></td>
						<td width="25%" align="center" nowrap="nowrap"><b>Certification Date</b></td>
					</tr>				
					<%
										ArrayList g1 = new ArrayList();
										ArrayList v = (ArrayList) hshValues.get("vecRow");
										if (v != null) {
											int vecsize = v.size();
											for (int l = 0; l < vecsize; l++) {
												g1 = (ArrayList) v.get(l);
									%>
					<tr valign="top" class="datagrid">
						<td width="5%" align="left"><input type="radio"
							onclick="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>',
																'<%=Helper.correctNull((String) g1.get(2))%>','<%=Helper.correctNull((String) g1.get(3))%>',
																'<%=Helper.correctNull((String) g1.get(4))%>','<%=Helper.correctNull((String) g1.get(5))%>',
																'<%=nf.format(Double.parseDouble(Helper.correctDouble((String) g1.get(6))))%>','<%=Helper.correctNull((String) g1.get(7))%>',
																'<%=nf.format(Double.parseDouble(Helper.correctDouble((String) g1.get(8))))%>','<%=Helper.replaceForJavaScriptString((String) g1.get(9))%>',
																 '<%=Helper.correctNull((String) g1.get(10))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String) g1.get(11))))%>',
																 '<%=nf.format(Double.parseDouble(Helper.correctDouble((String) g1.get(12))))%>','<%=Helper.correctNull((String) g1.get(13))%>',
																 '<%=Helper.correctNull((String) g1.get(14))%>','<%=Helper.correctNull((String) g1.get(15))%>',
																 '<%=Helper.correctNull((String) g1.get(16))%>','<%//=Helper.correctNull((String)g1.get(17))%>',
																 '<%//=Helper.correctNull((String)g1.get(18))%>','<%//=Helper.correctNull((String)g1.get(19))%>',
																 '<%//=Helper.correctNull((String)g1.get(20))%>','<%//=Helper.correctNull((String)g1.get(21))%>',
																 '<%//=Helper.correctNull((String)g1.get(22))%>','<%//=Helper.correctNull((String)g1.get(23))%>',
																 '<%//=Helper.correctNull((String)g1.get(24))%>','<%//=Helper.correctNull((String)g1.get(25))%>',
																 '<%//=Helper.correctNull((String)g1.get(26))%>')"
							name="radiobutton"
							value="<%=Helper.correctNull((String) g1
											.get(1))%>"
							style="border:none"> &nbsp;</td>
						<td width="25%" align="center"><%=Helper.correctNull((String) g1.get(13))%></td>
						<td width="20%"><%=Helper.correctNull((String) g1.get(15))%></td>
						<td width="25%"><%=Helper.correctNull((String) g1
											.get(4))%></td>
						<td width="25%" align="center"><%=Helper.correctNull((String) g1
											.get(5))%>&nbsp;</td>
					</tr>
					<%
						}
						}
					%>
					<tr class="datagrid">
						<td align="center" width="5%">&nbsp;</td>
						<td width="25%">&nbsp;</td>
						<td width="20%">&nbsp;</td>
						<td width="25%">&nbsp;</td>
						<td width="25%">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidslno" value="<%=Helper.correctNull((String) hshValues
									.get("strsno"))%> "> 
<input type="hidden" name="hidmastid" value="">
</form>
</body>
</html>
