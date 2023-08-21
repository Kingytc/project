<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var select1="<%=Helper.correctNull((String)hshValues.get("mon_roc"))%>";
var select2="<%=Helper.correctNull((String)hshValues.get("mon_dbc"))%>";
var select3="<%=Helper.correctNull((String)hshValues.get("mon_guarantor"))%>";
var select4="<%=Helper.correctNull((String)hshValues.get("mon_guarantorsigned"))%>";
var select5="<%=Helper.correctNull((String)hshValues.get("mon_equitable"))%>";
var select6="<%=Helper.correctNull((String)hshValues.get("mon_equitperfect"))%>";
var select7="<%=Helper.correctNull((String)hshValues.get("mon_checkmsod"))%>";
var select8="<%=Helper.correctNull((String)hshValues.get("mon_checkstock"))%>";
var select9="<%=Helper.correctNull((String)hshValues.get("mon_checkbkdebts"))%>";
var select10="<%=Helper.correctNull((String)hshValues.get("mon_checkqpr"))%>";
var selinspection="<%=Helper.correctNull((String)hshValues.get("mon_inspection"))%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var varOrgLev = "<%=strOrgLevel%>";

function disableCommandButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
		document.forms[0].cmdedit.disabled=cmdedit;
		document.forms[0].cmddelete.disabled=cmddelete;
		document.forms[0].cmdsave.disabled=cmdsave;
		document.forms[0].cmdcancel.disabled=cmdcancel;
		document.forms[0].cmdclose.disabled=cmdclose;	
}
function callCalender(fname)
 {
	 if(document.forms[0].cmdsave.disabled==false)
	 {
	 	showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	 }	
 }

function onLoading()
{
	disableFields(true);
	if(varOrgLev != 'A')
	{
		disableCommandButtons(true,true,true,true,false);
	}
	else
	{
		disableCommandButtons(false,true,true,true,false);
	}
	
	if(select1!="")
	{
	    document.forms[0].sel_roc.value=select1;		
	}
	else
	{
	    document.forms[0].sel_roc.value="n";	
	}
	if(select2!="")
	{
	    document.forms[0].sel_dbc.value=select2;
	}
	else
	{
	    document.forms[0].sel_dbc.value="n";
	}
	if(select5!="")
	{
	    document.forms[0].sel_equitable.value=select5;
	}
	else
	{
	    document.forms[0].sel_equitable.value="n";	
	}
	if(select6!="")
	{
	    document.forms[0].sel_equitperfect.value=select6;		
	}
	else
	{
	    document.forms[0].sel_equitperfect.value="n";	
	}
	if(select7!="")
	{
	    document.forms[0].sel_msod.value=select7;		
	}
	else
	{
	    document.forms[0].sel_msod.value="n";	
	}
	if(select8!="")
	{
	    document.forms[0].sel_stock.value=select8;		
	}
	else
	{
	    document.forms[0].sel_stock.value="n";	
	}
	if(select9!="")
	{
	    document.forms[0].sel_bookdebts.value=select9;		
	}
	else
	{
	    document.forms[0].sel_bookdebts.value="n";	
	}
	if(select10!="")
	{
	    document.forms[0].sel_qpr.value=select10;		
	}
	else
	{
	    document.forms[0].sel_qpr.value="n";	
	}
	showROC();
	showDBC();
	showEquitable();
	showmsod();
}
function doDelete()
{
	if(varRecordflag == "Y"){
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatemonitorchecklist";
		document.forms[0].hidBeanGetMethod.value="getmonitorchecklist";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="action/mon_checklist.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
	}
}
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,false,false,false,true);	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidBeanGetMethod.value="getmonitorchecklist";
		document.forms[0].action=appURL+"action/mon_checklist.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();

	}	
}

function doSave()
	{
	
	if(checktrim(document.forms[0].sel_roc.value)=="y")
	{
	  if(document.forms[0].txt_rocdate.value=="")
	 {
	  	document.forms[0].txt_rocdate.focus();
	  	ShowAlert('121',"Date of ROC");
	  	return false;
	  	}
	
	 if(document.forms[0].txt_resoludate.value=="")
	 {
	  	document.forms[0].txt_resoludate.focus();
	  	ShowAlert('121',"Date of Resolution");
	  	return false;
	  	}
	}	
	
	if(checktrim(document.forms[0].sel_dbc.value)=="y")
	{
	  if(document.forms[0].txt_dbcdate.value=="")
	 {
	  	document.forms[0].txt_dbcdate.focus();
	  	ShowAlert('121',"Date of DBC");
	  	return false;
		}
	
	 if(document.forms[0].txt_dbcamount.value=="")
	 {
	  	document.forms[0].txt_dbcamount.focus();
	  	ShowAlert('121',"Amount of DBC");
	  	return false;
	  	}
	}	
	document.forms[0].hidRecordflag.value = varRecordflag;
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidBeanMethod.value="updatemonitorchecklist";
	document.forms[0].hidBeanGetMethod.value="getmonitorchecklist";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/mon_checklist.jsp";
	document.forms[0].submit();
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
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();		
	}
}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function showROC()
{
	if(document.forms[0].sel_roc.value=="y")
	{
		document.all.a1.style.visibility="visible";
		document.all.a2.style.visibility="visible";
		document.all.a3.style.visibility="visible";
		document.all.a4.style.visibility="visible";
	}
	else
	{
		document.all.a1.style.visibility="hidden";
		document.all.a2.style.visibility="hidden";
		document.all.a3.style.visibility="hidden";
		document.all.a4.style.visibility="hidden";
		document.forms[0].txt_rocdate.value="";
		document.forms[0].txt_resoludate.value="";
	}
}
function showDBC()
{
	if(document.forms[0].sel_dbc.value=="y")
	{
		document.all.b1.style.visibility="visible";
		document.all.b2.style.visibility="visible";
		document.all.b3.style.visibility="visible";
		document.all.b4.style.visibility="visible";
	}
	else
	{
		document.all.b1.style.visibility="hidden";
		document.all.b2.style.visibility="hidden";
		document.all.b3.style.visibility="hidden";
		document.all.b4.style.visibility="hidden";
		document.forms[0].txt_dbcdate.value="";
		document.forms[0].txt_dbcamount.value="";
	}
}
function showEquitable()
{
	if(document.forms[0].sel_equitable.value=="y")
	{
		document.all.d1.style.visibility="visible";
		document.all.d2.style.visibility="visible";
	}
	else
	{
		document.all.d1.style.visibility="hidden";
		document.all.d2.style.visibility="hidden";
		document.forms[0].sel_equitperfect.value="n";
	}
}
function showmsod()
{
	if(document.forms[0].sel_msod.value=="y")
	{
		document.all.s1.style.visibility="visible";
		document.all.s2.style.visibility="visible";
		document.all.s1.style.position="relative";
		document.all.s2.style.position="relative";
	}
	else if(document.forms[0].sel_msod.value=="n")
	{
		document.all.s1.style.visibility="hidden";
		document.all.s2.style.visibility="hidden";
		document.all.s1.style.position="absolute";
		document.all.s2.style.position="absolute";
	}
	else
	{
		document.all.s1.style.visibility="hidden";
		document.all.s2.style.visibility="hidden";
		document.all.s1.style.position="absolute";
		document.all.s2.style.position="absolute";
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<lapschoice:monitortag pageid="6" />
<span class="page_flow">Home -&gt; Monthly Monitoring	Reports-&gt;Monitoring Register-&gt;Monitoring Check List</span>
<lapschoice:Monitor strSource="MREG" />
<table width="79%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center">
			<tr>
				<td colspan="2"  rowspan="2">Charge with ROC Registered</td>
				<td width="15%" align="center" rowspan="2"><select
					name="sel_roc" tabindex="1" onChange="showROC()">
					<option value="y">Yes</option>
					<option value="n">No</option>
					<option value="na">Not Applicable</option>
				</select></td>
				<td width="23%" id="a1" >Date of ROC</td>
				<td width="17%" id="a2" ><a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_rocdate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"> <input type="text"
					name="txt_rocdate" size="12" maxlength="10"
					style="text-align:left;border-style=groove"
					onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String)hshValues.get("mon_rocdate"))%>"
					onBlur="checkDate(this)"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender" tabindex="2"></a></td>
			</tr>
			<tr>
				<td width="23%" id="a3">Date of Resolution</td>
				<td width="17%" id="a4"><a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_resoludate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"> <input type="text"
					name="txt_resoludate" size="12" maxlength="10"
					style="text-align:left;border-style=groove"
					onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String)hshValues.get("mon_resolutiondate"))%>"
					onBlur="checkDate(this)"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender" tabindex="3"></a></td>
			</tr>
			<tr>
				<td colspan="2" rowspan="2">Whether DBC obtained</td>
				<td width="15%" align="center" rowspan="2"><select name="sel_dbc"
					tabindex="4" onChange="showDBC()">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
				<td id="b1" width="23%" >Date of DBC</td>
				<td id="b2" width="17%" ><a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_dbcdate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"> <input type="text"
					name="txt_dbcdate" size="12" maxlength="10"
					style="text-align:left;border-style=groove"
					onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String)hshValues.get("mon_dbcdate"))%>"
					onBlur="checkDate(this)"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender" tabindex="5"></a></td>
			</tr>
			<tr>
				<td id="b3" width="23%" >Amount of DBC</td>
				<td id="b4" width="17%" ><lapschoice:CurrencyTag
					name="txt_dbcamount" tabindex="6" size="20" maxlength="15"
					value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mon_dbcamount"))))%>' />
				</td>
			</tr>
			<tr>
				<td colspan="2">Whether equitable mortgage applicable</td>
				<td width="15%" align="center"><select name="sel_equitable"
					tabindex="9" onChange="showEquitable()">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
				<td width="23%" id="d1">Equitable mortgage perfected</td>
				<td width="17%" id="d2"><select name="sel_equitperfect"
					tabindex="10">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
			</tr>
			<tr>
				<td colspan="2" >Whether MSOD to be obtained</td>
				<td width="15%" align="center" ><select name="sel_msod"
					tabindex="11" onChange="showmsod()">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
				<td colspan="2" >&nbsp;</td>
			</tr>
			<tr id="s1">
				<td colspan="2" >Stock statement to be obtained?</td>
				<td width="15%" align="center" ><select name="sel_stock"
					tabindex="12">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
				<td colspan="2" >&nbsp;</td>
			</tr>
			<tr id="s2">
				<td colspan="2" >Book Debts to be obtained?</td>
				<td width="15%" align="center" ><select
					name="sel_bookdebts" tabindex="13">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
				<td colspan="2" >&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" >Whether QPR to be Obtained?</td>
				<td width="15%" align="center" ><select name="sel_qpr"
					tabindex="14">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
				<td colspan="2" >&nbsp;</td>
			</tr>
		</table>
		</td>
		</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'
	btnnames='Edit_Save_Cancel_Delete_Audit Trail' /> <br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidkeyid"  value ="<%=Helper.correctNull((String)hshValues.get("strCustAccno")) %>">
</form>
</body>
</html>

