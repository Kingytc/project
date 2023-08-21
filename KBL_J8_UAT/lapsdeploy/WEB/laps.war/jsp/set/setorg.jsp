<%@include file="../share/directives.jsp"%>
<%
	String strglp_orgname1 = "";
	String strglp_orgname2 = "";
	String strglp_orgname3 = "";
	String strglp_orgname4 = "";
	String strglp_orgname5 = "";
	String strorgcode1 = "";
	String strorgcode2 = "";
	String strorgcode3 = "";
	String strorgcode4 = "";
	String strorgcode = "";
	String strLevels = "";

	HashMap hshRecord = (HashMap) hshValues.get("hshRecord");
	HashMap hshLevels = (HashMap) hshValues.get("hshLevels");
	strglp_orgname1 = Helper.correctNull(
			(String) hshLevels.get("glp_orgname1")).trim();
	strglp_orgname2 = Helper.correctNull(
			(String) hshLevels.get("glp_orgname2")).trim();
	strglp_orgname3 = Helper.correctNull(
			(String) hshLevels.get("glp_orgname3")).trim();
	strglp_orgname4 = Helper.correctNull(
			(String) hshLevels.get("glp_orgname4")).trim();
	strglp_orgname5 = Helper.correctNull(
			(String) hshLevels.get("glp_orgname5")).trim();
	strLevels = Helper.correctNull(
			(String) hshLevels.get("glp_orglevel")).trim();

	strorgcode = "001000000000000";

	if (strglp_orgname1 != "") {
		strorgcode1 = Helper.correctNull(
				(String) hshRecord.get("strorgcode1")).trim();
		if (!strorgcode1.equals("")) {
			strorgcode1 = strorgcode1.substring(0, 3);
		}
	}
	if (strglp_orgname2 != "") {
		strorgcode2 = Helper.correctNull(
				(String) hshRecord.get("strorgcode2")).trim();
		if (!strorgcode2.equals("")) {
			strorgcode2 = strorgcode2.substring(0, 6);
		}
	}
	if (strglp_orgname3 != "") {
		strorgcode3 = Helper.correctNull(
				(String) hshRecord.get("strorgcode3")).trim();
		if (!strorgcode3.equals("")) {
			strorgcode3 = strorgcode3.substring(0, 9);
		}
	}
	if (strglp_orgname4 != "") {
		strorgcode4 = Helper.correctNull(
				(String) hshRecord.get("strorgcode4")).trim();
		if (!strorgcode4.equals("")) {
			strorgcode4 = strorgcode4.substring(0, 12);
		}
	}
	String seluser = Helper.correctNull((String) hshRecord
			.get("userlist"));
	seluser = seluser.trim();
%>
<html>
<head>
<title>Setup-Organization</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setorg.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" 
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"> 
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appurl = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
</script>
<script>
var varLevels = "<%=strLevels%>";
var varstrorgcode1 = "<%=Helper.correctNull((String) hshRecord
									.get("strorgcode1"))%>";
var varstrorgcode1 ="001000000000000";
var varstrorgcode2 = "<%=Helper.correctNull((String) hshRecord
									.get("strorgcode2"))%>";
var varstrorgcode3 = "<%=Helper.correctNull((String) hshRecord
									.get("strorgcode3"))%>";
var varstrorgcode4 = "<%=Helper.correctNull((String) hshRecord
									.get("strorgcode4"))%>";
var varstrorgcode5 = "<%=Helper.correctNull((String) hshRecord
									.get("strorgcode5"))%>";

var varglp_orgname1= "<%=strglp_orgname1%>";
var varglp_orgname2= "<%=strglp_orgname2%>";
var varglp_orgname3= "<%=strglp_orgname3%>";
var varglp_orgname4= "<%=strglp_orgname4%>";
var varglp_orgname5= "<%=strglp_orgname5%>";

var varorg_code = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_code"))%>";
var varorg_name = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_name"))%>";
var varorg_scode = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_scode"))%>";
var varorg_taxid = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_taxid"))%>";
var varorg_trasitid = "<%=Helper.correctNull((String) hshRecord
							.get("txtorg_trasitid"))%>";
var varorg_add1 = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_add1"))%>";
var varorg_add2 = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_add2"))%>";
var varorg_city = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_city"))%>";
var varorg_district = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_district"))%>";
var varorg_state = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_state"))%>";
var varorg_zip = "<%=Helper.correctNull((String) hshRecord.get("txtorg_zip"))%>";
var varorg_phone = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_phone"))%>";
var varorg_fax = "<%=Helper.correctNull((String) hshRecord.get("txtorg_fax"))%>";
var varorg_url = "<%=Helper.correctNull((String) hshRecord.get("txtorg_url"))%>";
var varorg_level = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_level"))%>";
var varorg_micr = "<%=Helper.correctNull((String) hshRecord
									.get("txtorg_micr"))%>";
var varorg_headname = "<%=Helper.correctNull((String) hshRecord
							.get("txtorg_headname"))%>";
var varorg_headid = "<%=seluser%>";

var varorg_branchType = "<%=Helper.correctNull((String) hshRecord.get("branchType"))%>";
var varorg_branchIn = "<%=Helper.correctNull((String) hshRecord.get("branchIn"))%>";
var varorg_region = "<%=Helper.correctNull((String) hshRecord
									.get("region"))%>";
var varorg_saaBranch = "<%=Helper.correctNull((String) hshRecord.get("saaBranch"))%>";
var varorg_SAA_branch = "<%=Helper.correctNull((String) hshRecord
							.get("txtSAA_branch"))%>";
var varorg_solid = "<%=Helper.correctNull((String) hshRecord.get("solid"))%>";
var varorg_issaral = "<%=Helper.correctNull((String) hshRecord.get("issaral"))%>";
var varorg_saralhead = "<%=Helper.correctNull((String) hshRecord.get("saralhead"))%>"; 
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varorg_isinternet = "<%=Helper.correctNull((String) hshRecord.get("isinternet"))%>";
var varorg_centrename = "<%=Helper.correctNull((String) hshRecord.get("centrename"))%>"; 
var varorgexceluploadflag = "<%=Helper.correctNull((String) hshRecord.get("strExceluploadFlag"))%>";
var varorgabmid = "<%=Helper.correctNull((String) hshRecord.get("strOrgABMID"))%>"; 

function calltarget()
{
	var varQryString = appURL+"action/TargetMaster.jsp?hidBeanId=targetmaster&hidBeanGetMethod=getaccountdetails";
	var title = "TargetMaster";
	var prop = "scrollbars=yes,width=850,height=400,menubar=no";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);	
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function ABMStaff()
{
	if(document.forms[0].setorghelp4.value !="")
	{
		document.all.ABM.style.visibility="visible";
		document.all.ABM.style.position="relative";
	}else
	{
		document.all.ABM.style.visibility="hidden";
		document.all.ABM.style.position="absolute";
	}
}

/*function dosaralchange(){
	
	if((varorg_level.toUpperCase() == 'D') || (document.forms[0].hidAction.value == 'child' && varorg_level.toUpperCase() == 'R')){
	if(document.forms[0].selissaral.value=="N" || document.forms[0].selissaral.value=="0"){
		document.all.ts1.style.visibility="hidden";
		document.all.ts1.style.position="absolute";
		document.all.ts2.style.visibility="hidden";
		document.all.ts2.style.position="absolute";
	}else{
		document.all.ts1.style.visibility="visible";
		document.all.ts1.style.position="relative";
		document.all.ts2.style.visibility="visible";
		document.all.ts2.style.position="relative";
	}}
}

function dointernetchange(){

	if((varorg_level.toUpperCase() == 'A') || (document.forms[0].hidAction.value == 'child' && varorg_level.toUpperCase() == 'D')){
		
		if(document.forms[0].selisinternet.value=="N" || document.forms[0].selisinternet.value=="0"){
			document.all.ts3.style.visibility="hidden";
			document.all.ts3.style.position="absolute";
			document.all.ts4.style.visibility="hidden";
			document.all.ts4.style.position="absolute";
		}else{
			document.all.ts3.style.visibility="visible";
			document.all.ts3.style.position="relative";
			document.all.ts4.style.visibility="visible";
			document.all.ts4.style.position="relative";
		}	
	}
}*/
</script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues();ABMStaff();">
<form name="org" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Organisation</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable border1 tableBg">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td width="74%" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							<tr style="visibility: hidden; position: absolute">
								<td width="62">Organisation Code</td>
								<td colspan="4"><input type="text" name="txtorg_code"
									size="18"></td>
							</tr>
							<tr>
								<td width="62">Name<b><span class="mantatory">*&nbsp;</span></b></td>
								<td colspan="2"><input type="text" name="txtorg_name"
									size="30" maxlength="50" onKeyPress="notAllowSplChar()">
								</td>
								<td width="85" NOWRAP="nowrap">Branch (IBR) Code <b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td width="383"><input type="text" name="txtorg_scode"
									size="15" maxlength="8" onKeyPress="notAllowedDouble()"
									onBlur="checkSolidandBranchCode()"></td>
							</tr>
							<tr>
							<td>IFSC Code <b><span class="mantatory">*&nbsp;</span></b></td>
							<td colspan="2"><input type="text" name="txt_ifsccode"
									size="15" maxlength="15" onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String) hshRecord.get("strOrgIFSCcode"))%>">
								</td>
							</tr>
							<tr>
								<td width="62">BSR Code</td>
								<td colspan="2"><input type="hidden" name="txtorg_taxid"
									size="15" maxlength="15" onKeyPress="notAllowedDouble()">
								<input type="text" name="bsr1" size="5" align="right"
									maxlength="3"> <input type="text" name="bsr2"
									size="10" align="right" maxlength="5"></td>
								<td width="85">MICR Code</td>
								<td width="383"><input type="text" name="txtorg_micr"
									size="15" maxlength="15" onKeyPress="notAllowedDouble()">
								<input type="hidden" name="txtorg_trasitid" size="10"
									maxlength="8" onKeyPress="notAllowedDouble()"></td>
							</tr>
							<tr>
								<td width="62">Address</td>
								<td colspan="2"><input type="text" name="txtorg_add1"
									size="30" maxlength="50" onKeyPress="notAllowSplChar()">
								</td>
								<td width="85">Organisation Head<b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td width="383"><select name="userlist">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<lapschoice:users />
								</select></td>
							</tr>
							<tr>
								<td width="62"></td>
								<td colspan="2"><input type="text" name="txtorg_add2"
									size="30" maxlength="50" onKeyPress="notAllowSplChar()">
								</td>
								<td width="85">Phone No</td>
								<td width="383"><input type="text" name="txtorg_phone"
									size="15" maxlength="12" onKeyPress="allowPhone()"></td>
							</tr>
							<tr>
								<td width="62">City</td>
								<td colspan="2"><input type="text" name="txtorg_city"
									size="15" maxlength="20" onKeyPress="notAllowSplChar()">
								<input type="hidden" name="hidcity"
									value="<%=Helper.correctNull((String) hshRecord.get("citycode"))%>" />
								<a href="#"
									onClick="showCitySearch('txtorg_city','txtorg_state','hidcity','hidstate','txtorg_zip','hidzip')"
									style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></a></td>
								<td width="85">Fax&nbsp;No.</td>
								<td width="383"><input type="text" name="txtorg_fax"
									size="15" maxlength="15" onKeyPress="allowPhone()"></td>
							</tr>
							
							<!-- Added by Subha -->
							<tr>
								<td width="62">District</td>
								<td colspan="2"><input type="text" name="txtorg_district"
									size="15" maxlength="20" onKeyPress="notAllowSplChar()">
								<input type="hidden" name="hid_district"
									value="<%=Helper.correctNull((String) hshRecord.get("districtcode"))%>" />
								<a href="#"
									onClick="showDistSearch('ORGANISATION')"
									style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></a></td>
								<td width="85">&nbsp;</td>
								<td width="383">&nbsp;</td>
							</tr>
							
							
							<tr>
								<td width="62"><%=ApplicationParams.getZipName()%></td>
								<td colspan="2"><input type="text" name="txtorg_zip"
									size="15" style="text-align: left" onBlur="zipvalidate(this,6)"
									maxlength="<%=ApplicationParams.getZipValue()%>"
									onKeyPress="allowInteger(window.event)"></td>
								<td width="85">Email ID</td>
								<td width="383"><input type="text" name="txtorg_url"
									size="30" maxlength="50" onKeyPress="notAllowSplChar()"
									onBlur="isEmailAddr(document.forms[0].txtorg_url.value,document.forms[0].txtorg_url)">
								</td>
							</tr>
							<tr>
								<td width="62">State&nbsp;</td>
								<td colspan="2"><input type="text" name="txtorg_state"
									size="20" maxlength="50" onKeyPress="notAllowSplChar()"
									onBlur="changecase(this)"> <input type="hidden"
									name="hidstate"
									value="<%=Helper.correctNull((String) hshRecord.get("statecode"))%>" />
								</td>
								<td width="85">Branch Type</td>
								<td width="383"><select name="branchType">
									<%
										String strBranchtype = "71";
									%>
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<lapschoice:StaticDataNewTag apptype='<%=strBranchtype%>' />
								</select></td>
							</tr>
							<tr>
								<td width="62">Location<span
									class="mantatory">*&nbsp;</span></td>
								<td colspan="2"><select name="branchIn">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<lapschoice:StaticDataNewTag apptype="128" />
									<!--  <option value="1">METRO</option>
									<option value="2">URBAN</option>
									<option value="3">SEMI URBAN</option>
									<option value="5">RURAL</option>-->
								</select></td>
								<td>Branch Opened Date</td>
								<td colspan="2">
								<input type="text" name="txt_opendate"
									size="12" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currdate);"
									style="text-align: left" value="<%=Helper.correctNull((String)hshRecord.get("opendate"))%>">
									 <a alt="Select date from calender"  href="javascript:callCalender('txt_opendate')">
									 <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
								</td>
							</tr>
							<tr>
							<td>Whether Excel Upload can be done<span class="mantatory">*&nbsp;</span></td>
								<td colspan="2">
								<select name="sel_excelupload">
								<option value=""><--select--></option>
								<option value="y">Yes</option>
								<option value="n">No</option>
								</select>
								</td>
								<td>Manager Contact No</td>
								<td><input type="text" name="txtorg_mgrphn"
									size="15" maxlength="10" onKeyPress="allowPhone()" value="<%=Helper.correctNull((String) hshRecord
							.get("txtorg_mgrphn"))%>"></td>
							</tr>
							<tr id="ABM" style="visibility: hidden">
							<td>Organisation ABM<span class="mantatory">*&nbsp;</span><td colspan="2">
								<select name="user_abm">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<lapschoice:users /></td>
								<td>ABM Contact no </td>
								<td><input type="text" name="txtorg_abmno"
									size="15" maxlength="10" onKeyPress="allowPhone()" value="<%=Helper.correctNull((String) hshRecord
							.get("strOrgOrgABMMOB"))%>"></td>
							</tr>
								<!-- <td width="85">Region</td>
								<td width="383"><select name="region">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<option value="1">NORTHERN</option>
									<option value="2">NORTH EAST</option>
									<option value="3">EASTERN</option>
									<option value="4">CENTRAL</option>
									<option value="6">WESTERN</option>
									<option value="7">SOUTHERN</option>
								</select></td>
							</tr>
							<tr>
								<td width="62" NOWRAP="nowrap">SAA Branch</td>
								<td width="124"><select name="saaBranch"
									onchange="showBranch()">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<option value="1">YES</option>
									<option value="2">NO</option>
								</select></td>
								<td width="80" id="tab_branch">No of Villages <b><span
									class="mantatory">*&nbsp;</span></b> &nbsp;&nbsp; <input
									type="text" name="txtSAA_branch" style="text-align: right"
									size="8"
									value="<%=Helper.correctNull((String) hshRecord
							.get("txtSAA_branch"))%>"
									maxlength="8" onKeyPress="allowInteger()"></td>-->
							<!--  <tr>
								<td width="85">Sol Id<span
									class="mantatory">*&nbsp;</span></td>
								<td colspan="2" width="383"><select name="solid"
									style="width: 375" onChange="checkSolidandBranchCode()">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<%
										String apptype = "10";
									%>
									<lapschoice:StaticDataNewTag apptype="<%=apptype%>" />
								</select></td>
							</tr>-->
							<!--<tr id="issaral">
								<td>Whether SARAL<span class="mantatory">*&nbsp;</span></td>
								<td><select name="selissaral" onchange="dosaralchange();">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<option value="Y">YES</option>
									<option value="N">NO</option>
								</select></td>
								<td>&nbsp;&nbsp;</td>
								<td id="ts1" width="85">SARAL HEAD<span class="mantatory">*&nbsp;</span></td>
								<td id="ts2" colspan="2"><select name="saralhead">
									<option value="0" selected="selected">&lt;---Select ---&gt;</option>
									<lapschoice:users />
								</select></td>
							</tr>
							-->
							<input type="hidden" name="solid">
							<input type="hidden" name="selissaral" value="N">
							<!--<tr id="isinternet">
							<td>Whether Internet Application Centre <span class="mantatory">*&nbsp;</span>
							</td>
							<td><select name="selisinternet" onchange="dointernetchange();">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<option value="Y">YES</option>
									<option value="N">NO</option>
								</select>
							</td>
							<td>&nbsp;
							</td>
							<td id="ts3">Centre Name</td>
							<td id="ts4"><input type="text" name="txt_centrename" size="30" maxlength="50"></td>	
							</tr>
						--></table>
						</td>
						<td width="26%" valign="top" align="center">
						<fieldset>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="2"
									align="center" class="outertable">
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<tr>
										<td><b><%=strglp_orgname1%></b></td>
									</tr>
									<tr>
										<td><select name="setorghelp1" onClick="submitHelp1()"
											style="width: 180">
											<%
												String s = strorgcode + "^C";
											%>
											<lapschoice:choiceOrg value='<%=s%>' />
										</select></td>
									</tr>
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<tr>
										<td align="center"></td>
									</tr>
									<tr>
										<td><b><%=strglp_orgname2%></b></td>
									</tr>
									<tr>
										<td><select name="setorghelp2" onChange="submitHelp2()"
											style="width: 180">
											<option value="" selected>----Select----</option>
											<%
												String s1 = strorgcode1 + "^R";
											%>
											<lapschoice:choiceOrg value='<%=s1%>' />
										</select></td>
									</tr>
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<tr>
										<td align="center"></td>
									</tr>
									<%
										if (!strglp_orgname3.equals("")) {
									%>
									<tr>
										<td><b><%=strglp_orgname3%></b></td>
									</tr>
									<tr>
										<td><select name="setorghelp3" onChange="submitHelp3()"
											style="width: 180">
											<option value="">----Select----</option>
											<%
												String s2 = strorgcode2 + "^D";
											%>
											<lapschoice:choiceOrg value='<%=s2%>'/>
										</select></td>
									</tr>
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<%
										}
										if (!strglp_orgname4.equals("")) {
									%>
									<tr>
										<td align="center"></td>
									</tr>
									<tr>
										<td><b><%=strglp_orgname4%></b></td>
									</tr>
									<tr>
										<td><select name="setorghelp4" onChange="submitHelp4()"
											style="width: 180">
											<option value="">----Select----</option>
											<%
												String s3 = strorgcode3 + "^A";
											%>
											<lapschoice:choiceOrg value='<%=s3%>' />
										</select></td>
									</tr>
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<%
										}
										if (!strglp_orgname5.equals("")) {
									%>
									<tr>
										<td align="center"></td>
									</tr>
									<tr>
										<td><b><%=strglp_orgname5%></b></td>
									</tr>
									<tr>
										<td><select name="setorghelp5" onChange="submitHelp5()"
											style="width: 180">
											<option value="">----Select----</option>
											<%
												String s4 = strorgcode4 + "^B";
											%>
											<lapschoice:choiceOrg value='<%=s4%>' />
										</select></td>
									</tr>
									<%
										}
									%>
								</table>
								</td>
							</tr>
						</table>
						</fieldset>
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
<%if(Helper.correctNull((String)hshRecord.get("txtorg_level")).equalsIgnoreCase("A") ){%>
<lapschoice:combuttonnew
	btnnames='Add_Edit_Save_Cancel_Delete_Audit Trail_Move Organisation'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<%}else{ %>
<lapschoice:combuttonnew
	btnnames='Add_Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<%} %>
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="hidsetorghelp1" value=""> 
<input type="hidden" name="hidsetorghelpvalue1" value=""> 
<input type="hidden" name="hidsetorghelp2" value=""> 
<input type="hidden" name="hidsetorghelpvalue2" value=""> 
<input type="hidden" name="hidsetorghelp3" value=""> 
<input type="hidden" name="hidsetorghelpvalue3" value=""> 
<input type="hidden" name="hidsetorghelp4" value=""> 
<input type="hidden" name="hidsetorghelpvalue4" value=""> 
<input type="hidden" name="hidsetorghelp5" value=""> 
<input type="hidden" name="hidsetorghelpvalue5" value=""> 
<input type="hidden" name="hidlevel" value="<%=Helper.correctNull((String)hshRecord.get("txtorg_level")) %>"> 
<input type="hidden" name="hidorgcode" value="">
<input type="hidden" name="hidleveldel" value=""> 
<input type="hidden" name="hidorgcodedel" value=""> 
<input type="hidden" name="hidzip" value="">

<input type="hidden" name="hidbranchin" value="">
<input type="hidden" name="hidbranchtype" value=""> 
<input type="hidden" name="hidregion" value=""> 
<input type="hidden" name="hidsaabranch" value="">
<input type="hidden" name="hidsolid" value="">
<input type="hidden" name="hidsaral" value="">
<input type="hidden" name="hidsaralhead" value="">
<input type="hidden" name="hidorghead" value="">
<input type="hidden" name="hidkeyid" value="set">
</form>
</body>
</html>


