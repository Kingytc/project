<%@include file="../share/directives.jsp"%>
<%
	ArrayList g1 = new ArrayList();
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
%>

<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var MSME_CRITERIA_SALES="<%=Helper.correctNull((String) hshValues
							.get("MSME_CRITERIA_SALES"))%>";
var varinitializeflag="<%=Helper.correctNull((String) hshValues
							.get("MSME_INITIATE_FLAG"))%>";
var varcriteriainvest="<%=Helper.correctNull((String) hshValues
								.get("MSME_CRITERIA_INVESTMENT"))%>";
							
function disableFields(val) {
	for ( var i = 0; i < document.forms[0].length; i++) {
		if (document.forms[0].elements[i].type == 'text') {
			document.forms[0].elements[i].readOnly = val;
		}
		if (document.forms[0].elements[i].type == 'select-one') {
			document.forms[0].elements[i].disabled = val;
		}
	}
}

function disableCommandButtons(cmdEdit, cmdSave, cmdCancel, cmddelete,cmdinitiate,cmdClose) {
	document.forms[0].cmdedit.disabled = cmdEdit;
	document.forms[0].cmdsave.disabled = cmdSave;
	document.forms[0].cmdcancel.disabled = cmdCancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdsendforverification.disabled = cmdinitiate;
	document.forms[0].cmdclose.disabled = cmdClose;
	
}

function doEdit() {
	disableFields(false);
	disableCommandButtons(true, false, false, false, false,true);
	document.forms[0].hidAction.value = "update";
}

function doCancel() {
	var varconfirm = ConfirmMsg('102');
	if (varconfirm) {
		document.forms[0].hidBeanGetMethod.value = "getMsmeApproval";
		document.forms[0].hidBeanId.value = "inwardRegister";
		document.forms[0].action = appURL + "action/msme_proposallist.jsp";
		document.forms[0].submit();
	}
}

function doSave() {
	
	if(document.forms[0].txt_sales_turnover.value=="0.00"||document.forms[0].txt_sales_turnover.value=="")
	{
		  ShowAlert(121,'Sales Turnover of the Applicant');
		    
		  document.forms[0].txt_sales_turnover.focus();
		  return;
	}
	if(document.forms[0].txt_sales_turnoverdate.value=="")
	{
		  ShowAlert(111,'Sales Turnover As on Date');
		  document.forms[0].txt_sales_turnoverdate.focus();
		  return;
	}
	if(document.forms[0].sel_sales_turnover.value==""||document.forms[0].sel_sales_turnover.value=="0")
	{
		  ShowAlert(111,'Criteria for Sales Turnover');
		  document.forms[0].sel_sales_turnover.focus();
		  return;
	}
	if(document.forms[0].txt_equipval.value=="0.00"||document.forms[0].txt_equipval.value=="")
	{
		  ShowAlert(121,'Investment in Plant & Machineries/Equipments');
		    
		  document.forms[0].txt_equipval.focus();
		  return;
	}
	if(document.forms[0].txt_effdate.value=="")
	{
		  ShowAlert(111,' New Classification Effective date');
		  document.forms[0].txt_effdate.focus();
		  return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidBeanGetMethod.value = "updatemsmeproposal";
	document.forms[0].hidBeanId.value = "inwardRegister";
	document.forms[0].action = appURL + "action/msme_proposallist.jsp";
	document.forms[0].submit();
}

function doDelete() {
	var varconfirm = ConfirmMsg('101');
	if (varconfirm) {
		document.forms[0].hidAction.value = "delete";
		document.forms[0].hidBeanMethod.value = "updatemsmeproposal";
		document.forms[0].hidBeanGetMethod.value = "getMsmeApproval";
		document.forms[0].hidBeanId.value = "inwardRegister";
		document.forms[0].hidSourceUrl.value = "/action/msme_proposallist.jsp";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].method = "post";
		document.forms[0].submit();
	}
}
function doClose() {
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callCalender(name) {

	if (document.forms[0].cmdsave.disabled == false) {
		showCal(appURL, name);

	}
}
function callonLoad(){
	disableFields(true);
	 if(document.forms[0].hidpropchk.value=="N"||document.forms[0].hiddelflag.value=="Y")
	 {
			disableCommandButtons(true, true, true, true, true,true);
	 }else {
			disableCommandButtons(false, true, true, true, true,true);
		
	 }
	 if(MSME_CRITERIA_SALES!=""){
		 document.forms[0].sel_sales_turnover.value=MSME_CRITERIA_SALES;
	 }
	 if(document.forms[0].hidappno.value!="")
	 {
		 document.forms[0].cmdsendforverification.disabled=false;
	 }
	 if(varinitializeflag=="Y")
	 {
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsendforverification.disabled=true;
		 document.all.idBranch.style.display="none";
	 }
	 if(varcriteriainvest!=""){
		 document.forms[0].sel_criteria_invest.value=varcriteriainvest;
	 }
	 
	// document.forms[0].cmdreport.disabled=true;
	 if(document.forms[0].hidappstatus.value=="pa")
	 {
		document.forms[0].cmdreport.disabled=false; 
	 }
}
function doSendForVerification() {

	if(document.forms[0].hid_Branch.value=="")
	{
		alert("Select Organisation");
		return;
	}
	if(document.forms[0].hiddocchk.value=="N"){
	alert("Please Upload at least one  Document");
	return;
    }
	doDocumentUpload();
	document.forms[0].hidAction.value = "Initiate";
	document.forms[0].hidBeanId.value = "inwardRegister";
	document.forms[0].hidBeanMethod.value = "updatemsmeproposal";
	document.forms[0].hidBeanGetMethod.value = "getMsmeApproval";
	document.forms[0].hidSourceUrl.value = "/action/msme_proposallist.jsp";
	document.forms[0].action = appURL + "controllerservlet";			
	alert("Your application has been sent successfully");
	document.forms[0].submit();
}
function doReport()
{
	var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
	var url=appURL+"action/msmerunrepot.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMsmeReport&appno="+document.forms[0].hidappno.value;
	window.open(url,"MSME",prop);	
}
function showOrganizationSearch(path, forgscode, forgname)
{
	if(document.forms[0].cmdsendforverification.disabled==false)
	{
		var appno1=document.forms[0].hidappno.value;
		{
			var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
			var url=appURL+"action/orgnamelist.jsp?pagename=MSME&appno="+appno1;
			window.open(url,"",prop);
		}
	}
}
function doDocumentUpload()
{
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/perm_docAttachment.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getpermDocumentDetails&hidpagefrom=MSME&appno="+document.forms[0].hidappno.value;
	var title = "Organization";
	var prop = "scrollbars=yes,width=1200,height=900,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}
function doDocument()
{
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/perm_docAttachment.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getpermDocumentDetails&hidpagefrom=MSME&appno="+document.forms[0].hidappno.value;
	var title = "Organization";
	var prop = "scrollbars=yes,width=1200,height=900,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}
</script>
</head>
<body onload="callonLoad();">
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>

				<td valign="top" class="page_flow">Home -&gt; MSME</td>

			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable">
							<tr valign="top">
								<td colspan="8">
								<table width="100%" border="0" cellspacing="1" cellpadding="1"
									class="outertable">
									<tr class="dataheader">
										<td width="5%">Sl.No</td>
										<td width="10%">Proposal No</td>
										<td width="10%">Facility Sl.No</td>
										<td width="10%">Facility Name</td>
										<td width="10%">Amount</td>
										<td width="10%">Activity Code</td>
										<td width="10%">MIS Classification</td>
										<td width="10%">Plant &
										Machineries Value</td>
										<td width="10%">Equipments Value</td>
										<td width="10%">Details Fetched as on date</td>
										<td width="10%">Status of Facility</td>
									</tr>
									<tr>
										<td colspan="8">
										<%
												ArrayList v = (ArrayList) hshValues.get("arrRow");
												if (v != null) {
													int vecsize = v.size();

													if (vecsize != 0) {

														for (int l = 0; l < vecsize; l++) {

															g1 = (ArrayList) v.get(l);
											%>
										
									<tr class="datagrid">
										<td width="5%"><%=l + 1%></td>
										<td width="10%"><%=Helper.correctNull((String) g1.get(0))%></td>
										<td width="10%"><%=Helper.correctNull((String) g1.get(1))%></td>
										<td width="10%"><%=Helper.correctNull((String) g1.get(2))%></td>
										<td width="10%" align="right"><%=nf.format(Double.parseDouble(Helper
										.correctDouble((String) g1.get(3))))%></td>
										<td width="10%"><%=Helper.correctNull((String) g1.get(4))%></td>
										<td width="10%"><%=Helper.correctNull((String) g1.get(5))%></td>
										<td width="10%" align="right"><%=nf.format(Double.parseDouble(Helper
										.correctDouble((String) g1.get(7))))%></td>
										<td width="10%" align="right"><%=nf.format(Double.parseDouble(Helper
										.correctDouble((String) g1.get(6))))%></td>
										<td width="10%"><%=Helper.getCurrentDateTime()%></td>
										<td width="10%"><%=Helper.correctNull((String) g1.get(8))%></td>

									</tr>
									<%
												}
													} else {
											%>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td align="center" colspan="10">No Data Found</td>
									</tr>
									<%
												}

												}
											%>

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

<tr>
	<td>
	<table width="100%" border="" cellspacing="0" cellpadding="3"
		class="outertable" align="center">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="3"
				class="outertable" align="center">
				<tr class="dataheader">
					<td>MSME Proposal No : <%=Helper.correctNull((String) hshValues.get("MSME_APPNO"))%>&nbsp;</td>
					<td>Customer ID : <%=Helper.correctDouble((String) hshValues.get("strCBSID"))%></td>
					<td>Customer Name : <%=Helper.correctDouble((String) hshValues
							.get("strborrowername"))%></td>
					<td>Branch Name : <%=Helper.correctDouble((String) hshValues
									.get("strscode"))
							+ "-"
							+ Helper.correctDouble((String) hshValues
									.get("strorgname"))%></td>
				</tr>
				<tr>
					<td>Sales Turnover of the Applicant (Rs.)</td>
					<td><input type="text" name="txt_sales_turnover" size="12"
						value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("MSME_SALES_TURNOVER"))))%>"
						onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
						style="text-align: right;">
					<td>Sales Turnover As on Date</td>
					<td><input type="text" name="txt_sales_turnoverdate" size="12"
						maxlength="10"
						value="<%=Helper.correctNull((String) hshValues
							.get("MSME_SALES_DATE"))%>"
						onBlur="checkDate(this);checkmaxdate(this,currentDate);">
					<a onClick="callCalender('txt_sales_turnoverdate')"
						title="Click to view calender" border=0><img
						src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
						border="0"></a></td>
				</tr>
				<tr>
					<td>Criteria for Sales Turnover</td>
					<td><select name="sel_sales_turnover" style="width: 200px">
						<option value="0">&lt;--Select--&gt;</option>
						<%
															String apptype = "243";
														%>
						<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
					</select></td>
				</tr>
				<tr>
					<td>Investment in Plant & Machineries/Equipments (Rs.)</td>
					<td><input type="text" name="txt_equipval"
						onKeyPress="allowNumber(this)" style="text-align: right;"
						onBlur="roundtxt(this);"
						value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("MSME_EQUIP_VAL"))))%>"></td>

					<td>New Classification Effective date</td>
					<td colspan="3"><input type="text" name="txt_effdate"
						size="12" maxlength="10"
						value="<%=Helper.correctNull((String) hshValues
							.get("MSME_CLASSI_DATE"))%>"
						onBlur="checkDate(this);checkmaxdate(this,currentDate);">
					<a onClick="callCalender('txt_effdate')"
						title="Click to view calender" border=0><img
						src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
						border="0"></a></td>
				</tr>
				<tr>
					<td>Investment value as on Date <b><span class="mantatory">&nbsp;*</span></b></td>
					<td><input type="text" name="txt_investDate"
						onBlur="checkDate(this);checkmaxdate(this,currentDate);"
						size="15%"
						value="<%=Helper.correctNull((String) hshValues
											.get("MSME_INVESTMENT_DATE"))%>">
					<a alt="Select date from calender"
						href="javascript:callCalender('txt_investDate')" tabindex="10">
					<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
						width="21" height="18" border="0"> </a></td>
					<td>Criteria for Investment value</td>
					<td><select name="sel_criteria_invest" style="width: 200px">
						<option value="0">&lt;--Select--&gt;</option>
						<%
											String strapptype = "248";
										%>
						<lapschoice:StaticDataNewTag apptype='<%=strapptype%>' />
					</select></td>
				</tr>
				<tr id="idBranch">
					<td>Organisation</td>
					<td><input type="hidden" name="hid_Branch" value=""> <input
						type="text" name="txt_Branch" size="38" value=""> <b><a
						href="#"
						onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_Branch','txt_Branch')"
						style="cursor: hand"> <img
						src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
						border="0"></a></b></td>
				</tr>

				<%
																									if (!Helper.correctNull((String) hshValues.get("msme_remarks"))
																											.equalsIgnoreCase("")) {
																								%>
				<tr>
					<td>Remarks</td>
					<td><textarea name="txt_remarks" cols="90" rows="5"
						tabindex="21" disabled="disabled"><%=Helper.correctNull((String) hshValues
								.get("msme_remarks"))%></textarea></td>
				</tr>
				<%
													}
												%>

			</table>
			</td>
		<tr>
			<br>
		<tr>
			<td>
			<table width="100%" border="" cellspacing="0" cellpadding="3"
				class="outertable" align="center">
				<lapschoice:combuttonnew
					btnnames='Edit_Save_Cancel_delete_Send for Verification_Document Upload'
					btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
			</table>
			</td>
		</tr>
		<input type="hidden" name="hidPageType"
			value="<%=request.getParameter("hidPageType")%>">
		<input type="hidden" name="hidapplicantid">
		<input type="hidden" name="hidRatingProposalFlag">
		<input type="hidden" name="hidRatingProposalPendingFlag">
		<input type="hidden" name="hidRatingProposalUser">
		<input type="hidden" name="hidApprovedApplDemoID">
		<input type="hidden" name="hidOccuCode">
		<input type="text" name="hidappid"
			value="<%=Helper.correctNull((String) hshValues.get("strappid"))%>">
		<input type="hidden" name="hidname"
			value="<%=Helper.correctNull((String) hshValues
							.get("strborrowername"))%>">
		<input type="hidden" name="hidcbsid"
			value="<%=Helper.correctNull((String) hshValues.get("strCBSID"))%>">
		<input type="hidden" name="hidappno"
			value="<%=Helper.correctNull((String) hshValues.get("MSME_APPNO"))%>">
		<input type="hidden" name="hidinitiateFlag">
		<input type="hidden" name="hidappstatus"
			value="<%=Helper.correctNull((String) hshValues
							.get("MSME_APPSTATUS"))%>">
		<input type="hidden" name="hiddocchk"
			value="<%=Helper.correctNull((String) hshValues
							.get("strmsmedoccheck"))%>">
		<input type="hidden" name="hidpropchk"
			value="<%=Helper.correctNull((String) hshValues
							.get("strpropmodificationchk"))%>">
		<lapschoice:hiddentag pageid='<%=PageId%>' />
		</form>
</body>
</html>
