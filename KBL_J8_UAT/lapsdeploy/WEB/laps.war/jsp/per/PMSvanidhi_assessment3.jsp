<%@include file="../share/directives.jsp"%>
<%

String appno = Helper.correctNull((String) session
		.getAttribute("strappno"));
String prdcode = Helper.correctNull((String) session
		.getAttribute("prdcode"));
String strSessionModuleType = Helper.correctNull(
		(String) session.getAttribute("sessionModuleType")).trim();
String strPageName=Helper.correctNull((String)request.getParameter("flowtype"));
String strType="3";
if(strPageName.equalsIgnoreCase(""))
	strPageName=Helper.correctNull((String)hshValues.get("flowtype1"));
String strPageid="35";
if(strPageName.equalsIgnoreCase("KSAE"))
	strPageid="38";
else if(strPageName.equalsIgnoreCase("FIDPN"))
	strPageid="39";
else if(strPageName.equalsIgnoreCase("MMithra"))
	strPageid="40";
else if(strPageName.equalsIgnoreCase("GECL"))
	strPageid="41";
else if(strPageName.equalsIgnoreCase("CGSSD"))
	strPageid="42";
else if(strPageName.equalsIgnoreCase("Restructure"))
	strPageid="43";

else if(strPageName.equalsIgnoreCase("PMS3"))
	strPageid="45";



	%>
<html>
<head>
<title>Svanidhi 3.0</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
	.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordFlag"))%>";	
var varEligibilty="<%=Helper.correctNull((String)hshValues.get("Eligible_percentage"))%>";

function callonLoad()
{
	disablefields(true);
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value=="Y")
 		{
			if(varRecordFlag=="Y")
	 			enableButtons(false,true,true,true,false);
	 		else
	 			enableButtons(true,false,true,true,false);	
			
 			
 		}
		else
		{
			enableButtons(true,true,true,true,false);
		}
		if(varEligibilty=="N"){
			alert('Please Define Elibile Percentage in Product -> Svanidhi Eligibilty');
			enableButtons(true,true,true,true,false);
			return;
		}
		
		
	}
	else
	{
		enableButtons(true,true,true,true,false);
	}
			
}


function doEdit()
{
	//disablefields(false);
	enableButtons(true,false,false,false,true);
	}
function doDelete()
{
	alert('Assessment for PM Svanidhi 3 is Required,You cannot delete the assessment');
	return;
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].recordFlag.value="Y";
		document.forms[0].hidBeanGetMethod.value="getSvanidhiAssess";
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].action=appURL+"action/PMSvanidhi_assessment3.jsp";
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
}
function enableButtons(bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doSave()
{
	document.forms[0].recordFlag.value="Y";
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updateSvanidhiAssess";
	document.forms[0].hidBeanGetMethod.value="getSvanidhiAssess";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/PMSvanidhi_assessment3.jsp";
	document.forms[0].submit();
}


</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();">
<form name="appform" method="post" class="normal">
 
 <%
	if (strSessionModuleType.equals("CORP")
			|| strSessionModuleType.equals("AGR")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5>
			<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include>
		</td>
	</tr>
	<tr>
		<%
			if (strSessionModuleType.equals("AGR")) {
		%>
		<td class="page_flow"> Home -&gt; Agriculture &amp; SME -&gt; Proposal -&gt; Assessment -&gt;Assessment for PM Svanidhi 3.0</td>
			<% } else {%>
		<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Assessment -&gt; Assessment for PM Svanidhi 3.0	</td>
		<% 	}%>
		</tr>
</table>

<lapschoice:application />
<jsp:include page="../com/com_commentstab.jsp" flush="true">
<jsp:param name="tabid" value="<%=strPageid %>" />
</jsp:include>

<%
	}  else {
%> <jsp:include page="../share/Applurllinkper.jsp" flush="true">
	<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic)
		-&gt; Appraisal -&gt;Assessment for PM Svanidhi 3.0</td>
	</tr>
</table>
<lapschoice:application /> <jsp:include page="../share/apprlinktab.jsp"
	flush="true">
	<jsp:param name="tabid" value="216" />
</jsp:include> <br>
<%
	}
%>


	
				<table width="80%" border="0" cellspacing="0" cellpadding="3"
				class="outertable" align="center">
				<tr>
				<tr class="dataheader">
					<td width="5%">S.No</td>
					<td width="40%">Description</td>
					<td width="40%">Values</td>
					
				</tr>
				
				<tr class="datagrid">
					<td nowrap="nowrap" >1.</td>
					<td nowrap="nowrap">Svanidhi 2.0 Account number</td>
					<td nowrap="nowrap"><input type="text"
						name="txt_svanidhi_accnumber" size="18"
						onKeyPress="allowInteger()" value="<%=Helper.correctNull((String)hshValues.get("SVANIDHI_ACCNUMBER"))%>" maxlength="18"></td>

				</tr>
				<tr class="datagrid">
					<td nowrap="nowrap" >2.</td>
					<td nowrap="nowrap">Svanidhi 2.0 Account Open Date</td>
					<td nowrap="nowrap"><input type="text"
						name="txt_svanidhi_opened_date" size="18"
						value="<%=Helper.correctNull((String)hshValues.get("SVANIDHI_OPENED_DATE"))%>" maxlength="18"></td>

				</tr>
				<tr class="datagrid">
					<td nowrap="nowrap" >3.</td>
					<td nowrap="nowrap">Svanidhi 2.0 Account Close Date</td>
					<td nowrap="nowrap"><input type="text"
						name="txt_svanidhi_closed_date" size="18"
						value="<%=Helper.correctNull((String)hshValues.get("SVANIDHI_CLOSED_DATE"))%>" maxlength="18"></td>
                 </tr>
                 <tr class="datagrid">
					<td nowrap="nowrap" >4.</td>
					<td nowrap="nowrap">Svanidhi 2.0 Loan amount sanctioned</td>
					<td nowrap="nowrap"><input type="text"
						name="txt_svanidhi_sanctioned_amount" size="18"
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SVANIDHI_SANCTIONED_AMOUNT"))))%>" maxlength="18"></td>
                 </tr>
                 <tr class="datagrid">
					<td nowrap="nowrap" >5.</td>
					<td nowrap="nowrap">Repayment Days</td>
					<td nowrap="nowrap"><input type="text"
						name="txt_svanidhi_repay_days" size="18"
						value="<%=Helper.correctNull((String)hshValues.get("SVANIDHI_REPAY_DAYS"))%>" maxlength="4"></td>
                 </tr>
                  <tr class="datagrid">
					<td nowrap="nowrap" >6.</td>
					<td nowrap="nowrap">Limit eligible </td>
					<td nowrap="nowrap"><input type="text"
						name="txt_svanidhi_eligible_amount" size="18"
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SVANIDHI_ELIGIBLE_AMOUNT"))))%>" ></td>
                 </tr>
                 <tr class="datagrid">
					<td nowrap="nowrap" >7.</td>
					<td nowrap="nowrap">Limit Requested by Borrower under Svanidhi 3.0 </td>
					<td nowrap="nowrap"><input type="text"
						name="txt_svanidhi_borrower_amount" size="18"
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SVANIDHI_BORROWER_AMOUNT"))))%>" ></td>
                 </tr>
                 <tr class="datagrid">
					<td nowrap="nowrap" >8.</td>
					<td nowrap="nowrap">Limit proposed and recommended </td>
					<td nowrap="nowrap"><input type="text"
						name="txt_svanidhi_proposed_amount" size="18"
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SVANIDHI_PROPOSED_AMOUNT"))))%>" ></td>
                 </tr>
                 
					</table>

	<br>
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
		btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
	<lapschoice:hiddentag pageid='<%=PageId%>' /> 
	<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
	<INPUT TYPE="hidden" name="hid_strType" value = "<%=strType %>">
	<INPUT TYPE="hidden" name="recordFlag" value = "">
    <input type="hidden" name="hidCategoryType" value="<%=strCategoryType%>"> 
     <input type="hidden" name="pagefrom"> 
		
</form>
</body>
</html>