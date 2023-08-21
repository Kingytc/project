<%@include file="../share/directives.jsp"%>
<html>

<%
	String loan_type = Helper.correctNull((String) hshValues
			.get("app_loantype"));
	String legalcomp = Helper.correctNull((String) hshValues
			.get("app_legalcomp"));
	String strBtnEnable = Helper.correctNull((String) request
			.getParameter("btnenable"));

	String loantype = "";

	if (loan_type.equalsIgnoreCase("P")) {
		loantype = "Retail";
	}
	if (loan_type.equalsIgnoreCase("A")) {
		loantype = "Agriculture";
	}

	if (loan_type.equalsIgnoreCase("c")) {
		loantype = "Corporate";
	}
	if (loan_type.equalsIgnoreCase("T")) {
		loantype = "Tertiary";
	}
	if (loan_type.equalsIgnoreCase("E")) {
		loantype = "Short Review/Extension";
	}
	String strPrdtype = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

%>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var strPrdType="<%=strPrdtype%>";
var varUserID="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
function callOtherTab(val)
{
	var strCatType="<%=strCategoryType%>";
	 if(val=="history")
	 {
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
	/* if(val=="sanction")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
		document.forms[0].action=appURL+"action/com_termsofsanction.jsp";
		document.forms[0].submit();
	}*/
	 <%if(strSessionModuleType.equalsIgnoreCase("DIGI")){%>
		if(val=="action")
		{
			document.forms[0].hidBeanGetMethod.value="getAction";
			document.forms[0].hidBeanId.value="perDeviation";
			document.forms[0].action=appURL+"action/permworkflowaction.jsp";
			document.forms[0].submit();
		}
		<%}else{%>
			if(val=="action")
			{
			     
				document.forms[0].hidBeanGetMethod.value="getAction";
				document.forms[0].hidBeanId.value="commworkflow";
				document.forms[0].cattype.value=strCatType;
				document.forms[0].action=appURL+"action/appworkflowaction.jsp";
				document.forms[0].submit();
			}
			<%}%>

	if(val=="sanction")
	{
		document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].cattype.value=strCatType;
		document.forms[0].action=appURL+"action/com_termsofsanction.jsp";
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

function callSearch(arg)
{
	if(document.forms[0].cmdedit.disabled==false)
	{
		alert("Please click Edit button");
		return;
	}
	var varQryString = appURL+"action/setUserSearch.jsp?pagefrom=legalcomp&selrownum="+arg;
	var title = "Users";
	var prop = "scrollbars=no,width=650,height=450,menubar=no,status=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}
function doSave()
 { 
	 document.forms[0].cmdsave.disabled = true;
	 document.forms[0].hidRecordflag.value=varRecordFlag;
     document.forms[0].hidAction.value="insert";
	 document.forms[0].hidBeanId.value="commworkflow";
	 document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
	 document.forms[0].hidBeanMethod.value="updateLegalComplianceData";	
	 document.forms[0].hidSourceUrl.value="/action/legalcompliance.jsp";
	 document.forms[0].action=appURL+"controllerservlet";
	 document.forms[0].submit();
 }

 function disablebutton(val)
  {
	document.forms[0].cmdedit.disabled=!val;  
	document.forms[0].cmdsave.disabled=val; 
	document.forms[0].cmdcancel.disabled=val;  
	document.forms[0].cmddelete.disabled=val;  
  }

  function doEdit()
  {
	  disablebutton(false); 
  }
  function doDelete()
  {

	  if(varRecordFlag=="Y")
	  	{
		  	  
	     document.forms[0].hidAction.value="delete";
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
		 document.forms[0].hidBeanMethod.value="updateLegalComplianceData";	
		 document.forms[0].hidSourceUrl.value="/action/legalcompliance.jsp";
		 document.forms[0].action=appURL+"controllerservlet";
		 document.forms[0].submit();
	  	}
	  	else
		{
			ShowAlert(158);
		}   
 }
  function doCancel()
  {
	  if(ConfirmMsg(102))
		{
		  
	  document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
	  document.forms[0].hidBeanId.value="commworkflow";
	  document.forms[0].action=appURL+"action/legalcompliance.jsp";
	  document.forms[0].submit();
		}
  }

   function doClose()
   {
	   if(ConfirmMsg(100))
	   {
		   document.forms[0].action=appURL+"action/mainnav.jsp";
		   document.forms[0].submit();
	   }
   }
 function doPrint()
{		
	var varloantype='<%=loan_type%>';	
	var appno=document.forms[0].appno.value;
	var title = "Legal_Compliance_Letter";
	var borrName="<%=Helper.encodeAmpersand((String)request.getParameter("appname"))%>";
	var apprec="<%=request.getParameter("apporgname")%>";						                                                                                         
	var purl ="<%=ApplicationParams.getAppUrl()%>action/legalcompliancelevel.jsp?hidBeanGetMethod=getlegalComplianceData&hidBeanId=commworkflow&appno="+appno+"&borrowername="+borrName+"&recieved="+apprec+"&loantype="+varloantype;
	var prop = 'scrollbars=yes,menubar=yes,width=750,height=540';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);

	}
		
function callComment()
{
 	document.forms[0].hidBeanId.value="commworkflow";
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
function placevalues()
{
	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	{
		if(strPrdType!="pG" && strPrdType!="pR")
		{
			document.all.idloanaccount.style.visibility="visible";
			document.all.idloanaccount.style.position="relative";
			document.all.idCGTMSEtxn.style.visibility="visible";
			document.all.idCGTMSEtxn.style.position="relative";	
		}
		else
		{
			document.all.idloanaccount.style.visibility="hidden";
			document.all.idloanaccount.style.position="absolute";
			document.all.idCGTMSEtxn.style.visibility="hidden";
			document.all.idCGTMSEtxn.style.position="absolute";	
		}
		<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")){%>
		document.all.idfacdetail.style.visibility="visible";
		document.all.idfacdetail.style.position="relative";
		<%}%>
		
	}
	else
	{
		document.all.idloanaccount.style.visibility="hidden";
		document.all.idloanaccount.style.position="absolute";
		document.all.idCGTMSEtxn.style.visibility="hidden";
		document.all.idCGTMSEtxn.style.position="absolute";	
		
		<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")){%>
		document.all.idfacdetail.style.visibility="hidden";
		document.all.idfacdetail.style.position="absolute";
		<%}%>
	}

	if(varUserID!=document.forms[0].appholder.value)
	{
		document.forms[0].cmdedit.disabled=true;  
	}

}
function callFacDetail()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
	document.forms[0].action=appURL+"action/appfacilitydetails.jsp";
	document.forms[0].submit();
}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<title>Legal Compliance Letter</title>
<body onLoad="disablebutton(true);placevalues();">
<form name="frmworkflow" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<%if (loan_type.equalsIgnoreCase("P")) {
		%> <jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
		</jsp:include> <%
 	} else if (loan_type.equalsIgnoreCase("E")
 			|| loan_type.equalsIgnoreCase("U")
 			|| loan_type.equalsIgnoreCase("H")
 			|| loan_type.equalsIgnoreCase("T")) {
 %> <jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span> <%
 	} else if (loan_type.equalsIgnoreCase("C")|| loan_type.equalsIgnoreCase("A")) {
 %> <jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none"><lapschoice:borrowertype /></span> <%
 	}
 %>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<%
		if (strCategoryType.equalsIgnoreCase("SRE")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Review/Extension -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%
		} else if (strCategoryType.equalsIgnoreCase("STL")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Term Loan -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%
		} else if (strCategoryType.equalsIgnoreCase("ADC")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc
		Limit -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%
		} else if (strCategoryType.equalsIgnoreCase("OPS")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%
		} else if (strCategoryType.equals("LAD")) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Loan Against Gold
	Ornaments &amp; Deposits -&gt; WorkFlow -&gt; Action</td></tr>
	<%
		} else {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; WorkFlow
		-&gt; Legal Compliance Certificate</td>
	</tr>
	<%
		}
	%>

</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable linebor">
	<lapschoice:application />
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3"
			class="outertable" align="left" width="80%">
			<tr align="center">

				<td class="sub_tab_inactive"><a
					href="javascript:callOtherTab('history')">History</a></td>
					<td class="sub_tab_inactive"><a
					href="javascript:callComment()">Comments</a></td>
				
               <%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A") || loan_type.equalsIgnoreCase("T") || loan_type.equalsIgnoreCase("H") || loan_type.equalsIgnoreCase("U") || loan_type.equalsIgnoreCase("E"))
			        { %>
				<td id="action" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('sanction')">Proposed facility Approve/Reject
				</a></td>
				<%}%>
				<td id="action" class="sub_tab_inactive"> <a
					href="javascript:callOtherTab('action')"> Action</a></td>
				<%
				if((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))
				{
				if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive" id="idCGTMSEtxn"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
				<%} else { %>
					<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
				<% } } %>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>

				<td class="sub_tab_active" nowrap="nowrap">Legal Compliance
				Certificate</td>
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
<table width="779" class="outertable">
	<tr>
		<td width="184" align="center">&nbsp;</td>
		<td width="49" align="center">&nbsp;</td>
		<td width="271" align="center">&nbsp;</td>
		<td width="360" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td width="184" align="center" height="9">&nbsp;</td>
		<td width="49" align="center" height="9">&nbsp;</td>
		<td width="271" align="center" height="9">&nbsp;</td>
		<td width="360" align="center" height="9">&nbsp;</td>
	</tr>
	<tr>
		<td width="184" align="center">User ID</td>
		<td width="49" align="center">&nbsp;</td>
		<td width="271" align="center">Name</td>
		<td width="360" align="center">Designation</td>
	</tr>
	<tr>
		<td width="184" align="center"><input type="text" name="text_id1"
			size="30"
			value="<%=Helper.correctNull((String) hshValues.get("userid1"))%>"
			readOnly="readonly" /></td>
		<td width="49"><span id="idorgselect"> <a href="#"
			onClick="javascript:callSearch('1')"> <img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"> </a></span></td>
		<td width="271" align="center"><input type="text"
			name="text_name1" size="40"
			value="<%=Helper.correctNull((String) hshValues.get("username1"))%>"
			readOnly="readonly"></td>
		<td width="360" align="center"><input type="text"
			name="text_desig1" size="50"
			value="<%=Helper.correctNull((String) hshValues
									.get("desig1"))%>"
			readOnly="readonly"></td>
	</tr>
	<tr>
		<td width="184" align="center"><input type="text" name="text_id2"
			size="30"
			value="<%=Helper.correctNull((String) hshValues.get("userid2"))%>"
			readOnly="readonly" maxlength="30"></td>
		<td width="49"><span id="idorgselect"> <a href="#"
			onClick="javascript:callSearch('2')"> <img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"> </a></span></td>
		<td width="271" align="center"><input type="text"
			name="text_name2" size="40"
			value="<%=Helper.correctNull((String) hshValues.get("username2"))%>"
			readOnly="readonly"></td>
		<td width="360" align="center"><input type="text"
			name="text_desig2" size="50"
			value="<%=Helper.correctNull((String) hshValues
									.get("desig2"))%>"
			readOnly="readonly"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">&nbsp;</td>
	</tr>	
	<tr>
		<td colspan="4" align="center">
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames=' Edit _Save_Cancel_Delete_Print_Audit Trail' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="cattype" value=""></form>
</body>
</html>