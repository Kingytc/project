<%@include file="../share/directives.jsp"%>
<%
String strPgDist = Helper.correctNull(request.getParameter("hiPgDist"));
String loan_type=Helper.correctNull((String)hshValues.get("app_loantype"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strfacility = Helper.correctNull((String) hshValues.get("strfacility"));
String facility="";

if(!strfacility.equalsIgnoreCase(""))
{
	facility=strfacility;
}
else
{
	facility="0";
}

ArrayList arrFacDetRow = new ArrayList();
ArrayList arrCol = new ArrayList();

if(hshValues!=null)
{
	arrFacDetRow		= (ArrayList)hshValues.get("arrFacDetRow");
}
%>

<html>
<head>
<title>Facility Details</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varloantype ="<%=loan_type%>";
var appstatus = "<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var varUserID="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";

function callOtherTab(val)
{
	var strCatType="<%=strCategoryType%>";
	if(document.forms[0].cmdsave.disabled)
	{	
		if(val=="action")
		{	     
			document.forms[0].hidBeanGetMethod.value="getAction";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].cattype.value=strCatType;
			document.forms[0].action=appURL+"action/appworkflowaction.jsp";
			document.forms[0].submit();
		}
		if(val=="sanction")
		{
			document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].cattype.value=strCatType;
			document.forms[0].action=appURL+"action/com_termsofsanction.jsp";
			document.forms[0].submit();
		}
		if(val=="history")
		{
			 document.forms[0].hidBeanGetMethod.value="getHistory";
			 document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
			 document.forms[0].submit();
		}
		if(val=="legcomp")
		{
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
			document.forms[0].action=appURL+"action/legalcompliance.jsp";
			document.forms[0].submit();
		}
		if(val=="loanaccount")
		{
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
			document.forms[0].action=appURL+"action/apploanaccount.jsp";
			document.forms[0].submit();
		}
		if(val=="restrfacdetails")
		{
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
			document.forms[0].action=appURL+"action/apprestructureaccountdetails.jsp";
			document.forms[0].submit();
		}
		if(val=="drawdownschedule")
		 {
			if (varloantype == "C"||true)
			{
			 document.forms[0].hidBeanId.value="commworkflow";
			 document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
			 document.forms[0].action=appURL+"action/drawdownschedule.jsp";
			 document.forms[0].submit();
		 	}
			else
			{
	                alert("Draw Down Schedule to be Entered only for Project Loans");
	                return;
	        }
	   }
		if(val=="CGTMSE_TXN")
		{
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="getCGTMSE_txndet";
			document.forms[0].action=appURL+"action/app_CGTMSE_txnDet.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function doEdit()
{
	disableFields(false);
	disableCommandButtons("edit");	
	document.forms[0].hidAction.value ="update";
	enableButtons(true,true,false,false,true,false);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="commworkflow"
		document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/appfacilitydetails.jsp";
		document.forms[0].submit();
	}	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
	}
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updFacilityDetailsData";
	document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/appfacilitydetails.jsp";
	document.forms[0].submit();
}

function callComment()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
	document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
	document.forms[0].submit();
}
function placeValues()
{
	disableFields(true);
	enableButtons(false,false,true,true,true,false);
	if(varUserID!=document.forms[0].appholder.value)
	{
		document.forms[0].cmdedit.disabled=true;  
	}	
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		enableButtons(false,false,true,true,true,true);
	}
	if(val=="edit")
	{	 
		enableButtons(true,true,false,false,true,true);
		disableFields(false);
	}
	if(val=="radioselect")
	{	 
		enableButtons(true,false,true,true,false,true);
	}	  
	if(val=="disableall")
	{
		enableButtons(true,true,true,true,true,true);
		disableFields(true);

	}
} 
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
</script>

</head>
<body onload="placeValues()">
<form method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<%if(loan_type.equalsIgnoreCase("P")){%> 
			<jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			</jsp:include> 
		<%}else if(loan_type.equalsIgnoreCase("E") || loan_type.equalsIgnoreCase("U") || loan_type.equalsIgnoreCase("H")  || loan_type.equalsIgnoreCase("T")){%>
			<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span>
		<%}else if(loan_type.equalsIgnoreCase("C")  || loan_type.equalsIgnoreCase("A")){%>
			<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span>
		<%}%>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<%if(strSessionModuleType.equals("AGR")){%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; WorkFlow -&gt; Comments</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("SRE")){%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("STL")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Term Loan -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("ADC")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc Limit -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("OPS")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%} else if(strCategoryType.equals("LAD")) {  %>
	<tr>
		<td class="page_flow">Home -&gt; Loan Against Gold Ornaments &amp; Deposits -&gt; WorkFlow -&gt; Facility Details</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("AGR")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; WorkFlow -&gt; Facility Details</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("RET")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt;Application -&gt; WorkFlow -&gt; Facility Details</td>
	</tr>
	<%}else{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp;SME -&gt; Proposal -&gt; WorkFlow -&gt; Facility Details </td>
	</tr>
	<%}%>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="80%">
			<tr align="center">
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('history')">History</a></td>
				<td class="sub_tab_inactive"><a	href="#" onclick="javascript:callComment()">Comments</a></td>
				
				<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A") || loan_type.equalsIgnoreCase("T") || loan_type.equalsIgnoreCase("H") || loan_type.equalsIgnoreCase("U") || loan_type.equalsIgnoreCase("E")) { %>
				<td id="action" class="sub_tab_inactive" nowrap="nowrap">
					<a href="#" onclick="javascript:callOtherTab('sanction')">Proposed facility Approve/Reject</a></td>
				<%}%>
				
				<td id="action" class="sub_tab_inactive"><a href="#" onclick="javascript:callOtherTab('action')">Action</a></td>
				<%
				if((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))
				{
				if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive" id="idCGTMSEtxn"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
				<%} else { %>
					<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
				<% } } %>
				<td class="sub_tab_inactive"><a
					href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
				<%if (Helper.correctNull((String) hshValues.get("app_legalcomp")).equalsIgnoreCase("Y")){ %>
				<td class="sub_tab_inactive" nowrap="nowrap"><a href="#" onClick="javascript:callOtherTab('legcomp')">Legal Compliance Certificate</a></td>
				<%} %>
				
				<td id="action" class="sub_tab_inactive" nowrap="nowrap"><a href="#" onclick="javascript:callOtherTab('loanaccount')">Loan Account Details</a></td>
				<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
					<%}else{ %>
					<td><input type="hidden" id="idrestr" style="display: none;"></td>
					<%} %>
				<td class="sub_tab_active" nowrap="nowrap">Facility Details</td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>

<table width="98%" border="0" cellspacing="0" cellpadding="1" align="center" class="outertable border1">
	<tr>
		<td valign="top">
			<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
				<tr class="dataheader">
					<td align="center" width="5%">Facility S.No.</td>
					<td align="center" width="30%">Facility Name</td>
					<td align="center" width="10%">Type of Limit</td>
					<td align="center" >Nature of Limit</td>
					<td align="center" >Sanctioned Amount</td>
					<td align="center" >CBS Account No.</td>
					<td align="center" >Current Status</td>
					<td align="center" >Whether Send to CBS Done</td>
					<td align="center" >Revalidation</td>
					</tr>
				
			<% if(arrFacDetRow!=null && arrFacDetRow.size()>0) 
			{ 
				for(int i=0;i<arrFacDetRow.size();i++)
				{
					arrCol	= (ArrayList)arrFacDetRow.get(i);
			%>
				<tr class="datagrid">
					<td align="center"><input type="hidden" name="hidFacSno" size="15" maxlength="10" value="<%=Helper.correctNull((String)arrCol.get(0))%>"><%=Helper.correctNull((String)arrCol.get(0))%></td>
					<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(1)))%></td>
					<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(2)))%></td>
					<td align="center"><%=Helper.correctNull((String)arrCol.get(13))%>&nbsp;</td>
					<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(3)))%></td>
					<td align="center"><%=Helper.correctNull((String)arrCol.get(6))%></td>
					<td align="center"><%=Helper.correctNull((String)arrCol.get(10))%></td>
					<td align="center"><%=Helper.correctNull((String)arrCol.get(11))%>&nbsp;</td>
					<td align="center"><%=Helper.correctNull((String)arrCol.get(12))%>&nbsp;</td>
					</tr>
			<%} } %>
			</table>
		</td>
	</tr>
</table><br>

<table width='0%' border='1' cellspacing='0' cellpadding='0' class='outertable' align='center'>
	<tr>
		<td>
		<table width='0%' border='0' cellspacing='0' cellpadding='3'>
			<tr valign='top'>
				<td><input type='button' name='cmdedit' value='Edit' onClick="doEdit()" class="buttonStyle" ></td>
				<td><input type='button' name='cmdsave' value='Save' onClick="doSave()" class="buttonStyle" ></td>
				<td><input type='button' name='cmdcancel' value='Cancel' onClick="doCancel()" class="buttonStyle" ></td>
				<td><input type='button' name='cmddelete' value='Delete' onClick="doDelete()" class="buttonStyle" ></td>
				<td><input type='button' name='cmdclose' value='Close' onClick="doClose()" class="buttonClose" ></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	<lapschoice:hiddentag pageid='<%=PageId%>' /> 
	<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
	<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
	<input type="hidden" name="radLoan" value="Y"> 
	<input type="hidden" name="cattype" value="<%=strCategoryType%>">
	<input type="hidden" name="hidLoantype" value="<%=loan_type%>">	
	</form>
</body>
</html>