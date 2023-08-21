<%@include file="../share/directives.jsp"%>
<%String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
			String tempProfile = "";
			if (strProfilestatus.equalsIgnoreCase("Y")) {
				tempProfile = "Completed";
			} else {
				tempProfile = " Not Completed";
			}
			String strModuleName = Helper.correctNull(request
					.getParameter("hidModuleName"));
			String strModName = "";
			if (strModuleName.equalsIgnoreCase("T")) {
				strModName = "Tertiary";
			} else if (strModuleName.equalsIgnoreCase("P")) {
				strModName = "Retail";
			} else {
				strModName = "Corporate & SME";
			}
			String strCattype=Helper.correctNull(request.getParameter("hidCategoryType"));
			String strappname=Helper.correctNull((String)request.getParameter("txtperapp_fname"));
			if(strappname.equals(""))
			{
				strappname=Helper.correctNull((String)request.getParameter("hidapp_name"));
			}
		String appid = Helper.correctNull((String)hshValues.get("perapp_id"));		
		String pageid = Helper.correctNull((String) request.getParameter("pageid"));
		String strEmployment=(String)session.getAttribute("strEmployment");
		String strapptype=(String)request.getParameter("corp");
		String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Personal - Applicant KYC NORMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
var varcusttype="<%=Helper.correctNull((String)hshValues.get("custtype"))%>";
var varform="<%=Helper.correctNull((String)hshValues.get("form"))%>";
var varaccount="<%=Helper.correctNull((String)hshValues.get("account"))%>";
var varofac="<%=Helper.correctNull((String)hshValues.get("ofac"))%>";
var varremittance="<%=Helper.correctNull((String)hshValues.get("remittance"))%>";
var varsleeppartner="<%=Helper.correctNull((String)hshValues.get("kyc_sleeppartner"))%>";
var varpoliticalexpose="<%=Helper.correctNull((String)hshValues.get("kyc_politicalexposed"))%>";
var varfamilyshare="<%=Helper.correctNull((String)hshValues.get("kyc_familyshare"))%>";
var varcons="<%=Helper.correctNull((String)hshValues.get("perapp_constitution"))%>";
var varstatus="<%=Helper.correctNull((String)hshValues.get("perapp_status"))%>";
var ownership="<%=Helper.correctNull((String)hshValues.get("comapp_ownership"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varactivitycode="<%=Helper.correctNull((String)hshValues.get("activitycode"))%>";
function callLoad()
{
	disableFields(true);

	if(varactivitycode!="")
	{
		
		document.forms[0].hid_Activity.value=varactivitycode;
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
		else if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
		else if(document.forms[0].elements[i].type=="checkbox")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
	}
}
</SCRIPT>
</head>
<body onload="callLoad()">
<form name="appform" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="23" />
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
			<jsp:param name="subsubpageid" value="23"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="23"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
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
   <%

if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt;Application -&gt; Applicant -&gt; Customer Profile -&gt; KYC Norms</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant -&gt; Customer Profile -&gt; KYC Norms</td>
	</tr>
	
  </table>
<%}}else if(strapptype.equalsIgnoreCase("R")){ %>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; Demographics</td>
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
		<%}%>
		<%if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
		<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="23"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
<%} }%>
<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="90%" border="0" cellspacing="3" cellpadding="3"
					align="center" class="outertable">
					<tr>
						<td width="17%">Customer Occupation<span class="mantatory">*&nbsp;</span></td>
						<td width="33%" nowrap><input type="text"
							name="hid_custoccup" size="6"
							value="<%=Helper.correctNull((String)hshValues.get("custoccupcode"))%>">
						<input type="text" name="txt_custoccup" size="40" maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("custoccupdesc"))%>"></td>
						<td width="16%">Since</td>
						<td width="34%"><input type="text" name="txt_sinceoccupation" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("kyc_sinceoccupation"))%>"
							onBlur="" maxlength="12">
							<a style="vertical-align: middle;" alt="Select date from calender" href="#"
							onClick=""
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
					</tr>
					<tr>
						<td width="17%">ID Proof Type<span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="hid_IdProofType"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("idprooftypecode"))%>">
						<input type="text" name="txt_IdProofType" size="40" maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("idprooftypedesc"))%>"></td>
						<td width="16%">Residence Proof Type<span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><input type="text" name="hid_ResiProofType"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("resiprooftypecode"))%>">
						<input type="text" name="txt_ResiProofType" size="40"
							maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("resiprooftypedesc"))%>"></td>
					</tr>
					<tr>
						<td width="17%">ID Reference<span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="txt_IDProofRef"
							size="40" maxlength="25"
							value="<%=Helper.correctNull((String)hshValues.get("idproofref"))%>">
						</td>
						<td width="16%" nowrap>Residence ID Reference <span class="mantatory">*&nbsp;</span></td>
						<td width="34%"><input type="text" name="txt_ResiIDRefNo"
							size="40" maxlength="25"
							value="<%=Helper.correctNull((String)hshValues.get("resiidrefno"))%>">
						</td>
					</tr>
					<tr>
						<td width="17%">Valid Upto</td>
						<td width="33%" nowrap><input type="text" name="txt_id_valid" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("kyc_id_valid"))%>"
							onBlur="" maxlength="12">
							<a style="vertical-align: middle;" alt="Select date from calender" href="#"
							onClick=""
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
						<td width="16%">Valid Upto</td>
						<td width="34%"><input type="text" name="txt_residence_valid" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("kyc_residence_valid"))%>"
							onBlur="" maxlength="12">
							<a style="vertical-align: middle;" alt="Select date from calender" href="#"
							onClick=""
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
					</tr>
					<tr>
						<td width="17%">Risk Categorization <span class="mantatory">*&nbsp;</span></td>
						<td width="33%"><input type="text" name="hid_Risk" size="6"
							value="<%=Helper.correctNull((String)hshValues.get("riskcode"))%>">
						<input type="text" name="txt_Risk" size="40" maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("riskdesc"))%>"></td>
						
						<td width="16%">Nature of Activity <span class="mantatory">*&nbsp;</span></td><!--
						<td width="34%"><input type="text" name="hid_Activity"
							size="6"
							value="<%=Helper.correctNull((String)hshValues.get("activitycode"))%>">
						<input type="text" name="txt_Activity" size="40" maxlength="20"
							value="<%=Helper.correctNull((String)hshValues.get("activitydesc"))%>"></td>
						-->
							<td width="34%"><select name="hid_Activity" style="width: 200px" >
		                    <option value="0">---Select-----</option>
		                    <%String apptype="60"; %>
		                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
		                   
		                  </select>
		                     </td>
					</tr>
						<tr>
					<td>Activity</td>
					<td ><input type="text" name="txt_Activitykyc" maxlength="280" size="50" value="<%=Helper.correctNull((String)hshValues.get("kyc_kycActivity"))%>"></td>
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
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
	<input type="hidden" name="hidModuleName" value="<%=strModuleName%>">
	<INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
	<input type="hidden" name="comapp_id" value="<%=Helper.correctNull((String)hshValues.get("cust_id"))%>">
	<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)request.getParameter("hidappstatus"))%>">
	<input type="hidden" name="hidappexist" value="<%=Helper.correctNull((String)request.getParameter("hidappexist"))%>">
	<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
	<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
	<input type="hidden" name="hidapp_name" value="<%=strappname%>">
	<input type="hidden" name="hid_zip">
	<input type="hidden" name="hid_zip1">
	<input type="hidden" name="hid_zip2">
	<input type="hidden" name="hidres1">
	<input type="hidden" name="hidres2">
	<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">
	<input type="hidden" name="cmdsave" value="" disabled>
	<INPUT TYPE="hidden" name="hidPage" value="<%=pageid%>">
	<input type="hidden" name="hidEmployment" value="<%=Helper.correctNull((String)request.getParameter("hidEmployment"))%>">
</form>
</body>
</html>