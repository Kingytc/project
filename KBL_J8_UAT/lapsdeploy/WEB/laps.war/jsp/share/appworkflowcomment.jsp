<%@include file="../share/directives.jsp"%>
<%
String strPgDist = Helper.correctNull(request.getParameter("hiPgDist"));
String loan_type=Helper.correctNull((String)hshValues.get("app_loantype"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String loantype="";
	if(loan_type.equalsIgnoreCase("P"))
	{
		loantype="Retail";
	}
	if(loan_type.equalsIgnoreCase("A"))
	{
		loantype="Agriculture";
	}

	if(loan_type.equalsIgnoreCase("c"))
	{
		loantype="Corporate";
	}
	if(loan_type.equalsIgnoreCase("T"))
	{
		loantype="Tertiary";
	}
	if(loan_type.equalsIgnoreCase("E"))
	{
		loantype="Short Review/Extension";
	}
	String strPrdtype = Helper.correctNull((String) session.getAttribute("strProductType"));
%>
<html>
<head>
<title></title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varorg_level="<%=Helper.correctNull((String)hshValues.get("remarksorglevel"))%>";
var varapp_level="<%=Helper.correctNull((String)hshValues.get("remarksapplevel"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var strPrdType="<%=strPrdtype%>";
var varloantype="<%=loan_type%>";
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
	if(val=="restrfacdetails")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
		document.forms[0].action=appURL+"action/apprestructureaccountdetails.jsp";
		document.forms[0].submit();
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
function callQueries()
{
		 document.forms[0].hidBeanGetMethod.value="getQueryData";
		 document.forms[0].hidBeanId.value="documentsupport";
		 document.forms[0].action=appURL+"action/appqueryhome.jsp";
		 document.forms[0].submit();
}
function placeValues()
{
	var loan_type="<%=loan_type%>";
	disableFields(true);
	if(varorg_level!="")
	{
		document.forms[0].sel_level.value=varorg_level;
	}
	else
	{
		document.forms[0].sel_level.value="S";
	}
	if(varOrgLevel==varorg_level && document.forms[0].appstatus.value=="Open/Pending" && document.forms[0].btnenable.value=="Y")
	{
		enableButtons(false,true,true,true,false);
	}
	else
	{
		enableButtons(true,true,true,true,false);
	}
	if(varapp_level=="S" && varorg_level=="A" && varOrgLevel=="D" && document.forms[0].appstatus.value=="Open/Pending")
	{
		enableButtons(false,true,true,true,false);
	}

	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	{
		if(strPrdType!="pG" && strPrdType!="pR")
		{
			document.all.idloanaccount.style.visibility="visible";
			document.all.idloanaccount.style.position="relative";
			document.all.idrestr.style.visibility="visible";
			document.all.idrestr.style.position="relative";
			document.all.idCGTMSEtxn.style.visibility="visible";
			document.all.idCGTMSEtxn.style.position="relative";
		}
		else
		{
			document.all.idloanaccount.style.visibility="hidden";
			document.all.idloanaccount.style.position="absolute";
			document.all.idrestr.style.visibility="hidden";
			document.all.idrestr.style.position="absolute";
			document.all.idCGTMSEtxn.style.visibility="hidden";
			document.all.idCGTMSEtxn.style.position="absolute";
		}
		
		if(loan_type.toUpperCase()=="C" || loan_type.toUpperCase()=="A")
		{
			document.all.idfacdetail.style.visibility="visible";
			document.all.idfacdetail.style.position="relative";
		}
	}
	else
	{
		document.all.idloanaccount.style.visibility="hidden";
		document.all.idloanaccount.style.position="absolute";
		document.all.idrestr.style.visibility="hidden";
		document.all.idrestr.style.position="absolute";
		document.all.idCGTMSEtxn.style.visibility="hidden";
		document.all.idCGTMSEtxn.style.position="absolute";

		if(loan_type.toUpperCase()=="C" || loan_type.toUpperCase()=="A")
		{
			document.all.idfacdetail.style.visibility="hidden";
			document.all.idfacdetail.style.position="absolute";
		}
	}
}
function callFacDetail()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
	document.forms[0].action=appURL+"action/appfacilitydetails.jsp";
	document.forms[0].submit();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="commworkflow"
		document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
		document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
		document.forms[0].submit();
	}	
}

function doDelete()
{	
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="commworkflow"
		document.forms[0].hidBeanMethod.value="updateWorkFlowComments";
		document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/appworkflowcomment.jsp";
 		document.forms[0].submit();
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="update"
	document.forms[0].hidBeanId.value="commworkflow"
	document.forms[0].hidBeanMethod.value="updateWorkFlowComments";
	document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/appworkflowcomment.jsp";
	document.forms[0].submit();
}

function doClose()
{
	if("<%=strPgDist%>"=="P")
	{
		if(ConfirmMsg(100))
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/retailpge.jsp";
			document.forms[0].submit();
		}
	}
	var cattype=document.forms[0].cattype.value;
    if((cattype=="ASSI")||(cattype=="ASBI")||(cattype=="OPS"))
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
		 	document.forms[0].submit();
	 	}
	}
	if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME")||(cattype=="SRE")||(cattype=="STL")||(cattype=="ADC"))
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}	
}

function getValues()
{
	document.forms[0].hidBeanId.value="commworkflow"
	document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
	document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
	document.forms[0].submit();
}
function callLoanAccount()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action=appURL+"action/apploanaccount.jsp";
	document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="remarks" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
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
		</jsp:include>
		<span style="display:none;"><lapschoice:borrowertype /></span>
			<%}else if(loan_type.equalsIgnoreCase("C")  || loan_type.equalsIgnoreCase("A")){%>
      	<jsp:include page="../com/proposallinks.jsp" flush="true"> 
      	<jsp:param name="pageid" value="7" />
      	<jsp:param name="cattype" value="<%=strCategoryType%>" />
      	<jsp:param name="ssitype" value="<%=strSSIType%>" />
      	</jsp:include>
      	<span style="display:none;"><lapschoice:borrowertype /></span> 
	<%}%>
      </td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <%if(strSessionModuleType.equals("AGR")){%>
	 <tr>
		 <td class="page_flow"> Home -&gt; Agriculture -&gt; Proposal -&gt; WorkFlow -&gt; Comments</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("SRE")){%>
	<tr>
		
      <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension 
        -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("STL")){ %>
	<tr>
		
      <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Term Loan 
        -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("ADC")){ %>
	<tr>
		
      <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc Limit -&gt; WorkFlow 
        -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("OPS")){ %>
	<tr>
		
      <td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; WorkFlow 
        -&gt; Comment</td>
	</tr>
	<%}
	else if(strSessionModuleType.equals("LAD"))
    {
    %> 
    <tr>
    <td class="page_flow"> Home -&gt; Loan Against Gold Ornaments &amp; Deposits -&gt; WorkFlow -&gt; Comment</td></tr>
    <%}else if (strCategoryType.equalsIgnoreCase("AGR")){ %>
	<tr>
		
      <td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; WorkFlow 
        -&gt; Comments</td>
	</tr>   
	<%} else if (strSessionModuleType.equalsIgnoreCase("RET")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Retail  -&gt;Application -&gt; WorkFlow -&gt;
		Comments</td>
	</tr> 
    <%}else{%>
 	<tr>
      <td class="page_flow"> Home -&gt; Corporate &amp;SME -&gt; Proposal -&gt; WorkFlow -&gt; Comments</td>
    </tr>
 	<%}%> 
</table>
<lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
			<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="80%">
				<tr align="center">
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('history')">History</a></td>					
					 <td class="sub_tab_active">Comments</td>
					 <td class="sub_tab_inactive"><a  href="#" onClick="javascript:callQueries()">Queries</a></td>
					 <%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A") || loan_type.equalsIgnoreCase("T") || loan_type.equalsIgnoreCase("H") || loan_type.equalsIgnoreCase("U") || loan_type.equalsIgnoreCase("E"))
			        { %>
					  <td id="action" class="sub_tab_inactive" nowrap="nowrap"><a href="#" onclick="javascript:callOtherTab('sanction')">Proposed facility Approve/Reject</a></td>
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
					<%if(!Helper.correctNull((String)hshValues.get("strLoanType")).equalsIgnoreCase("OD")){ %>
						<td class="sub_tab_inactive"><a href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
					<%} %>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>
					<%if (Helper.correctNull((String) hshValues.get("app_legalcomp")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive" nowrap="nowrap"><a href="#" onClick="javascript:callOtherTab('legcomp')">Legal Compliance Certificate</a></td>
					<%} %>	
					<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
					<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
					<%}else{ %>
					<td  style="display: none;"><input type="hidden" id="idrestr"></td>
					<%} %>
					<% if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {%>
					<td class="sub_tab_inactive" id="idfacdetail"  nowrap="nowrap"><a href="#" onClick="javascript:callFacDetail()">Facility Details</a></td> 			
					<% } %>	
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<table width="75%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  <tr> 
    <td width="20%" nowrap="nowrap">Select Organisation </td>
    <td> 
      <select name="sel_level" onChange="getValues()" tabindex="1">
        <option value="S" selected="selected">&lt;---Select---&gt;</option>
        <option value="C">Head Office</option>
        <option value="R">CPC / Regional Office</option>
        <option value="D">CLPU</option>
        <option value="A">Branch</option>
      </select>
    </td>
  </tr>  
  <tr><td colspan="2">&nbsp;</td> </tr>  
  <tr> 
    <td valign="top"> Comment</td>
    <td><textarea name="txt_Comment" cols="100"  rows="13" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String)hshValues.get("comment"))%></textarea>
     </td>
  </tr>
</table>                              
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trial" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
<INPUT TYPE="hidden" name="hidAppNo" VALUE=<%=Helper.correctNull((String)request.getParameter("appno"))%>>
<INPUT TYPE="hidden" name="radLoan" value="Y">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
</form>
</body>
</html>
