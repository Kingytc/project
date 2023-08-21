<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<% String stroptions=" "; %>
<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>

<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT   LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/per/perpropertydetails.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>

var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 

function onloading()
{
}

function doAfterEdit()
{
	
}




function disableCommandButtons(val)
{
  if(val=="load")
  {
	  if(editflag==1)
	  document.forms[0].cmdedit.disabled=false;
	  document.forms[0].cmdapply.disabled=true;
	  document.forms[0].cmdcancel.disabled=true;
	  document.forms[0].cmdclose.disabled=false;
  }
  if(val=="edit")
  {

	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdapply.disabled=false;
	 document.forms[0].cmdcancel.disabled=false;
	 document.forms[0].cmdclose.disabled=true;
  }
}



</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading()">
<jsp:include page="../share/help.jsp" flush="true"/> 


<form method="post" >
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
         </td>
    </tr>
  </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        Retail</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>-&gt; </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i><%= (String)session.getAttribute("pgeLabel")%></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"> 
        <b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Applicant</i></b></font></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td> 
               <lapschoice:application /> </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="bottom"> 
        <table width="91%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
 
            <td width="12%"  height="16" bgcolor="#EEEAE3" ><b><font size="1" face="ms sans serif"><a href="javascript:loanDetails()" class="blackfont">LoanProduct</a></font></b></td>
            <td width="13%" height="16" bgcolor="#EEEAE3"><b><font size="1" face="ms sans serif"><a href="JavaScript:callDemographics()" class="blackfont">Demographics</a></font></b></td>
            <td width="17%" height="16" bgcolor="#EEEAE3"><b><font size="1" face="ms sans serif"><a href="JavaScript:callIncomeExpenses()" class="blackfont">Income 
              &amp; Expenses</a></font></b></td>

            <td width="16%" height="16" bgcolor="#71694F"><b><font  color="#FFFFFF">Proposed 
              Asset</font></b></td>

            <td width="17%"  height="16" bgcolor="#EEEAE3" id="employertdbtn1"><b><font size="1" face="ms sans serif"><a href="JavaScript:callEmployer()" class="blackfont">Employment 
              Details </a></font></b></td>
			   
            <td width="25%"  height="16" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><font color="#CCCCCC"><a href="JavaScript:callCoAppGuarantor()" class="blackfont">Co-Applicant 
              / Guarantor</a></font></b></font></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
 
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="380">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="40%" border="0" cellspacing="3" cellpadding="3" align="left">
                      <tr> 
                        <td width="30%" align="center" id="prm" bgcolor="#71694F"> 
                          <b><font  color="#FFFFFF">Particulars 
                          of Student</font></b> </td>
                        <td width="35%" align="center" id="com2" bgcolor="#EEEAE3"><a href="JavaScript:callVehicle()" class="blackfont"><b><font size="1" face="MS Sans Serif">Vehicle</font></b></a></td>
                        <td width="35%" align="center" id="com2" bgcolor="#EEEAE3"> 
                          <a href="JavaScript:callOtherAssets()" class="blackfont"><b><font size="1" face="MS Sans Serif">Other 
                          Asset </font></b></a></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="1" cellspacing="0" cellpadding="3" width="100%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Name 
                                of Student</font></td>
                              <td colspan="2"> 
                                <input type="text" name="address1" size="50" maxlength="50" onKeyPress="notAllowedDouble()" readOnly>
                              </td>
                              <td width="25%">&nbsp; </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Name 
                                of </font></td>
                              <td width="25%"> 
                                <select value="0"name="qualityconst" onChange="getSelectedvalue('qualityconst','hidqtyconst')" disabled>
                                  <option value="1" selected>Father</option>
                                  <option value="2">Mother</option>
                                  <option value="3">Guardian</option>
                                  <option value="4">Husband</option>
                                </select>
                                <input type="text" name="state2" size="20" maxlength="50"  onKeyPress="allowAlphabets()" onBlur="changecase(this)" readOnly>
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">If 
                                Guardian state relationship</font></td>
                              <td width="25%"> 
                                <input type="text" name="valdoneby" size="20" maxlength="50" readOnly>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Date 
                                of Birth </font></td>
                              <td width="25%"> 
                                <input type="text" name="address2" size="12"  maxlength="12"  onKeyPress="notAllowedDouble()" readOnly>
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">Age</font></td>
                              <td width="25%"> 
                                <input type="text" name="city" size="20" maxlength="20"  onKeyPress="allowAlphabets()" readOnly>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Caste</font></td>
                              <td width="25%"> 
                                <input type="text" name="state" size="15" maxlength="20"  onKeyPress="allowAlphabets()" onBlur="changecase(this)" readOnly>
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">Religion</font></td>
                              <td width="25%"> 
                                <input type="text" name="pincode" size="15" maxlength="6"  onKeyPress="allowInteger(window.event)" readOnly>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Marital 
                                Status </font></td>
                              <td width="25%"> 
                                <select value="0"name="select" onChange="getSelectedvalue('qualityconst','hidqtyconst')" disabled>
                                  <option value="0" selected>Select</option>
                                  <option value="1">Married</option>
                                  <option value="2">Single</option>
                                  <option value="3">Divirced</option>
                                  <option value="4">Widowed</option>
                                </select>
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">No 
                                of Children if any</font></td>
                              <td width="25%"> 
                                <input type="text" name="phone" size="15" maxlength="20"  onKeyPress="notAllowSplChar()" readOnly >
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Address1</font></td>
                              <td width="25%"> 
                                <input type="text" name="buildername2" size="20"  maxlength="20"  onKeyPress="notAllowedDouble()" readOnly >
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">Address2</font></td>
                              <td width="25%"> 
                                <input type="text" name="ageproperty" size="15" maxlength="7"  onKeyPress="allowDecimals(this.value)" readOnly>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">City</font></td>
                              <td width="25%"> 
                                <input type="text" name="totalarea" size="25"  onKeyPress="allowDecimals(this.value)" readOnly>
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">State</font></td>
                              <td width="25%"> 
                                <input type="text" name="builtuparea" size="25"  onKeyPress="allowDecimals(this.value)" readOnly>
                              </td>
                            </tr>
                            <tr>
                              <td width="25%"><font size="1" face="MS Sans Serif">Pincode</font></td>
                              <td width="25%">
                                <input type="text" name="buildername22" size="20"  maxlength="20"  onKeyPress="notAllowedDouble()" readOnly >
                              </td>
                              <td width="25%">&nbsp;</td>
                              <td width="25%">&nbsp;</td>
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
      </td>
    </tr>
  </table>
  <br>

  <%String strappno = request.getParameter("appno");

		if(strappno.equalsIgnoreCase("new")){strappno ="";}
  %>
    <lapschoice:combuttons  apporgcode='<%=strappno%>' strSource=""/>

<lapschoice:hiddentag/>
<input type="hidden" name="hidflag" value="">
<input type="hidden" name="selsno" value="">
<input type="hidden" name="hidval" >
<INPUT TYPE="hidden" name="page">
<INPUT TYPE="hidden" name="radLoan" value="Y">
<%-- 
<INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
--%> 
</form>
</body>
</html>
