<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
			ArrayList vecCol = new ArrayList();
			java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}	
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="disabled")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
}
function selectValues(val1,val2,val3,val5,val6,val7,val8,val10,i,size)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_type_applicant.value=val2;
	document.forms[0].txt_name_applicant.value=val3;
	document.forms[0].txt_renew_means.value=val5;
	document.forms[0].txt_renew_date.value=val6;
	document.forms[0].txt_present_means.value=val7;
	document.forms[0].txt_present_date.value=val8;
	if(size==1)
	{
		document.forms[0].txt_present_activity.value=document.forms[0].hidactivity.value;
	}
	else
	{
		document.forms[0].txt_present_activity.value=document.forms[0].hidactivity[i].value;
	}
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		disableCommandButtons("radioselect"); 
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidmoduletype.value="OTSCO";
	disableCommandButtons("edit");
	document.forms[0].sel_type_applicant.focus();	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hidmoduletype.value="OTSCO";
	disableCommandButtons("edit");	
	document.forms[0].sel_type_applicant.focus();	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidmoduletype.value="OTSCO";
		document.forms[0].hidSourceUrl.value="/action/npacompromise_means.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}
function doSave()
{
	var selapptype=document.forms[0].sel_type_applicant.options[document.forms[0].sel_type_applicant.selectedIndex].value;
	if(selapptype=='s')
	{
		alert("select Applicant Type");
		document.forms[0].sel_type_applicant.focus();
		return ;
	}
	if(document.forms[0].sel_type_applicant.value=="0")
	{
		alert("Select the Type of Applicant");
		document.forms[0].sel_type_applicant.focus();
		return;
	}
	if(document.forms[0].txt_present_means.value=="")
	{
		alert("Enter the Present Position - Amount");
		document.forms[0].txt_present_means.focus();
		return;
	}
	if(document.forms[0].txt_present_date.value=="")
	{
		alert("Enter the Present Position - Date");
		document.forms[0].txt_present_date.focus();
		return;
	}
		document.forms[0].hidAppType.value = document.forms[0].sel_type_applicant[document.forms[0].sel_type_applicant.selectedIndex].text;
		document.forms[0].hidmoduletype.value="OTSCO";
		document.forms[0].hidSourceUrl.value="/action/npacompromise_means.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidmoduletype.value="OTSCO";
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/npacompromise_means.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateBorrwerDetails";
		document.forms[0].hidBeanGetMethod.value="getBorrowerDetails";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
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
function onLoading()
{
	disableCommandButtons("onload"); 
	disableFields(true);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);		
	}
}
function callLink(page,bean,method)
 {
 	if (document.forms[0].cmdsave.disabled)
	{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].hidmoduletype.value="OTSCO";
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
	}
	else
	{
	ShowAlert(103);
	}
 }
</script>
</head>
<body onload="onLoading()">
<form name="safaeri2" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			 class="outertable">
			<tr>
				<td><lapstab:otscourltag pageid="3" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Compromise
				Proposal -&gt; Present Position -&gt; Promoters/ Guarantors</td>
			</tr>

		</table>
		</td>
	</tr>
</table>

<lapschoice:npaapplication /> <INPUT type="hidden" name="npa_appno"
	value="<%=(String)request.getParameter("npa_appno")%>" /> <lapstab:npapresentpostion
	module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>'
	pageid="3" /><br>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>
				<td colspan="2">TYPE OF APPLICANT <span class="mantatory">*&nbsp;</span></td>
				<td><select name="sel_type_applicant" tabindex="1">
					<option value="0">---Select-----</option>
					<%String apptype = "44";%>
					<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
				</select></td>
				<td>NAME OF APPLICANT <span class="mantatory">*&nbsp;</span></td>
				<td><input type="text" name="txt_name_applicant" size="30"
					maxlength="25" tabindex="2">
				</td>
			</tr>
			<tr>
				<td colspan="2">PRESENT ACTIVITY OF APPLICANT</td>
				<td><textarea rows="2" name="txt_present_activity" cols="50"
					tabindex="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="5"><b>AT THE TIME OF RENEWAL </b></td>
			</tr>
			<tr>
				<td>AMOUNT</td>
				<td align="right"><b>Rs.</b></td>
				<td><lapschoice:CurrencyTag name="txt_renew_means" maxlength="15"
					tabindex="6" /></td>
				<td>DATE</td>
				<td><input type="text" name="txt_renew_date" size="15"
					maxlength="10" tabindex="7"
					onBlur="checkDate(this)"> <a href="#"
					onClick="callCalender('txt_renew_date')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="7"></a></td>
			</tr>
			<tr>
				<td colspan="2"><b>PRESENT POSITION</b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>AMOUNT <span class="mantatory">*&nbsp;</span></td>
				<td align="right"><b>Rs.</b></td>
				<td><lapschoice:CurrencyTag name="txt_present_means" maxlength="15"
					tabindex="8" /></td>
				<td>DATE <span class="mantatory">*&nbsp;</span></td>
				<td><input type="text" name="txt_present_date" size="15"
					maxlength="10" tabindex="9" onBlur="checkDate(this)"> <a href="#"
					onClick="callCalender('txt_present_date')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="9"></a></td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr align="center">
		<td colspan="2">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
					<tr class="dataheader">
						<td width="3%" rowspan="2">&nbsp;</td>
						<td rowspan="2" align="center">TYPE OF APPLICANT</td>
						<td width="20%" rowspan="2" align="center"><b>NAME OF APPLICANT</b></td>
						<td colspan="2" align="center"><b>AT THE TIME OF RENEWAL</b></td>
						<td align="center" colspan="2"><b>PRESENT POSITION</b></td>
					</tr>
					<tr class="dataheader">
						<td width="15%" align="center"><b>AMOUNT</b></td>
						<td width="16%" align="center"><b>DATE</b></td>
						<td width="13%" align="center"><b>AMOUNT </b></td>
						<td width="16%" align="center"><b>DATE</b></td>
					</tr>
					<%vecRow = (ArrayList) hshValues.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				int size = vecRow.size();
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
					<tr class="datagrid">
						<td width="3%" align=center> <input
							type="radio" style="border:none" name="radiobutton"
							value="radiobutton"
							onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(7))%>','<%=Helper.correctNull((String)vecCol.get(10))%>','<%=i%>','<%=size%>')">
						<input type="hidden" name="hidaddress"
							value="<%=Helper.correctNull((String)vecCol.get(9))%>"> <input
							type="hidden" name="hidactivity"
							value="<%=Helper.correctNull((String)vecCol.get(3))%>"> </td>
						<td width="17%">&nbsp;<%=Helper.correctNull((String) vecCol.get(11))%></td>
						<td width="20%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
						<td width="15%" align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>
						<td width="16%">&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
						<td width="13%" align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
						<td width="16%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
					</tr>
					<%}} else {%>
					<tr class="datagrid">
						<td align="center" colspan="9">No Data Found</td>
					</tr>
					<%}%>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>" />
<input type="hidden" name="hidAppType"> 
</form>
</body>
</html>
