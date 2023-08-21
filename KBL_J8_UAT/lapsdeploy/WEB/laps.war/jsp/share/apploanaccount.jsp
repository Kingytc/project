<%@include file="../share/directives.jsp"%>
<%
String strPgDist = Helper.correctNull(request.getParameter("hiPgDist"));
String loan_type=Helper.correctNull((String)hshValues.get("app_loantype"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strfacility = Helper.correctNull((String) hshValues
		.get("strfacility"));
String facility="";
if(!strfacility.equalsIgnoreCase(""))
{
	facility=strfacility;
}
else
{
	facility="0";
}
String strProposalType = Helper.correctNull((String)session.getAttribute("strAppType"));
String Strprdtype=Helper.correctNull((String)hshValues.get("Strprdtype"));
//out.print(hshValues);
%>
<html>
<head>
<title></title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varorg_level="<%=Helper.correctNull((String)hshValues.get("remarksorglevel"))%>";
var varapp_level="<%=Helper.correctNull((String)hshValues.get("remarksapplevel"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var varloantype="<%=loan_type%>";
var varUserID="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
function callOtherTab(val)
{
	var strCatType="<%=strCategoryType%>";
	if(document.forms[0].cmdsave.disabled)
	{	
		<%if(strSessionModuleType.equalsIgnoreCase("DIGI")&& !Strprdtype.equalsIgnoreCase("pB")){
			%>
		
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
	if(val=="facdetail")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
		document.forms[0].action=appURL+"action/appfacilitydetails.jsp";
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
	disableFields(true);
	document.forms[0].select_facility.disabled=false;
	document.forms[0].select_facility.value="<%=facility%>";
	if(varloantype=="P")
	{
		document.all.idfacility.style.visibility="hidden";
		document.all.idfacility.style.position="absolute";
		document.forms[0].select_facility.value="1";
	}
	else
	{
		document.all.idfacility.style.visibility="visible";
		document.all.idfacility.style.position="relative";
	}
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		if(document.forms[0].select_facility.value=="0")
		{
			enableButtons(true,true,true,true,true,false);
		}
		else
		{
			enableButtons(false,false,true,true,true,false);
		}
	}
	else
	{	
		disableFields(true);
		if(document.forms[0].select_facility.value=="0")
		{
			enableButtons(true,true,true,true,true,false);
		}
		else
		{
			enableButtons(false,false,true,true,true,false);
		}
	}
	if(varUserID!=document.forms[0].appholder.value)
	{
		if(document.forms[0].select_facility.value=="0")
		{
			document.forms[0].cmdedit.disabled=true;  
		}
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

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].select_facility.disabled=false;
		document.forms[0].hidBeanId.value="commworkflow"
		document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/apploanaccount.jsp";
		document.forms[0].submit();
	}	
}

function doDelete()
{	
	if(ConfirmMsg(101))
	{
		document.forms[0].select_facility.disabled=false;
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="commworkflow"
		document.forms[0].hidBeanMethod.value="updateLoanAccountData";
		document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/apploanaccount.jsp";
 		document.forms[0].submit();
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
function doEdit()
{
	disableFields(false);
	disableCommandButtons("edit");	
	document.forms[0].select_facility.disabled=true;
	document.forms[0].hidAction.value ="update";
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
function doSave()
{		
	document.forms[0].select_facility.disabled=false;
	if(document.forms[0].select_facility.value=="0")
	{
		alert("Select Facility");
		document.forms[0].select_facility.focus();
		return;
	}
	if(document.forms[0].txt_flowstartdate.value=="")
	{
		alert("Enter Flow Start Date");
		document.forms[0].txt_flowstartdate.value="";
		document.forms[0].txt_flowstartdate.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateLoanAccountData";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/apploanaccount.jsp";
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
function callfacility()
{
	var facility=document.forms[0].select_facility.value;
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action = appURL+"action/apploanaccount.jsp?facility="+facility;
	document.forms[0].submit();
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}
function callComment()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
	document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
	document.forms[0].submit();
}
function checkthismonth(obj)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var vartoday=new Date();
	var varlastdayofMonth=new Date(vartoday.getFullYear(),vartoday.getMonth()+1,0);
	var varday=varlastdayofMonth.getDate();
	if(varday<10)varday='0'+varday;
	var varmonth=varlastdayofMonth.getMonth()+1;
	if(varmonth<10)varmonth='0'+varmonth;
	var varyear=varlastdayofMonth.getFullYear();
	var maxdate=varday+"/"+varmonth+"/"+varyear;
	var maxdt=changeDateformat(maxdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) <= Date.parse(maxdt))
		{
			alert("Date should be greater than " +maxdate );
			obj.value="";
			obj.focus();
		}
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="remarks" method="post" class="normal">
<%if(strProposalType.equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="136" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="9" />
			<jsp:param name="subpageid" value="121" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>	
<%}

}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
			<% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
		<%if(loan_type.equalsIgnoreCase("P")){%> <jsp:include
			page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
		</jsp:include> <%}else if(loan_type.equalsIgnoreCase("E") || loan_type.equalsIgnoreCase("U") || loan_type.equalsIgnoreCase("H")  || loan_type.equalsIgnoreCase("T")){%>
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
		<%}}%>
		<% if (strSessionModuleType.equalsIgnoreCase("DIGI")) {
		%> <jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
		<jsp:param name="pageid" value="7" />
	</jsp:include> <%
	} %>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<%if(strSessionModuleType.equals("AGR")){%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt;
		WorkFlow -&gt; Comments</td>
	</tr>
	<%}else if(strSessionModuleType.equalsIgnoreCase("DIGI")){%>
	<tr>

		<td class="page_flow">Home -&gt; Digi Retail  -&gt; Proposal -&gt; WorkFlow -&gt;  Loan Account Details</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("SRE")){%>
	<tr>

		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Review/Extension -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("STL")){ %>
	<tr>

		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Term Loan -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("ADC")){ %>
	<tr>

		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc
		Limit -&gt; WorkFlow -&gt; Comment</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("OPS")){ %>
	<tr>

		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt;
		WorkFlow -&gt; Comment</td>
	</tr>
	<%}
	else if(strCategoryType.equals("LAD"))
    {
    %>
	<tr>
		<td class="page_flow">Home -&gt; Loan Against Gold Ornaments
		&amp; Deposits -&gt; WorkFlow -&gt; Loan Account Details</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("AGR")){ %>
	<tr>

		<td class="page_flow">Home -&gt; Agriculture -&gt; Application
		-&gt; WorkFlow -&gt; Loan Account Details</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("RET")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt;Application -&gt;
		WorkFlow -&gt; Loan Account Details</td>
	</tr>
	
	<%}else{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp;SME -&gt;
		Proposal -&gt; WorkFlow -&gt; Loan Account Details </td>
	</tr>
	<%}%>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable"
			width="80%">
			<tr align="center">
				<td class="sub_tab_inactive"><a
					href="javascript:callOtherTab('history')">History</a></td>
				<!-- <td class="sub_tab_inactive"><a	href="#" onclick="javascript:callComment()">Comments</a></td> -->
								<% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
				
				<td class="sub_tab_inactive"><a  href="#" onClick="javascript:callQueries()">Queries</a></td>
				<%} %>
				<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A") || loan_type.equalsIgnoreCase("T") || loan_type.equalsIgnoreCase("H") || loan_type.equalsIgnoreCase("U") || loan_type.equalsIgnoreCase("E"))
			        { %>
				<td id="action" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('sanction')">Proposed facility Approve/Reject
				</a></td>
				<%}%>
				<td id="action" class="sub_tab_inactive"><a
					href="#" onclick="javascript:callOtherTab('action')">Action</a></td>
				<%
				if((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))
				{
				if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive" id="idCGTMSEtxn"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
				<%} else { %>
					<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
				<% } } %>
				<% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
				<%} %>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>
				<%if (Helper.correctNull((String) hshValues.get("app_legalcomp")).equalsIgnoreCase("Y")){ %>
				<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onClick="javascript:callOtherTab('legcomp')">Legal
				Compliance Certificate</a></td>
				<%} %>
				<td class="sub_tab_active"  nowrap="nowrap">Loan Account Details</td>
				<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
					<%}else{ %>
				<td>	<input type="hidden" id="idrestr"></td>
					<%} %>
				<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) { %>
				<td id="action" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('facdetail')">Facility Details</a></td>
				<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<%} %>
<TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="5"
	ALIGN="center" CLASS="outertable border1">
	<TR>
		<TD VALIGN="top">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1"
					CLASS="outertable">
					<TR>
					<td>
<table width="75%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<%if(!facility.equalsIgnoreCase("0")){ %>
	<tr>
	<td colspan="2">
		<table width="60%" border="0"  cellspacing="3" cellpadding="3"
	class="outertable" >
			<tr>
				<td width="10%" class="dataheader" align="center">&nbsp;<b>Status :</b> </td>
				<td width="20%"  class="datagrid"><b><%=Helper.correctNull((String)hshValues.get("strStatusDesc")) %></b>&nbsp;</td>
				<%if(Helper.correctNull((String)hshValues.get("strStatus")).equalsIgnoreCase("ca")){%>
				<td  width="10%" class="dataheader" align="center"><b>Date </b></td>
				<td width="20%"  class="datagrid"><b>&nbsp;<%=Helper.correctNull((String)hshValues.get("strCloseDate")) %></b>&nbsp;</td>
				<%}%>
			</tr>
		</table>
		</td>
	</tr>
	<%} %>
	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr id="idfacility">
		<td width="20%" nowrap="nowrap">Facility&nbsp;<span
			class="mantatory">*</span></td>
		<td><SELECT NAME="select_facility" onChange="callfacility()"
			TABINDEX="1" STYLE="width: 200">
			<option value="0" selected="selected">---Select---</option>
			<lapschoice:loanaccountdetails apptype="F"/>
		</SELECT></td>
	</tr>
	
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">Installment Start Date &nbsp;<span class="mantatory">*</span></td>
		<td>
		<table width="100%" border="0">
			<tr>
				<td width="21%"><input type="text" name="txt_flowstartdate" size="16"
					onBlur="checkDate(this);checkthismonth(this);"
					value="<%=Helper.correctNull((String)hshValues.get("flow_start_date"))%>">
				</td>
				<td width="79%"><a alt="Select date from calender" href="#"
					onClick="callCalender('txt_flowstartdate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</td>
</tr>
<tr>
<td>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trial"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</td>
</tr>
</TABLE>
</TD>
</TR>
</TABLE>
	
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidDemoId"
	value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
<INPUT TYPE="hidden" name="hidAppNo"
	VALUE=<%=Helper.correctNull((String)request.getParameter("appno"))%>>
<INPUT TYPE="hidden" name="radLoan" value="Y"> <input
	type="hidden" name="cattype" value="<%=strCategoryType%>">
	<INPUT TYPE="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("loan_sno"))%>">
	<input type="hidden" name="hidLoantype" value="<%=loan_type%>">	
	</form>
</body>
</html>


