<%@include file="../share/directives.jsp"%>
<%
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Appraisal - Background Information Report(BIR)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varBIR="<%=Helper.correctNull((String) hshValues.get("bir_flag"))%>";
var strAppVar="<%=Helper.correctNull((String) hshValues.get("strAppVal"))%>";
var varqualityreport="<%=Helper.correctNull((String) hshValues.get("bir_quality_report"))%>";
var  varopinionall="<%=Helper.correctNull((String) hshValues.get("bir_opinion_all"))%>";
function callonLoad()
{
	if(varBIR!="")
	{
		document.forms[0].sel_bir.value=varBIR;
	}
	if(varqualityreport!="")
	{
		document.forms[0].sel_qual_report.value=varqualityreport;
	}
	if(varopinionall!="")
	{
		document.forms[0].sel_opinion.value=varopinionall;
	}
	disablefields(true);
	enabledfields('N');
}
function enabledfields(varflag)
{
	if(document.forms[0].sel_bir.value=="Y")
	{
		document.all.idbir.style.display="table-row";
		document.all.idbir1.style.display="table-row";
		
		document.all.bir1.style.display="table-cell";
		document.all.bir2.style.display="table-cell";
		document.all.bir3.style.display="table-cell";
		document.all.bir_charges.style.display="table-cell";
		document.all.bir_charges1.style.display="table-cell";
		document.all.id_birname.style.display="table-row";
		document.all.id_newfeild.style.display="table-row";
		document.all.birveriby.style.visibility="visible";
		  document.all.birveriby.style.position="relative";
		  document.all.birveridate.style.visibility="visible";
		  document.all.birveridate.style.position="relative";
		if(varflag=="Y")
		{
			document.forms[0].txt_charges.readOnly=false;
			document.forms[0].txt_bircomments.value="";
			
		}
		
		
	}
	else
	{
		document.all.idbir.style.display="none";
		document.all.idbir1.style.display="table-row";
		document.all.bir1.style.display="none";
		document.all.bir2.style.display="none";
		document.all.bir3.style.display="none";
		document.all.bir_charges.style.display="none";
		document.all.bir_charges1.style.display="none";
		document.all.id_birname.style.display="none";
		document.all.id_newfeild.style.display="none";
		document.all.birveriby.style.visibility="hidden";
		document.all.birveriby.style.position="absolute";
		document.all.birveridate.style.visibility="hidden";
		document.all.birveridate.style.position="absolute";
		document.forms[0].txt_convertedid.value="";
		document.forms[0].txt_convertedname.value="";
		document.forms[0].birverifidate.value="";
		
		
		if(varflag=="Y")
		{
			document.forms[0].txt_receiptdate.value="";
			document.forms[0].txt_submitteddate.value="";
			document.forms[0].txt_charges.value="";
			document.forms[0].txt_bircomments.value="";
			document.forms[0].txt_birprocess_date.value="";
			
		}
		document.forms[0].txt_charges.readOnly=true;
	}
	if(document.forms[0].sel_bir.value=="N"){
		document.all.id_comments.innerHTML="Reason for Not obtaining BIR";
	}else{
		document.all.id_comments.innerHTML="Comments";
	}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
function doEdit()
{
	disablefields(false);
	enableButtons(true,false,false,false,true);
	document.forms[0].txt_name.readOnly=true;
	document.forms[0].txt_convertedid.readOnly=true;
	document.forms[0].txt_convertedname.readOnly=true;
	document.forms[0].birverifidate.readOnly=true;
	//enabledfields('Y');
	
	
}
function doSave()
{
	if(document.forms[0].sel_bir.value=="")
	{
		ShowAlert('111',"Whether BIR Required?");
		document.forms[0].sel_bir.focus();
		return;
	}
	else if(document.forms[0].sel_bir.value=="Y" && document.forms[0].txt_submitteddate.value=="")
	{
		ShowAlert('121',"Date of submission of request for BIR by Bank");
		document.forms[0].txt_submitteddate.focus();
		return;
	}
	else if(document.forms[0].sel_bir.value=="Y" && document.forms[0].txt_receiptdate.value=="")
	{
		ShowAlert('121',"Date of receipt of BIR report by Bank");
		document.forms[0].txt_receiptdate.focus();
		return;
	}
	else if(document.forms[0].sel_bir.value=="Y" &&( document.forms[0].txt_charges.value==""|| document.forms[0].txt_charges.value=="0.00"|| document.forms[0].txt_charges.value=="0"))
	{
		ShowAlert('121',"BIR Charges");
		document.forms[0].txt_charges.focus();
		return;
	} 
	else if(document.forms[0].sel_bir.value=="Y" && document.forms[0].txt_birprocess_date.value=="")
	{
		ShowAlert('121',"BIR Report Date");
		document.forms[0].txt_birprocess_date.focus();
		return;
	}
	else if(document.forms[0].sel_bir.value=="Y" && document.forms[0].txt_convertedid.value=="")
	{
		ShowAlert('121',"BIR Verified By");
		document.forms[0].txt_convertedid.focus();
		return;
	}
	else if(document.forms[0].sel_bir.value=="Y" && document.forms[0].birverifidate.value=="")
	{
		ShowAlert('121',"BIR Verified Date ");
		document.forms[0].birverifidate.focus();
		return;
	}
if(document.forms[0].txt_bircomments.value=="")
	{
		ShowAlert('121',"Comments");
		document.forms[0].txt_bircomments.focus();
		return;
	}
if(document.forms[0].sel_bir.value=="Y" &&(document.forms[0].sel_qual_report.value==""||document.forms[0].sel_qual_report.value=="0"))
{
	ShowAlert('111',"Quality of report");
	document.forms[0].sel_qual_report.focus();
	return;
}
if(document.forms[0].sel_bir.value=="Y" &&(document.forms[0].sel_opinion.value==""||document.forms[0].sel_opinion.value=="0"))
{
	ShowAlert('111',"Over all opinion of prospective borrower");
	document.forms[0].sel_opinion.focus();
	return;
}
if(document.forms[0].sel_bir.value=="Y" && document.forms[0].txt_name.value=="")
{
	ShowAlert('121',"Name");
	document.forms[0].txt_name.focus();
	return;
}

	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateBIRData";
	document.forms[0].hidBeanGetMethod.value="getBIRData";
	document.forms[0].hidSourceUrl.value="/action/per_bir.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateBIRData";
	document.forms[0].hidBeanGetMethod.value="getBIRData";
	document.forms[0].hidSourceUrl.value="/action/per_bir.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/retailpge";
	   	document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getBIRData";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].action=appURL+"action/per_bir.jsp";
		document.forms[0].submit();
	}
}
function disablefields(val)
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
	document.forms[0].txt_submitteddate.readOnly=true;
	document.forms[0].txt_receiptdate.readOnly=true;
	document.forms[0].txt_birprocess_date.readOnly=true;
	
}
function enableButtons(bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function callDDRDetails(val)
{
	if(val=="1")
	{
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].hidBeanGetMethod.value="getdueReport";
		document.forms[0].action=appURL+"action/due_report.jsp";
		document.forms[0].submit();
	}
	else if(val=="2")
	{
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].hidBeanGetMethod.value="getdueReportGeneralInfo";
		document.forms[0].action=appURL+"action/due_report_general.jsp";
		document.forms[0].submit();
	}
}
function callAgentName()
{
	document.forms[0].hidAppVal.value=strAppVar;
	document.forms[0].hidbirfalg.value="Y";
	
	
		var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
		var url=appURL+"action/birproplist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getBIRListprop&hidAction=search&strfrom=BIRmaster&hidAppVal="+strAppVar+"&strflag="+document.forms[0].hidbirfalg.value;
		window.open(url,"",prop);
	
}
function callUsersHelp1(val)
{
	if(document.all.cmdsave.disabled==false)
	{
		var pagefield="ddr"+val;
		var varQryString = appURL+"action/setUserSearchforbirddr.jsp?pagefrom="+pagefield;
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}else{
		alert("Enable the edit Mode");
	}
}
function callCalender(fname)
{
	if(document.all.cmdedit.disabled==true)
	{
		showCal(appURL,fname);
	}else{
		alert("Enable the edit Mode");
	}
}
</SCRIPT>
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<%
	if (strSessionModuleType.equals("CORP")
			|| strSessionModuleType.equals("AGR")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="35" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<%
			if (strSessionModuleType.equals("AGR")) {
		%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture
		-&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp; Due Diligence Report -&gt; BIR</td>
		<%
			} else {
		%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp;
		SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp; Due Diligence Report -&gt;
		BIR</td>
		<%
			}
		%>

	</tr>
</table>

<lapschoice:application />
<table width="60%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr align="center">
				<td width="30%" class="sub_tab_inactive"><a
					href="JavaScript:callDDRDetails('1');">Due Diligence -
				Applicant Info</a></td>
				<td width="30%" class="sub_tab_inactive"><a
					href="JavaScript:callDDRDetails('2');">Due Diligence - Security
				Info</a></td>
				<td width="50%" class="sub_tab_active">Background Information
				Report(BIR)</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
	} else if (strSessionModuleType.equalsIgnoreCase("DIGI")) {
%> <jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
	<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal
		-&gt; Background Information Report(BIR)</td>
	</tr>
</table>
<lapschoice:application /> <jsp:include page="../share/apprlinktab.jsp"
	flush="true">
	<jsp:param name="tabid" value="102" />
</jsp:include> <br>
<%
	} else {
%> <jsp:include page="../share/Applurllinkper.jsp" flush="true">
	<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic)
		-&gt; Appraisal -&gt; Background Information Report(BIR)</td>
	</tr>
</table>
<lapschoice:application /> <jsp:include page="../share/apprlinktab.jsp"
	flush="true">
	<jsp:param name="tabid" value="102" />
</jsp:include> <br>
<%
	}
%>
<table width="95%" border="0" cellpadding="3" cellspacing="0"
	class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="95%" border="0" cellpadding="3" cellspacing="0"
			class="outertable" align="center">
			<tr>
				<td width="20%">Whether BIR Required? <span class="mantatory">*&nbsp;</span></td>
				<td colspan="5"><select name="sel_bir"
					onchange="enabledfields('Y');">
					<option value=""><--select--></option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
			</tr>
			<tr id="idbir">
				<td width="20%">Date of submission of request for BIR by Bank <span
					class="mantatory">*&nbsp;</span></td>
				<td width="5%"><input type="text" name="txt_submitteddate"
					maxlength="10"
					onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmaxdate(this,document.forms[0].txt_receiptdate.value);checkmaxdate(this,document.forms[0].txt_birprocess_date.value)"
					size="12"
					value="<%=Helper.correctNull((String) hshValues
							.get("bir_submitteddate"))%>"></td>
				<td width="5%"><a alt="Select date from calender" href="#"
					onClick="callCalender('txt_submitteddate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender" align="middle"></a></td>
				<td width="15%">Date of receipt of BIR report by Bank <span
					class="mantatory">*&nbsp;</span></td>
				<td width="5%"><input type="text" name="txt_receiptdate"
					maxlength="10"
					onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmindate(this,document.forms[0].txt_submitteddate.value)"
					size="12"
					value="<%=Helper.correctNull((String) hshValues
							.get("bir_receiptdate"))%>"></td>
				<td width="5%"><a alt="Select date from calender" href="#"
					onClick="callCalender('txt_receiptdate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender" align="middle"></a></td>
			</tr>
			<tr>
				<td id="bir_charges">BIR charges(Excluding Taxes) <span
					class="mantatory">*&nbsp;</span></td>
				<td id="bir_charges1"><input type="text" name="txt_charges"
					size="16" onBlur="javascript:roundtxt(this);" onKeyPress="allowNumber(this)" maxlength="13"
					value="<%=Helper.correctNull((String) hshValues
									.get("bir_charges"))%>"
					style="text-align: right;"></td>
				<td>&nbsp;</td>
				<td width="15%" id="bir1">BIR Report Date<span
					class="mantatory">*&nbsp;</span></td>
				<td width="5%" id="bir2"><input type="text"
					name="txt_birprocess_date" maxlength="10"
					onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmindate(this,document.forms[0].txt_submitteddate.value)"
					size="12"
					value="<%=Helper.correctNull((String) hshValues
							.get("bir_processdate"))%>"></td>
				<td width="5%" id="bir3"><a alt="Select date from calender"
					href="#" onClick="callCalender('txt_birprocess_date')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender" align="middle"></a></td>

			</tr>
			<tr id="id_birname">
				<td>Name</td>
				<td valign="top" nowrap="nowrap" colspan="2"><input type="text"
					name="txt_name" size="38" maxlength="50" tabindex="1" value="<%=Helper.correctNull((String) hshValues
							.get("bir_service_name"))%>"
					onKeyPress="notAllowSplChar()"> &nbsp;&nbsp;<b><span
					onClick="callAgentName()" style="cursor: hand" id="idsearch1"><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b></td>


			</tr>
			<tr id="id_newfeild">
				<td>Quality of report<span class="mantatory">*</span></td>
				<td colspan="1"><select name="sel_qual_report"
					style="width: 150px">
					<option value="0">---select---</option>
					<lapschoice:StaticDataTag apptype="250" />
				</select></td>
				<td>&nbsp;</td>
				<td nowrap="nowrap">Over all opinion of prospective borrower<span
					class="mantatory">*</span></td>
				<td ><select name="sel_opinion"
					style="width: 150px">
					<option value="0">---select---</option>
					<lapschoice:StaticDataTag apptype="251" />
				</select></td>
			</tr>
			<tr id="idbir1">
				<td valign="top" id="id_comments">Comments</td>
				<td colspan="2"><textarea name="txt_bircomments" cols="40"
					rows="3" onKeyPress="notAllowSplChar(this);textlimitcorp1(this,1000)"
						onkeyup="textlimitcorp1(this,1000);" onkeydown="textlimitcorp1(this,1000);"><%=Helper.correctNull((String) hshValues
									.get("bir_comments"))%></textarea></td>

			</tr>
	         <tr style="visibility: hidden; position: absolute;" id="birveriby">
	         
									<td>BIR Verified by <span class="mantatory">*</span> :</td>
									<td><input type="text" name="txt_convertedid" size="10" value="<%=Helper.correctNull((String)hshValues.get("birverifiedby"))%>" readonly="readonly">
				<input type="text" name="txt_convertedname" size="30" value="<%=Helper.correctNull((String)hshValues.get("BIR_verified_name"))%>">
				<a href="#" onClick="javascript:callUsersHelp1('2')">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a>
				</td>
								</tr> 
								<tr style="visibility: hidden; position: absolute;" id="birveridate">
								<td>BIR Verified Date<span class="mantatory">*</span> :</td>
							    <td>
	                 <input type="text" name="birverifidate" onBlur="checkmaxdate(this,currentDate)"
										value="<%=Helper.correctNull((String)hshValues.get("birverifieddate"))%>" maxlength="10" size="15" alt="Select date from calender">
										<a style="vertical-align: middle" onClick="callCalender('birverifidate')" 
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender"></a>
	                </td>
								</tr>
	         </tr>



		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
 <input	type="hidden" name="hidAppVal">
  <input	type="hidden" name="hidbirfalg">
</form>
</body>

</html>