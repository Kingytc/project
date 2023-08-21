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
	src="<%=ApplicationParams.getAppUrl()%>js/set/lawyermaster.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var action = "<%=Helper.correctNull((String) hshValues
							.get("LAWYER_ACTIVE"))%>";
var blacklist = "<%=Helper.correctNull((String) hshValues
							.get("lawyer_blacklist"))%>";
var vartrapedit="<%=Helper.correctNull((String) hshValues.get("trapedit"))%>";
var varelitepanel="<%=Helper.correctNull((String) hshValues.get("lawyer_elitepanel"))%>";
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
		
			if(!(varTextControl=="txtperapp_country" || varTextControl=="txtperapp_permcountry" ))
			{
				var varQryString = appURL+"action/searchCountry.jsp?hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
				var title = "Country";
				var prop = "scrollbars=no,width=750,height=500";	
				prop = prop + ",left=200,top=200";
				window.open(varQryString,title,prop);	
			}
			else
			{
				//No Function
			}
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();getdate()">
<form name="frmlawyermast" method="post" class="normal">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Lawyer Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td align="left">
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
                    <td colspan="4">&nbsp;</td>
                    <td>Branch &nbsp;</td>
                    <td><select name="org_code"
									disabled="disabled">
									<option value="">---Select---</option>
									<lapschoice:organizations />
								</select></td>
                  </tr>
                  <tr> 
                    <td width="11%">Lawyer Name <b><span class="mantatory">*</span></b></td>
                    <td colspan="3">
                      <input type="text" name="txt_name" size="38"
							maxlength="50" tabindex="1"
							value="<%=Helper.correctNull((String) hshValues
									.get("LAWYER_NAME"))%>">
                      &nbsp;&nbsp;<b><span onClick="callsupnam()"
							style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
                    <td valign="top" width="11%" nowrap>Contact Person Name<b><span
							class="mantatory">*</span></b></td>
                    <td width="33%"> 
                      <input type="text" name="txt_contactperson"
							size="25" maxlength="50" tabindex="14"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_CONTPER"))%>"
							onKeyPress="notAllowedDouble()">
                    </td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">Lawyer Address <b><span class="mantatory">*</span></b> 
                    </td>
                    <td colspan="3">
                      <input type="text" name="txt_address1"
							size="38" maxlength="100" tabindex="2"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_ADDRESS1"))%>"
							onKeyPress="notAllowedDouble()">
                    </td>
                    <td WIDTH="11%">Contact Person Mobile /Phone No.</td>
                    <td WIDTH="33%"> 
                      <input type="text"
							name="txt_contactmobilephone" size="15" maxlength="15"
							tabindex="15"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_CONTPER_PHMOBNO"))%>"
							onKeyPress="allowPhone()">
                    </td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">&nbsp;</td>
                    <td colspan="3">
                      <input type="text" name="txt_address2"
							size="38" maxlength="100" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_ADDRESS2"))%>"
							onKeyPress="notAllowedDouble()">
                    </td>
                    <td WIDTH="11%">Contact Person's Designation<b><span
							class="mantatory">*</span></b></td>
                    <td valign="top" WIDTH="33%"> 
                      <input type="hidden"
							name="txt_desig" size="25" maxlength="10" tabindex="7"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_DESIGN"))%>"
							onKeyPress="notAllowedDouble()">
                      <input type="text"
							name="txt_desig1" size="25" maxlength="60"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_DESIGN"))%>"
							onKeyPress="notAllowedDouble()">
                      &nbsp;&nbsp;
                      <!--<b><span>
                      <a href="javascript:callDesignation1()" style="cursor:hand" tabindex="16">
                      <img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a></span></b>-->
                    </td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">&nbsp;</td>
                    <td colspan="3">
                      <input type="text" name="txt_address3"
							size="38" maxlength="50" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_ADDRESS3"))%>"
							onKeyPress="notAllowedDouble()">
                    </td>
                    <td WIDTH="11%">&nbsp;</td>
                    <td valign="top" WIDTH="33%">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">City <b><span class="mantatory">*</span> </b></td>
                    <td WIDTH="18%"> 
                      <input type="text" name="txt_city" size="25"
							value="<%=Helper.correctNull((String) hshValues
									.get("LAWYER_CITY"))%>">
                      <b><a
							href="javascript:showCitySearch('txt_city','txt_state','hidcity','hidstate','txt_zip','hidzip')"
							tabindex="5"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></a></b> 
                      <input type="hidden" name="hidcity"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_CITY_CODE"))%>" />
                    </td>
                    <td WIDTH="10%">&nbsp;</td>
                    <td WIDTH="17%">&nbsp;</td>
                    <td WIDTH="11%"><%=ApplicationParams.getZipName()%><b><span
							class="mantatory">*</span></b></td>
                    <td WIDTH="33%"> 
                      <input type="text" name="txt_zip" size="12"
							style="text-align: left"
							maxlength="<%=ApplicationParams.getZipValue()%>" tabindex="6"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_PINCODE"))%>"
							onKeyPress="allowInteger()"
							onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');showCountry()">
                    </td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">State</td>
                    <td WIDTH="18%"> 
                      <input type="text" name="txt_state" size="25"
							value="<%=Helper.correctNull((String) hshValues
									.get("LAWYER_STATE"))%>">
                      <input type="hidden" name="hidstate"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_STATE_CODE"))%>" />
                    </td>
                    <td WIDTH="10%">&nbsp;</td>
                    <td WIDTH="17%">&nbsp; </td>
                    <td WIDTH="11%">Empanelled on<b><span class="mantatory">*</span></b></td>
                    <td WIDTH="33%"> 
                      <table border="0" cellpadding="0" cellspacing="0"
							class="outertable">
                        <tr> 
                          <td>
                            <input type="text" name="txt_empaneledon" size="11"
									maxlength="11"
									value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_EMPANELEDDT"))%>"
									onBlur="checkDate(document.forms[0].txt_empaneledon);checkmaxdate(this,currdate)">
                            &nbsp;</td>
                          <td><a alt="Select date from calender" href="#"
									onClick="callCalender('txt_empaneledon')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" tabindex="17"></a></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
				  <tr>
				    <td WIDTH="11%">Country</td>
					    
                    <td WIDTH="18%"> 
                      <input type="text" name="txt_country"
							size="15" maxlength="15" tabindex="7"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_COUNTRY"))%>"
							onKeyPress="notAllowSplChar();">
							<input type="hidden"
							name="hidperapp_country"
							><a href="#"  id="idsearch3"
							onClick="callCntrySearch('txt_country','hidperapp_country')"
							style="cursor:hand" tabindex="8"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="21"></a>
							
                    </td>
					 
                    <td WIDTH="10%">&nbsp;</td>
                    <td WIDTH="17%">&nbsp;</td>
					 
                    <td WIDTH="11%" NOWRAP>Office Fax No.<b></b></td>
                    <td WIDTH="33%"> 
                      <input type="text" name="txt_offfaxno"
							size="18" maxlength="15" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_OFF_FAXNO"))%>"
							onKeyPress="allowPhone()">
                    </td>
				  </tr>
                  <tr> 
                    <td WIDTH="11%">Residential Phone No.</td>
                    <td WIDTH="18%"> 
                      <input type="text" name="txt_resphone"
							size="18" maxlength="15" tabindex="8"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_RES_PHONENO"))%>"
							onKeyPress="allowPhone()">
                    </td>
                    <td WIDTH="10%">&nbsp;</td>
                    <td WIDTH="17%">&nbsp; </td>
                     
                    <td WIDTH="11%">Mobile No.</td>
                    <td WIDTH="33%"> 
                      <input type="text" name="txt_resmobileno"
							size="15" maxlength="10" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_RES_MOBNO"))%>"
							onKeyPress="allowPhone()">
                    </td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">Office Phone No.</td>
                    <td WIDTH="18%"> 
                      <input type="text" name="txt_offphone"
							size="18" maxlength="15" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues
							.get("LAWYER_OFF_PHONENO"))%>"
							onKeyPress="allowPhone()">
                    </td>
                    <td WIDTH="10%" NOWRAP><b></b></td>
                    <td WIDTH="17%">&nbsp;</td>
                    <td WIDTH="11%">Action</td>
                    <td WIDTH="33%"> 
                      <select name="txt_action" tabindex="18">
                        <option value="1">Enabled</option>
                        <option value="2">Disabled</option>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">Email Id</td>
                    <td colspan="3">
                      <input type="text" name="txt_emailid"
							size="38" maxlength="50" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues
									.get("LAWYER_EMAIL"))%>"
							onKeyPress=""
							onBlur="isEmailAddr(document.forms[0].txt_emailid.value,document.forms[0].txt_emailid)">
                    </td>
                    <td WIDTH="11%">Comments</td>
                    <td WIDTH="33%">
                      <textarea name="txt_comments"
							onKeyPress="notAllowSingleQuote();textlimitcorp1(this,300)" onkeyup="textlimitcorp1(this,300);" onkeydown="textlimitcorp1(this,300);"
							tabindex="13" rows="3" cols="40" wrap="VIRTUAL"><%=Helper.correctNull((String) hshValues.get("LAWYER_COMMENTS"))%></textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">&nbsp;</td>
                    <td colspan="3">&nbsp; </td>
                    <td WIDTH="11%">&nbsp; 
                      <!--  <input type="button" name="cmdindustrymaster" value="IndustryMaster" tabindex="24"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100"
					onClick="createIndustryMasterFile()">
            </td>
                          <td>
              <input type="button" name="cmdgroupmaster" value="GroupMaster" tabindex="24"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100"
					onClick="createGroupMasterFile()">
            </td>
            
             <td>
              <input type="button" name="cmdgroupmaster" value="Ram to laps countrymaster" tabindex="24"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100"
					onClick="readcountrymaster()">
            </td> -->
                    <td WIDTH="33%">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td WIDTH="11%">If he is Black Listed</td>
                    <td colspan="3">
                      <select name="sel_blacklist"
							onChange="getdate()" tabindex="19">
                        <option value="N">No</option>
                        <option value="Y">Yes</option>
                      </select>
                    </td>
                    <td id="t1" WIDTH="11%">Black Listed Date<b> <span
							class="mantatory">*</span></b></td>
                    <td id="t2" WIDTH="33%"> 
                      <table border="0" cellspacing="0" cellpadding="4"
							class="outertable">
                        <tr> 
                          <td>
                            <input type="text" name="txt_blacklistdate" size="11"
									maxlength="10"
									onBlur="checkmaxdate(this,currdate);checkDate(document.forms[0].txt_blacklistdate);"
									value="<%=Helper.correctNull((String) hshValues
							.get("lawyer_blacklistdate"))%>"
									readonly>
                          </td>
                          <td><a alt="Select date from calender" href="#"
									onClick="callCalender('txt_blacklistdate')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" tabindex="20"></a></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  
                  <tr>
                   <td> Whether in Elite Panel? <span
							class="mantatory">*</span></td>
                   <td> <select name="sel_elitepanel"
							 tabindex="20">
							<option value="S">---Select---</option>
                        <option value="N">No</option>
                        <option value="Y">Yes</option>
                      </select></td>
                  </tr>
                </table>
		</table>
		</td>
	</tr>
</table>
</div>
<br>
<table width="12%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td><lapschoice:combuttonnew
			btnnames="New_Edit_Save_Cancel_Audit Trail"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno"
	value="<%=Helper.correctNull((String) hshValues
									.get("LAWYER_CODE"))%>">
<input type="hidden" name="hidseqno"
	value="<%=Helper.correctNull((String) hshValues
									.get("lawyer_seqno"))%>">
<input type="hidden" name="hidmastid"/>
									
<lapschoice:hiddentag pageid='<%=PageId%>' />
 <input type="hidden" name="hidzip">
 <input type="hidden" name="hidExorgcode">
  <input type="hidden" name="hidelitepanel">
 </form>
</body>
</html>
