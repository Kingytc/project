<%@include file="../share/directives.jsp"%>
<%
	String nfiles = "";
	String type = "";
	String goodfile = "";
	String badfile = "";
	String badrow = "";
	String ramdetails = "N";
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
	String appno = Helper.correctNull((String) session
			.getAttribute("strappno"));
	String prdcode = Helper.correctNull((String) session
			.getAttribute("prdcode"));
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String strPageName=Helper.correctNull((String)request.getParameter("flowtype"));
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


	ArrayList listRow=new ArrayList();
	ArrayList listCol=new ArrayList();

	listRow=(ArrayList)hshValues.get("arrRow");
	
	ArrayList listloanRow=new ArrayList();
	ArrayList listloanCol=new ArrayList();

	listloanRow=(ArrayList)hshValues.get("arrloanRow");

%>
<html>
<head>
<title>Appraisal - Reason For Manual Processing</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var vatypeofborrower="<%=Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER"))%>";
var varpurposeofloan="<%=Helper.correctNull((String)hshValues.get("COM_PURPOSE_OF_LOAN"))%>";
var varagriallied="<%=Helper.correctNull((String)hshValues.get("COM_AGRI_ALLIED"))%>";
var varpermact="<%=Helper.correctNull((String)hshValues.get("COM_PERM_ACT"))%>";
var varpermactelig="<%=Helper.correctNull((String)hshValues.get("COM_PERM_ACT_ELIGIBLE"))%>";
var varexposurelig="<%=Helper.correctNull((String)hshValues.get("COM_EXPOSUE_ELIGIBLE"))%>";
var varborroweravailed="<%=Helper.correctNull((String)hshValues.get("COM_BRW_AVAILED"))%>";
var varborroweravailedelig="<%=Helper.correctNull((String)hshValues.get("COM_BRW_AVAILED_ELIGIBIE"))%>";
var varrestrucheme="<%=Helper.correctNull((String)hshValues.get("COM_MSME_REST_SCHEME"))%>";
var varrestruchemeelig="<%=Helper.correctNull((String)hshValues.get("COM_MSME_RESTR_SCHEME_ELIG"))%>";
var varesolframework="<%=Helper.correctNull((String)hshValues.get("COM_RESOL_FW"))%>";
var varesolframeworkelig="<%=Helper.correctNull((String)hshValues.get("COM_RESOL_FW_ELIGIBLE"))%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var varealliedframework="<%=Helper.correctNull((String)hshValues.get("COM_RESTRUCTURE_ALLIED"))%>";
var varealliedframeworkelig="<%=Helper.correctNull((String)hshValues.get("COM_REST_ALLIED_ELIGIBLE"))%>";

function callonLoad()
{
	if(vatypeofborrower!=""){
		document.forms[0].sel_type_borrower.value=vatypeofborrower;
	}
	if(varpurposeofloan!=""){
		document.forms[0].sel_purpose.value=varpurposeofloan;
	}
	if(varpurposeofloan=="3"){
	if(varagriallied!=""){
		document.forms[0].sel_alliedactivity.value=varagriallied;
	}
	}
	if(varpermact!=""){
		document.forms[0].sel_per_Activity.value=varpermact;
	}
	if(varpermactelig!=""){
		document.forms[0].sel_per_Activity_eligible.value=varpermactelig;
	}
	if(varpermactelig!=""){
		document.forms[0].sel_Aggregate_eligible.value=varexposurelig;
	}
	if(vatypeofborrower=="1"){
	if(varborroweravailed!=""){
		document.forms[0].sel_whether_borrower.value=varborroweravailed;
	}
	if(varborroweravailed!=""){
		document.forms[0].sel_whether_borrower_eligible.value=varborroweravailedelig;
	}
	}
	if(vatypeofborrower=="3"){
		if(varrestrucheme!=""){
			document.forms[0].sel_restructure_scheme.value=varrestrucheme;
		}
		if(varrestruchemeelig!=""){
			document.forms[0].sel_restructure_scheme_eligible.value=varrestruchemeelig;
		}
	}

	if(vatypeofborrower=="2"){
		if(varesolframework!=""){
			document.forms[0].sel_resolution_framework.value=varesolframework;
		}
		if(varesolframeworkelig!=""){
			document.forms[0].sel_resolution_framework_eligible.value=varesolframeworkelig;
		}
	}

	if(vatypeofborrower=="4"){
		if(varealliedframework!=""){
			document.forms[0].sel_restructure_agriallied.value=varealliedframework;
		}
		if(varealliedframeworkelig!=""){
			document.forms[0].sel_restructure_agriallied_eligible.value=varealliedframeworkelig;
		}
	}
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


function doEdit()
{
	disablefields(false);
	enableButtons(true,false,false,false,true);
	document.forms[0].txt_present_morotorium.readOnly=true;
	if(document.forms[0].txt_gstn_number.length==undefined || document.forms[0].txt_gstn_number.length==1)
		{
			document.forms[0].txt_gstn_number.readOnly=true;
		}
		else
		{
			for(var i=0;i<document.forms[0].txt_gstn_number.length;i++)
			{
				document.forms[0].txt_gstn_number[i].readOnly=true;
			}
		}	
	
}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateRestruceAssessment";
	document.forms[0].hidBeanGetMethod.value="getRestruceAssessment";
	document.forms[0].hidSourceUrl.value="/action/app_restructure_assessment.jsp";
	document.forms[0].action=appURL+"controllerservlet";
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
		document.forms[0].hidBeanGetMethod.value="getRestruceAssessment";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].action=appURL+"action/app_restructure_assessment.jsp";
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
if(document.forms[0].sel_type_borrower.value=="0"||document.forms[0].sel_type_borrower.value=="")
{
	
			alert("Select Type of Borrower");
			document.forms[0].sel_type_borrower.focus();
			return false;
}

if(document.forms[0].sel_purpose.value=="0"||document.forms[0].sel_purpose.value=="")
{
	
			alert("Select purpose of the loan ");
			document.forms[0].sel_purpose.focus();
			return false;
}
if(document.forms[0].sel_purpose.value=="3"){
if(document.forms[0].sel_alliedactivity.value=="0"||document.forms[0].sel_alliedactivity.value=="")
{
	
			alert("Select allied Activity");
			document.forms[0].sel_alliedactivity.focus();
			return false;
}
}
if(document.forms[0].sel_per_Activity.value=="0"||document.forms[0].sel_per_Activity.value=="")
{
	
			alert("Enter Permitted activities under Resolution Frame work");
			document.forms[0].sel_per_Activity.focus();
			return false;
}

if(document.forms[0].sel_per_Activity.value=="6")
{

if(document.forms[0].txt_others.value=="")
{
	
			alert("Enter Other details");
			document.forms[0].txt_others.focus();
			return false;
}
}
if(document.forms[0].sel_per_Activity_eligible.value=="0"||document.forms[0].sel_per_Activity_eligible.value=="")
{
	
			alert("select Permitted activities under Resolution Frame work Eligibility");
			document.forms[0].sel_per_Activity_eligible.focus();
			return false;
}

if(document.forms[0].txt_Aggregate.value=="0"||document.forms[0].txt_Aggregate.value==""||document.forms[0].txt_Aggregate.value=="0.00")
{
	
			alert("Enter Aggregate exposure across all Member Lending Institutions (MLIs) as on March 31,2021");
			document.forms[0].txt_Aggregate.focus();
			return false;
}

if(document.forms[0].sel_Aggregate_eligible.value=="0"||document.forms[0].sel_Aggregate_eligible.value=="")
{
	
			alert(" Enter Aggregate exposure across all Member Lending Institutions (MLIs) as on March 31,2021 Eligibility");
			document.forms[0].sel_Aggregate_eligible.focus();
			return false;
}
if(document.forms[0].sel_type_borrower.value=="1")
{
	
	if(document.forms[0].sel_whether_borrower.value=="0"||document.forms[0].sel_whether_borrower.value=="")
	{
		
				alert("Enter whether borrower availed Resolution Framework 1.0");
				document.forms[0].sel_whether_borrower.focus();
				return false;
	}

	if(document.forms[0].sel_whether_borrower_eligible.value=="0"||document.forms[0].sel_whether_borrower_eligible.value=="")
	{
		
				alert("Enter whether borrower availed Resolution Framework 1.0 Eligibility");
				document.forms[0].sel_whether_borrower_eligible.focus();
				return false;
	}

	if(document.forms[0].sel_whether_borrower.value=="Y")
	{
		if(document.forms[0].txt_previous_mortorium.value=="")
		{
			
					alert("Enter Previous Moratorium Granted");
					document.forms[0].txt_previous_mortorium.focus();
					return false;
		}
		if(document.forms[0].txt_extended_date.value=="")
		{
			
					alert("Already extended Due date in CBS");
					document.forms[0].txt_extended_date.focus();
					return false;
		}
	}
}
if(document.forms[0].sel_type_borrower.value=="3")
{
	if(document.forms[0].sel_restructure_scheme.value=="0"||document.forms[0].sel_restructure_scheme.value=="")
	{
		
				alert("select Restructured under earlier MSME Restructuring Schemes ");
				document.forms[0].sel_restructure_scheme.focus();
				return false;
	}

	if(document.forms[0].sel_restructure_scheme_eligible.value=="0"||document.forms[0].sel_restructure_scheme_eligible.value=="")
	{
		
				alert("select Restructured under earlier MSME Restructuring Schemes  Eligibility");
				document.forms[0].sel_whether_borrower_eligible.focus();
				return false;
	}
}
if(document.forms[0].sel_type_borrower.value=="2")
{
	if(document.forms[0].sel_resolution_framework.value=="0"||document.forms[0].sel_resolution_framework.value=="")
	{
		
				alert("select Restructured under earlier Resolution Framework ");
				document.forms[0].sel_resolution_framework.focus();
				return false;
	}

	if(document.forms[0].sel_resolution_framework_eligible.value=="0"||document.forms[0].sel_resolution_framework_eligible.value=="")
	{
		
				alert("select Restructured under earlier Resolution Framework  Eligibility");
				document.forms[0].sel_whether_borrower_eligible.focus();
				return false;
	}
}
	if(document.forms[0].sel_type_borrower.value=="3")
	{
		if(document.forms[0].sel_restructure_scheme.value=="Y"){
			if(document.forms[0].sel_restructure_scheme_eligible.value=="Y"){
				alert("If Restructured under earlier MSME Restructuring Schemes Selected is Yes then  not eligible for restructure");
				document.forms[0].sel_restructure_scheme_eligible.focus();
				return false;
			}
		}
	}
	if(document.forms[0].sel_type_borrower.value=="2")
	{
		if(document.forms[0].sel_resolution_framework.value=="Y"){
			if(document.forms[0].sel_resolution_framework_eligible.value=="Y"){
				alert("If Restructured under earlier Resolution Framework Selected is Yes then  not eligible for restructure");
				document.forms[0].sel_resolution_framework_eligible.focus();
				return false;
			}
		}
	}
	if(document.forms[0].sel_type_borrower.value=="1")
	{
		if(document.forms[0].sel_whether_borrower.value=="Y"){
			if(document.forms[0].txt_previous_mortorium.value=="")
				document.forms[0].txt_previous_mortorium.value="0";
			if(document.forms[0].txt_present_morotorium.value=="")
				document.forms[0].txt_present_morotorium.value="0";
			var vartotalamt=eval(document.forms[0].txt_previous_mortorium.value)+eval(document.forms[0].txt_present_morotorium.value);
			var varmaxmortorium="24";
			if(vartotalamt>varmaxmortorium){
				alert(" Holiday period should be not be greater than 24 months");
				return false;
			}
		}
	}
	if(document.forms[0].sel_type_borrower.value=="4")
	{
		if(document.forms[0].sel_restructure_agriallied.value=="0"||document.forms[0].sel_restructure_agriallied.value=="")
		{
	
					alert("select Restructured under earlier Resolution Framework 1.0 ");
					document.forms[0].sel_restructure_agriallied.focus();
					return false;
		}

		if(document.forms[0].sel_restructure_agriallied_eligible.value=="0"||document.forms[0].sel_restructure_agriallied_eligible=="")
		{
			
					alert("select Restructured under earlier Resolution Framework  Eligibility 1.0");
					document.forms[0].sel_restructure_agriallied_eligible.focus();
					return false;
		}
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateRestruceAssessment";
	document.forms[0].hidBeanGetMethod.value="getRestruceAssessment";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/app_restructure_assessment.jsp";
	document.forms[0].submit();
}


function alliedactivityval(){
if(document.forms[0].sel_purpose.value=="3"){
	document.all.id_allied.style.display="table-row";
}
else {	
	document.all.id_allied.style.display = "none";
}	
}
function borrowertype(){
	if(document.forms[0].sel_type_borrower.value=="1"){
		document.all.id_borrower.style.display="table-row";
		document.all.val2.innerHTML="4";
		
	}
	else {	
		document.all.id_borrower.style.display= "none";
		document.all.val2.innerHTML="3";
	}	
	if(document.forms[0].sel_type_borrower.value=="2"){
		document.all.id_framework.style.display="table-row";
		document.all.val3.innerHTML="4";
	}
	else {	
		document.all.id_framework.style.display="none";
	}
	if(document.forms[0].sel_type_borrower.value=="3"){
		document.all.id_msme.style.display="table-row";
		document.all.val4.innerHTML="4";
	}
	else {	
		document.all.id_msme.style.display="none";
	}
	
	if(document.forms[0].sel_per_Activity.value=="6"){
		document.all.id_permit_Activity.style.display="table-row";
		
	}
	else {	
		document.all.id_permit_Activity.style.display="none"
		
	}
	if(document.forms[0].sel_type_borrower.value=="4"){
		document.all.id_agrialliedmsme.style.display="table-row";
		document.all.val6.innerHTML="4";
	}
	else {	
		document.all.id_agrialliedmsme.style.display="none";
	}
	if(document.forms[0].sel_type_borrower.value=="1" && document.forms[0].sel_whether_borrower.value=="Y"){
		document.all.id_borrower1.style.display="table-row";
		document.all.id_borrower2.style.display="table-row";
		document.all.id_borrower3.style.display="table-row";
		
	}
	else {	
		document.all.id_borrower1.style.display="none";
		document.all.id_borrower2.style.display="none";
		document.all.id_borrower3.style.display="none";
	}
}

function chkamtval(obj){
	var val2="50.00";
	if(eval(obj.value)>eval(val2))
	{	
	 
		alert("Aggregate exposure across all Member Lending Institutions (MLIs) Should not exceed Rs. 50.00 Crore as on March 31st 2021");
		obj.value="";
		return;
	}
	
}
function callCalender(cmdname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,cmdname);
	}
} 

function amtcheck(){


}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();alliedactivityval();borrowertype();">
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
		<td class="page_flow"> Home -&gt; Agriculture &amp; SME -&gt; Proposal -&gt; Assessment -&gt;Eligibility under resolution framework</td>
			<% } else {%>
		<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Assessment -&gt; Eligibility under resolution framework	</td>
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
		-&gt; Appraisal -&gt; Eligibility under Restructure</td>
	</tr>
</table>
<lapschoice:application /> <jsp:include page="../share/apprlinktab.jsp"
	flush="true">
	<jsp:param name="tabid" value="216" />
</jsp:include> <br>
<%
	}
%>

<tr>
	<td>
	<table width="64%" border="0" cellspacing="0" cellpadding="3"
		class="outertable" align="center">
		<tr class="dataheader">
			<td align="center"><b>Eligibility under Restructure</b></td>
		</tr>
	</table>
	</td>
</tr>
<tr>
	<td>
	<table width="80%" border="0" cellspacing="0" cellpadding="0"
		class="outertable" align="center">
		<tr>
			<td>
			<table width="80%" border="0" cellspacing="0" cellpadding="0"
				class="outertable" align="center">
				<tr>
					<td>
					<table width="80%" border="0" cellspacing="0" cellpadding="0"
						class="outertable" align="center">
					</table>
					</td>
				</tr>
				<tr class="datagrid">
					<td nowrap="nowrap">1.Type of Borrower</td>
					<td colspan="1"><select name="sel_type_borrower"
						onchange="borrowertype();">
						<option value="0">Select</option>
						<%if(listRow!=null && listRow.size()>0){
					for(int i=0;i<listRow.size();i++){
					listCol=(ArrayList)listRow.get(i);
					String strsector="";
					%>
					<option value="<%=listCol.get(0)%>"><%=listCol.get(1) %></option>
						<%}} %>
					</select></td>
				</tr>
				<tr class="datagrid">
					<td nowrap="nowrap">2.Purpose of the Loan</td>
					<td><select name="sel_purpose" onchange="alliedactivityval();">
						<option value="0">Select</option>
						<lapschoice:StaticDataTag apptype="261" />
					</select>&nbsp;&nbsp;&nbsp;<select name="sel_alliedactivity" id="id_allied"
						onchange="">
						<option value="0">Select</option>
						<lapschoice:StaticDataTag apptype="262" />
					</select></td>
				</tr>
				<tr>
					<td>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<table width="80%" border="0" cellspacing="0" cellpadding="3"
				class="outertable" align="center">
				<tr class="dataheader">
					<td align="center"><b>RBI Parameters</b></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<table width="80%" border="0" cellspacing="0" cellpadding="3"
				class="outertable" align="center">
				<tr>
				<tr class="dataheader">
					<td width="5%">S.No</td>
					<td width="40%">Parameters under</td>
					<td width="40%">Instant Case</td>
					<td width="15%">Eligible</td>
				</tr>
				<tr class="datagrid">
					<td>1.</td>
					<td nowrap="nowrap">Permitted activities under Resolution
					Frame work</td>
					<td><select name="sel_per_Activity" onchange="borrowertype();">
						<option value="0">Select</option>
						
				<%if(listloanRow!=null && listloanRow.size()>0){
					for(int i=0;i<listloanRow.size();i++){
					listloanCol=(ArrayList)listloanRow.get(i);
					%>
					<option value="<%=listloanCol.get(0)%>"><%=listloanCol.get(1) %></option>
						<%}} %>
						
					</select>
					<textarea id="id_permit_Activity"  name="txt_others" cols="40"
					rows="3" onKeyPress="notAllowSplChar(this);textlimit(this,999)"
					onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
									.get("COM_OTHER_LOAN"))%></textarea></td>
					<td><select name="sel_per_Activity_eligible"
						onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
				</tr>
				<tr class="datagrid">
					<td>2.</td>
					<td nowrap="nowrap">Aggregate exposure across all Member
					Lending Institutions (MLIs) as on March 31,2021</td>
					<td><input type="text" name="txt_Aggregate" size="18"
						onkeypress="allowAlphaNumeric();" value="<%=Helper.correctNull((String)hshValues.get("COM_EXPOSUE"))%>" maxlength="18" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);chkamtval(this)"><b>(Amount
					Rs. in Crores)</b></td>
					<td><select name="sel_Aggregate_eligible" onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
				</tr>
				<tr class="datagrid" id="id_borrower">
					<td>3.</td>
					<td nowrap="nowrap">whether borrower availed Resolution
					Framework 1.0</td>
					<td><select name="sel_whether_borrower" onchange="borrowertype();">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
					<td><select name="sel_whether_borrower_eligible" onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
				</tr>
				<tr class="datagrid" id="id_borrower1">
					<td nowrap="nowrap" id="val1">3.a)</td>
					<td nowrap="nowrap">Previous Moratorium Granted</td>
					<td colspan="2"><input type="text"
						name="txt_previous_mortorium" size="18"
						onKeyPress="allowInteger()" value="<%=Helper.correctNull((String)hshValues.get("COM_PREVIOUS_MOROTORIUM"))%>" maxlength="18"></td>

				</tr>
				<tr class="datagrid" id="id_borrower2">
					<td nowrap="nowrap">3.b)</td>
					<td nowrap="nowrap">Already extended Due date in CBS</td>
					<td colspan="2"d><input type="text" name="txt_extended_date" size="12"
							maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("COM_EXTENDED_DATE"))%>"
							onBlur="">
                      <a href="#"
							onClick="callCalender('txt_extended_date')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
					
				</tr>
				<tr class="datagrid" id="id_borrower3">
					<td nowrap="nowrap">3.c)</td>
					<td nowrap="nowrap">Present Moratorium Granted</td>
					<td colspan="2"><input type="text"
						name="txt_present_morotorium" size="18" style="background: #FFFFCC; font-weight: bold;text-align: right;"
						onKeyPress="allowInteger()" value="<%=Helper.correctNull((String)hshValues.get("loan_moratorium_ex"))%>" maxlength="18"></td>

				</tr>



				<tr class="datagrid">
					<td id="val2" >4.</td>
					<td nowrap="nowrap" >Whether GSTIN Registered</td>
					<%
					String strwhethergstrn=Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG"));
					if(strwhethergstrn.equalsIgnoreCase("Y")){
						strwhethergstrn="Yes";
					}else if(strwhethergstrn.equalsIgnoreCase("N")){
						strwhethergstrn="No";
					}else if (strwhethergstrn.equalsIgnoreCase("NA")){
						strwhethergstrn="Not Applicable";
					}else{
						strwhethergstrn="";
					}
					 %>
					<td  colspan="2"><input type="text"   name="txt_gstn_number" style="background: #FFFFCC; font-weight: bold;text-align: right;" value="<%=strwhethergstrn%>"><br/></td>
					</tr>
					<tr class="datagrid">
						<%if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("Y")){ %>
						<td id="val21" >a)</td>
						
						<td  nowrap="nowrap">GSTIN</td>
							<td colspan="2">
						<%
						String[] strArr1=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN")).split("@");
						for(int a=0;a<strArr1.length;a++)
						{
							%>
							
					<input type="text"   name="txt_gstn_number" style="background: #FFFFCC; font-weight: bold;text-align: right;" value="<%=strArr1[a] %>"><br/>
									 
						<%} } 
						else if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("N")){%>
							<td id="val21" >a)</td>
						
						<td  nowrap="nowrap">Whether GSTIN Exempted </td>
							<td colspan="2">
						<% String strexempted=Helper.correctNull((String)hshValues.get("COMINFO_GST_EXEMPTED"));
						if(strexempted.equalsIgnoreCase("Y")){
							strexempted="Yes";
							
						}else if(strexempted.equalsIgnoreCase("N")){
							strexempted="No";
						}else{
							strexempted="";
						}
						%>
						<input type="text"   name="txt_gstn_number" style="background: #FFFFCC; font-weight: bold;text-align: right;" value="<%=strexempted%>"><br/>
						
						<%} else{%>
			        		<td colspan="4"><input type="hidden"   name="txt_gstn_number" style="background: #FFFFCC; font-weight: bold;text-align: right;" value=""><br/></td>
						
						<%} %>
						</td>
				</tr>
				<tr class="datagrid" id="id_msme">
					<td id="val3">4.</td>
					<td nowrap="nowrap">Restructure under earlier MSME Restructuring Schemes</td>
					<td><select name="sel_restructure_scheme" onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
					<td><select name="sel_restructure_scheme_eligible" onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
				</tr>
				<tr class="datagrid" id="id_framework">
					<td id="val4">4.</td>
					<td nowrap="nowrap">Restructured under earlier Resolution
					Framework 1.0</td>
					<td><select name="sel_resolution_framework" onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
					<td><select name="sel_resolution_framework_eligible"
						onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
					</select></td>
				</tr>
				
				<tr class="datagrid" id="id_agrialliedmsme">
					<td id="val6">4.</td>
					<td nowrap="nowrap"> Restructure under earlier Resolution frame work 1.0</td>
					<td><select name="sel_restructure_agriallied" onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
					<td><select name="sel_restructure_agriallied_eligible" onchange="">
						<option value="" selected>---select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>

					</select></td>
				</tr>
			</table>

			</td>
		</tr>

		<tr>
			<td></td>
		</tr>
	</table>

	<br>
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
		btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
	<lapschoice:hiddentag pageid='<%=PageId%>' /> <iframe height="0"
		width="0" name="ifrmsancauthority" frameborder="0" style="border: 0"></iframe>
	<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0"
		style="border: 0"></iframe> <input type="hidden" name="radLoan"
		value="Y"> <input type="hidden" name="prdcode"
		value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
	<input type="hidden" name="hidValid" value="Y"> <input
		type="hidden" name="hidInterestType"
		value="<%=Helper.correctNull((String) hshValues
									.get("loan_inttype"))%>">
									<input type="hidden" name="hid_GSTINNO">
									<input type="hidden" name="flowtype1" value="<%=strPageName %>">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
	<iframe name="ifrm" width="0" height="0" border="0"></iframe> <iframe
		name="ifrminterest" width="0" height="0" border="0"></iframe>
		
</form>
</body>
</html>