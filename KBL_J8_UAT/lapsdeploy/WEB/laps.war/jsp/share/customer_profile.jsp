
<% 
HashMap hshParams = new HashMap();

hshParams = (HashMap) hshValues.get("hshParams");
if (hshParams == null) {
	hshParams = hshValues;
}

String strCattype1=Helper.correctNull(request.getParameter("hidCategoryType"));
String strLocation = (String) session.getAttribute("strOrgName");
String txt_flag = Helper.correctNull((String) hshValues.get("txt_flag"));
String custtmpid = Helper.correctNull((String) hshValues.get("custtmpid"));

boolean bval = false;
//Raman
bval = false;
//Raman
String apptype1="";
%>
<script>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varCatType = "<%=strCattype%>";
var id="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>";
var appstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var imageEnable="<%=ApplicationParams.getImageEnabled()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var bankarrage = "<%=Helper.correctInt((String)hshValues.get("indinfo_bankarrangement"))%>";
var banksector = "<%=Helper.correctInt((String)hshValues.get("indinfo_banksector"))%>";
var varGSTIN="<%=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN"))%>";
var selGSTIN="<%=Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG"))%>";
var selGST_EXEMPTED="<%=Helper.correctNull((String)hshValues.get("COMINFO_GST_EXEMPTED"))%>";
var PERAPP_CRITERIA_SALES_TURNOVER="<%=Helper.correctNull((String)hshValues.get("PERAPP_CRITERIA_SALES_TURNOVER"))%>";
var varmsmeclassification="<%=Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION"))%>";
var varcommstate="<%=Helper.correctNull((String)hshValues.get("app_stateminority"))%>";
var varminorityindustry="<%=Helper.correctNull((String)hshValues.get("PERAPP_MINORITYINDUSTRY"))%>";
var varminorityflag="<%=Helper.correctNull((String)hshValues.get("strminorityflag"))%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";
function checkcurrmaxdate(obj,maxdte)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(maxdte);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date cannot be greater than " +maxdte );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}
function checkchar()
{
	var udyamchar = document.forms[0].txt_udyam_regno.value;
	
	var capudyamchar=udyamchar.toUpperCase();
	if(capudyamchar.length==19)
	{
	for (var i = 0; i < capudyamchar.length; i++) {
		  if(capudyamchar.charAt(0)!='U')
		  {
			 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			 return false;
			 
		  }
		  if(capudyamchar.charAt(1)!='D')
		  {
			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		  if(capudyamchar.charAt(2)!='Y')
		  {
			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		  if(capudyamchar.charAt(3)!='A')
		  {
			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		  if(capudyamchar.charAt(4)!='M')
		  {
			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		  if(capudyamchar.charAt(5)!='-')
		  {
			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		  if(capudyamchar.charAt(6))
		  {
			  var code = capudyamchar.charCodeAt(6);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(7))
		  {
			  var code = capudyamchar.charCodeAt(7);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(8)!='-')
		  {
			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		  if(capudyamchar.charAt(9))
		  {
			 var code = capudyamchar.charCodeAt(9);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(10))
		  {
			  var code = capudyamchar.charCodeAt(10);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(11)!='-')
		  {
			  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		  if(capudyamchar.charAt(12))
		  {
			 var code = capudyamchar.charCodeAt(12);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(13))
		  {
			var code = capudyamchar.charCodeAt(13);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(14))
		  {
			var code = capudyamchar.charCodeAt(14);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(15))
		  {
			 var code = capudyamchar.charCodeAt(15);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(16))
		  {
			var code = capudyamchar.charCodeAt(16);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(17))
		  {
			var code = capudyamchar.charCodeAt(17);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		  if(capudyamchar.charAt(18))
		  {
			 var code = capudyamchar.charCodeAt(18);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 
		  
		  
			  
		  
			  
		
		}
	}
	else
	{
		alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
		return;
	}
  
}
function checkudyam()
{
	if(document.forms[0].txt_udyam_regno.value=="" && document.forms[0].cmdsave.disabled==false)
	{
		document.forms[0].txt_udyam_regno.value="UDYAM-";
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable border1">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable">
        <tr>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable">
              <tr>
                <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
                    <tr class="dataheader">
                      <td width="11%" align="center">Applicant ID</td>
                      <td width="16%" align="center">CBS Customer ID</td>
                      <td align="center" width="13%">Title<b><span
							class="mantatory">*&nbsp;</span></b></td>
                      <td width="24%" align="center">Full Name <b><span
							class="mantatory">*&nbsp;</span></b></td>
                      <td width="18%" align="center">Short Name <b><span
							class="mantatory">*&nbsp;</span></b></td>
                      <td width="18%" align="center" id="id_fatherlbl">Father Name</td>
                    </tr>
                    <tr align="center">
                      <td width="11%"><input type="text" name="txt_laps_app_id"
							size="12" maxlength="9" readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>"
							onKeyPress="allowInteger()">
					<input type="hidden"
							name="txt_perappid" readOnly
							value="<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>">		
                      </td>
                      <td width="16%"><input type="text" name="txt_cbs_id" size="17"
							maxlength="9"  class="finaclefieldsbgcolor"
							value="<%=strCBSID%>"
							onKeyPress="allowInteger()">
                      </td>
                      <td valign="top" width="13%"><select
							name="txt_applt_title" onChange="showCorporate()" class="finaclefieldsbgcolor">
                          <option value="0">---Select-----</option>
                          <%String apptypecon = "1";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
                        </select>
                      </td>
                      <td width="24%"><input type="text" name="txt_applt_fullname" class="finaclefieldsbgcolor"
							size="35" maxlength="80" 
							value="<%=strFullName%>"
							onKeyPress="notAllowSplChar()">
                      </td>
                      <td width="18%"><input type="text" name="txt_applt_shortname" class="finaclefieldsbgcolor"
							size="17" maxlength="9" 
							value="<%=strShortName%>"
							onKeyPress="notAllowSplChar()">
                      </td>
                      <td width="18%" id="id_fathertxt"><input type="text" name="txt_applt_fatname"  class="finaclefieldsbgcolor"
							size="30" maxlength="50" 
							value="<%=strFatherName%>"
							onKeyPress="notAllowSplChar()">
                      </td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
              <tr class="dataHeader">
                <td colspan="5"><b>PERSONAL DETAILS</b></td>
              </tr>
              <tr>
                <td width="18%">Constitution <b><span class="mantatory">*&nbsp;</span></b></td>
                <td colspan="3"><select name="sel_applt_constitutionnew" class="finaclefieldsbgcolor"
					onChange="showCorporate();callHeldWomen();callcgt()">
                    <option value="0">---Select-----</option>
                    <%apptypecon = "2";%>
                    <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
                  </select>
				   </td>
                <td rowspan="6" valign="top" align="left" width="17%"><table width="100%" cellpadding="0" cellspacing="0" id="id_photo">
                    <tr>
                      <td align="center"><iframe
					src="<%=ApplicationParams.getAppUrl()%>action/setphoto.jsp?hidBeanGetMethod=getdemographicsphoto&hidBeanId=mastapplicant&hidDemoId=<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"
					id="idfrm1" leftmargin="0" topmargin="0" border="0" marginwidth="0"
					marginheight="0" width="140" height="160" scrolling="no"
					frameborder=no valign="top"></iframe></td>
                    </tr>
                    <tr>
                      <td width="17%" align="center"><input type="button"
					name="cmdPhoto" value="Get Photo"
					style="background-color: #8F8369; font-weight: bold; color: white; font-size: 10px; font-family: mssansserif; width: 80px;"
					onClick="getPhoto()" />
                      </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td width="18%">PAN /TAN/ GIR No.<span class="mantatory">*&nbsp;</span></td>
                <td width="22%"><input type="text" name="txt_applt_panno" class="finaclefieldsbgcolor"
					size="14" maxlength="10"
					value="<%=strPANNo%>"
					onBlur="checkpanno(this)">
                </td>
                <td width="15%" id="id_borr_sex_lbl">Gender<b><span class="mantatory">*&nbsp;</span></b></td>
                <td width="28%"  id="id_borr_sex_fld"><select name="sel_applt_sex" class="finaclefieldsbgcolor">
                    <option value="0">--Select--</option>
                    <option value="M">Male</option>
                    <option value="F">Female</option>
                    <option value="O">Others</option>
                  </select>
                </td>
                <td width="15%" id="id_incorp_lbl">Date of Incorporation</td>
                <td valign="top" width="28%" id="id_incorp_fld"><table border="0" cellspacing="0" cellpadding="3" width="40%"
					class="outertable">
                    <tr>
                      <td><input type="text" name="txt_incorporation_date" size="12"
							maxlength="10" 
							value="<%=strIncorporationDate%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                      </td>
                      <td><a href="#"
							onClick="callCalender('txt_incorporation_date')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td width="18%" id="id_borr_dob_lbl">Date of Birth <b><span
					class="mantatory">*&nbsp;</span></b></td>
                <td valign="top" width="22%"><table border="0" cellspacing="0" cellpadding="0" width="40%"
					class="outertable">
                    <tr>
                      <td><input type="text" name="txt_applt_dob" size="12" class="finaclefieldsbgcolor"
							maxlength="10" 
							value="<%=strDOB%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                      </td>
                      <td><a href="#"
							onClick="callCalender('txt_applt_dob')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
                    </tr>
                  </table></td>
                <td width="15%" id="id_martial_lbl">Marital Status <b><span
					class="mantatory">*&nbsp;</span></b></td>
                <td width="28%" id="id_martial_fld"><select name="sel_applt_martial_status" onchange="showSpouseDetails()" class="finaclefieldsbgcolor">
                    <option value="0">---Select-----</option>
                    <%apptypecon = "3";%>
                    <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
                  </select>
                </td>
                <td width="15%" id="id_buss_comm_lbl">Date of Commencement of business <span class="mantatory">*&nbsp;</span></td>
                <td valign="top" width="28%" id="id_buss_comm_fld"><table border="0" cellspacing="0" cellpadding="3" width="40%"
					class="outertable">
                    <tr>
                      <td><input type="text" name="txt_buss_commencement_date" size="12"
							maxlength="10" 
							value="<%=strCommencementDate%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                      </td>
                      <td><a href="#"
							onClick="callCalender('txt_buss_commencement_date')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td width="18%">Status<b><span class="mantatory">*&nbsp;</span></b></td>
                <td width="22%"><select name="sel_istatus" class="finaclefieldsbgcolor"
					style="width: 200px">
                    <option value="0">&lt;--Select--&gt;</option>
                    <%String apptype = "4";%>
                    <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
                  </select>
                </td>
                <td></td>
                <td width="15%">Borrower Status<b><span class="mantatory">*&nbsp;</span></b></td>
                <td width="28%"><select name="sel_borr_status" 
					style="width: 200px">
                    <option value="0">---Select-----</option>
                    <%apptypecon = "109";%>
                    <lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
                  </select>
                </td>
              </tr>
              <tr>
                <td nowrap width="18%">Application Recd. From <b><span
					class="mantatory">*&nbsp;</span></b></td>
                <td width="22%"><INPUT type="hidden" name="select_loc"
					style="width: 200" value="<%=strOrgScode %>">
                  <input type="text"
					name="txt_applt_org" size="25" class="finaclefieldsbgcolor"
					value="<%=Helper.correctNull((String)hshValues.get("cust_branch_name"))%>">
                  <b><a href="#"
					onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','select_loc','txt_applt_org')"
					style="cursor: hand"></a></b></td><td></td>
                    	<td width="15%">Tax Slab<b><span class="mantatory">*&nbsp;</span></b></td>
                <td width="28%"><select name="sel_tax_slab"  class="finaclefieldsbgcolor"
					style="width: 200px">
                    <option value="0">&lt;--Select--&gt;</option>
                    <%apptype = "5";%>
                    <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
                  </select>
                </td>
              </tr>
              <tr>
              	<td>Aadhar Number</td>
              	<td><input type="text" name="txt_aadhar" class="finaclefieldsbgcolor" size="12" maxlength="12" value="<%=Helper.correctNull((String)hshValues.get("perapp_aadhaar")) %>"></td>
              </tr>
              <tr>
              	<td>&nbsp;</td>
              </tr>
              <tr>
                <td width="18%">Employment Status <b><span class="mantatory">*&nbsp;</span></b></td>
                <td width="22%" align="left" ><select name="sel_applt_occupation" style="width:200" onchange="disablelineofAction()" >
                  </select>
                </td>
                <td width="15%">Sector</td>
				<td>  
                <select name="sel_sector">
                 <option value="0">&lt;--Select--&gt;</option>
                <lapschoice:CustProfBankArrangeTag pagevalue='143'/>
                </select>
                </td>
                <td width="15%" id="id_line_of_activity">Line of Activity<b><span class="mantatory">*&nbsp;</span></b></td>
                <td width="28%" id="id_line_of_activity1"><select name="sel_applt_loa"
							style="width:200">
                    <option value="0">--Select--</option>
                    <%apptype = "113";%>
                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                  </select>
                </td>
                <td align="left" id="id_since">Since &nbsp;<input type="text"
							name="txt_loa_since" size="10" maxlength="4"
							style="text:align:left"
							value="<%=strLoASince%>"
							onKeyPress="allowInteger()" onBlur="min_nos(document.forms[0].txt_loa_since,4);checkcurrentyear(document.forms[0].txt_loa_since);">
                </td>
              </tr>
              <tr>
                <td width="18%">Banking with us<b><span class="mantatory">*&nbsp;</span></b></td>
                <td width="22%"><select name="sel_banking_with" onChange="showBankingDetails()" >
                    <option value="2" selected>No</option>
                    <option value="1">Yes</option>
                  </select>
                </td>
                <td   id="id_borr_since_lbl" nowrap="nowrap">Borrower Since<b><span class="mantatory">*&nbsp;</span></b></td>
                <td  id="id_borr_since_fld">
                <input type="text" name="txt_borr_since" size="12"
							maxlength="10" 
							value="<%=strBorrowerSince%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);checkBorrowerSince(this);">
                     
                      <a style="vertical-align: middle" href="#"
							onClick="callCalender('txt_borr_since')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
              </tr>
               
			  <tr id="id_satisfactory_row" >
			  <td>Satisfactory Dealing<b><span class="mantatory">*&nbsp;</span></b></td>
			  <td><select name="sel_satisfactory_dealing" onChange="showJusificationDetails()">
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select></td>
               
            <td id="justdetails">Justification Details<b><span class="mantatory">*&nbsp;</span></b></td>						
            <td id="justdetails1"><textarea name="txt_justComment" cols="50"  rows="5" onKeyPress="notAllowSingleQuote();textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String)hshValues.get("perapp_just_details"))%></textarea>
            </td>
			  </tr>
			   <tr>
			   <td id="id_salary_routed_lbl">Is salary routed through our bank</td>
                <td  id="id_salary_routed_fld"><select name="sel_salary_routed">
                    <option value="2" selected>No</option>
                    <option value="1">Yes</option>
                  </select>
                </td>
          </tr>
          <tr>
                <td>Any relation to Bank Staff/Executive/Director <b><span class="mantatory">*</span></b></td>
                <td><select name="sel_relative_bank" onChange="showdirectorlabel();showStaffRelationDetails();disableRelativeName();" style="width:200px">
                    <option value="0">&lt;--Select--&gt;</option>
                    <%apptype = "110";%>
                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                  </select>
                </td>
              </tr>
              <tr>
                <td id="id_staff_relat">Staff ID
                	<input type="text" name="txt_relat_staff_id" readOnly="readonly" size="15"
                	value="<%=strRelateStaffID%>">
                	<b>
                		<a href="#" onClick="showUsers('relation');" style="cursor: hand">
                			<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" >
                		</a>
                	</b>
                </td>
                </tr>
                <tr>
                <td><label id="id_staff_name_lbl"><span id="direc1">Name of Bank's Director</span><b><span class="mantatory">*&nbsp;</span></b></label></td>
                <td id="direc_name"><input type="text" name="txt_staff_name" id="id_staff_name_fld"
							size="25" maxlength="50" style="text-align:left"
							value="<%=strRelationName%>"
							onKeyPress="notAllowedDouble();notAllowSplChar()">
                </td>
                <td id="direc_master">
                 <select name="txt_staff_name1">
                   	<option value="">--Select--</option>
                   	 <%apptype = "153";%>
                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                 </select>
               </td>
                <td><label id="id_blood_reln_lbl"><span id="direc2">Blood Relation to the borrower</span></label></td>
                <td><select name="sel_blood_relation" id="id_blood_reln_fld">
                    <option value="0">&lt;--Select--&gt;</option>
                    <%apptype = "111";%>
                    <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                  </select>
                </td>
              </tr>
              <tr>
              <td>Networth of the Borrower</td>
                <td><input type="text" name="txt_networth" size="20" maxlength="15" style="text-align:right"
							value="<%=strNetworth%>" onKeyPress="allowNegtiveNumber(this)" onBlur="roundtxt(this);callDate();">
                </td>
                <td>As on Date <b><span id="id_asonDate" class="mantatory" style="visibility: hidden;position: absolute;">*</span></b></td>
                <td><input type="text" name="txt_networthdate"	size="12" maxlength="10" style="text-align:left"
							value="<%=strNetworthAson%>" onBlur="checkDate(this);checkmaxdate(this,currdate);">
							<a alt="Select date from calender"  href="javascript:callCalender('txt_networthdate')">
									 <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
                </td>
              </tr>
              
              <tr><td id="TL1">Type of Lending<b><span class="mantatory">*&nbsp;</span></b></td>
                <td id="TL2"><select name="sel_lending" >
                    <option value="">--Select--</option>
                    <option value="IL">Internal Lending</option>
                    <option value="IG">Income generating activity</option>
                    </select></td>
              </tr>
              <tr><td id="Con1">Whether majority of shareholding & controlling stake held by women<b><span class="mantatory">*&nbsp;</span></b></td>
              <td id="Con2"><select name="sel_heldwomen">
                    <option value="S">--Select--</option>
                    <option value="Y">Yes</option>
                    <option value="N">No</option>
                    </select></td></tr>
                    
                     <tr>
                    <td>Legal Entity Identification No</td><td><input type="text" name="txt_entity_id" class="finaclefieldsbgcolor" value="<%=Helper.correctNull((String) hshValues.get("PERAPP_LEGAL_ENTITYID"))%>"
                     maxlength="20" onkeypress="allowAlphaNumeric()"></td>
                    
                      <td>LEI Issue Date</td><td><input type="text" name="txt_issue_date" class="finaclefieldsbgcolor" size="12"
							maxlength="10" value="<%=Helper.correctNull((String) hshValues.get("PERAPP_LEGAL_ISSUEDATE"))%>">
							
                      </td>
                      <td>LEI Expiry Date</td><td><input type="text" name="txt_expirey_date" class="finaclefieldsbgcolor" size="12"
							maxlength="10" value="<%=Helper.correctNull((String) hshValues.get("PERAPP_LEGAL_EXPIRYDATE"))%>">
							
                      </td>
                    </tr>
            </table></td>
        </tr> 
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
              <tr class="dataHeader">
                <td colspan="5"><b>INTRODUCER DETAILS</b></td>
              </tr>
              <tr>
                <td width="18%">Introducer Type<span class="mantatory">*</span></td>
                <td width="22%"><select name="sel_introducer_type" onchange="showcbsidfield()">
                <option value="0" selected>--Select--</option>
                <option value="1">Staff</option>
                <option value="2">Existing Customer</option>
                <option value="3">Others</option>
                </select>
                </td>
                <td colspan="2">
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"> 
                <tr id="staff">
                <td width="25%">Introducer Staff ID&nbsp;<span class="mantatory">*</span></td>
                <td width="75%"><input type="text" name="txt_introstaff_id" size="20" 
                value="<%=strIntroStaffID%>"        
                onKeyPress="return false">
                <b><a href="#" onClick="showUsers('intro');" style="cursor: hand">
                	<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></a>
                </b>
                </td>
                </tr>
                <tr id="cbsid">
                <td width="25%">Customer CBS ID&nbsp;<span class="mantatory">*</span></td>
                <td width="75%"><input type="text" name="txt_introcbs_id"  size="20" onBlur="callValidateCBSid(this)"
                		value="<%=strIntroCBSID%>" maxlength="20" onKeyPress="allowAlphaNumeric();">
                </td>
                </tr>
                </table>
                </td>
              </tr>
              <tr>
                <td width="18%">Introducer Name</td>
                <td width="22%"><input type="text" name="txt_introducer_name" class="finaclefieldsbgcolor"
							size="30" maxlength="50" style="text-align:left"
							value="<%=strIntroducerName%>"
							onKeyPress="allowAlphabetsForName()">
                </td>
                <td width="15%">Introducer Status</td>
                <td width="45%"><select name="sel_introducer_status" class="finaclefieldsbgcolor" style="width: 250px">
                    <option value="0">&lt;--Select--&gt;</option>
                    <%apptype = "6";%>
                    <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
                  </select>
                </td>
              </tr>
            </table></td>
        </tr>
        		<!-- Added by Arsath for New Header called Banking Arrangements -->
          		<tr>
          		<td>
          		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
              	<tr class="dataHeader">
                <td colspan="5"><b>BANKING ARRANGEMENT</b></td>
              	</tr>
              	<tr>
                <td width="18%">Banking Arrangement</td>
                <td width="22%">
                <select name="sel_bankarrange">
                  <option value="0">&lt;--Select--&gt;</option>
                <lapschoice:CustProfBankArrangeTag pagevalue='142'/>
                </select>
                
                </td>
                <td width="15%">&nbsp;</td>
				<td>&nbsp; </td>
               	</tr>
              	</table>
              	</td>
        		</tr>
        		<!-- End of Arsath -->
        <tr>
          <td><table cellspacing="0" cellpadding="3" width="100%" class="outertable">
              <tr class="dataHeader">
                <td colspan="6"><b>OTHER DETAILS</b></td>
              </tr>
              <tr>
                <td width="18%">Trade Finance</td>
                <td width="22%"><select name="sel_trade" onchange="showTradeFinanceDetails()" class="finaclefieldsbgcolor">
                    <option value="Y">Yes</option>
                    <option value="N" selected>No</option>
                  </select>
                </td>
                <td width="15%" id="id_inland_lbl">Inland Trade Allowed</td>
                <td width="18%" id="id_inland_fld"><select name="sel_inland">
                    <option value="1">Yes</option>
                    <option value="2" selected>No</option>
                  </select>
                </td>
                <td width="12%">&nbsp;</td>
               	<td width="15%">&nbsp;</td>
                
              </tr>
            </table></td>
        </tr>
        <tr>
          <td id="id_individual"><table width="100%" cellpadding="3" cellspacing="0" class="outertable">
              <tr id="resident">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                    <tr>
                      <td width="18%">Resident Status<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td width="22%"><select name="sel_resident_status" onchange="showCountry()" class="finaclefieldsbgcolor">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "18";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
                        </select></td>
                      <td width="15%" id="id_country_lbl">Country</td>
                      <td width="18%" id="id_country_fld"><input type="text" name="txt_country"
					size="30" maxlength="30" tabindex="46"	value='<%=strCountry%>'
					onKeyPress="notallowInteger()"></td>
					<td width="12%">&nbsp;</td>
					<td width="15%">&nbsp;</td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                    <tr>
                      <td width="18%">Whether Staff?</td>
                      <td width="22%"><select name="sel_istaff" onChange="showisStaffDetails()" class="finaclefieldsbgcolor" tabindex="57">
                          <option value="02">Yes</option>
                          <option value="01" selected>No</option>
                          <option value="03">Ex-Staff</option>
                        </select></td>
                      <td width="15%" id="id_staffid_lbl">Staff ID<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td width="18%" id="id_staffid_fld"><input type="text" class="finaclefieldsbgcolor" name="txt_staff_id" maxlength="20" size="20" onKeyPress="allowInteger()" value="<%=strStaffID%>"></td>
                      <td width="12%" id="id_joiningdt_lbl">Date of Joining</td>
                      <td width="15%" id="id_joiningdt_fld"><table cellspacing="0" cellpadding="0">
                          <tr>
                            <td><input type="text" name="txt_dateofjoining" 
			size="12" maxlength="10" tabindex="58"
			value="<%=strStaffDOJ%>"
			onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                            </td>
                            <td><a href="#"
			onClick="callCalender('txt_dateofjoining')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			height="22" border="0" tabindex="59"></a></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td width="18%">Religion<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td width="22%"><select name="sel_religion" tabindex="73" class="finaclefieldsbgcolor">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "11";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>'/>
                        </select></td>
                      <td width="15%">Caste/Tribe&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td width="18%"><select name="sel_caste" tabindex="73" class="finaclefieldsbgcolor">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "7";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
                        </select></td>
                      <td width="12%">Minority</td>
                      <td width="15%"><select name="sel_minority" tabindex="81">
                      <option value="0" >--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select></td>
                    </tr>
                    <tr id="depend">
                      <td id="child1" width="18%">No. of Dependents<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td id="child2" width="22%"><table border="0" cellspacing="0" cellpadding="0" width="82" class="outertable">
                          <tr>
                            <td width="25%">Children&nbsp;</td>
                            <td width="25%"><input type="text" name="txt_dep_children"
									size="4" maxlength="2" tabindex="74" style="text-align:left"
									value="<%=strChildDep%>"
									onKeyPress="allowInteger()"></td>
                            <td width="30%">&nbsp;&nbsp;Others&nbsp;</td>
                            <td width="20%"><input type="text" name="txt_dep_others"
									size="5" maxlength="2" tabindex="75" style="text-align:left"
									value="<%=strOtherDep%>"
									onKeyPress="allowInteger()"></td>
                          </tr>
                        </table></td>
                      <td width="15%">No. Earning Members in family&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td id="child2" width="18%"><input type="text"
							name="txt_earning_member" size="3" maxlength="2" tabindex="76"
							style="text:align:left"
							value="<%=strEarningMem%>"
							onKeyPress="notAllowSingleQuote();allowInteger()" onBlur="showFamilyIncome();"></td>
					<td id="fmlyincome" nowrap="nowrap">Annual Family Income<b><span class="mantatory">*&nbsp;</span></b> <%=ApplicationParams.getCurrency()%></td>						
            		<td id="fmlyincome1" nowrap="nowrap"><input type="text" name="txt_familyincome" size="15" maxlength="10" tabindex="76"	style="text-align:right" onKeyPress="allowInteger()"
            		onBlur="roundtxt(document.forms[0].txt_familyincome)" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("indinfo_family_income"))))%>"></td>
                    </tr>
                    <tr>
                      <td width="18%">Educational Qualification<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td width="22%"><select name="sel_edu_qual" tabindex="78" class="finaclefieldsbgcolor">
                          <%apptype1 = "8";%>
                          <option value="0" selected>--select--</option>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptype1%>' />
                        </select></td>
                      <td width="15%" id="area">Area Specialized</td>
                      <td width="18%"><input type="text" name="txt_area_spec" size="25"
							maxlength="50" tabindex="79" onKeyPress="notAllowedDouble();notAllowSplChar()"
							value="<%=strAreaSpecial%>">
                      </td>
                      <TD>Whether Blind <b><span class="mantatory">*</span></b></TD>
                      <td><select name="sel_blind" tabindex="80">
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select></td>
                     </tr>
                    <tr>
                      <td>Physically Challenged <b><span class="mantatory">*</span></b></td>
                      <td><select name="sel_phy_hycpd" tabindex="81">
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select></td>
                      <td>Ex-Serviceman</td>
                      <td><select name="sel_ex_servicemen" tabindex="82"
									onChange="showExServiceMenDetails()">
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select>
                      </td>
                      <td id="id_exservice_years_lbl">Years of
                        Service<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td id="id_exservice_years_fld" width="15%"><input type="text"
									name="txt_yrs_service" size="3" maxlength="2" tabindex="83"
									style="text:align:left"
									value='<%=strYearsofService%>'
									onKeyPress="notAllowSingleQuote();allowInteger()" /></td>
                    </tr>
                
                    <tr>
                      <td >Whether Minor</td>
                      <td ><select name="sel_minor" onChange="showGaurdianDetails()" class="finaclefieldsbgcolor"
							tabindex="88">
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select></td>
                      <td id="id_gaurdian_cbsid_lbl">Guardian CBSID <b><span class="mantatory">*&nbsp;</span></b></td>
                      <td id="id_gaurdian_cbsid_txt">
                      	<input type="text" name="txt_guardian_cbsid" size="35" maxlength="50" value="<%=strGuardianCBSID%>">
                      </td>
                      <td id="id_gaurdian_name_lbl">Guardian Name <b><span class="mantatory">*&nbsp;</span></b></td>
                      <td  id="id_gaurdian_name_fld"><input type="text" class="finaclefieldsbgcolor" name="txt_guardian_name" size="35" maxlength="50" value="<%=strGaurdianName%>" onKeyPress="notAllowedDouble();notAllowSplChar()">
                      </td>
                    </tr>
                    <tr id="id_gaurdian_det_row">
                      <td  id="g1">Guardian Relationship<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td  id="g2"><!--<input type="text" name="txt_gaurdian_relationship" class="finaclefieldsbgcolor" size="25" maxlength="50" onKeyPress="notAllowedDouble();notAllowSplChar()" value="<%=strGaurdianReln%>">-->
                      	<select name="sel_gaurdian_relationship" class="finaclefieldsbgcolor">
                      		<option value="">--Select--</option>
                          <lapschoice:CBSStaticDataNewTag apptype="19" />
                      	</select>
                      </td>
                      <td id="f1">Guardian
                        Address<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td id="f2"><textarea name="txt_gaurdian_addr" class="finaclefieldsbgcolor" onKeyDown="textlimit(this,200)" onKeyUp="textlimit(this,200)"
							tabindex="91" rows="5" cols="40"><%=strGaurdianAddr%></textarea></td>
							<td>Group</td>
                      <td><input type="hidden" name="hid_groupid"
		size="20" maxlength="23"
		style=text-align:left;border-style=groove
		value="<%=strGroup%>">
                        <input type="text" name="txt_group"
				size="30" maxlength="20"
				style="text-align:left;border-style=groove" onKeyPress=""
				readOnly="readonly" value="<%=Helper.correctNull((String)hshValues.get("cominfo_groupname"))%>">
                        <span onClick="openGroup()" style="cursor:hand"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="81"></span></td>
                    </tr>
                  </table></td>
              </tr>
              <tr id="spouse">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                    <tr class="dataHeader">
                      <td colspan="6"><b>SPOUSE DETAILS</b></td>
                    </tr>
                    <tr>
                      <td>
                          <tr>
                            <td width="17%">Title</td>
                            <td width="23%"><select name="sel_spouse_title" tabindex="95">
                                <option value="MR">MR.</option>
                                <option value="MRS" selected>MRS.</option>
                              </select></td>
                            <td width="15%">Name</td>
                            <td width="17%"><input type="text" name="txt_spouse_name" size="30"
							maxlength="50" tabindex="96"
							value="<%=strSpouseName%>"
							onKeyPress="notAllowedDouble();notAllowSplChar()" class="finaclefieldsbgcolor"></td>
                            <td width="13%">Date of Birth <b><span
					class="mantatory">*&nbsp;</span></b></td>
                            <td width="15%" valign="top"><table border="0" cellspacing="0" cellpadding="3" width="40%"
					class="outertable">
                                <tr>
                                  <td><input type="text" name="txt_spouse_dob" size="12"
							maxlength="10" 
							value="<%=strSpouseDOB%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                                  </td>
                                  <td><a href="#"
							onClick="callCalender('txt_spouse_dob')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
                                </tr>
                              </table></td>
                          </tr>
                          <tr>
                            <td>Occupation</td>
                            <td><select name="txt_spouse_occupation" style="width:200px" class="finaclefieldsbgcolor">
                                <%apptype1 = "9";%>
                                <option value="0" selected>--Select--</option>
                                <lapschoice:CBSStaticDataNewTag apptype='<%=apptype1%>' />
                              </select></td>
                            <td>Qualification</td>
                            <td><select name="sel_spouse_qualification" tabindex="97" class="finaclefieldsbgcolor">
                                <%apptype1 = "105";%>
                                <option value="0" selected>--select--</option>
                                <lapschoice:StaticDataNewTag apptype='<%=apptype1%>' />
                              </select></td>
                            <td>PAN No. / GIR</td>
                            <td><input type="text" name="txt_spouse_panno" size="15"
							maxlength="10"
							value="<%=strSpousePANNo%>"
							tabindex="99" onBlur="checkpanno(this)"></td>
                          </tr>
                          <tr>
                            <td>Employer</td>
                            <td><input type="text" name="txt_spouse_employer" size="15"
							maxlength="30"
							value="<%=strSpouseEmployer%>"
							tabindex="99" onKeyPress="notAllowedDouble();notAllowSplChar()"></td>
                            <td nowrap>Net Monthly Income</td>
                            <td><lapschoice:CurrencyTag name="txt_spouse_netmonthly_income" size="15"
							maxlength="12"
							value='<%=strSpouseIncome%>'
							tabindex="100" /></td>
                            <td>Address<b><span class="mantatory">*&nbsp;</span></b></td>
                            <td><textarea name="txtar_spouse_addr" onKeyDown="textlimit(this,200)" onKeyUp="textlimit(this,200)"
							tabindex="91" rows="4" cols="30" class="finaclefieldsbgcolor"><%=strSpouseAddr%></textarea></td>
                          </tr>
                        </table>
                        </td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
     <tr>
          <td id="id_non_individual"><table width="100%" cellpadding="3" cellspacing="0" class="outertable">
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                    <tr>
                  <!--    <td width="17%">Industry BSR Code <b><span class="mantatory">*&nbsp;</span></b></td>
                      <td colspan="3"><input type="hidden" name="hid_industry_code"
		size="20" maxlength="23"
		style=text-align:left;border-style=groove
		value="<%=strIndustryCode%>">
                        <input type="text" name="txt_industry_bsr_code" size="50"
		maxlength="500" style=text-align:left;border-style=groove
		onKeyPress="notAllowedDouble();notAllowSpace()" tabindex="7"
		value="<%=Helper.correctNull((String)hshValues.get("perapp_companyname"))%>"
		read<boy>
                        <b><span onClick="callDescHelp('applicantmaster')"
		style="cursor:hand"><img
		src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
		border="0" tabindex="7"></span></b></td>-->
                      <td width="13%">Type of Ownership</td>
                      <td width="15%"><select name="sel_ownership_type" onchange="funenableTypeofliab();">
                          <option value="0" selected="selected">--Select--</option>
                         <lapschoice:StaticDataNewTag apptype='204' />
                        </select></td>
                        <td id="typeofliab1">Type of Liability
                        </td>
                        <td id="typeofliab2">
                        <textarea name="txt_typeofliab" cols="50"  rows="3" onKeyPress="notAllowSingleQuote();textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("companyinfo_typeofliability"))%></textarea>
                        </td>
                    </tr>
                    <tr>
                      <td>ROC Number</td>
                      <td width="23%"><input type="text" name="txt_roc_number" maxlength="30" size="20" value="<%=strROCNumber%>"></td>
                      <td width="15%">Company Identification Number (CIN)</td>
                      <td width="17%"><input type="text" name="txt_cin_number" class="finaclefieldsbgcolor" style="text-transform: uppercase" maxlength="21" size="20" value="<%=strCIN%>" readOnly="readonly"></td>
                      <td>TIN</td>
                      <td><input type="text" name="txt_tin_number" maxlength="30" size="20" value="<%=strTIN%>"></td>
                       </tr>
                       <tr>
                       <td>IEC</td>
                      <td><input type="text" name="txt_iec" maxlength="30" size="20" value="<%=strIEC%>"></td>
                      <td>Group Name</td>
                      <td><input type="hidden" name="hidcomgroupid" value="<%=Helper.correctNull((String)hshValues.get("com_groupid"))%>"><input type="text" name="txt_group_name" class="finaclefieldsbgcolor"  value="<%=Helper.correctNull((String)hshValues.get("com_groupname"))%>"></td>
                    <tr>
                      
                      <td>Industry Type</td>
                      <td><select name="sel_industry_type">
                          <option selected="selected" value="0">--Select--</option>
                         <lapschoice:StaticDataTag apptype="138"/>
                        </select>
                      </td>
                      
                    
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                    <tr>
                      <td colspan="2">Whether Line of Activity undertaken is NBFC</td>
                      <td  colspan="2"><select name="sel_loa_nbfc" onchange="showNBFCDetails()">
                          <option value="0" >--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N" selected="selected">No</option>
                        </select>
                      </td>
                    </tr>
                    <tr id="id_nbfc_row2">
                      <td width="17%">Deposit Taking NBFC</td>
                      <td width="23%"><select name="sel_nbfc_deposit">
                          <option value="0" selected="selected">--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N">No</option>
                        </select>
                      </td>
                      <td width="15%">Infrastructure Financing NBFC</td>
                      <td width="17%"><select name="sel_nbfc_infrastructure">
                          <option value="0" selected="selected">--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N">No</option>
                        </select>
                      </td>
                      <td width="13%">Asset Financing NBFC</td>
                      <td width="15%"><select name="sel_nbfc_asset">
                          <option value="0" selected="selected">--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N" >No</option>
                        </select>
                      </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                    <tr>
                      <td colspan="2">Whether the firm/institution is a MFI(Micro Financial Institution)</td>
                      <td width="15%"><select name="sel_mfi">
                          <option value="0" >--Select--</option>
                          <option value="Y">Yes</option>                 
                           <option  value="N" selected="selected">No</option>
                           
                        </select>
                      </td>
                    </tr>
                    <tr>
                     <td colspan="2">Whether majority of members belongs to SC/ST</td>
                     <td><select name="sel_majoritymem">
                    	  <option value="0" >--Select--</option>
                    	  <option value="Y">Yes</option>
                       	  <option value="N" selected="selected">No</option>

                     </select></td>	
                    </tr>
                    <tr>
                      <td colspan="2">Whether majority of members/owners belong to minority community</td>
                      <td><select name="sel_firm_minority" onchange="showMinorityDetails();">
                          <option value="0" selected="selected">--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N">No</option>
                        </select>
                      </td>
                      <td width="7%" id="id_nonind_religion_lbl">Religion</td>
                      <td width="38%" id="id_nonind_religion_fld"><select name="sel_corp_religion">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "11";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptype%>' />
                        </select>
                      </td>
                    </tr>
                    <!--<tr>
                     <td width="12%" nowrap="nowrap">Whether start up as per definition of Ministry of commerce and Industry<b><span class="mantatory">*&nbsp;</span></td>
                      <td width="15%"><select name="sel_minIndustry" tabindex="81">
                      <option value="0" >--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N" selected>No</option>
                        </select></td>
                        </tr>
                    
                  --></table></td>
              </tr>
              <tr id="id_shg_details">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                    <tr>
                      <td width="17%">SHG Formed/Located at<b><span class="mantatory">*&nbsp;</span></b></td>
                      <td width="23%"><select name="sel_shg_location">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "114";%>
                          <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                        </select></td>
                      <td width="15%">No. of members</td>
                      <td width="17%"><input type="text" name="txt_shg_members" maxlength="3" size="5" onKeyPress="allowInteger()" value="<%=strMembers%>"></td>
                      <td width="13%">No. of Beneficiaries</td>
                      <td width="15%"><input type="text" name="txt_shg_beneficiaries" maxlength="3" size="5" onKeyPress="allowInteger()" value="<%=strBeneficiaries%>"></td>
                    </tr>
                    <tr>
                      <td>Promoting Agency/Scheme (if any)</td>
                      <td><select name="sel_shg_promoting_agency" style="width:200px">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "115";%>
                          <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                        </select></td>
                      <td>Whether financed through any NGOs</td>
                      <td><select name="sel_ngo_finance">
                          <option selected="selected" value="0">--Select--</option>
                          <option value="Y">Yes</option>
                          <option value="N">No</option>
                        </select>
                      </td>
                      <td>Savings Banks account maintained by SHG</td>
                      <td><input type="text" name="txt_shg_savings_acctno" maxlength="16" size="20"  value="<%=strSavingsAcct%>"></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr id="const_partnership">
        	<td>
        		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
					<td width="18%">Partnership Details<b><span class="mantatory">*&nbsp;</span></td>
		        	<td width="20%"> 
		        		<select name="sel_partnership" onchange="chngePartner('valchange')"> 
		        			<option value="S">-- Select -- </option>
		        			<option value="R">Registered </option>
		        			<option value="U">Un-registered </option>
		        		</select>
		        	</td>
		        	<td width="15%">latest Partnership Deed Date<b><span class="mantatory">*&nbsp;</span></td>
					<td width="18%"><input type="text" name="txt_part_deeddate" size="12" maxlength="10" value="<%=PERAPP_PARTNERSHIP_DEEDDATE%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                     		<a 
							onClick="callCalender('txt_part_deeddate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
					
          </tr>   
          <tr>
            <td width="15%" id="id_part_regno1" >Registration No<b><span class="mantatory">*&nbsp;</span></td>
		        	<td width="15%" id="id_part_regno2" ><input type="text" name="txt_regno" value="<%=PERAPP_PARTNERSHIP_REGNO %>"> </td>		
          </tr>
        		</table>
        	</td>
        </tr>
        <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr id="id_cgtmse">
					<td width="18%">Udyog Aadhaar Number<b></td>
		        	<td width="20%"> 
		        		<input type="text" name="txt_udyog_aadhar"  value="<%=PERAPP_UDYOG_AADHAR%>" maxlength="12" onBlur="min_nos(document.forms[0].txt_udyog_aadhar,12);checkSplDotC(this);" onkeypress="allowAlphaNumeric();">
		        	</td>
		        	<td width="15%">MSE Registration Number<b></td>
					<td width="18%"><input type="text" name="txt_mse_regno" size="12" maxlength="10" value="<%=PERAPP_MSE_REGNO%>"
							onBlur="checkSplDotC(this);">
                     		</td>		
					</tr>
					<tr>
					<td>Total Employees</td>
                      <td><input type="text" name="txt_total_employees" maxlength="5" size="10" value="<%=strTotalEmployees%>" onkeypress="allowInteger();"></td>
                      <td>As on Date</td>
                      <td><input type="text" name="txt_employee_asondate" size="12" maxlength="10" value="<%=strEmployeeAsonDate%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                     		<a 
							onClick="callCalender('txt_employee_asondate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
					</tr>
					</table>
					</td>
        </tr>
         <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
					<td width="18%">Udyam Registration Certificate Number<b></td>
		        	<td width="20%"> 
		        		<input type="text" name="txt_udyam_regno"  value="<%=Helper.correctNull((String)hshValues.get("PERAPP_UDYAM_REGNO"))%>" maxlength="19" style="text-transform:uppercase" onBlur="checkchar();" onfocus="checkudyam();" onkeypress="allowAlphaNumeric();">
		        	</td>
		        	<td width="15%">MSME Classification as per Udyam Registration Certificate</td>
                    <td width="18%"><select name="sel_msme_classification" style="width:200px">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "249";%>
                          <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                        </select></td>
                        </tr>
                        <tr>
                        	<td>Udyam Certification Date</td>
                      <td><input type="text" name="txt_certificate_date" size="12" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_CERTIFICATION_DATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                     		<a 
							onClick="callCalender('txt_certificate_date')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
		        			
					</tr>
					         <tr>
					         </table>
					         </td>
					         </tr>
					         <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
					<td width="18%">Sales Turnover As on Date</td>
                      <td width="20%"><input type="text" name="txt_turnover_asondate" size="12" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER_DATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                     		<a 
							onClick="callCalender('txt_turnover_asondate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
							<td width="15%">Criteria for Sales Turnover </td>
                    <td width="18%"><select name="sel_sales_turnover" style="width:200px">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%apptype = "243";%>
                          <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                        </select></td>
                      
					</tr>
					<tr>
				
							<td width="15%">Sales Turnover of the Applicant<b></td>
					<td width="18%"><input type="text" name="txt_sales_turnover" size="12" maxlength="15" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PERAPP_SALES_TURNOVER"))))%>"
							style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);">
                     		</td>
                      
					</tr>
					</table>
					</td>
        </tr>
        <tr>
        <td id="const_company">
       		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
       			<tr>
       				<td width="18%">Latest search report dated <b><span class="mantatory">*&nbsp;</span></td>
       				<td width="20%"><input type="text" name="txt_comp_repDate" size="12" maxlength="10" value="<%=PERAPP_COM_SEARCHREPDATE%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                     		<a 	onClick="callCalender('txt_comp_repDate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a>
					</td>
					<td width="15%">Authorised Capital<b><span class="mantatory">*&nbsp;</span></td>
					<td width="18%"><input type="text" name="txt_com_authCapital" onKeyPress="allowInteger()" style="text-align: right" value="<%=PERAPP_COM_AUTHCAPTAL%>" onblur="roundtxt(this);"> </td>
					<td width="15%">Paid up Capital<b><span class="mantatory">*&nbsp;</span></td>
					<td width="15%"><input type="text" name="txt_com_PaidupCapital" onKeyPress="allowInteger()" style="text-align: right"  value="<%=PERAPP_COM_PAIDUPCAP%>" onblur="roundtxt(this);"> </td>
       			</tr>
       			<tr>
       				<td width="18%" >MOA/AOA - Powers to borrow by the company <br>and to mortgage the asset verified<b><span class="mantatory">*&nbsp;</span> </td> 
       				<td width="20%" >
       					<select name="sel_MOA_verified" onchange="chngeMOAverif('valchange')"> 
		        			<option value="S">-- Select -- </option>
		        			<option value="Y">Yes </option>
		        			<option value="N">No </option>
		        		</select>
		        	 </td>
		        	 <td width="15%"  id="id_amendedMOA1">Amended MOA/AOA<b><span class="mantatory">*&nbsp;</span></td>
		        	 <td width="18%" id="id_amendedMOA2"> <textarea rows="3" cols="20" name="amendedMOA_comments"><%=PERAPP_COM_AMENDEDMOA%></textarea> </td>
       			</tr>
       		</table>
       	</td>
        </tr>
        <tr id="const_huf">
        	<td>
     	       	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	        		<tr>
	        			<td width="18%"> Trust deed dated <b><span class="mantatory">*&nbsp;</span></td>
	        			<td width="20%"><input type="text" name="txt_trust_deeddate" size="12" maxlength="10" value="<%=PERAPP_TRUST_DEEDDATE%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);">
                     		<a 	onClick="callCalender('txt_trust_deeddate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a>
						</td>
						<td width="15%">Trust Type<b><span class="mantatory">*&nbsp;</span></td>
						<td width="18%"> 
							<select name="sel_trustType"> 
			        			<option value="S">-- Select -- </option>
			        			<option value="R">Registered Trust</option>
			        			<option value="U">Un-registered Trust</option>
			        		</select>
						</td>
						<td width="15%"> Permission Reference number for opening trust account <b><span class="mantatory">*&nbsp;</span></td>
						<td width="15%"><input type="text" name="txt_trust_refno_openacc"  value="<%=PERAPP_TRUST_PERMREFNO%>"> </td>
	        		</tr>
	        	</table>
        	</td>
        </tr>
        <tr id="const_assetslist">
			           <td valign="top"><b>The charge on assets of the company observed&nbsp;</b><br/>
						 <table width="100%" border="0"  align="center" class="outertable" id="tabid_assetslist">
							<tr class="dataheader" align="center" ><td>Name of the assets</td><td>Charge Holder</td><td>Date of Charge</td>
							</tr>
							<%if(arrAssetDet!=null && arrAssetDet.size()>0)
		                    {
		                    for(int j=0;j<arrAssetDet.size();j++){
								arrcol5 = (ArrayList)arrAssetDet.get(j);
						%>
							<tr  align="center">	
								<td><input type="text" name="txt_assetname" value="<%=Helper.correctNull((String)arrcol5.get(1)) %>" size="30"></td>
								<td><input type="text" name="txt_charholder" value="<%=Helper.correctNull((String)arrcol5.get(2)) %>" size="30"></td>
								<td><input type="text" name="txt_assetsdate" size="15"
										value="<%=Helper.correctNull((String)arrcol5.get(3)) %>" onBlur="checkDate(this);checkmaxdate(this,currentDate);" maxlength="10" tabindex="15">
					   					 <a alt="Select date from calender" 
										onClick="callCalender_mul('txt_assetsdate',this.parentNode.parentNode.id)"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender" tabindex="29"></a> 
								</td>	
								
							</tr>	
								<%}}else{ %>
								<tr  align="center">	
								<td><input type="text" name="txt_assetname" value="" size="30"></td>
								<td><input type="text" name="txt_charholder" value="" size="30"></td>
								<td><input type="text" name="txt_assetsdate" size="15"
										value="" onBlur="checkDate(this);checkmaxdate(this,currentDate);" maxlength="10" tabindex="15">
					   					 <a alt="Select date from calender" 
										onClick="callCalender_mul('txt_assetsdate',this.parentNode.parentNode.id)"
										onMouseOver="window.status='Date Picker';return true;"
										onMouseOut="window.status='';return true;"><img
										src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
										alt="Select date from calender" tabindex="29"></a> 
								</td>	
								
							</tr>
								<%} %>
						 </table>
						</td> 
						<td valign="top"><span style="width: 30%;"><a onClick="Addvaluer();"><img
										src="<%=ApplicationParams.getAppUrl()%>img/add.png"
										border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;
								 		<a onClick="deleteRow('tabid_assetslist');"><img
										src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
										border="0" tabindex="38"></a> </span>
						</td>
						<td>&nbsp;</td>
              	</tr>
              	<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
<tr>
                       <td width="18%" > Whether GSTIN Registered<b></td> 
       				<td width="20%" >
       					<select name="txt_GSTIN_reg" onchange="callGSTINChange()"> 
		        			<option value="S">-- Select -- </option>
		        			<option value="Y">Yes </option>
		        			<option value="N">No </option>
		        			<option value="NA">Not Applicable </option>
		        		</select>
		        	 </td>
		        	 <td width="15%"   id="GSTIN_Exempted" >Whether GSTIN Exempted <span class="mantatory">*&nbsp;</span>&nbsp;</td>
		        	 <td width="18%"   id="GSTIN_Exempted1" >
		        	 <select name="txt_GSTIN_Exempted" > 
		        			<option value="S">-- Select -- </option>
		        			<option value="Y">Yes </option>
		        			<option value="N">No </option>
		        			
		        		</select>
		        	 </td>
		        	 
                      <td valign="top"  id="GSTIN_name">
						<table border="0"  align="center" class="outertable">
					  		<tr>
					  			
								<td>GSTIN <span class="mantatory">*&nbsp;</span>&nbsp;</td>
								<td width="5%"><span style=""><a onClick="Addvaluer1();"><img
												src="<%=ApplicationParams.getAppUrl()%>img/add.png"
											    border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;
									<a onClick="deleteRow1('idGSTName','0');"><img
											src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
											width="10" height="10" border="0" tabindex="38"></a></span>
								</td>
								
							</tr>
						</table>
						</td> 
						<td id="GSTIN_name1"  align="left">
                   		<table border="0" cellspacing="0" cellpadding="2" id="idGSTName" >
					  	 <tr align="center" id="0">	
					  	  	<td width="5%"><input type="checkbox" name="chks" style="border: none;"></td>
								<td width="20%"><input type="text" name="txt_GstIn" size="25" value="" maxlength="15" onkeypress="allowAlphaNumeric()" onblur="changecase(this);fnValidateGSTNo(this);DuplicateCheck(this,this.parentNode.parentNode.id,'txt_GstIn')" tabindex=""></td>
 																						
                      </tr>
					  	</table>
						</td>
						 <!-- <td colspan="2">&nbsp;</td> -->
                   		
                      
                      
                    </tr>
                    </table>   
                    </td>
                    </tr>
                    
                    <tr>
          			<td>
	          			<table cellspacing="0" cellpadding="3" width="47%" class="outertable">
		             	 <tr>
			                <td width="18%">Date of Restructure Invocation</td>
			                <td width="15%"> <input type="text" name="txt_restructdate" onBlur="checkDate(this);checkmindate(this,invocmindate);checkmaxdate(this,invocmaxdate);checkcurrmaxdate(this,currentDate);" value="<%=PERAPP_INVOCDATE%>" 
			                 size="10">
								<% if((invocblockusers.equalsIgnoreCase("Y") && EligtoinvocdateEdit.equalsIgnoreCase("N")) ) {
									 %>
									<a alt="Select date from calender" href="#" onClick="callCalender('txt_restructdate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"></a>
										<%}else if((invocblockusers.equalsIgnoreCase("N"))){ 
										if(PERAPP_INVOCDATE.equalsIgnoreCase("") || EligtoinvocdateEdit.equalsIgnoreCase("N")){%>	
										<a alt="Select date from calender" href="#" onClick="callCalender('txt_restructdate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"></a>
										<%}} %>						
			                </td>
		                </tr>
		                </table>
	                </td>
	                </tr>
			     
</table>

<input type="hidden" name="sel_senior_citizen">
<input type="hidden" name="txt_applt_regno">
<input type="hidden" name="sel_applt_constitution">
<input type="hidden" name="hidcgtmsestat">
 <input type="hidden" name="hid_GSTINNO">

 <iframe height="0" width="0" id="ifrmcheckduplicate" frameborder="0"	style="border: 0"></iframe>