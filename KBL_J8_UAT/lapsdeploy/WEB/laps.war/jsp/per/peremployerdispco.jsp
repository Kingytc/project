<%@include file="../share/directives.jsp"%>
<%String empdet = Helper.correctNull((String) hshValues	.get("peremploy"));
String strEmployment=(String)session.getAttribute("strEmployment");

	String pageid = request.getParameter("pageid");
	String strapptype = request.getParameter("corp");
	String strApplnt = Helper.correctNull((String) request.getParameter("applnt"));
	if (strApplnt.equals("C")) {
		strApplnt = "CoApplicant";
	} else {
		strApplnt = "Guarantor";
	}
	String strSelConfEmp=Helper.correctNull((String) hshValues.get("peremp_confemp"));
	String strSelListComp=Helper.correctNull((String) hshValues.get("peremp_listcomp"));
	String strSelDeal=Helper.correctNull((String) hshValues.get("peremp_dealing"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/peremployerdispco.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var vardesig = "<%=Helper.correctNull((String)hshValues.get("peremp_empdesig"))%>";
var varemploy = "<%=Helper.correctNull((String)hshValues.get("peremploy"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var Category = "<%=Helper.correctNull((String)hshValues.get("peremp_category"))%>";
var buspremises ="<%=Helper.correctNull((String)hshValues.get("peremp_lease"))%>";
var varOccupation="<%=Helper.correctNull((String)hshValues.get("peremp_occupation"))%>";
var varStaff="<%=Helper.correctNull((String)hshValues.get("perapp_istaff"))%>";

function callDemographics()
{
	var applnt=document.forms[0].applntype.value;
	if(isNaN(value1))
	{
		//alert("no permission");
	}else
	{
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		document.forms[0].action=appURL+"action/perapplicantdispco.jsp?applnt="+applnt;
		document.forms[0].submit();
	}
}

function callIncome()
{
	if(isNaN(value1))
	{
		//alert("no permission");
	}else
	{	
		var applnt=document.forms[0].applntype.value;
		document.forms[0].hidBeanGetMethod.value="getIncome";
		document.forms[0].action=appURL+"action/perincexpensesdispco.jsp?applnt="+applnt;
		document.forms[0].submit();
	}
}

function callKYCNorms()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
		document.forms[0].action=appURL+"action/perkycnormsdisp.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function setValues()
{
	var varConfEmp="<%=strSelConfEmp%>";
	var varListcomp="<%=strSelListComp%>";
	var varDeal="<%=strSelDeal%>";
	if(varConfEmp == "")
		document.forms[0].sel_confemp.value="0";
	else
		document.forms[0].sel_confemp.value=varConfEmp;
	if(varListcomp == "")
		document.forms[0].sel_listcom.value="0";
	else
		document.forms[0].sel_listcom.value=varListcomp;
	if(varDeal == "")
		document.forms[0].sel_empdeal.value="0";
	else
		document.forms[0].sel_empdeal.value=varDeal;
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();setValues();">
<form name="appform" method="post" action="newapplicantDBase.jsp" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="25" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="25"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="25"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
<%if (!strCategoryType.equalsIgnoreCase("OPS")) { %>
<%if(strapptype.equalsIgnoreCase("C")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;
		<%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
		Agriculture -&gt;
		<%}else{%>
		Corporate &amp; SME -&gt;
		<%} %>
		
		 Application -&gt; Applicant-&gt; customer profile -&gt; Employment details</td>
	</tr>
  </table>
<%}else if(strapptype.equalsIgnoreCase("R")){ %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="<%=pageid%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; 
<%  if(strCategoryType.equals("AGR")){ %>Agriculture <% }
	else if(strCategoryType.equals("LAD"))
	{
	%> Loan Against Gold Ornaments &amp; Deposits  
	<%} 
     else { %> Retail(including schematic) <%} %> -&gt; Application -&gt; Applicant/Guarantor
		-&gt; Employment Details</td>
	</tr>
</table>
<%} %>
<lapschoice:application />
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">			
			<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%} if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
		<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="25"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table><%} %>
<%} else if (strCategoryType.equalsIgnoreCase("OPS")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="25" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Promoter -&gt; Employment</td></tr></table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<lapschoice:TerPromoterTag pageid="4" />
<%}}%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td><b> <%if (empdet.equalsIgnoreCase("1") && !empdet.equalsIgnoreCase("9")) {%> 
						Current Employment Details <%} else {%> Self Employment Details <%}%> </b></td>
					</tr>
				</table>
				</td>
			</tr>
			
			<tr>
	<td>
		<table  width="100%" border="1" cellpadding="2" cellspacing="5" class="outertable">
			<tr>
				<td width="40%">
					<table  width="100%" border="0" cellpadding="2" cellspacing="5" class="outertable">
				<tr>
					<td width="4%" nowrap> <%
 					if (empdet.equalsIgnoreCase("1") && !empdet.equalsIgnoreCase("9")) {
 				%> Employer Name  <%
 				} else {
 			%> Company Name <%
 				}
 					%> <span class="mantatory" id="empname">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_name"
									maxlength="100" size="40"
									value="<%=Helper.correctNull((String) hshValues
									.get("peremp_name"))%>"
									onKeyPress="notAllowSingleQuote()" tabindex="1"> <input
									type="hidden" name="txtperemp_name1" size="15" maxlength="20"
									value="<%=Helper.correctNull((String) hshValues
									.get("company_name"))%>"
									onKeyPress="allowAlphabets()">
									<span onClick=""
									style="cursor: hand"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="2"></span>
					</td>
				</tr>
				<tr>
					<td width="4%">Address <span class="mantatory" id="add">*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txtperemp_address1"
							size="30" maxlength="50" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_address1"))%>"
							onKeyPress="notAllowedDouble()"></td>
				</tr>
				<tr>
				<td width="4%">&nbsp;</td>
				<td width="30%"><input type="text" name="txtperemp_address2"
							size="30" maxlength="25" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_address2"))%>"
							onKeyPress="notAllowedDouble()"></td>
				</tr>
				<tr>
					<td width="4%">Village / Taluk</td>
					<td width="30%"><input type="text" name="txtperemp_address3" size="30" maxlength="50" tabindex="5"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_address3"))%>"
							onKeyPress="notAllowedDouble()"></td>
				</tr>
				<tr>
					<td width="4%">City<span class="mantatory" id="city">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_city" size="30" maxlength="20"
									value="<%=Helper.correctNull((String) hshValues.get("peremp_city"))%>"
									onKeyPress="notAllowSplChar()"> <a href="#"
									onClick="showCitySearch('txtperemp_city','txtperemp_state','hidcity','hidstate','txtperemp_zip','hidzip')"
									style="cursor: hand"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="6"></a></td>
				</tr>
				<tr>
					<td width="4%">State<span class="mantatory" id="state">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_state"
							size="30" maxlength="50"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_state"))%>"
							onKeyPress="" onBlur=""
							tabindex="7"></td>
				</tr>
				<tr>
					<td width="4%"><%=ApplicationParams.getZipName()%><span class="mantatory" id="pin">*&nbsp;</span></td>
					<td ><input type="text" name="txtperemp_zip"
							size="8" maxlength="6" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_zip"))%>"
							onKeyPress=""
							onBlur=""></td>
				</tr>
				<tr>
					<td width="4%">Phone No.<span class="mantatory" id="phone">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_phone" size="18" maxlength="15" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_phone"))%>"
							onKeyPress="allowInteger()"></td>
				</tr>
				<tr>
					<td width="4%">FAX No.</td>
					<td><input type="text" name="txtperemp_fax" size="12" maxlength="15" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_fax"))%>"
							onKeyPress="allowInteger()"></td>
				</tr>
				<tr>
					<td width="4%">Company E-mail</td>
					<td><input type="text" name="txtperemp_email" maxlength="50" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_email"))%>"
							onBlur="" size="30"></td>
				</tr>
				</table>
				</td>
				<td width="60%">
					<table  width="100%" border="0" cellpadding="2" cellspacing="5" class="outertable">
				<tr>
					<td width="6%" nowrap="nowrap">Employee Id<span class="mantatory" id="empid">*&nbsp;</span></td>
					<td width="35%" id="emp1"><input type="text"
							name="txtperemp_empno" size="12" maxlength="9" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues
									.get("peremp_empno"))%>"
							onKeyPress="notAllowSplChar()"></td>
					<td width="20%" >Experience in years<span class="mantatory">*&nbsp;</span></td>
					<td width="39%"><input type="text" name="txt_expinyrs" size="4"
							maxlength="4" 
							value="<%=Helper.correctNull((String) hshValues.get("peremp_expinyrs"))%>"></td>
				</tr>
				<tr>
					<td width="6%" nowrap="nowrap">Designation</td>
					<td><input type="text" name="txtperemp_Designation"
									size="20" maxlength="60"
									value="<%=Helper.correctNull((String) hshValues.get("peremp_design"))%>"
									onKeyPress="notAllowSplChar()"><input type="hidden"
									name="txtperemp_Desigcode" size="15" maxlength="20"
									value="<%=Helper.correctNull((String) hshValues.get("peremp_design"))%>"
									onKeyPress="allowAlphabets()"></td>
				<td width="6%">
						<%
							if (empdet.equalsIgnoreCase("9")) {
						%> Pension <%
							} else {
						%> Salary <%
							}
						%> Receipt Date <span class="mantatory" id="rec">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_receipt"
									value="<%=Helper.correctNull((String) hshValues
							.get("peremp_receipt"))%>"
									onBlur="">&nbsp;<a  style="vertical-align: middle;" href="#" onClick=""
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0" tabindex="19"></a></td>
				</tr>
				<tr>	
					<td width="6%">Department Name</td>
					<td><input type="text"
							name="txtperemp_department" size="35" maxlength="50"
							tabindex="17"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_department"))%>"
							onKeyPress="notAllowSplChar()"></td>
					<td >Date of Commencement<span id="est" class="mantatory">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_establish" size="11"
									value="<%=Helper.correctNull((String) hshValues.get("peremp_establish"))%>"
									onBlur="">&nbsp;<a style="vertical-align: middle;" href="#"
									onClick="" title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0" tabindex="22"></a></td>
				</tr>
				<tr>
					<td width="6%" >Retirement Date<span id="ret" class="mantatory">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_retdate" size="11" maxlength="10"
									value="<%=Helper.correctNull((String) hshValues.get("peremp_retdate"))%>"
									onBlur="">&nbsp;<a style="vertical-align: middle;" href="#" onClick=""
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0" tabindex="21"></a></td>
					<td width="6%">Years of service</td>
					<td><input type="text" name="txtserviceleft"
							size="3" maxlength="2" onKeyPress="" readOnly
							value="<%=Helper.correctNull((String) hshValues.get("peremp_servleft"))%>">&nbsp;Years&nbsp;<input type="text" name="txt_servicemonths" size="3"
							maxlength="2" onBlur="" onKeyPress="" readOnly
							value="<%=Helper.correctNull((String) hshValues.get("peremp_servleftmon"))%>">&nbsp;Months</td>
				</tr>
				<tr>
				<td width="6%" id="t1"> Contact Person</td>
				<td id="t2"><input type="text" name="peremp_contperson" size="25" maxlength="50" tabindex="25"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_contperson"))%>"
							onKeyPress="notAllowedDouble();allowAlphabets()"></td>
				<td>&nbsp;</td><td>&nbsp;</td>
				</tr>
				<tr id="id_conemp">
					<td width="6%" colspan="2">Whether a confirmed employee<span class="mantatory">*&nbsp;</span></td>
					<td colspan="2"><select name="sel_confemp">
					<option value="0">--Select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					</select></td>
				</tr>
				<tr id="id_list">
					<td width="6%" colspan="2">Whether an employee of listed company, school/college/university and of any other entity permitted by credit department<span class="mantatory">*&nbsp;</span></td>
					<td colspan="2"><select name="sel_listcom" onchange="callemp();">
					<option value="0">--Select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					</select></td>
				</tr>
				<tr id="id_empdeal">
					<td width="6%" colspan="2">Whether an employer is dealing with our bank<span class="mantatory">*&nbsp;</span></td>
					<td colspan="2"><select name="sel_empdeal" onchange="callnoofyrs();">
					<option value="0">--Select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					</select></td>
				</tr>
				<tr id="id_noofyrs">
					<td>No of Years<span class="mantatory">*&nbsp;</span></td>
					<td><input type="text" name="txt_noofyears" size="4"
							maxlength="4" onBlur="" onKeyPress=""
							value="<%=Helper.correctNull((String) hshValues.get("peremp_noofyrs"))%>"></td>
							<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td>Past Experience</td>
					<td colspan="3"><textarea name="txtperemp_experience" cols="30"
							%="%" onKeyPress="textlimit(this,2999);notAllowSplChar()" onKeyUp="textlimit(this,2999)"
							tabindex="28"><%=Helper.correctNull((String) hshValues.get("peremp_experience"))%></textarea></td>
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
<br>
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidApp_type" value="A"> 
<INPUT TYPE="hidden" name="page" value="ep">
<INPUT TYPE="hidden" name="hidAppType"> 
<INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>"> 
<INPUT TYPE="hidden" name="pageid" value="<%=pageid%>"> 
<INPUT TYPE="hidden" name="hidPage" value="<%=pageid%>"> 
<INPUT TYPE="hidden" name="applntype" value="<%=(String)request.getParameter("applnt")%>">
<input type="hidden" name="otherGetMethod" value=""> 
<input type="hidden" name="cmdsave" value="" disabled> 
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="hidEmployment" value="<%=Helper.correctNull((String)request.getParameter("hidEmployment"))%>">
</form>
</body>
</html>
