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
String strPageid="44";
	%>
<html>
<head>
<title>e Krishik Bhandar</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
	.getParameter("appstatus"))%>";

function callonLoad()
{
	disablefields(true);
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value=="Y")
 		{
			enableButtons(false,true,true,true,false);
 			
 		}
		else
		{
			enableButtons(true,true,true,true,false);
		}
		
	}
	else
	{
		enableButtons(true,true,true,true,false);
	}
			
}

function calculation()
{
	var margin_amt=(0.25)*(document.forms[0].txt_totalvalue.value);
	document.forms[0].txt_marginvalue.value=margin_amt;
	var eligibleloanvalue=(0.75)*(document.forms[0].txt_totalvalue.value);
	document.forms[0].txt_eligibleloanvalue.value=eligibleloanvalue;
	
}

function doEdit()
{
	disablefields(false);
	enableButtons(true,false,false,false,true);
	}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateeNWRassessment";
	document.forms[0].hidBeanGetMethod.value="geteNWRassessment";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agreNWR_assessment.jsp";
	document.forms[0].submit();
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
		document.forms[0].hidBeanGetMethod.value="geteNWRassessment";
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].action=appURL+"action/agreNWR_assessment.jsp";
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
	if(document.forms[0].txt_sanctionvalue.value=="0.00" || document.forms[0].txt_sanctionvalue.value=="")
	{
			ShowAlert(121,"Loan Sanction amount");
			document.forms[0].txt_sanctionvalue.focus();
			return;
	
	}	
	checkloansanctionamt();
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateeNWRassessment";
	document.forms[0].hidBeanGetMethod.value="geteNWRassessment";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agreNWR_assessment.jsp";
	document.forms[0].submit();
}

function checkloansanctionamt()
{
	var eligibleloanamt=document.forms[0].txt_eligibleloanvalue.value;
	var loansanctionamt=document.forms[0].txt_sanctionvalue.value;
	var loanappliedamt=document.forms[0].txt_loanapplyvalue.value;
	if(eligibleloanamt=="NaN" ||eligibleloanamt=="")
	{
		eligibleloanamt="0.00";
	}if(loansanctionamt=="NaN" ||loansanctionamt=="")
	{
		loansanctionamt="0.00";
	}
	if(loanappliedamt=="NaN" ||loanappliedamt=="")
	{
		loanappliedamt="0.00";
	}
	if(eval(eligibleloanamt)<eval(loansanctionamt)){
		alert("Loan Sanction amount should not be greater than the Eligible Loan Amount");
		document.forms[0].txt_sanctionvalue.value="0.00";
		document.forms[0].txt_sanctionvalue.focus();
		return;
	}
	if(eval(loanappliedamt)<eval(loansanctionamt)){
		alert("Loan Sanction amount should not be greater than the Loan Applied Amount");
		document.forms[0].txt_sanctionvalue.value="0.00";
		document.forms[0].txt_sanctionvalue.focus();
		return;
	}
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();calculation();">
<form name="appform" method="post" class="normal">
 
 <%
	if (strSessionModuleType.equals("CORP")
			|| strSessionModuleType.equals("AGR")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5>
			<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="44" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include>
		</td>
	</tr>
	<tr>
		<%
			if (strSessionModuleType.equals("AGR")) {
		%>
		<td class="page_flow"> Home -&gt; Agriculture &amp; SME -&gt; Proposal -&gt; Assessment -&gt;Assessment for e- Krishik Bhandar</td>
			<% } %>
		</tr>
</table>

<lapschoice:application />
<jsp:include page="../com/com_commentstab.jsp" flush="true">
<jsp:param name="tabid" value="<%=strPageid %>" />
</jsp:include>

<%
	} 
%>


	
				<table width="80%" border="0" cellspacing="0" cellpadding="3"
				class="outertable" align="center">
				<tr>
				<tr class="dataheader">
					<td width="40%"></td>
					<td width="60%">Details of Assessment</td>
				</tr>
				
				<tr class="datagrid">
				<td  nowrap="nowrap">Name of the Crop/Commodity <b><span class="mantatory"></span></b></td>
				<td  nowrap="nowrap"><input type="text" name="txt_croporcommodity"
					value="<%=Helper.correctNull((String)hshValues.get("croporcommodity"))%>"
					size="35"  maxlength="50" disabled="true">
				</td>		
				</tr>
				<tr class="datagrid">
					<td nowrap="nowrap">Number of Packages/Bags <b><span class="mantatory"></span></b></td>
					<td nowrap="nowrap"><input type="text" name="txt_nopackages"
						value="<%=Helper.correctNull((String)hshValues.get("noofpackages"))%>"
						size="20%"  maxlength="10" disabled="true">
					</td>
				</tr>
				<tr class="datagrid">
					<td>Net Quantity in Quintal (A)  <b><span class="mantatory"></span></b> </td>
					<td nowrap> <input type="text" name="txt_netquantity" 
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("netquantity"))))%>"						
						onKeyPress="allowNumber(this)" maxlength="13" style="text-align: right" disabled="true">
					</td>
                 </tr>
                 <tr class="datagrid">
					<td>Estimated Value per Quintal (B) <b><span class="mantatory"></span></b></td>
					<td nowrap> <input type="text" name="txt_estimatedvalue" 
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("estimatedvalue"))))%>"						
						onKeyPress="allowNumber(this)" maxlength="13" style="text-align: right" disabled="true">
					</td>
                 </tr>
                 <tr class="datagrid">
					<td>Total Value (A X B)(C) </td>
					<td nowrap> <input type="text" name="txt_totalvalue"
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalvalue"))))%>"
						size="20%" maxlength="20"  style="text-align: right" disabled="true">
					</td>
                 </tr>
                  <tr class="datagrid">
					<td>Margin (25% of C )(D)</td>
					<td nowrap> <input type="text" name="txt_marginvalue"
						value=""
						size="20%" maxlength="20"  style="text-align: right" disabled="true">
					</td>
                 </tr>
                 <tr class="datagrid">
					<td>Eligible Loan amount (75% of C) (E)</td>
					<td nowrap> <input type="text" name="txt_eligibleloanvalue"
						value=""
						size="20%" maxlength="20"  style="text-align: right" disabled="true">
					</td>
                 </tr>
                 <tr class="datagrid">
					<td>Loan Applied</td>
					<td nowrap> <input type="text" name="txt_loanapplyvalue"
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facproposed"))))%>"
						size="20%" maxlength="20"  style="text-align: right" disabled="true">
					</td>
                 </tr>
                 <tr class="datagrid">
					<td>Loan Sanctioned Amount </td>
					<td nowrap> <input type="text" name="txt_sanctionvalue"
						value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loansanctionamt"))))%>"
						size="20%" maxlength="20"  style="text-align: right" onBlur="checkloansanctionamt();">
					</td>
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