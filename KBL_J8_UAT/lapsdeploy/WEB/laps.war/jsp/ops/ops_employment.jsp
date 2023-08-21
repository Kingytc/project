<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	String empdet = Helper.correctNull((String)hshValues.get("peremploy"));
	String pageid = request.getParameter("pageid");

	String strApplnt = Helper.correctNull((String)request.getParameter("applnt"));
		
		if(strApplnt.equals("C"))
		{
		strApplnt = "CoApplicant";
		}
		else
		{
		strApplnt = "Guarantor";
		}
		String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
		String strSSIType = Helper.correctNull((String) request
				.getParameter("hidSSIType"));
		//System.out.print("strSSIType------->"+strSSIType);
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/peremployerdispco.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
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

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body text="#000000"  vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callonLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" url="">
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
function showText() 
{	
	if(document.forms[0].sel_pre.value=="2")
	{
	
		document.all.name_lease.style.visibility="visible";
		
		document.all.text_lease.style.visibility="visible";
	
	}
	if(document.forms[0].sel_pre.value=="0" || document.forms[0].sel_pre.value=="1" || document.forms[0].sel_pre.value=="3")
	{
	
		document.all.name_lease.style.visibility="hidden";
		document.all.text_lease.style.visibility="hidden";
	
	}
}
function callApplicantTab(page)
{
	if(page=="facilities")
	{
		document.forms[0].hidBeanMethod.value="getOPSFacilityData";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ops_facilities.jsp";
	}	  
	if(page=="subsidy")
	{
			document.forms[0].hidBeanId.value="comssiaboveten";
			document.forms[0].hidBeanGetMethod.value="getDataSubsidy";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_subsidy.jsp";
	}
	if(page=="ops_incomeexpenses")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getIncome";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_incomeexpenses.jsp";
	}
	if(page=="customerprofile")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getDemographics";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_applicantdisp1.jsp";
	}
	if(page=="accountdetails")
	{
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanGetMethod.value="getAccountDetails";
		document.forms[0].action=appURL+"action/ops_accountdetails.jsp";
		document.forms[0].submit();
	}
	document.forms[0].submit();
}
function callLink(page,bean,method)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
</script>
</div>
  </div>
<jsp:include page="../share/help.jsp" flush="true"/> 
<form name="appform" method="post" action="newapplicantDBase.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td><jsp:include page="../share/help.jsp" flush="true"/>
		<jsp:include page="../share/menus.jsp" flush="true"/>
		 <jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
      </tr>
     </table>
  
     <b><i><font face="Times New Roman, Times, serif" size="3">Home
		-&gt; Tertiary-&gt; Existing Application-&gt; Applicant-&gt;  Employment  </i></b>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
   <table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF">
      <tr> 
        <td colspan="2" valign="bottom"> 
          <table width="100%" border="0" cellspacing="3" cellpadding="3">
            <tr align="center"> 
            		<td width="15%" class="tabactivenew"><font  
							 ><b><a href="javascript:callApplicantTab('facilities')"
							class="blackfont">Facilities</a></b></td>
					<td width="15%" class="tabactivenew"><a
							href="javascript:callApplicantTab('subsidy')" class="blackfont"><font
							   ><b>Subsidy </b></a></td>
					<td width="15%" class="tabactivenew"><a
							href="javascript:callApplicantTab('accountdetails')" class="blackfont"><font
							   ><b>Account Details </b></a></td>							
					<td width="15%" class="tabactivenew"><a href="javascript:callApplicantTab('customerprofile')" class="blackfont"><font  
							 ><b>Customer Profile </b></a></td>	
					<td width="20%" class="tabactivenew"><a
							href="javascript:callApplicantTab('ops_incomeexpenses')" class="blackfont"><font
							   ><b>Income &amp; Expenses </b></a></td>
					<td width="20%" bgcolor="#71694F"><font
							    color="#FFFFFF"><b>Employment </b></td>	             
            </tr>
          </table>
        </td>
      </tr>
    </table>
   <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
              <tr> 
                
      <td> 
        <table width="100%" border="1" cellspacing="0" cellpadding="2"
	bgcolor="#DEDACF" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td><b> 
                    <%if (empdet.equalsIgnoreCase("1") && !empdet.equalsIgnoreCase("9")) {
									%>
                    Current Employment Details 
                    <%} else {
									%>
                    Self Employment Details 
                    <%}
									%>
                    </b></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="4%" nowrap><b> 
                          <%if (empdet.equalsIgnoreCase("1") && !empdet.equalsIgnoreCase("9")) {
												%>
                          </b>Employer Name <b> 
                          <%} else {%>
                          </b>Company Name<b> 
                          <%}
												%>
                          </b><b></b></td>
                        <td width="5%" id="empname">&nbsp;</td>
                        <td width="30%"> 
                          <table border="0" width="30%" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <input type="text" name="txtperemp_name"
											maxlength="100" size="40" 
											value="<%=Helper.correctNull((String)hshValues.get("peremp_name"))%>"
											onKeyPress="notAllowSingleQuote()" tabindex="1">
                                <input
											type="hidden" name="txtperemp_name1" size="15" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("company_name"))%>"
											onKeyPress="allowAlphabets()">
                              </td>
                            </tr>
                          </table>
                        </td>
                        <td width="4%" nowrap align="left">City</td>
                        <td width="4%" nowrap align="left" id="city">&nbsp;</td>
                        <td width="24%"> 
                          <table border="0" width="30%" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <input type="text" name="txtperemp_city"
											size="30" maxlength="20" 
											value="<%=Helper.correctNull((String)hshValues.get("peremp_city"))%>"
											onKeyPress="notAllowSplChar()">
                              </td>
                            </tr>
                          </table>
                        </td>
                        <td width="4%"><font  
											 >Phone No. </td>
                        <td width="5%" id="phone">&nbsp;</td>
                        <td width="20%"> 
                          <input type="text"
											name="txtperemp_phone" size="18" maxlength="15" tabindex="10"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_phone"))%>"
											onKeyPress="allowInteger()">
                        </td>
                      </tr>
                      <tr> 
                        <td width="4%" >Address<b></b></td>
                        <td width="5%" id="add">&nbsp;</td>
                        <td width="30%" > 
                          <input type="text" name="txtperemp_address1"
											size="30" maxlength="50" tabindex="3"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_address1"))%>"
											onKeyPress="notAllowedDouble()">
                        </td>
                        <td width="4%" ><font  
											 >State 
                        </td>
                        <td width="4%" id="state" >&nbsp;</td>
                        <td width="24%"> 
                          <input type="text" name="txtperemp_state"
											size="30" maxlength="50"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_state"))%>"
											onKeyPress="notAllowSplChar()" onBlur="changecase(this)" tabindex="7">
                        </td>
                        <td width="9%" colspan="2"><font  
											 >Fax No. </td>
                        <td width="20%"> 
                          <input type="text" name="txtperemp_fax" size="12"
											maxlength="15" tabindex="11"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_fax"))%>"
											onKeyPress="allowInteger()">
                        </td>
                      </tr>
                      <tr> 
                        <td width="9%" colspan="2">&nbsp;</td>
                        <td width="30%"> 
                          <input type="text" name="txtperemp_address2"
											size="30" maxlength="25" tabindex="4"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_address2"))%>"
											onKeyPress="notAllowedDouble()">
                        </td>
                        <td width="8%" colspan="2"><font  
											 >Country</td>
                        <td width="24%"> 
                          <input type="text" name="txtperemp_country" size="15"
											maxlength="15" tabindex="8"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_country"))%>"
											onKeyPress="notAllowSplChar()">
                        </td>
                        <td width="9%" colspan="2">Company 
                          E-mail</td>
                        <td width="20%" > 
                          <input type="text"
											name="txtperemp_email" maxlength="50" tabindex="12"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_email"))%>"
											onBlur="isEmailAddr(document.forms[0].txtperemp_email.value,document.forms[0].txtperemp_email)"
											size="20">
                        </td>
                      </tr>
                      <tr> 
                        <td width="9%" colspan="2">&nbsp;</td>
                        <td width="30%"> 
                          <input type="text" name="txtperemp_address3"
											size="30" maxlength="50" tabindex="5"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_address3"))%>"
											onKeyPress="notAllowedDouble()">
                        </td>
                        <td width="4%"><%=ApplicationParams.getZipName()%> 
                        </td>
                        <td width="4%" id="pin">&nbsp;</td>
                        <td width="24%"> 
                          <input type="text" name="txtperemp_zip"
											size="8" maxlength="6" tabindex="9"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_zip"))%>"
											onKeyPress="allowInteger()">
                        </td>
                        <td width="9%" colspan="2">&nbsp;</td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td nowrap width="6%" id="emp">Employee 
                          Id <b></b></td>
                        <td nowrap width="6%" id="empid">&nbsp;</td>
                        <td width="27%" id="emp1"> 
                          <input type="text" name="txtperemp_empno" size="12"
											maxlength="10" tabindex="13"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_empno"))%>"
											onKeyPress="notAllowSplChar()">
                        </td>
                        <td width="13%" colspan="2">Phone 
                          Extn. </td>
                        <td width="17%"> 
                          <input type="text" name="txt_empphoneextn"
											size="15" maxlength="5" tabindex="18"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_phexten"))%>" onKeyPress="allowInteger()" >
                        </td>
                        <td width="6%">  Establishment 
                          Date </td>
                        <td width="6%" id="est">&nbsp;</td>
                        <td width="19%"> 
                          <table border="0" width="30%" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <input type="text" name="txtperemp_establish" size="11"
                                value="<%=Helper.correctNull((String)hshValues.get("peremp_establish"))%>" onBlur="checkDate(this);checkmaxdate(this,currdate)">
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td width="12%" colspan="2">Category<b></b></td>
                        <td width="27%" > 
                          <select
											name="sel_category" tabindex="14">
                            <option value="0" selected>--Select--</option>
                            <option value="1">Executive /Senior Managerial</option>
                            <option value="2">Managerial/ Officer(&gt;2years) 
                            / Clerical</option>
                            <option value="3">Junior(Officers &lt; 2 years) / 
                            Clerical</option>
                            <option value="4">Self Employed</option>
                            <option value="5">Others</option>
                          </select>
                          </td>
                        <td width="6%">  
                          <%if (empdet.equalsIgnoreCase("9")) {
												%>
                          Pension 
                          <%} else {%>
                          Salary  
                          <%}
												%>
                          Receipt Date  </td>
                        <td width="7%" id="rec">&nbsp;</td>
                        <td width="17%"> 
                          <table border="0" width="30%" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <input type="text" name="txtperemp_receipt"  
                                value="<%=Helper.correctNull((String)hshValues.get("peremp_receipt"))%>" onBlur="checkDate(this)">
                              </td>
                            </tr>
                          </table>
                        </td>
                        <td width="6%">Business 
                          Premises </td>
                        <td width="6%" id="bp">&nbsp;</td>
                        <td width="19%"> 
                          <select name="sel_pre" onChange="showText()"  tabindex="23" >
                            <option value="0">Owned</option>
                            <option value="1">Rented</option>
                            <option value="2">Leased</option>
                            <option value="3">Not Applicable</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="6%"><font  
											 >Occupation<b></b></td>
                        <td width="6%" id="occ">&nbsp;</td>
                        <td width="27%"> 
                          <!--<input type="text"
											name="txtperemp_occupation" size="15" maxlength="50"
											
											value="<%//=Helper.correctNull((String)hshValues.get("peremp_occupation"))%>"
											onKeyPress="notAllowSplChar()">
                                &nbsp;<b><span
											onClick="callsupnam1()" style="cursor:hand"> 
                                <input
											type="hidden" name="txtperemp_occupcode" size="15"
											maxlength="20"
											value="<%//=Helper.correctNull((String)hshValues.get("peremp_occupation"))%>"
											onKeyPress="allowAlphabets()">
                                ?</span></b>-->
                          <select name="selperemp_occupation" style="width:200px"  tabindex="15">
                            <option value="0">--Select--</option>
                            <%String apptype = "13";

			%>
                            <lapschoice:StaticDataNewTag apptype='<%=apptype%>' /> 
                          </select>
                        </td>
                        <td width="6%"> 
                          <%if (empdet.equalsIgnoreCase("1") && !empdet.equalsIgnoreCase("9")) {
												%>
                          Years in Employment  
                          <%} else {%>
                           Years in Business 
                           
                          <%}
												%>
                          <b></b></td>
                        <td width="7%" id="yeb">&nbsp;</td>
                        <td width="17%"> 
                          <input
											type="text" name="txtperemp_noofemp" size="3" maxlength="2"
											tabindex="20"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_yearsinbuss"))%>"
											onKeyPress="allowInteger()">
                        </td>
                        <td width="12%" colspan="2"><font     id="name_lease">Lease 
                          Period </td>
                        <td width="19%"> 
                          <input type="text" name="txtperemp_lease" size="12" 
                    onKeyPress="allowInteger()"
                    id="text_lease" maxlength="10" tabindex="24" value="<%=Helper.correctNull((String)hshValues.get("peremp_lease"))%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="12%" colspan="2">Designation</td>
                        <td width="27%"> 
                          <table border="0" width="30%" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <input type="text"
											name="txtperemp_Designation" size="20" maxlength="20"
											
											value="<%=Helper.correctNull((String)hshValues.get("peremp_design"))%>"
											onKeyPress="notAllowSplChar()">
                                <input type="hidden"
											name="txtperemp_Desigcode" size="15" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_design"))%>"
											onKeyPress="allowAlphabets()">
                              </td>
                            </tr>
                          </table>
                        </td>
                        <td width="6%" nowrap>Retirement 
                          Date </td>
                        <td width="7%" nowrap id="ret">&nbsp;</td>
                        <td width="17%"> 
                          <table border="0" width="30%" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <input type="text" name="txtperemp_retdate" size="11"
											maxlength="10" 
											value="<%=Helper.correctNull((String)hshValues.get("peremp_retdate"))%>"
											onBlur="checkDate(this);calyearsofserviceleft()">
                              </td>
                            </tr>
                          </table>
                        </td>
                        <td width="12%" id="t1" colspan="2">Contact 
                          Person</td>
                        <td width="19%" id="t2"> 
                          <input type="text" name="peremp_contperson"
											size="25" maxlength="50" tabindex="25"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_contperson"))%>"
											onKeyPress="notAllowedDouble()">
                          </td>
                      </tr>
                      <tr> 
                        <td width="12%" colspan="2">Department 
                          Name</td>
                        <td width="27%"> 
                          <input type="text" name="txtperemp_department"
											size="35" maxlength="50" tabindex="17"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_department"))%>"
											onKeyPress="notAllowSplChar()">
                        </td>
                        <td width="13%" nowrap colspan="2">Years 
                          Of Service Left</td>
                        <td width="17%"> 
                          <input type="text" name="txtserviceleft"
											size="3" maxlength="2" onKeyPress="allowInteger()" readOnly 
											value="<%=Helper.correctNull((String)hshValues.get("peremp_servleft"))%>" >
                          Years  
                          <input
											type="text" name="txt_servicemonths" size="3" maxlength="2"  
											onBlur="GetYearsleft()" onKeyPress="allowInteger()" readOnly
											value="<%=Helper.correctNull((String)hshValues.get("peremp_servleftmon"))%>">
                          Months </td>
                        <td width="12%" colspan="2">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="6%">License 
                          No</td>
                        <td width="6%" id="ln">&nbsp;</td>
                        <td width="27%"> 
                          <input type="text" name="txtperemp_licenseno" size="12"
											maxlength="15" tabindex="9"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_licenseno"))%>"
											>
                        </td>
                        <td width="6%" nowrap>License 
                          Date</td>
                        <td width="7%" nowrap id="ld">&nbsp;</td>
                        <td width="17%"> 
                          <input type="text" name="txtperemp_licensedate" size="11"
                                value="<%=Helper.correctNull((String)hshValues.get("peremp_licensedate"))%>" onBlur="checkDate(this);checkmaxdate(this,currdate)">
                        </td>
                        <td width="12%" colspan="2">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <%--	<tr> 
							<td width="18%"> 
                                <div align="left"><b> 
                                  <%if (!empdet.equalsIgnoreCase("2")) {

			%>
                                  </b>Working Since<b> 
                                  <%} else {

			%>
                                  </b>Since When Esablished<b> 
                                  <%}

			%>
                                  </b></div>
                              </td>
                              <td width="13%"> 
                                <div align="left"> 
                                  <input
											type="text" name="txtperemp_yresemp" size="5" maxlength="4"
											tabindex="14"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_yresemp"))%>"
											onKeyPress="allowInteger(document.forms[0].txtperemp_yresemp)" onBlur="min_nos(this,4)">
                                  (Year)</div>
                              </td>
                              <td width="10%">&nbsp;</td>
                              <td width="21%">&nbsp;</td>
                              <td width="10%">&nbsp;</td>
                              <td width="21%">&nbsp;</td>
							</tr>--%>
                      <tr> 
                        <td width="15%">Name 
                          of Previous Employer</td>
                        <td width="16%"> 
                          <input type="text" name="txtperemp_prevempname" size="15"
											maxlength="40" tabindex="26"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_prevempname"))%>"
											onKeyPress="notAllowSplChar()">
                        </td>
                        <td width="8%">City 
                          </td>
                        <td width="19%"> 
                          <table border="0" width="30%" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <input type="text" name="txtperemp_prevempcity" size="15"
							maxlength="23" 
							value="<%=Helper.correctNull((String)hshValues.get("permcity_code_val"))%>"
							onKeyPress="notAllowSplChar()">
                              </td>
                              
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td width="15%">Knowledge 
                          &amp; Experience</td>
                        <td width="16%"> 
                          <textarea name="txtperemp_experience" cols="20" %="%" onKeyPress="textlimit(this,2999);notAllowSplChar()" onKeyUp="textlimit(this,2999)"  tabindex="28"><%=Helper.correctNull((String)hshValues.get("peremp_experience"))%></textarea>
                        </td>
                        <td width="9%">&nbsp;</td>
                        <td width="8%">&nbsp;</td>
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
           
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td> 
        <table width="43%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0"> 
              <input type="button" name="cmdEdit" value="Edit" class="buttonStyle" onClick="callEdit()">
            </td>
            <td height="0"> 
              <input type="button" name="cmdapply" value="Save" class="buttonStyle" onClick="doSave()">
            </td>
            <td height="0"> 
              <input type="button" name="cmdCancel" value="Cancel" class="buttonStyle" >
            </td>
            <td height="0"> 
              <input type="button" name="cmddel" value="Delete" class="buttonStyle" disabled>
            </td>
           <!--  <td height="0"> 
              <input type="button" name="cmdHelp" value="Help" class="buttonHelp" onClick="dohlp()">
            </td> -->
            <td height="0"> 
              <div align="center"> 
                <input type="button" name="cmdClose" value="Close" class="buttonClose" onClick="doClose()" >
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <laps:hiddentag/>
  <INPUT TYPE="hidden" name="hidApp_type" value="A">
  <INPUT TYPE="hidden" name="page" value="ep">
  <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
    <INPUT TYPE="hidden" name="pageid" value="<%=pageid%>">
  <INPUT TYPE="hidden" name="applntype" value="<%=(String)request.getParameter("applnt")%>" >
</form>
</body>
</html>
 