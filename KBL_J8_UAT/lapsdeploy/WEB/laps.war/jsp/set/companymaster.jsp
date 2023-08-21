<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
%>
<lapschoice:handleerror />
<html>
<head>
<title>Company Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/set/companymaster.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var blacklist = "<%=Helper.correctNull((String) hshValues
							.get("company_blacklist"))%>";
var vartrapedit="<%=Helper.correctNull((String) hshValues.get("trapedit"))%>";

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();getdate()">
<form name="frmcompmast" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Company Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="5" />
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
						<td colspan="6" class="setuphead"><b>Present Address</b></td>
					</tr>
					<tr>
						<td width="12%">Company Name <b><span class="mantatory">*</span></b></td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_name" size="38" maxlength="50" tabindex="1"
							value="<%=Helper.correctNull((String) hshValues
									.get("company_name"))%>"
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
						<td width="12%">
						Company Address <b><span
							class="mantatory">*</span></b>
						</td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address1" size="38" maxlength="100" tabindex="2"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_address1"))%>"
							onKeyPress="notAllowedDouble()"></td>
						<td valign="top" width="21%">Contact Person Name</td>
						<td valign="top" width="26%"><input type="text"
							name="txt_contactperson" size="25" maxlength="50" tabindex="15"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_contper"))%>"
							onKeyPress="notAllowSplChar()"></td>
					</tr>
					<tr>
						<td width="12%">&nbsp;</td>
						<td colspan="3"><input type="text" name="txt_address2"
							size="38" maxlength="100" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_address2"))%>"
							onKeyPress="notAllowedDouble()"></td>
						<td valign="top" width="21%">Contact Person Mobile /Phone No.</td>
						<td valign="top" width="26%"><input type="text"
							name="txt_contactmobilephone" size="18" maxlength="15"
							tabindex="16"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_contper_phmobno"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						<td width="12%">&nbsp;</td>
						<td colspan="3"><input type="text" name="txt_address3"
							size="38" maxlength="50" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_address3"))%>"
							onKeyPress="notAllowedDouble()"></td>
						<td valign="top" width="21%">Contact Person's Designation</td>
						<td valign="top" width="26%"><input type="hidden"
							name="txt_desig" size="25" maxlength="10" tabindex="17"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_contper_design"))%>"
							onKeyPress="notAllowSplChar()"> <input type="text"
							name="txt_desig1" size="25" maxlength="60" tabindex="17"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_contper_design"))%>"
							onKeyPress="notAllowSplChar()"> &nbsp;&nbsp;<%--<b><span onClick="callDesignation1()" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0"></span></b>--%></td>
					</tr>
					<tr>
						<td width="12%">
						City <b><span class="mantatory">*</span>
						</b>
						</td>
						<td width="18%"><input type="text" name="txt_city" size="25"
							maxlength="30" tabindex="5"
							value="<%=Helper.correctNull((String) hshValues
									.get("company_city"))%>"
							onKeyPress="notAllowSplChar();notallowInteger()"> <b><a
							href="javascript:showCitySearch('txt_city','txt_state','hidcity','hidstate','txt_zip','hidzip')"
							tabindex="5"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></a></b> <input type="hidden" name="hidcity"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_city_code"))%>" />
						</td>
						
                  <td width="8%"><b></b></td>
						
                  <td width="15%">&nbsp;</td>
						<td width="8%"><%=ApplicationParams.getZipName()%><b><span
							class="mantatory">*</span></b></td>
						<td width="15%"><input type="text" name="txt_zip" size="12"
							maxlength="<%=ApplicationParams.getZipValue()%>" tabindex="6"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_pincode"))%>"
							onKeyPress="allowInteger()"
							onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');showCountry()"
							style="text-align: left"></td>
					</tr>
					<tr>
						<td width="12%">State <b><span class="mantatory">*</span></b></td>
						<td width="18%"><input type="text" name="txt_state" size="25"
							maxlength="25" tabindex="7"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_state"))%>"
							onKeyPress="notAllowSplChar();notallowInteger()"
							onBlur="changecase(document.forms[0].txt_state)"> <input
							type="hidden" name="hidstate"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_state_code"))%>" />
						</td>
						
                  <td width="8%">&nbsp;</td>
						
                  <td width="15%">&nbsp;</td>
						<td width="8%">Country</td>
						<td width="15%"><input type="text" name="txt_country"
							size="15" maxlength="20" tabindex="8"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_country"))%>"
							onKeyPress="notAllowSplChar()"></td>
					</tr>
					<tr>
						<td width="12%">Residential Phone No.</td>
						<td width="18%"><input type="text" name="txt_resphone"
							size="18" maxlength="15" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_res_phoneno"))%>"
							onKeyPress="allowPhone()"></td>
						
                  <td width="8%">&nbsp;</td>
						
                  <td width="15%">&nbsp;</td>
							<td width="8%">Mobile No.</td>
							<td width="15%"><input type="text" name="txt_resmobileno"
							size="15" maxlength="10" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_res_mobno"))%>"
							onKeyPress="allowPhone()"></td>
						
						
                 
					</tr>
					<tr>
						<td width="12%">
						Office Phone No.
						</td>
						<td width="18%"><input type="text" name="txt_offphone"
							size="18" maxlength="15" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_off_phoneno"))%>"
							onKeyPress="allowPhone()"></td>
						
                  <td width="8%">&nbsp;</td>
                  <td width="15%">&nbsp;</td>
							<td width="8%">Office Fax No.</td>
							<td width="15%"><input type="text" name="txt_offfaxno"
							size="18" maxlength="15" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_off_faxno"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						<td width="12%">Email Id</td>
						<td colspan="3"><input type="text" name="txt_emailid"
							size="38" maxlength="50" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues
							.get("company_email"))%>"
							onKeyPress=""
							onBlur="isEmailAddr(document.forms[0].txt_emailid.value,document.forms[0].txt_emailid)">
						</td>
						<td width="8%">Comments</td>
						<td  width="21%"><textarea name="txt_comments"
							onKeyPress="notAllowSingleQuote()"
							rows="3" cols="30" tabIndex="18"
							onKeyPress="textlimit(this,300)" onKeyUp="textlimit(this.form.txt_comments,300);"  wrap="virtual"><%=Helper.correctNull((String) hshValues
							.get("company_comments"))%></textarea>
						</td>
					</tr>
					<tr>
						<td width="12%">If he is Black Listed</td>
						<td colspan="3"><select name="sel_blacklist"
							onChange="getdate()" tabindex="14">
							<option value="N">No</option>
							<option value="Y">Yes</option>
						</select></td>
						<td id="t1" width="21%">Black Listed Date<b><span
							class="mantatory">*</span></b></td>
						<td id="t2" width="26%">
						<table border="0" cellspacing="0" cellpadding="4">
							<tr>
								<td><input type="text" name="txt_blacklistdate" size="11"
									maxlength="10"
									onBlur="checkmaxdate(this,currdate);checkDate(document.forms[0].txt_blacklistdate);"
									value="<%=Helper.correctNull((String) hshValues
							.get("company_blacklistdate"))%>">
								</td>
								<td><a alt="Select date from calender" href="#"
									onClick="callCalender('txt_blacklistdate')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" align="middle"></a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
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
									.get("company_code"))%>">
  <input type="hidden" name="hidzip">
  <input type="hidden" name="hidExorgcode">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> </form>
</body>
</html>
