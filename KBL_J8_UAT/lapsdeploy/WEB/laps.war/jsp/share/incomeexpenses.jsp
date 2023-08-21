<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList vecReport = new ArrayList();
	if (hshValues != null) {
		vecReport = (ArrayList) hshValues.get("vecReport");
	}
	int count = 0;
	int vecRsize = 0;
	ArrayList b1 = null;%>
<html>
<head>
<title>Appraisal - LoanDetails</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strper_appid="<%=Helper.correctNull((String) hshValues.get("strper_appid"))%>";
var count1="<%=count%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var comments="<%=Helper.correctNull((String) hshValues.get("Pagename"))%>";
var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
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
	}
	if(comments!="" && comments!="0")
	{
		document.forms[0].chk_apptype.disabled=false;
	}
	document.forms[0].sel_comments.disabled=false;
}
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function callonLoad()
{
	disablefields(true);
	if(comments!="" && comments!="0")
	{
		if(strper_appid!="")
		{
			document.forms[0].chk_apptype.value=strper_appid;
		}
		else
		{
			document.forms[0].chk_apptype.value="";
		}
	}
	if(comments!="" && comments!="0")
	{
		document.forms[0].sel_comments.value=comments;
	}
	else
	{
		document.forms[0].sel_comments.value="0";
	}	
}
function doEdit()
{
	if(document.forms[0].sel_comments.value != "0")
	{
		if(document.forms[0].chk_apptype.value == "")
		{
			alert("Select the Applicant Type");
			return;
		}		
		document.forms[0].hidAction.value="Edit"
		enableButtons(true,false,false,false,true);
		document.forms[0].chk_apptype.readOnly=true;
		document.forms[0].txt_comments.readOnly=false;
	}
	else
	{
	alert("Select the Comments on");
	document.forms[0].sel_comments.focus();
	return;
	}	
}
function doSave()
{
	if(document.forms[0].chk_apptype.value == "")
	{
		alert("Select the Applicant Type");
		return;
	}
	if(document.forms[0].txt_comments.value == "")
	{
		ShowAlert('121','Comments');
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/incomeexpenses.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="getAppraisalData";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].hidSourceUrl.value="/action/incomeexpenses.jsp";
		document.forms[0].submit();
	}
}
function getValues()
{
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].action=appUrl+"action/incomeexpenses.jsp";
	document.forms[0].submit();
}
function getCollData()
{
	if(document.forms[0].selapptype.value!="")
	{
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanGetMethod.value="getData";
	}
	document.forms[0].action=appUrl+"action/percollateralhome.jsp";	
	document.forms[0].submit();
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="updateAppraisalData";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].hidSourceUrl.value="/action/incomeexpenses.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function doClose()
{
	var con = ConfirmMsg('100');
	var id="<%=Helper.correctNull((String) hshValues
									.get("applicantid"))%>";
	var comappname="<%=Helper.correctNull((String) hshValues.get("appname"))%>";
	
	if(con)
	{
	 document.forms[0].action=appUrl+"action/retailpge.jsp";
	  document.forms[0].submit();
	}
}
function getFeilds()
{
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].action=appUrl+"action/incomeexpenses.jsp";
	document.forms[0].submit();
}
</SCRIPT>
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">	
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Income &amp; Expenses</td>
	</tr>
</table>
<lapschoice:application />
<jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="2" />
		</jsp:include>
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="113" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<jsp:include page="../share/postsanctionapprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="2" />
		</jsp:include>
<%} %>

<br>
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
	<tr>
		<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="center"><b>Comments on </b> <select
									name="sel_comments" style="width: 150" onchange="getFeilds()">
									<option value="0" selected="selected">--Select--</option>
									<option value="IE">Income &amp; Expenses</option>
									<option value="ES">Experience &amp; Services</option>
									<option value="CO">Confidential Opinion</option>
								</select></td>
							</tr>
								<%if (Helper.correctNull((String) hshValues.get("Pagename")).equalsIgnoreCase("IE")) {%>
								<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td valign="top"><b>Comment on Income &amp; Expenses</b></td>
									</tr>
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
													<tr class="dataheader">
														<td nowrap="nowrap"><b>Type</b></td>
														<td nowrap="nowrap"><b>Name</b></td>
														<td><b>Annual Gross Income</b></td>
														<td><b>Other Income</b></td>
														<td><b>Standard Deduction</b></td>
														<td><b>Other Deduction</b></td>
														<td><b>Annual Net Income</b></td>
													</tr>
													<%if (vecReport != null) {
																vecRsize = vecReport.size();
															}
															for (int l = 0; l < vecRsize; l++) {
																int colSize = 0;
																if (l < vecRsize) {
																	b1 = (ArrayList) vecReport.get(l);
																	if (b1 != null) {
																		colSize = b1.size();
																	}
																}
																if (colSize > 0) {%>
													<tr class="datagrid">
														<td nowrap="nowrap"><%=Helper.correctNull((String) b1.get(7))%></td>
														<td nowrap="nowrap"><%=Helper.correctNull((String) b1.get(8))%></td>
														<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(1))))%></td>
														<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(2))))%></td>
														<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(3))))%></td>
														<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(4))))%></td>
														<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(5))))%></td>
													</tr>
													<%}}%>													
												</table>
												</td>
											</tr>											
											<tr>
												<td valign="top">Applicant Type : <select
													name="chk_apptype" style="width: 150"
													onchange="getValues()">
													<option value="">--Select--</option>
													<lapschoice:fincoappguarantor />
												</select></td>
											</tr>
											<tr>
												<td valign="top" align="center"><textarea
													name="txt_comments" cols="100" rows="10" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("Comments"))%></textarea></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								<%} else if (Helper.correctNull((String) hshValues.get("Pagename")).equalsIgnoreCase("ES")) {%>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td valign="top"><b>Experience and Services</b></td>
									</tr>
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td valign="top">
												<table width="100%" cellspacing="0" cellpadding="3" class="outertable linebor">
													<tr align="center" class="dataheader">
														<td nowrap="nowrap"><b>Type</b></td>
														<td><b>Name</b></td>
														<td nowrap="nowrap"><b>Relation</b></td>
														<td><b>Age</b></td>
														<td nowrap="nowrap"><b>Date of Birth</b></td>
														<td width="11%" align="center" nowrap="nowrap"><b>Available Repayment Period (in
														Months)</b></td>
														<td nowrap="nowrap"><b>Networth</b></td>
													</tr>
													<%		if (hshValues != null) {
																vecReport = (ArrayList) hshValues.get("vecReport");
															}
															if (vecReport != null) {
																vecRsize = vecReport.size();
															}
															for (int l = 0; l < vecRsize; l++) {
																int colSize = 0;
																if (l < vecRsize) {
																	b1 = (ArrayList) vecReport.get(l);
																	if (b1 != null) {
																		colSize = b1.size();
																	}
																}
																if (colSize > 0) {
																	int intService = Integer.parseInt(Helper.correctInt((String) b1.get(8)));
																	if (intService < 0) {
																		intService = 0;
																	}%>
													<tr class="datagrid">
														<td nowrap="nowrap"><%=Helper.correctNull((String) b1.get(0))%></td>
														<td><%=Helper.correctNull((String) b1.get(1))%></td>
														<td nowrap="nowrap"><%=Helper.correctNull((String) b1.get(5))%></td>
														<td><%=Helper.correctNull((String) b1.get(7))%></td>
														<td nowrap="nowrap" align="center"><%=Helper.correctNull((String) b1.get(6))%></td>
														<td nowrap="nowrap"><%=intService%></td>
														<td nowrap="nowrap" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(9))))%></td>
													</tr>
													<%}}%>
													</table>
												</td>
											</tr>
											<tr>
												<td valign="top">&nbsp;</td>
											</tr>
											<tr>
												<td valign="top">Applicant Type : <select name="chk_apptype" style="width: 150"
													onchange="getValues()">
													<option value="">--Select--</option>
													<lapschoice:fincoappguarantor />
												</select> </td>
											</tr>
											<tr>
												<td valign="top" align="center"><textarea
													name="txt_comments" cols="80" rows="10" wrap="VIRTUAL"
													onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("Comments"))%></textarea></td>
											</tr>
											<tr>
												<td valign="top" align="center">&nbsp;</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								<%} else if (Helper.correctNull((String) hshValues.get("Pagename")).equalsIgnoreCase("CO")) {%>
								<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable"
									align="center">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td valign="top"><b>Comments on Confidential opinion from Bankers</b></td>
											</tr>
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0" class="outertable"
													cellpadding="3">													
													<tr>
														<td valign="top">Applicant
														Type :  <select name="chk_apptype" style="width: 150"
															onchange="getValues()">
															<option value="">--Select--</option>
															<lapschoice:fincoappguarantor />
														</select></td>
													</tr>
													<tr>
														<td valign="top" align="center"><textarea
															name="txt_comments" cols="100" rows="10" wrap="VIRTUAL"
															onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("Comments"))%></textarea></td>
													</tr>
													<tr>
														<td valign="top" align="center">&nbsp;</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<%}%>
										</td>
									</tr>
								</table>
						</table>
						</td>
					</tr>
				</table>
				<br>
		<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
		<lapschoice:hiddentag pageid='<%=PageId%>'/> 
		<input type="hidden" name="radLoan" value="Y">

</form>
</body>
</html>
