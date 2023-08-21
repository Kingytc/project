<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	String empdet = Helper.correctNull((String)hshValues.get("peremploy"));
	String pageid = request.getParameter("pageid");
	String strApplnt = request.getParameter("applnt");
		
		if(strApplnt.equals("C"))
		{
		strApplnt = "CoApplicant";
		}
		else
		{
		strApplnt = "Guarantor";
		}
		String pageType=Helper.correctNull((String) session.getAttribute("pageType"));
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
</STYLE>
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/nationalportal/psb59peremployerdispco.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var vardesig = "<%=Helper.correctNull((String)hshValues.get("peremp_empdesig"))%>";
var varemploy = "<%=Helper.correctNull((String)hshValues.get("peremploy"))%>";
var varexpoffamily="<%=Helper.correctNull((String)hshValues.get("peremp_expfammem"))%>";
function callhelp()
{
		   var varQryString = appURL+"/jsp/perhlp/hlp_peremployerdispco.jsp"
		   var title = "ApplicantDemographics";
			var prop = "scrollbars=no,width=600,height=450";	
			prop = prop + ",left=200,top=150";
			window.open(varQryString,title,prop);
}

function ShowEmployer(page)
{
	var demoid = document.forms[0].hidDemoId.value;
	var url = appURL+"action/"+page+"?hidBeanId=mastapplicant&hidBeanGetMethod=getPreEmpData&hidDemoId="+demoid;
	var title = "Employer";
	var prop = "scrollbars=no,width=1000,height=550,menubar=no";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body class="bgcolor" text="#000000"  vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callonLoad()">
<jsp:include page="../share/help.jsp" flush="true"> </jsp:include>
<form name="appform" method="post" action="newapplicantDBase.jsp">
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
     <td>
		<%if(!pageType.equals("agri")){ %>
		<jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true">
			<jsp:param name="pageid" value="<%=pageid%>" />
		</jsp:include>
		
		<%}else{ %>
		<jsp:include page="../agri/Applurllinkagri.jsp" flush="true">
			<jsp:param name="pageid" value="<%=pageid%>" />
		</jsp:include>
		<%} %>
		</td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
    
    	<%if(pageType.equals("agri")){%>
    <td class="bredcrumb">Home <span class="bredcrumbArw">&gt; </span> &nbsp; Agriculture <span class="bredcrumbArw"> &gt; </span> &nbsp;<%= (String)session.getAttribute("pgeLabel")%> <span class="bredcrumbArw"> &gt; </span> &nbsp;  <%=strApplnt%></td>
    <%} else{%>
		  <td class="bredcrumb">Home <span class="bredcrumbArw">&gt; </span> &nbsp; Retail <span class="bredcrumbArw"> &gt; </span> &nbsp; <%= (String)session.getAttribute("pgeLabel")%> <span class="bredcrumbArw"> &gt; </span> &nbsp;  <%=strApplnt%></td>
		<%} %>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td> <lapschoice:application /> </td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td id="hyperlnk3" class="outertablecolor" > 
        <table width="55%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="30%" class="tabinactive"><b><font size="1" face="ms sans serif"><a href="JavaScript:callDemographics()" class="blackfont">Demographics</a></font></b></td>
            <td width="35%" class="tabinactive"><b><font size="1" face="ms sans serif"><a href="JavaScript:callIncome()" class="blackfont">Income 
              &amp; Deductions</a></font></b></td>
            <td width="35%" class="tabactive"  ><b><font size="1" face="ms sans serif" color="#FFFFFF">Employment 
              Details </font></b></td>
          </tr>
        </table>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
 <table width="100%" border="1" cellspacing="0" cellpadding="3"
	height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	class="outertablecolor">
	<tr>
		<td valign="top">
		<div class="cellContainer">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td valign="top">
				<table width="100%" border="1" cellspacing="0" cellpadding="8"
					height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr>
						<td valign="top"><br>
						<table width="100%" border="1" cellspacing="0" cellpadding="0"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
							<tr>
								<td>
								
                              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                <tr> 
                                  <td colspan="6"><font size="1" face="MS Sans Serif"><b> 
                                    <%if (!empdet.equalsIgnoreCase("6")) {

			%>
                                    Current Employment Details 
                                    <%} else {

			%>
                                    Self Employment Details 
                                    <%}

			%>
                                    </b></font><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                                </tr>
                                <tr> 
                                  <td width="29%"><font size="1" face="MS Sans Serif"><b> 
                                    <%if (!empdet.equalsIgnoreCase("6")) {

			%>
                                    </b>Employer Name <b> 
                                    <%} else {

			%>
                                    </b>Company Name<b> 
                                    <%}

			%>
                                    </b></font></td>
                                  <td width="29%"><font size="1" face="MS Sans Serif"> 
                                    <input type="text"
											name="txtperemp_name" maxlength="40" size="42"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_name"))%>"
											onKeyPress="notAllowSingleQuote()">
                                    </font></td>
                                  <td width="8%"><font size="1" face="MS Sans Serif">Employee 
                                    No.</font></td>
                                  <td width="9%"><font size="1" face="MS Sans Serif"> 
                                    <input type="text"
											name="txtperemp_id" size="10" maxlength="10"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_empid"))%>">
                                    </font></td>
                                </tr>
                                <tr> 
                                  <td width="29%"><font size="1" face="MS Sans Serif">Address</font></td>
                                  <td colspan="5"><font size="1" face="MS Sans Serif"> 
                                    <input
											type="text" name="txtperemp_address1" size="35"
											maxlength="50"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_address1"))%>"
											onKeyPress="notAllowedDouble()">
                                    </font></td>
                                </tr>
                                <tr> 
                                  <td width="29%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                                  <td colspan="5"><font size="1" face="MS Sans Serif"> 
                                    <input
											type="text" name="txtperemp_address2" size="35"
											maxlength="50"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_address2"))%>"
											onKeyPress="notAllowedDouble()">
                                    </font></td>
                                </tr>
                                <tr> 
                                  <td width="29%"><font size="1" face="MS Sans Serif">City</font></td>
                                  <td width="29%"><font size="1" face="MS Sans Serif"> 
                                    <input
											type="text" name="txtperemp_city" size="15" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_city"))%>"
											onKeyPress="allowAlphabets()">
                                    </font></td>
                                  <td width="8%"> 
                                    <div align="left"><font size="1" face="MS Sans Serif">State</font></div>
                                  </td>
                                  <td width="9%"> 
                                    <div align="left"><font size="1" face="MS Sans Serif"> 
                                      <input
											type="text" name="txtperemp_state" size="15" maxlength="50"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_state"))%>"
											onKeyPress="allowAlphabets()" onBlur="changecase(this)">
                                      </font></div>
                                  </td>
                                  <td width="8%"> 
                                    <div align="left"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font></div>
                                  </td>
                                  <td width="15%"> 
                                    <div align="left"><font size="1" face="MS Sans Serif"> 
                                      <input
											type="text" name="txtperemp_zip" size="12"
											maxlength="<%=ApplicationParams.getZipValue()%>"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_zip"))%>"
											onKeyPress="allowInteger()">
                                      </font></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td width="29%" height="45"><font size="1"
											face="MS Sans Serif">Phone No. </font></td>
                                  <td width="29%" height="45"><font size="1"
											face="MS Sans Serif"> 
                                    <input type="text"
											name="txtperemp_phone" size="12" maxlength="10"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_phone"))%>"
											onKeyPress="allowInteger()">
                                    </font></td>
                                  <td width="8%" height="45"> 
                                    <div align="left"><font size="1" face="MS Sans Serif">Fax 
                                      No. </font></div>
                                  </td>
                                  <td width="9%" height="45"> 
                                    <div align="left"><font size="1" face="MS Sans Serif"> 
                                      <input
											type="text" name="txtperemp_fax" size="12" maxlength="10"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_fax"))%>"
											onKeyPress="allowInteger()">
                                      </font></div>
                                  </td>
                                  <td width="8%" height="45"> 
                                    <div align="left"><font size="1" face="MS Sans Serif">Company 
                                      E-mail</font></div>
                                  </td>
                                  <td width="15%" height="45"> 
                                    <div align="left"><font size="1" face="MS Sans Serif"> 
                                      <input
											type="text" name="txtperemp_email" maxlength="50"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_email"))%>"
											onblur="isEmailAddr(document.forms[0].txtperemp_email.value,document.forms[0].txtperemp_email)"
											size="20">
                                      </font></div>
                                  </td>
                                </tr>
                                <!-- <tr>
										<td width="6%" height="45">
										<div align="left"><font size="1" face="MS Sans Serif">If,NRI,
										Passport No.<font></div>
										</td>
										<td width="24%"><font size="1" face="MS Sans Serif"> <input
											type="text" name="txtperemp_passno" size="12" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("txtperemp_passno"))%>">

										</font></td>
										<td>&nbsp;Date of Expiry &nbsp;</td>
										<td><input type="text" name="txtperemp_passexpiry" size="12"
											maxlength="10"
											value="<%=Helper.correctNull((String)hshValues.get("txtperemp_passexpiry"))%>"
											onKeyPress="allowDate(this)"> </font></td>

										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr> -->
                                <tr> 
                                  <td width="29%" height="39"><font size="1"
											face="MS Sans Serif">Designation</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                  <td width="29%" height="39"><font size="1"
											face="MS Sans Serif"> 
                                    <!-- <input type="text" name ="txtperemp_empdesig"  value ="<%//=Helper.correctNull((String)hshValues.get("peremp_empdesig"))%>" > -->
                                    <select name="txtperemp_empdesig">
										 <option value="0" selected> <----Select----> 
                                          </option>
                                          <lapschoice:StaticDataTag  apptype="13"/>
                                          </select>
                                    </font>
                                    </td>
                                    
                                  <td width="8%" height="39"> 
                                    
                                  <div align="left"><font size="1" face="MS Sans Serif"><b> 
                                    <%if (!empdet.equalsIgnoreCase("6")) {

			%>
                                    </b>Prior Work Experience<b> 
                                    <%} else {

			%>
                                    </b>Years in Business<b> 
                                    <%}

			%>
                                    </b></font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></div>
                                  </td>
                                  <td width="9%" height="39"> 
                                    <div align="left"><font size="1" face="MS Sans Serif"> 
                                      <input
											type="text" name="txtperemp_yresemp" size="5" maxlength="2"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_yresemp"))%>"
											onKeyPress="allowNumber(document.forms[0].txtperemp_yresemp)">
                                      </font></div>
                                  </td>
                                  <%if (!empdet.equalsIgnoreCase("6")) {

				%>
                                  <td width="8%"><font size="1" face="MS Sans Serif">Department</font></td>
                                  <td width="15%"><font size="1" face="MS Sans Serif"> 
                                    <input
											type="text" name="txtperemp_department" size="25"
											maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_department"))%>"
											onKeyPress="allowAlphabetsAndSpace()">
                                    </font></td>
                                  <div align="left"></div>
                                  <%} else {

			%>
                                  <td width="1%"></td>
                                  <td width="1%"></td>
                                  <%}

			%>
                                </tr>
                                <tr id="r1"> 
                                  <td width="29%"><font size="1" face="MS Sans Serif">Contact 
                                    Person</font></td>
                                  <td width="29%"><font size="1" face="MS Sans Serif"> 
                                    <input
											type="text" name="peremp_contperson" size="25" maxlength="40"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_contperson"))%>"
											onKeyPress="notAllowedDouble()">
                                    </font></td>
                                  
                                </tr>
                                <tr id="r2"> 
                                  <td width="29%" height="45"> 
                                    <div align="left"><font size="1" face="MS Sans Serif">No. 
                                      of years of service left </font></div>
                                  </td>
                                  <td width="29%">
                                    <input
											type="text" name="txtperemp_retage" size="3" maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_retage"))%>"
											onKeyPress="allowInteger()">
                                  </td>
                                  <td width="8%">Completed Service &nbsp;</td>
                                  <td width="9%"><font size="1" face="MS Sans Serif"> 
                                    <input
											type="text" name="txtperemp_compservice" size="3"
											maxlength="20"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_compservice"))%>"
											onKeyPress="allowInteger()">
                                    </font></td>
                                </tr>
                                <tr> 
                                  <td width="29%" height="45"> 
                                    <div align="left"><font size="1" face="MS Sans Serif">Present 
                                      employment is on contract basis</font></div>
                                  </td>
                                  <td width="29%">
<select
											name="selContract">
                                      <option value="0" selected>----Select----</option>
                                      <%String Contract = Helper.correctNull((String) hshValues
					.get("peremp_selContract"));
			if (Contract.equals("1")) {

			%>
                                      <option value="1" selected>Yes</option>
                                      <%} else {

			%>
                                      <option value="1">Yes</option>
                                      <%}
			if (Contract.equals("2")) {

			%>
                                      <option value="2" selected>No</option>
                                      <%} else {

			%>
                                      <option value="2">No</option>
                                      <%}

			%>
                                    </select>
                                  </td>
                                  <td width="8%">&nbsp;Date of joining of present 
                                    employment &nbsp;</td>
                                  <td width="9%"> 
                                    <input type="text" name="txtperemp_joindate" size="12"
											maxlength="10"
											value="<%=Helper.correctNull((String)hshValues.get("peremp_joindate"))%>"
											onBlur="checkDate(this)">
                                  </td>
                                  <td width="8%">&nbsp;Employment Transferable&nbsp;</td>
                                  <td width="15%"> 
                                    <select name="selTransfer">
                                      <option value="0" selected>----Select----</option>
                                      <%String transfer = Helper.correctNull((String) hshValues
					.get("peremp_transferable"));
			if (transfer.equals("1")) {

			%>
                                      <option value="1" selected>Yes</option>
                                      <%} else {

			%>
                                      <option value="1">Yes</option>
                                      <%}
			if (transfer.equals("2")) {

			%>
                                      <option value="2" selected>No</option>
                                      <%} else {

			%>
                                      <option value="2">No</option>
                                      <%}

			%>
                                    </select>
                                  </td>
                                </tr>
                                <tr> 
								<td>Experience of the borrower / family members in the current line of activity</td>
								<td>
							 <select name="sel_expoffamilymem"
													tabindex="12">
                                          <option value="0" selected> <----Select----> 
                                          </option>
                                          <lapschoice:StaticDataTag apptype="24"/>
                                        
                                        </select>
								</td>
                                  <td colspan="4" align="center"> 
                                    <input type="button" name="preemp"
											value="Previous Employment"
											onClick="ShowEmployer('preemployerdisp.jsp')" style="width:150"
											class="buttoncolor">
                                  </td>
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
		</td>
	</tr>
</table>
  <br>
  <table border="1" align="center" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
    <tr> 
      <td> 
        <table width="43%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0"> 
              <input type="button" name="cmdEdit" value="Edit" style="width:50" class="buttoncolor" onClick="callEdit()">
            </td>
            <td height="0"> 
              <input type="button" name="cmdapply" value="Apply" style="width:50" class="buttoncolor" onClick="callApply()">
            </td>
            <td height="0"> 
              <input type="button" name="cmdCancel" value="Cancel" style="width:50" class="buttoncolor">
            </td>
            <td height="0"> 
              <input type="button" name="cmdDelete" value="Delete" style="width:50" class="buttoncolor" disabled>
            </td>
            <td height="0"> 
              <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callhelp()">
            </td>
            <td height="0"> 
              <div align="center"> 
                <input type="button" name="cmdClose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doClose()" >
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <INPUT TYPE="hidden" name="hidApp_type" value="A">
  <input type="hidden" name="hidBeanMethod" >
  <input type="hidden" name="hidBeanId" >
  <input type="hidden" name="hidSourceUrl" >
  <input type="hidden" name="hidBeanGetMethod" >
  <INPUT TYPE="hidden" name="page" value="ep">
  <!-- <INPUT TYPE="hidden" name="appno" value="<%=request.getParameter("appno")%>"> -->
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
  <input type="hidden" name="hidCoDemoId" value="<%=request.getParameter("hidCoDemoId")%>" >
  <INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=request.getParameter("hidGuaDemoId")%>">
  <INPUT TYPE="hidden" name="hiPgDist" value="P">
  <INPUT TYPE="hidden" name="pageid" value="<%=pageid%>">
  <INPUT TYPE="hidden" name="applntype" value="<%=(String)request.getParameter("applnt")%>" >
</form>
</body>
</html>
 