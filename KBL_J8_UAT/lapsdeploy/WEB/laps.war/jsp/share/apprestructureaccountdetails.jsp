<%@include file="../share/directives.jsp"%>
<%
String strPgDist = Helper.correctNull(request.getParameter("hiPgDist"));
String loan_type=Helper.correctNull((String)hshValues.get("app_loantype"));
String strLAPSOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
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
%>
<html>
<head>
<title></title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varorg_level="<%=Helper.correctNull((String)hshValues.get("remarksorglevel"))%>";
var varapp_level="<%=Helper.correctNull((String)hshValues.get("remarksapplevel"))%>";
var sanc_date="<%=Helper.correctNull((String)hshValues.get("sanc_date"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var varOrgCode="<%=strLAPSOrgCode%>";
var varloantype="<%=loan_type%>";
var varUserID="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var curr_date = "<%=Helper.getCurrentDateTime()%>";
function callOtherTab(val)
{
	var strCatType="<%=strCategoryType%>";
	if(document.forms[0].cmdsave.disabled)
	{	
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
		document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
		document.forms[0].action=appURL+"action/apprestructureaccountdetails.jsp";
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
		document.forms[0].hidBeanMethod.value="updRestrFacilityDetails";
		document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/apprestructureaccountdetails.jsp";
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
	if(varOrgCode == "001001000000000")
	{
		disableFields(false);
		disableCommandButtons("edit");	
		document.forms[0].select_facility.disabled=true;
		document.forms[0].hidAction.value ="update";
	}
	else
	{
		alert("Only a CPC user can access this page");
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
		enableButtons(true,true,false,false,false,true);
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
	if(document.forms[0].txt_effectivedate.value=="")
	{
		alert("Enter Effective Date");
		document.forms[0].txt_effectivedate.value="";
		document.forms[0].txt_effectivedate.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updRestrFacilityDetails";
	document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/apprestructureaccountdetails.jsp";
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
	document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
	document.forms[0].action = appURL+"action/apprestructureaccountdetails.jsp?facility="+facility;
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
function callLoanAccount()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action=appURL+"action/apploanaccount.jsp";
	document.forms[0].submit();
}

function checkeffdate(obj,mindate,maxdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	var maxdt=changeDateformat(maxdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) < Date.parse(mindt))
		{
			alert("Date cannot be less than the sanction date ("+mindate+")");
			obj.value="";
			obj.focus();
		}
		else if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date cannot be greater than today date ("+maxdate+")");
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
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
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
		<%}%>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<%if(strSessionModuleType.equals("AGR")){%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt;
		WorkFlow -&gt; Restructure Effective Date</td>
	</tr>
	<%}else{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp;SME -&gt;
		Proposal -&gt; WorkFlow -&gt; Restructure Effective Date </td>
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
				<td class="sub_tab_inactive"><a	href="#" onclick="javascript:callComment()">Comments</a></td>
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
				<%if (Helper.correctNull((String) hshValues.get("app_legalcomp")).equalsIgnoreCase("Y")){ %>
				<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onClick="javascript:callOtherTab('legcomp')">Legal
				Compliance Certificate</a></td>
				<%} %>
				<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"> <a href="#"
					onClick="javascript:callLoanAccount()" >Loan Account Details</a></td>
					
				<td class="sub_tab_active"  nowrap="nowrap">Restructure Effective Date</td>
				
				<%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) { %>
				<td id="action" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('facdetail')">Facility Details</a></td>
				<%}
				%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
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
	<tr id="idfacility">
		<td width="20%" nowrap="nowrap">Facility&nbsp;<span
			class="mantatory">*</span></td>
		<td><SELECT NAME="select_facility" onChange="callfacility()"
			TABINDEX="1" STYLE="width: 200">
			<option value="0" selected="selected">---Select---</option>
			<lapschoice:loanaccountdetails apptype="S"/>
		</SELECT></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">Effective Date &nbsp;<span class="mantatory">*</span></td>
		<td>
		<table width="100%" border="0">
			<tr>
				<td width="21%"><input type="text" name="txt_effectivedate" size="16"
					onBlur="checkDate(this);checkeffdate(this,sanc_date,curr_date);"
					value="<%=Helper.correctNull((String)hshValues.get("restr_eff_date"))%>">
				</td>
				<td width="79%"><a alt="Select date from calender" href="#"
					onClick="callCalender('txt_effectivedate')"
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


