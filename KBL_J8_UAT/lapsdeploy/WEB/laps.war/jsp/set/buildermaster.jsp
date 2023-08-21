<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/set/buildermaster.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var action = "<%=Helper.correctNull((String) hshValues
							.get("BUILDER_ACTIVE"))%>";
var reputedstatus="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_REPUTED_STATUS"))%>";
var blacklist = "<%=Helper.correctNull((String) hshValues
							.get("builder_blacklist"))%>";
var vartrapedit="<%=Helper.correctNull((String) hshValues.get("trapedit"))%>";


</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();getdate()">
<form name="frmbuildermast" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Builder Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="2" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1 tableBg">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td colspan="6" class="setuphead">Present Address</td>
					</tr>
					<tr>
						
                  <td width="11%">Builder Name<b><span class="mantatory">*</span></b></td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_name" size="38" maxlength="50" tabindex="1"
							value="<%=Helper.correctNull((String) hshValues
									.get("BUILDER_NAME"))%>"
							onKeyPress="notAllowSplChar()"> &nbsp;&nbsp;<b><span
							onClick="callsupnam()" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
						
                    <td>Branch &nbsp;</td>
                    <td><select name="org_code"
									disabled="disabled">
									<option value="">---Select---</option>
									<lapschoice:organizations />
								</select></td>
					</tr>
					<tr>
						
                  <td width="11%">Builder Address <b><span
							class="mantatory">*</span></b></td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address1" size="38" maxlength="100" tabindex="2"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_ADDRESS1"))%>"
							onKeyPress="notAllowedDouble()"></td>
						
                  <td valign="top" width="20%">Contact Person Name<b><span
							class="mantatory">*</span></b></td>
						
                  <td valign="top" width="27%">
<input type="text"
							name="txt_contactperson" size="25" maxlength="50" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_CONTPER"))%>"
							onKeyPress="notAllowSplChar()"></td>
					</tr>
					<tr>
						
                  <td width="11%">&nbsp;</td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address2" size="38" maxlength="100" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_ADDRESS2"))%>"
							onKeyPress="notAllowedDouble()"></td>
						
                  <td valign="top" width="20%">Contact Person Mobile /Phone No.</td>
						
                  <td valign="top" width="27%">
<input type="text"
							name="txt_contactmobilephone" size="18" maxlength="15"
							tabindex="14"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_CONTPER_PHMOBNO"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						
                  <td width="11%">&nbsp;</td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address3" size="38" maxlength="50" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_ADDRESS3"))%>"
							onKeyPress="notAllowedDouble()"></td>
						
                  <td valign="top" width="20%">Contact Person's Designation<b><span
							class="mantatory">*</span></b></td>
						
                  <td valign="top" width="27%">
<input type="hidden"
							name="txt_desig" size="25" maxlength="10" tabindex="7"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_CONTPER_DESIGN"))%>"
							onKeyPress="notAllowedDouble()"> <input type="text"
							name="txt_desig1" size="25" maxlength="60" tabindex="8"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_CONTPER_DESIGN"))%>"
							onKeyPress="notAllowedDouble()"> &nbsp;&nbsp;<b> <%--a href="#"
							onClick="callDesignation()" style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="15"></a>--%></b></td>
					</tr>
					<tr>
						
                  <td width="11%">City <b><span class="mantatory">*</span></b></td>
						<td width="19%"><input type="text" name="txt_city" size="25"
							maxlength="25" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues
									.get("BUILDER_CITY"))%>"
							onKeyPress="notAllowSplChar()"> <b><a
							href="javascript:showCitySearch('txt_city','txt_state','hidcity','hidstate','txt_zip','hidzip')"
							tabindex="5"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></a></b> <input type="hidden" name="hidcity"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_CITY_CODE"))%>" />
						</td>
						
                  <td width="8%">&nbsp;</td>
						
                  <td width="15%">&nbsp;</td>
                  <td width="20%"><%=ApplicationParams.getZipName()%><b><span
							class="mantatory">*</span></b></td>
						
                  <td width="27%"> 
                    <input type="text" name="txt_zip" size="12"
							tabindex="6" maxlength="<%=ApplicationParams.getZipValue()%>"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_PINCODE"))%>"
							onKeyPress="allowInteger()"
							onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');showCountry()"
							style="text-align: left">
                  </td>
					</tr>
					<tr>
						
                  <td width="11%">State</td>
						<td width="19%"><input type="text" name="txt_state" size="25"
							maxlength="25" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_STATE"))%>"
							onKeyPress="notAllowSplChar()"
							onBlur="changecase(document.forms[0].txt_state)"> <input
							type="hidden" name="hidstate"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_STATE_CODE"))%>" />
						</td>
						
                  <td width="8%"></td>
						
                  <td width="15%">&nbsp;</td>
						
                  <td width="20%">Reputed Status</td>
						
                  <td width="27%">
<select name="txt_reputedstatus"
							tabindex="16">
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select></td>
					</tr>
					<tr>
					
                  <td width="11%">Country</td>
					
                  <td width="19%">
				<input type="text" name="txt_country"
							size="15" maxlength="10" tabindex="7"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_COUNTRY"))%>"
							onKeyPress="notAllowSplChar();notallowInteger()">
							<input type="hidden" name="hid_country" value="<%=Helper.correctNull((String)hshValues.get("BUILDER_COUNTRY"))%>"> &nbsp; 
							<a href="#"	onClick="callCntrySearch('txt_country','hid_country')"
										style="cursor:hand" tabindex="8"><img
										src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
										border="0" tabindex="21"></a></td>
							 
                  <td width="8%">&nbsp;</td>
							  
                  <td width="15%">&nbsp;</td>
							  
                  <td width="20%">Office Fax No.</td>
				  <td width="27%">
<input type="text" name="txt_offfaxno"
							size="18" maxlength="15" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_OFF_FAXNO"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						
                  <td width="11%">Residential Phone No.</td>
						<td width="19%"><input type="text" name="txt_resphone"
							size="15" maxlength="15" tabindex="8"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_RES_PHONENO"))%>"
							onKeyPress="allowPhone()"></td>
						
                  <td width="8%">&nbsp;</td>
						
                  <td width="15%">&nbsp;</td>
						
                  <td width="20%">Mobile No</td>
						
                  <td width="27%">
<input type="text" name="txt_resmobileno"
							size="15" maxlength="10" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_RES_MOBNO"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						
                  <td align="left" width="11%">Office Phone No.</td>
						<td width="19%"><input type="text" name="txt_offphone"
							size="15" maxlength="15" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_OFF_PHONENO"))%>"
							onKeyPress="allowPhone()"></td>
						
                  <td width="8%">&nbsp;</td>
						
                  <td width="15%">&nbsp;</td>
						
                  <td width="20%">Action</td>
						
                  <td width="27%">
<select name="txt_action" tabindex="17">
							<option value="1">Enabled</option>
							<option value="2">Disabled</option>
						</select></td>
					</tr>
					<tr>
						
                  <td width="11%">Email Id</td>
						<td colspan="3"><input type="text" name="txt_emailid"
							size="38" maxlength="50" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues
							.get("BUILDER_EMAIL"))%>"
							onKeyPress=""
							onBlur="isEmailAddr(document.forms[0].txt_emailid.value,document.forms[0].txt_emailid)">
						</td>
						
                  <td width="20%">Comments</td>
						
                  <td width="27%"> 
                    <textarea name="txt_comments"
							onKeyPress="notAllowSingleQuote();textlimit(this,299)" onKeyUp="textlimit(this,299)"
							tabindex="18" rows="3" cols="40" wrap="virtual"><%=Helper.correctNull((String) hshValues
							.get("BUILDER_COMMENTS"))%></textarea>
                  </td>
					</tr>
					
					<tr>
						
                  <td width="11%">If he is Black Listed</td>
						<td colspan="3"><select name="sel_blacklist"
							onChange="getdate()" tabindex="19">
							<option value="N">No</option>
							<option value="Y">Yes</option>
						</select></td>
						
                  <td id="t1" width="20%">Black Listed Date<b><span
							class="mantatory">*</span></b></td>
						
                  <td id="t2" width="27%"> 
                    <table border="0" cellspacing="0" cellpadding="4">
							<tr>
								<td><input type="text" name="txt_blacklistdate" size="11"
									readonly maxlength="10"
									onBlur="checkmaxdate(this,currdate);checkDate(document.forms[0].txt_blacklistdate);"
									value="<%=Helper.correctNull((String) hshValues
							.get("apprisal_Date"))%>">
								</td>
								<td><a alt="Select date from calender" href="#"
									onClick="callCalender()"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" align="middle" tabindex="20"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>Project Name <span class="mantatory">*</span></td>
						<td><input type="text" name="txt_projectName" onKeyPress="notAllowSingleAndDoubleQuote()">  </td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		
<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno"
	value="<%=Helper.correctNull((String) hshValues
									.get("BUILDER_CODE"))%>">
<input type="hidden" name="hidmastid"/>
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidreputedstatus">
<input type="hidden" name="hidzip">
<input type="hidden" name="hidExorgcode">
</form>
</body>
</html>
