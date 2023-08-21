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
<title>Co operative Society Master</title>
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
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/set/co_opsocietymaster.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var chkapprovedflag = "<%=Helper.correctNull((String) hshValues
									.get("APPROVEDFLAG"))%>";
var blacklist = "<%=Helper.correctNull((String) hshValues
							.get("coopsoc_blacklist"))%>";
var vartrapedit="<%=Helper.correctNull((String) hshValues.get("trapedit"))%>";


</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();getdate()">
<form name="appform" method="post" class="normal">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Master - &gt; Co-Op Housing Societies Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="4" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top" align="left">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td colspan="2" align="left">Co-Op Housing Societies Registration No<b><span
							class="mantatory">*</span> </b></td>
						
                    <td colspan="2" align="left">
                      <input type="text" name="txt_code" size="15"
							maxlength="10" tabindex="1"
							value="<%=Helper.correctNull((String) hshValues.get("COOPSOC_NO"))%>"
							onKeyPress="notAllowedDouble()">
                    </td>
						
                    <td width="18%">&nbsp;</td>
						
                    <td width="30%">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="6"><b>Present Address</b></td>
					</tr>
					<tr>
						
                    <td width="14%" nowrap>Name of the Society<b><span
							class="mantatory">*</span></b></td>
						<td colspan="3"><input type="text" name="txt_name" size="38"
							maxlength="50" tabindex="2"
							value="<%=Helper.correctNull((String) hshValues
									.get("COOPSOC_NAME"))%>"
							onKeyPress="notAllowedDouble()"> &nbsp;&nbsp;<b><span
							onClick="callsupnam()" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
						
                    <td width="18%">Contact Person Name<b><span
							class="mantatory">*</span></b></td>
						
                    <td width="30%"> 
                      <input type="text" name="txt_contactperson"
							size="25" maxlength="50" tabindex="6"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_CONTPER"))%>"
							onKeyPress="allowAlphabets()"></td>
					</tr>
					<tr>
						
                    <td width="14%">Address <b><span class="mantatory">*</span></b> 
                    </td>
						<td colspan="3"><input type="text" name="txt_address1"
							size="38" maxlength="100" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_ADDRESS1"))%>"
							onKeyPress="notAllowedDouble()"></td>
						
                    <td width="18%">Contact Person Mobile /Phone No.</td>
						
                    <td width="30%"> 
                      <input type="text"
							name="txt_contactmobilephone" size="18" maxlength="15"
							tabindex="7"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_CONTPER_PHMOBNO"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						
                    <td width="14%">&nbsp;</td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address2" size="38" maxlength="100" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_ADDRESS2"))%>"
							onKeyPress="notAllowedDouble()"></td>
						
                    <td width="18%">Approved by a competent State Govt. Authority</td>
						
                    <td width="30%"> 
                      <input type="checkbox" name="chk_approved"
							value="checkbox" style="border: none" onClick="ongetvalue()"
							tabindex="10"></td>
					</tr>
					<tr>
						
                    <td width="14%">&nbsp;</td>
						<td colspan="3" valign="top"><input type="text"
							name="txt_address3" size="38" maxlength="50" tabindex="5"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_ADDRESS3"))%>"
							onKeyPress="notAllowedDouble()"></td>
					</tr>
					<tr>
						
                    <td width="14%">City <b><span class="mantatory">*</span></b> 
                    </td>
						
                    <td width="14%"> 
                      <input type="text" name="txt_city" size="25"
							maxlength="25" tabindex="8"
							value="<%=Helper.correctNull((String) hshValues
									.get("COOPSOC_CITY"))%>"
							onKeyPress="notAllowSplChar()">
                    </td>
						
                    <td width="7%"><b><a
							href="javascript:showCitySearch('txt_city','txt_state','hidcity','hidstate','txt_zip','hidzip')"
							tabindex="10"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></a></b> 
                      <input type="hidden" name="hidcity"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_CITY_CODE"))%>" />
                    </td>
						
                    <td width="17%">&nbsp;</td>
						
                    <td width="18%"><%=ApplicationParams.getZipName()%><b><span
							class="mantatory">*</span></b></td>
                    <td width="30%"> 
                      <input type="text" name="txt_zip" size="12"
							maxlength="<%=ApplicationParams.getZipValue()%>" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_PINCODE"))%>"
							onKeyPress="allowInteger()"
							onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');showCountry()"
							style="text-align: left"></td>
					</tr>
					<tr>
						
                    <td width="14%">State</td>
						
                    <td width="14%"> 
                      <input type="text" name="txt_state" size="25"
							maxlength="25" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_STATE"))%>"
							onKeyPress="notAllowSplChar()"
							onBlur="changecase(document.forms[0].txt_state)"> <input
							type="hidden" name="hidstate"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_STATE_CODE"))%>" />
						</td>
						
                    <td width="7%"></td>
						
                    <td width="17%">&nbsp;</td>
						
                    <td width="18%">Approved by</td>
						
                    <td width="30%"> 
                      <input type="text" name="txt_approvedby"
							size="15" maxlength="20" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues.get("APPROVEDBY"))%>"
							onKeyPress="notAllowSplChar()"></td>
					</tr>
					<tr>
					<td width="14%">Country</td>
					<td width="14%"> 
                      <input type="text" name="txt_country"
							size="15" maxlength="20" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_COUNTRY"))%>"
							onKeyPress="notAllowSplChar();notallowInteger()"></td>
					</tr>
					<tr>
						
                    <td width="14%">Residential Phone No</td>
						
                    <td width="14%"> 
                      <input type="text" name="txt_resphone"
							size="18" maxlength="15" tabindex="14"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_RES_PHONENO"))%>"
							onKeyPress="allowPhone()"></td>
						
                    <td width="7%">&nbsp;</td>
						
                    <td width="17%">&nbsp;</td>
						
                     
                    <td width="18%">Mobile No.</td>
						
                    <td width="30%">
<input type="text" name="txt_resmobileno"
							size="15" maxlength="10" tabindex="15"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_RES_MOBNO"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						
                    <td width="14%">Office Phone No.</td>
						
                    <td width="14%"> 
                      <input type="text" name="txt_offphone"
							size="18" maxlength="15" tabindex="16"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_OFF_PHONENO"))%>"
							onKeyPress="allowPhone()"></td>
						
                    <td width="7%">&nbsp;</td>
						
                    <td width="17%">&nbsp;</td>
						
                    <td width="18%">Office Fax No.</td>
						
                    <td width="30%">
<input type="text" name="txt_offfaxno"
							size="18" maxlength="15" tabindex="17"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_OFF_FAXNO"))%>"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						
                    <td width="14%">Email Id</td>
						<td colspan="3"><input type="text" name="txt_emailid"
							size="38" maxlength="50" tabindex="18"
							value="<%=Helper.correctNull((String) hshValues
							.get("COOPSOC_EMAIL"))%>"
							onblur="isEmailAddr(document.forms[0].txt_emailid.value,document.forms[0].txt_emailid)">
						</td>
						
                    <td width="18%">&nbsp;</td>
						
                    <td width="30%">&nbsp;</td>
					</tr>
					<tr>
						
                    <td width="14%">If he is Black Listed</td>
						<td colspan="3"><select name="sel_blacklist"
							onChange="getdate()" tabindex="19">
							<option value="N">No</option>
							<option value="Y">Yes</option>
						</select></td>
						
                    <td id="t1" width="18%">Black Listed Date<b><span
							class="mantatory">*</span></b></td>
						
                    <td id="t2" width="30%"> 
                      <table border="0" cellspacing="0" cellpadding="4">
							<tr>
								<td><input type="text" name="txt_blacklistdate" size="11"
									maxlength="10"
									onBlur="checkmaxdate(this,currdate);checkDate(document.forms[0].txt_blacklistdate);"
									value="<%=Helper.correctNull((String) hshValues
							.get("coopsoc_blacklistdate"))%>">
								</td>
								<td><a alt="Select date from calender" href="#"
									onClick="callCalender()"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" align="middle"></a></td>
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
</div>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno"
	value="<%=Helper.correctNull((String) hshValues
									.get("COOPSOC_CODE"))%>">
<input type="hidden" name="hid_chk">
  <input type="hidden" name="hidzip">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> </form>
</body>
</html>
