<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	HashMap hshLoan = (HashMap)hshValues.get("hshLoan");
	HashMap hshPrin = (HashMap)hshValues.get("hshPrin");
	HashMap hshColl = (HashMap)hshValues.get("hshColl");
	HashMap hshTemp = (HashMap)hshLoan.get("1");
%>

<html>
<head>
<title>Print Commercial Application</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<form name="frmprint" method="post" action="">
  <table width="50%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#000000" bordercolordark="#FFFFFF" >
    <tr> 
      <td bgcolor="#666666"> 
        <div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><b><font color="#FFFFFF" face="Verdana, Arial, Helvetica, sans-serif">COMMERCIAL 
          LOAN APPLICATION FORM</font></b></font></div>
      </td>
    </tr>
  </table>
  <p align=left><br>
  </p>
  <table width="95%" border="0" cellspacing="0">
    <tr>
	  <td align="center"> <font size="1" face="MS Sans Serif" color="#CC0000">All 
        the values are indicated in <%=ApplicationParams.getCurrency()%></font></td>
</tr>
</table>
<br>
  <table width="95%" border="1" cellspacing="0" bordercolorlight="#EBEBF8" bordercolordark="#000000" cellpadding="5" bgcolor="#E2E2E2">
    <tr> 
      <td width="16%" ><b><font size="1" face="MS Sans Serif" color="#333333">Organisation</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2" >
	  	<font face="MS Sans Serif" size="1" color="#333333"><%= hshTemp.get("org_name") %></font>
	  </td>
    </tr>
    <tr> 
      <td width="16%">
	  	<b><font size="1" face="MS Sans Serif" color="#333333">Application No</font></b>
	  </td>
      <td width="22%" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%= hshTemp.get("app_no") %></font>
	  </td>
      <td width="20%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Company Name</font></b>
	  </td>
      <td width="23%" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%= hshTemp.get("comapp_companyname") %></font>
	  </td>
    </tr>
    <tr> 
      <td width="16%">
	  	<b><font size="1" face="MS Sans Serif" color="#333333">Status</font></b>
	  </td>
      <td width="22%" bgcolor="#F2F2F2">
	  	<font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("app_status") %></font>
	  </td>
      <td width="20%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Date of Application</font></b>
	  </td>
      <td width="23%" bgcolor="#F2F2F2">
	  	<font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("app_createdate") %></font>
	  </td>
    </tr>
  </table>
  <p><br>
    <br>
  </p>
  <table width="95%" border="1" cellpadding="5" cellspacing="0" bordercolorlight="#EBEBF8" bordercolordark="#000000" bgcolor="#E2E2E2" >
    <tr> 
      <td colspan="2"> 
        <div align="center"> <b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#333333">Details 
          of Loan Requested </font></b></div>
      </td>
    </tr>
    <tr align="center"> 
      <td colspan="2" height="29"> <font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#333333">&nbsp;</font></td>
    </tr>
    <tr>
      <td width="48%"><font face="ms sans serif" size="1"><b>Product Type</b></font></td>
      <td width="52%" bgcolor="#F2F2F2" align="right"> 
        <div align="left"><font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("prd_type") %></font></div>
      </td>
    </tr>
    <tr>
      <td width="48%">
	  	<font face="ms sans serif" size="1"><b>Product Selected</b></font>
	  </td>
      <td width="52%" bgcolor="#F2F2F2" align="right"> 
        <div align="left"><font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("prd_catname") %></font>-<font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("prd_subcatname") %></font>(<font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("prd_rng_from") %></font>-<font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("prd_rng_to") %></font>)</div>
      </td>
    </tr>
    <tr> 
      <td width="48%"> <b><font size="1" face="MS Sans Serif" color="#333333">Amount 
        Requested</font></b> </td>
      <td width="52%" bgcolor="#F2F2F2" align="right"> 
        <div align="left"><font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("loan_amtreqd") %></font> 
        </div>
      </td>
    </tr>
    <tr> 
      <td width="48%"> <b><font size="1" face="MS Sans Serif" color="#333333">Term 
        Requested (months)</font></b> </td>
      <td width="52%" bgcolor="#F2F2F2" align="right"> 
        <div align="left"><font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("loan_terms") %></font> 
        </div>
      </td>
    </tr>
    <tr> 
      <td width="48%"> <font face="MS Sans Serif" size="1"><b>Interest on Loan 
        Amount</b></font> </td>
      <td width="52%" bgcolor="#F2F2F2" align="right"> 
        <div align="left"><font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("loan_modintrate") %></font> 
        </div>
      </td>
    </tr>
    <tr> 
      <td width="48%"> <b><font size="1" face="MS Sans Serif" color="#333333">Monthly 
        Payment </font></b> </td>
      <td width="52%" bgcolor="#F2F2F2" align="right"> 
        <div align="left"><font size="1" face="MS Sans Serif" color="#333333"><%= Helper.correctNull((String)hshTemp.get("")) + "&nbsp;" %></font> 
        </div>
      </td>
    </tr>
    <tr> 
      <td width="48%"> <b><font size="1" face="MS Sans Serif">Actual Margin Amount 
        </font></b> </td>
      <td width="52%" bgcolor="#F2F2F2" align="right"> 
        <div align="left"><font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("loan_downpay") %></font> 
        </div>
      </td>
    </tr>
    <tr> 
      <td width="48%"> <b><font size="1" face="MS Sans Serif">Amount Sanctioned</font></b> 
      </td>
      <td width="52%" bgcolor="#F2F2F2" align="right">
        <div align="left"><font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("loan_recmdamt") %></font></div>
      </td>
    </tr>
  </table>
  <br>
  <br>
  <table width="95%" border="1" align="left" cellspacing="0" cellpadding="5" bordercolorlight="#EBEBF8" bordercolordark="#000000" bgcolor="#E2E2E2" >
    <tr> 
      <td colspan="6" ><font face="MS Sans Serif" size="2" color="#333333"><b><font face="MS Sans Serif">1. 
        Applicant Details</font></b></font></td>
    </tr>
    <tr> 
      <td width="21%" ><b><font size="1" face="MS Sans Serif" color="#333333">Name 
        of the Company</font></b></td>
      <td colspan="2" bgcolor="#F2F2F2" >
	  	<font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_companyname") %></font></td>
      <td width="14%"><font size="1" face="MS Sans Serif" color="#333333"><b>Company 
        ID</b></font></td>
      <td colspan="2" bgcolor="#F2F2F2">
	  	<font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_companyid") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Address</font></b></td>
      <td colspan="5" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_crptaddress") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">City</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_crptcity") %></font></td>
      <td width="18%"><b><font size="1" face="MS Sans Serif" color="#333333">State</font></b></td>
      <td width="14%" bgcolor="#F2F2F2"><font face="MS Sans Serif" size="1" color="#333333"><%= hshTemp.get("comapp_crptstate") %></font></td>
      <td width="17%"><b><font size="1" face="MS Sans Serif" color="#333333">Pincode</font></b></td>
      <td width="12%" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_crptpin") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Phone</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_crptphone") %></font></td>
      <td width="18%"><b><font size="1" face="MS Sans Serif" color="#333333">Fax</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_crptfax") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Industry 
        Code</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("demo_industrycode") %></font></td>
      <td width="18%"><b><font size="1" face="MS Sans Serif" color="#333333">Business 
        Nature</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_businessnature") %></font><b></b><font size="1" face="MS Sans Serif" color="#333333">&nbsp;</font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Corporate 
        Structure</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_corpstructure") %></font></td>
      <td width="18%"><b><font size="1" face="MS Sans Serif" color="#333333">Role</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_companyrole") %></font></td>
      
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Years 
        in Business</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_yrsinbusiness") %></font></td>
      <td width="18%"><b><font size="1" face="MS Sans Serif" color="#333333">Type 
        of Ownership</font></b></td>
      <td width="14%" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333">&nbsp;<%= hshTemp.get("comapp_ownership") %></font></td>
      <td width="17%"><b><font size="1" face="MS Sans Serif" color="#333333">No 
        of Employees</font></b></td>
      <td width="12%" bgcolor="#F2F2F2"><font size="1" face="MS Sans Serif" color="#333333"><%= hshTemp.get("comapp_totemployees") %>&nbsp;</font></td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
    <br>
    <br>
    <br>
    <br>
    <br>
	<%
		if( hshPrin.containsKey("1") )
		{
			hshTemp = (HashMap)hshPrin.get("1");
	%>
  <table width="95%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#EBEBF8" bordercolordark="#000000" bgcolor="#E2E2E2" >
    <tr> 
      <td colspan="6"><b><font size="2" face="MS Sans Serif" color="#333333">2.1. Principal 1 of 3</font></b></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Pan 
        No </font></b></td>
      <td width="18%" bgcolor="#F2F2F2">
	  	<font face="ms sans serif" size="1"><%= hshTemp.get("prin_panno") %></font> </td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">Date of Birth</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_dateofbirth") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Last Name</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_lname") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">First Name</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_fname") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Address</font></b></td>
      <td colspan="5" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_address1") %> <%= hshTemp.get("prin_address2") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">City</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_city") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">State</font></b></td>
      <td width="14%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_state") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Pincode</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_pincode") %></font> </td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Phone</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_phone") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">Fax</font></b></td>
      <td width="14%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_fax") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Residential Status</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1">
	  <% 
	  String str = (String)hshTemp.get("prin_resstatus");
	  if(str.equals("r"))
	  {
	  	out.println("Resident");
	  }
	  else
	  {
	  out.println("Non Resident");
	  } %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Email</font></b></td>
      <td colspan="5" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_email") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Company Title</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_comptitle") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">% Ownership</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_ownership") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Role</font></b></td>
      <td width="18%" colspan="5" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_designation") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Salary</font></b></td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_monincome") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Monthly House Payment</font></b></td>
      <td width="28%" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_rentexp") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Other Income</font></b></td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_otherincome") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Other Payments</font></b></td>
      <td width="28%" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_otherexp") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Total Earnings</font></b></td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right">&nbsp;</td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Total Expenses</font></b></td>
      <td width="28%" bgcolor="#F2F2F2" align="right">&nbsp;</td>
    </tr>
  </table>
  <%
  		}
  %>
  <p>
  <%
		if( hshPrin.containsKey("2") )
		{
			hshTemp = (HashMap)hshPrin.get("2");
					
  %>
  </p>
  <table width="95%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#EBEBF8" bordercolordark="#000000" bgcolor="#E2E2E2" >
    <tr> 
      <td colspan="6"><b><font size="2" face="MS Sans Serif" color="#333333">2.2. 
        Principal 2 of 3</font></b></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Pan 
        No</font></b></td>
      <td width="18%" bgcolor="#F2F2F2">
	  <font face="ms sans serif" size="1"><%= hshTemp.get("prin_panno") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">Date 
        of Birth</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_dateofbirth") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Last 
        Name</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_lname") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">First 
        Name</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2">
	  <font face="ms sans serif" size="1"><%= hshTemp.get("prin_fname") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Address</font></b></td>
      <td colspan="5" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_address1") %> <%= hshTemp.get("prin_address2") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">City</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_city") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">State</font></b></td>
      <td width="14%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_state") %></font> </td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Pincode</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_pincode") %> </font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Phone</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_phone") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">Fax</font></b></td>
      <td width="14%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_fax") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Residential 
        Status</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1">
        <% 
	  String str = (String)hshTemp.get("prin_resstatus");
	  if(str.equals("r"))
	  {
	  	out.println("Resident");
	  }
	  else
	  {
	  out.println("Non Resident");
	  } %>
        </font></td>
    </tr>
    <tr> 
      <td width="21%" height="30"><b><font size="1" face="MS Sans Serif" color="#333333">Email</font></b></td>
      <td colspan="5" bgcolor="#F2F2F2" height="30"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_email") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Company 
        Title</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font size="1" face="ms sans serif"><%= hshTemp.get("prin_comptitle") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">% 
        Ownership</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_ownership") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Role</font></b></td>
      <td width="18%" colspan="5" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_designation") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Salary</font></b></td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_monincome") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Monthly 
        House Payment</font></b></td>
      <td width="28%" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_rentexp") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Other 
        Income</font></b></td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_otherincome") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Other 
        Payments</font></b></td>
      <td width="28%" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_otherexp") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Total 
        Earnings</font></b></td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right">&nbsp;</td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Total 
        Expenses</font></b></td>
      <td width="28%" bgcolor="#F2F2F2" align="right">&nbsp;</td>
    </tr>
  </table>
  <p>
    <br>
  </p>
<%
		}  
%>
		
<%
		//System.out.println("begin");
		if( hshPrin.containsKey("3") )
		{
					//System.out.println("inside if");
			hshTemp = (HashMap)hshPrin.get("3");
%>
  <table width="95%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#EBEBF8" bordercolordark="#000000" bgcolor="#E2E2E2" >
    <tr> 
      <td colspan="6"><b><font size="2" face="MS Sans Serif" color="#333333">2.3 
        Principal 3 of 3</font></b></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Pan 
        No</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_panno") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">Date 
        of Birth</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_dateofbirth") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Last 
        Name</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_lname") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">First 
        Name</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_fname") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Address</font></b></td>
      <td colspan="5" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_address1") %> <%= hshTemp.get("prin_address2") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">City</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_city") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">State</font></b></td>
      <td width="14%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_state") %></font> </td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Pincode</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_pincode") %> </font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Phone</font></b></td>
      <td width="18%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_phone") %></font></td>
      <td width="16%"><b><font face="MS Sans Serif" size="1" color="#333333">Fax</font></b></td>
      <td width="14%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_fax") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Residential 
        Status</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1">
        <% 
	  String str = (String)hshTemp.get("prin_resstatus");
	  if(str.equals("r"))
	  {
	  	out.println("Resident");
	  }
	  else
	  {
	  out.println("Non Resident");
	  } %>
        </font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Email</font></b></td>
      <td colspan="5" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_email") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Company 
        Title</font></b></td>
      <td colspan="3" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_comptitle") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">% 
        Ownership</font></b></td>
      <td width="28%" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_ownership") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Role</font></b></td>
      <td width="18%" colspan="5" bgcolor="#F2F2F2"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_designation") %></font></td>
    </tr>
    <tr> 
      <td width="21%"><b><font size="1" face="MS Sans Serif" color="#333333">Salary</font></b></td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_monincome") %></font></td>
      <td width="17%"><b><font face="MS Sans Serif" size="1" color="#333333">Monthly 
        House Payment</font></b></td>
      <td width="28%" bgcolor="#F2F2F2" align="right"><font face="ms sans serif" size="1"><%= hshTemp.get("prin_rentexp") %></font></td>
    </tr>
    <tr> 
      <td width="21%">
	  	<b><font size="1" face="MS Sans Serif" color="#333333">Other Income</font></b>
	  </td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right">
	  	<font face="ms sans serif" size="1"><%= hshTemp.get("prin_otherincome") %></font>
	  </td>
      <td width="17%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Other Payments</font></b>
	  </td>
      <td width="28%" bgcolor="#F2F2F2" align="right">
	  	<font face="ms sans serif" size="1"><%= hshTemp.get("prin_otherexp") %></font>
	  </td>
    </tr>
    <tr> 
      <td width="21%">
	  	<b><font size="1" face="MS Sans Serif" color="#333333">Total Earnings</font></b>
	  </td>
      <td width="18%" colspan="3" bgcolor="#F2F2F2" align="right">
	  	<font face="ms sans serif" size="1">&nbsp;</font>
	  </td>
      <td width="17%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Total Expenses</font></b>
	  </td>
      <td width="28%" bgcolor="#F2F2F2" align="right">
	  	<font face="ms sans serif" size="1">&nbsp;</font></td>
    </tr>
  </table>
  <br>
  <br>
<%
		}
%>		
  <!--  Financial TAB -->
<%
	//System.out.println("Fin Start");
	HashMap hshFinYrs = (HashMap)hshValues.get("hshFinYrs");
	HashMap hshFinValues = (HashMap)hshValues.get("hshFinValues");
	String strYear1="&nbsp;", strYear2="&nbsp;", strYear3="&nbsp;", strYear4="&nbsp;";
	String strType1 = "&nbsp;", strType2 = "&nbsp;", strType3 = "&nbsp;", strType4 = "&nbsp;";
	HashMap hshYear1 = null, hshYear2 = null, hshYear3 = null, hshYear4 = null;
	
	if( hshFinYrs.containsKey("1") )
	{
		hshYear1 = (HashMap)hshFinYrs.get("1");
		if(hshYear1.containsKey("finyrs_date"))
			strYear1 = (String)hshYear1.get("finyrs_date");
		if(hshYear1.containsKey("finyrs_fintype"))
			strType1 = (String)hshYear1.get("finyrs_fintype");
	}
	if( hshFinYrs.containsKey("2") )
	{
		hshYear2 = (HashMap)hshFinYrs.get("2");
		if(hshYear2.containsKey("finyrs_date"))
			strYear2 = (String)hshYear2.get("finyrs_date");
		if(hshYear2.containsKey("finyrs_fintype"))
			strType2 = (String)hshYear2.get("finyrs_fintype");
	}
	if( hshFinYrs.containsKey("3") )
	{
		hshYear3 = (HashMap)hshFinYrs.get("3");
		if(hshYear3.containsKey("finyrs_date"))
			strYear3 = (String)hshYear3.get("finyrs_date");
		if(hshYear3.containsKey("finyrs_fintype"))
			strType3 = (String)hshYear3.get("finyrs_fintype");
	}
	if( hshFinYrs.containsKey("4") )
	{
		hshYear4 = (HashMap)hshFinYrs.get("4");
		if(hshYear4.containsKey("finyrs_date"))
			strYear4 = (String)hshYear4.get("finyrs_date");
		if(hshYear4.containsKey("finyrs_fintype"))
			strType4 = (String)hshYear4.get("finyrs_fintype");
	}
%>
  <table width="95%" border="1" cellspacing="0" cellpadding="5" bgcolor="#E2E2E2"  bordercolorlight="#EBEBF8" bordercolordark="#000000" >
    <tr> 
      <td colspan="5"> 
	  	<font size="2" face="MS Sans Serif"><b>3. Financial Details</b></font> 
      </td>
    </tr>
    <tr> 
      <td width="37%"> 
	  	<font face="MS Sans Serif" size="1" color="#333333">&nbsp;</font> 
      </td>
      <td width="17%" align="center" bgcolor="#F2F2F2"> 
	  	<font face="MS Sans Serif" size="1" color="#333333">First Year</font> 
	  </td>
      <td width="16%" align="center" bgcolor="#F2F2F2"> 
	  	<font face="MS Sans Serif" size="1" color="#333333">Second Year </font>
	  </td>
      <td width="15%" align="center" bgcolor="#F2F2F2"> 
	  	<font face="MS Sans Serif" size="1" color="#333333">Third Year </font>
	  </td>
      <td width="15%" align="center" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333">Fourth Year </font>
	  </td>
    </tr>
    <tr>
      <td width="37%">&nbsp;</td>
      <td bgcolor="#F2F2F2" align="center" width="17%">
	  	<font face="MS Sans Serif" size="1" color="#333333">
			<%=strYear1%>
		</font>
	  </td>
      <td bgcolor="#F2F2F2" align="center" width="16%">
		<font face="MS Sans Serif" size="1" color="#333333">
			<%=strYear2%>
		</font>
	  </td>
      <td bgcolor="#F2F2F2" align="center" width="15%">
		<font face="MS Sans Serif" size="1" color="#333333">
			<%=strYear3%>
		</font>
	  </td>
      <td bgcolor="#F2F2F2" align="center" width="15%">
	    <font face="MS Sans Serif" size="1" color="#333333">
			<%=strYear4%>
		</font>
	  </td>
    </tr>
    <tr> 
      <td width="37%">&nbsp;</td>
      <td bgcolor="#F2F2F2" align="center" width="17%">
  	  	<font face="MS Sans Serif" size="1" color="#333333">
			<%=strType1%>
		</font>
	  </td>
      <td bgcolor="#F2F2F2" align="center" width="16%">
 	  	<font face="MS Sans Serif" size="1" color="#333333">
			<%=strType2%>
		</font>
	  </td>
      <td bgcolor="#F2F2F2" align="center" width="15%">
  	  	<font face="MS Sans Serif" size="1" color="#333333">
			<%=strType3%>
		</font>
	  </td>
      <td bgcolor="#F2F2F2" align="center" width="15%">
  	  	<font face="MS Sans Serif" size="1" color="#333333">
			<%=strType4%>
		</font>
	  </td>
    </tr>
    <tr> 
      <td colspan="5" align="left"> 
	  	<font face="MS Sans Serif" size="2"><b>3.1 Income Statement</b></font> 
	  </td>
    </tr>
    <tr> 
      <td colspan="5" align="left"> 
	  	<font face="MS Sans Serif" size="2"><b> Income</b></font> 
      </td>
    </tr>
	<%
		HashMap hshFinTmp = null;
		//System.out.println("chitra: "+hshFinValues.containsKey("1"));
		if( hshFinValues.containsKey("1") )
		{
		//System.out.println(hshFinValues.containsKey("1"));
			hshFinTmp = (HashMap)hshFinValues.get("1");
	%>
    <tr> 
      <td width="37%"> 
	  	<b><font face="MS Sans Serif" size="1" color="#333333">
			<%=hshFinTmp.get("fin_desc")%>
		</font></b> 
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
	<%
	}
	else
	{
	%>
    <tr> 
      <td width="37%"> 
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Domestic Sales</font></b> 
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
	<%
	}
	%>
	<%
		if( hshFinValues.containsKey("2") )
		{
			//System.out.println(hshFinValues.containsKey("2"));
			hshFinTmp = (HashMap)hshFinValues.get("2");
	%>
	    <tr> 
	      <td width="37%"> 
		  	<b><font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font></b> 
		  </td>
    	  <td width="17%" align="right" bgcolor="#F2F2F2">
		  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
		  </td>
	      <td width="16%" align="right" bgcolor="#F2F2F2">
		  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
		  </td>
    	  <td width="15%" align="right" bgcolor="#F2F2F2">
		  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
		  </td>
	      <td width="15%" align="right" bgcolor="#F2F2F2">
		  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
		  </td>
    	</tr>
    <%
		}
		else
		{
	%>
    <tr> 
      <td width="37%"> 
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Export Sales</font></b> 
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
	<%
		}
	%>
	<%
		if( hshFinValues.containsKey("3") )
		{//System.out.println(hshFinValues.containsKey("3"));
			hshFinTmp = (HashMap)hshFinValues.get("3");
	%>
    <tr> 
      <td width="37%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font></b> 
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
  	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
	<%
		}
		else
		{
	%>
    <tr> 
      <td width="37%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Other Income</font></b> 
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
	<%
		}
	%>
	<%
		if( hshFinValues.containsKey("4") )
		{//System.out.println(hshFinValues.containsKey("4"));
			hshFinTmp = (HashMap)hshFinValues.get("4");
	%>
    <tr> 
      <td width="37%" height="2"> <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font> 
      </td>
      <td bgcolor="#F2F2F2" width="17%" align="right" height="2"> <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font> 
      </td>
      <td bgcolor="#F2F2F2" width="16%" align="right" height="2"> <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font> 
      </td>
      <td bgcolor="#F2F2F2" width="15%" align="right" height="2"> <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font> 
      </td>
      <td bgcolor="#F2F2F2" width="15%" align="right" height="2"> <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font> 
      </td>
    </tr>
	<%
		}
		else
		{
	%>
	<tr> 
      <td width="37%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
      <td bgcolor="#F2F2F2" width="17%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="16%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
    </tr>
	<%
		}
		if( hshFinValues.containsKey("5") )
		{//System.out.println(hshFinValues.containsKey("5"));
			hshFinTmp = (HashMap)hshFinValues.get("5");
	%>
	
    <tr> 
      <td width="37%"> 
	  	<b><font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font></b> 
	  </td>
      <td bgcolor="#F2F2F2" width="17%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="16%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
	<%
		}
		else
		{
	%>		
	<tr> 
      <td width="37%">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="17%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="16%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
    </tr>
	<%
		}
		if( hshFinValues.containsKey("6") )
		{//System.out.println(hshFinValues.containsKey("6"));
			hshFinTmp = (HashMap)hshFinValues.get("6");
	%>
    <tr> 
      <td width="37%"> 
	  	<b><font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font></b>
	  </td>
      <td bgcolor="#F2F2F2" width="17%" align="right">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="16%" align="right">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
	  	  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
	  	  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>	
	<tr> 
      <td width="37%"> 
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Less Excise Duty</font></b>
	  </td>
      <td bgcolor="#F2F2F2" width="17%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="16%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
    </tr>
	<%
		}
		if( hshFinValues.containsKey("7") )
		{//System.out.println(hshFinValues.containsKey("7"));
			hshFinTmp = (HashMap)hshFinValues.get("7");
	%>
    <tr> 
      <td width="37%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font></b>
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>		
    <tr> 
      <td width="37%"> <b><font face="MS Sans Serif" size="1" color="#333333">Net 
        Sales </font></b></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("8") )
		{//System.out.println(hshFinValues.containsKey("8"));
			hshFinTmp = (HashMap)hshFinValues.get("8");
%>
    <tr> 
      <td width="37%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font></b>
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
  	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
  	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
	<tr> 
      <td width="37%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333">% age rise(+) or fall(-) 
		in net sales as compared to previous year</font></b>
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
%>
    <tr> 
      <td width="37%"><font face="MS Sans Serif" size="1" color="#333333"></font>&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="5" align="left"> 
	  	<font face="MS Sans Serif" size="2"><b> Cost of Sales</b></font>
	  </td>
    </tr>
	

    <tr> 
      <td colspan="5" align="left"> 
	  <b><font face="MS Sans Serif" size="1" color="#333333">Raw Materials</font></b>
      </td>
    </tr>

<%
		if( hshFinValues.containsKey("10") )
		{//System.out.println(hshFinValues.containsKey("10"));
			hshFinTmp = (HashMap)hshFinValues.get("10");
%>
    <tr> 
      <td width="37%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font></b>
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  	<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>		
    <tr> 
      <td width="37%">
	  	<b><font face="MS Sans Serif" size="1" color="#333333">Raw materials consumed</font></b>
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("11") )
		{//System.out.println(hshFinValues.containsKey("11"));
			hshFinTmp = (HashMap)hshFinValues.get("11");
%>			
    <tr> 
      <td width="37%">
	  	<b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
	  	  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>	
    <tr> 
      <td width="37%">
	  	<b><font face="ms sans serif" size="1">Purchasing of trading goods</font></b></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
%>	
	<tr> 
      <td colspan=5 width="37%">
	  	<font size="1" face="ms sans serif"><b>Other Spares</b></font></td>
    </tr>
<%
		if( hshFinValues.containsKey("13") )
		{//System.out.println(hshFinValues.containsKey("13"));
			hshFinTmp = (HashMap)hshFinValues.get("13");
%>		
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
 		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
  		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>		
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b>Imported</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%	
		}
		if( hshFinValues.containsKey("14") )
		{//System.out.println(hshFinValues.containsKey("14"));
			hshFinTmp = (HashMap)hshFinValues.get("14");
%>
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
  		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  	
	  </td>
    </tr>
<%
		}
		else
		{
%>		
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Indigenous</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("15") )
		{//System.out.println(hshFinValues.containsKey("15"));
			hshFinTmp = (HashMap)hshFinValues.get("15");
%>			
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  		  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  		  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  		  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
 		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  	
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Power &amp; Fuel</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("16") )
		{//System.out.println(hshFinValues.containsKey("16"));
			hshFinTmp = (HashMap)hshFinValues.get("16");
%>					
    <tr> 
      <td width="37%"><%=hshFinTmp.get("fin_desc")%></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="37%">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("17") )
		{//System.out.println(hshFinValues.containsKey("17"));
			hshFinTmp = (HashMap)hshFinValues.get("17");
%>			
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Direct Labour</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("18") )
		{//System.out.println(hshFinValues.containsKey("18"));
			hshFinTmp = (HashMap)hshFinValues.get("18");
%>			
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Other mfg Expenses</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("19") )
		{//System.out.println(hshFinValues.containsKey("19"));
			hshFinTmp = (HashMap)hshFinValues.get("19");
%>					
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>	
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b>Depreciation</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("20") )
		{//System.out.println(hshFinValues.containsKey("20"));
			hshFinTmp = (HashMap)hshFinValues.get("20");
%>		
    <tr> 
      <td width="37%"><%=hshFinTmp.get("fin_desc")%></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
<tr> 
      <td width="37%">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("21") )
		{//System.out.println(hshFinValues.containsKey("21"));
			hshFinTmp = (HashMap)hshFinValues.get("21");
%>			
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Sub Total </b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>

<%
		}
		if( hshFinValues.containsKey("22") )
		{//System.out.println(hshFinValues.containsKey("22"));
			hshFinTmp = (HashMap)hshFinValues.get("22");
%>				
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>		
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b>Add: Opening Stocks 
        - In process</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("23") )
		{//System.out.println(hshFinValues.containsKey("23"));
			hshFinTmp = (HashMap)hshFinValues.get("23");
%>	
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Sub Total</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("24") )
		{//System.out.println(hshFinValues.containsKey("24"));
			hshFinTmp = (HashMap)hshFinValues.get("24");
%>					
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  
	  </td>
    </tr>
<%	
		}
		else
		{
%>
	<tr> 
      <td width="37%">
	  	<font face="ms sans serif" size="1"><b>Deduct: Closing Stocks-In process</b></font>
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("25") )
		{//System.out.println(hshFinValues.containsKey("25"));
			hshFinTmp = (HashMap)hshFinValues.get("25");
%>			
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>	
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Cost of Production</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("26") )
		{//System.out.println(hshFinValues.containsKey("26"));
			hshFinTmp = (HashMap)hshFinValues.get("26");
%>
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
	    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b>Add: Opening Stock 
        of finished goods</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("27") )
		{//System.out.println(hshFinValues.containsKey("27"));
			hshFinTmp = (HashMap)hshFinValues.get("27");
%>			
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="37%"><font size="1" face="ms sans serif"><b>Sub Total</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("28") )
		{//System.out.println(hshFinValues.containsKey("28"));
			hshFinTmp = (HashMap)hshFinValues.get("28");
%>		
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Deduct Closing Stock 
        finished goods</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>			
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Deduct Closing Stock 
        finished goods</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%		
		}	
		if( hshFinValues.containsKey("29") )
		{//System.out.println(hshFinValues.containsKey("29"));
			hshFinTmp = (HashMap)hshFinValues.get("29");
%>		
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>	
    <tr> 
      <td width="37%"><font face="ms sans serif" size="1"><b>Sub Total (Total 
        Cost of Sales)</b></font></td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
%>	
  </table>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <table width="95%" border="1" cellspacing="0" cellpadding="5" bgcolor="#E2E2E2"  bordercolorlight="#EBEBF8" bordercolordark="#000000" >
    <tr> 
      <td colspan="5"> 
        <div align="left"><font size="1" face="MS Sans Serif"><b><font size="2">Operating 
          Expenses </font></b></font></div>
      </td>
    </tr>
<%
		if( hshFinValues.containsKey("30") )
		{//System.out.println(hshFinValues.containsKey("30"));
			hshFinTmp = (HashMap)hshFinValues.get("30");
%>	
    <tr> 
      <td width="39%"><font size="1" face="MS Sans Serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font size="1" face="MS Sans Serif"><b>Selling,General &amp; 
        Admn. exps</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("31") )
		{//System.out.println(hshFinValues.containsKey("31"));
			hshFinTmp = (HashMap)hshFinValues.get("31");
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
   		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Sub Total</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("32") )
		{//System.out.println(hshFinValues.containsKey("32"));
			hshFinTmp = (HashMap)hshFinValues.get("32");
%>	
    <tr> 
      <td width="39%">
	  	<b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
	    <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"> <b><font size="1" face="ms sans serif">Operating profit 
        before interest</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("33") )
		{//System.out.println(hshFinValues.containsKey("33"));
			hshFinTmp = (HashMap)hshFinValues.get("33");
%>					
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1"> Interest &amp s</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("34") )
		{//System.out.println(hshFinValues.containsKey("34"));
			hshFinTmp = (HashMap)hshFinValues.get("34");
%>			
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1">Operating profit 
        after interest </font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
%>
	<tr> 
      <td width="39%" colspan="5" >
	  	<font face="ms sans serif" size="1"><b>&nbsp;Add other non 
        - operating income</b></font>
	  </td>
    </tr>
<%

		if( hshFinValues.containsKey("36") )
		{//System.out.println(hshFinValues.containsKey("36"));
			hshFinTmp = (HashMap)hshFinValues.get("36");
%>						
    <tr> 
      <td width="39%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>			
    <tr> 
      <td width="39%"><font size="1" face="ms sans serif"><b>&nbsp;Misc Income</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("37") )
		{//System.out.println(hshFinValues.containsKey("37"));
			hshFinTmp = (HashMap)hshFinValues.get("37");
%>			
    <tr> 
      <td width="39%"><font size="1"><b><font face="ms sans serif">&nbsp;Interest 
        income</font></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font size="1"><b><font face="ms sans serif">&nbsp;Interest 
        income</font></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%		
		}
		if( hshFinValues.containsKey("38") )
		{//System.out.println(hshFinValues.containsKey("38"));
			hshFinTmp = (HashMap)hshFinValues.get("38");
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>&nbsp;<font color="#333333"><%=hshFinTmp.get("fin_desc")%></font></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>&nbsp;<font color="#333333">Others</font></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("39") )
		{//System.out.println(hshFinValues.containsKey("39"));
			hshFinTmp = (HashMap)hshFinValues.get("39");
%>						
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">&nbsp;Sub total (Income)</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
	%>
    <tr> 
      <td width="39%" colspan="5">
	  	<b><font size="1" face="ms sans serif">Deduct: Other 
        non - operating expenses</font></b></td>
    </tr>
<%
		if( hshFinValues.containsKey("41") )
		{//System.out.println(hshFinValues.containsKey("41"));
			hshFinTmp = (HashMap)hshFinValues.get("41");
%>					
<tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
	
  
<%
		}
		else
		{
%>
    <tr> 
      <td > 
		<font size="1" face="ms sans serif"><b> Prelim. exp w/off </b></font>   </td>
  	  <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
   
    </tr>
<%
		}		
		if( hshFinValues.containsKey("42") )
		{//System.out.println(hshFinValues.containsKey("42"));
			hshFinTmp = (HashMap)hshFinValues.get("42");
%>	
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td bgcolor="#F2F2F2" align="right" width="16%">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" align="right" width="17%">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" align="right" width="15%">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" align="right" width="13%">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Prior year exp.</font></b></td>
      <td bgcolor="#F2F2F2" align="right" width="16%">&nbsp;</td>
      <td bgcolor="#F2F2F2" align="right" width="17%">&nbsp;</td>
      <td bgcolor="#F2F2F2" align="right" width="15%">&nbsp;</td>
      <td bgcolor="#F2F2F2" align="right" width="13%">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("43") )
		{//System.out.println(hshFinValues.containsKey("43"));
			hshFinTmp = (HashMap)hshFinValues.get("43");
%>					
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1">Others</font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="17%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="13%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1">Others</font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="17%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="13%" align="right">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("44") )
		{//System.out.println(hshFinValues.containsKey("44"));
			hshFinTmp = (HashMap)hshFinValues.get("44");
%>			
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td bgcolor="#F2F2F2" width="17%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="13%" align="right">
	    <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1">Sub total (Expenses)</font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="17%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="13%" align="right">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("45") )
		{//System.out.println(hshFinValues.containsKey("45"));
			hshFinTmp = (HashMap)hshFinValues.get("45");
%>			
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td bgcolor="#F2F2F2" width="17%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="13%" align="right">
	    <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Net of other non-operating 
        income/expense</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("46") )
		{//System.out.println(hshFinValues.containsKey("46"));
			hshFinTmp = (HashMap)hshFinValues.get("46");
%>					
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Profit before Tax/Loss 
        </font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("47") )
		{//System.out.println(hshFinValues.containsKey("47"));
			hshFinTmp = (HashMap)hshFinValues.get("47");
%>			
    <tr> 
      <td width="39%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font size="1" face="ms sans serif"><b>Provision of Taxes</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("48") )
		{//System.out.println(hshFinValues.containsKey("48"));
			hshFinTmp = (HashMap)hshFinValues.get("48");
%>			
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Net Profit/Loss </b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("49") )
		{//System.out.println(hshFinValues.containsKey("49"));
			hshFinTmp = (HashMap)hshFinValues.get("49");
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>		
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Equity dividend paid</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("50") )
		{//System.out.println(hshFinValues.containsKey("50"));
			hshFinTmp = (HashMap)hshFinValues.get("50");
%>	
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Dividend rate</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("51") )
		{//System.out.println(hshFinValues.containsKey("51"));
			hshFinTmp = (HashMap)hshFinValues.get("51");
%>	
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Pref. Dividend</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("52") )
		{//System.out.println(hshFinValues.containsKey("52"));
			hshFinTmp = (HashMap)hshFinValues.get("52");		
%>						
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Retained Profit </b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("53") )
		{//System.out.println(hshFinValues.containsKey("53"));
			hshFinTmp = (HashMap)hshFinValues.get("53");		
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Retained Profit/ 
        Net Profit</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("54") )
		{//System.out.println(hshFinValues.containsKey("54"));
			hshFinTmp = (HashMap)hshFinValues.get("54");	
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Cash Profit</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
%>			
  </table>
  <br>
  <br>
  <br>
  <br>
  <table width="95%" border="1" cellspacing="0" cellpadding="5" bgcolor="#E2E2E2"  bordercolorlight="#EBEBF8" bordercolordark="#000000" >
    <tr> 
      <td colspan="5">
	  	<font face="MS Sans Serif" size="1" color="#333333">
		  <b><font size="2">3.2 Liabilities</font></b>
		</font>
	  </td>
    </tr>
    <tr> 
      <td colspan="5"> 
        <div align="left"><font size="1" face="MS Sans Serif">
			<b><font size="2">Current Liabilities</font></b>
		</font></div>
      </td>
    </tr>
<%
		if( hshFinValues.containsKey("55") )
		{//System.out.println(hshFinValues.containsKey("55"));
			hshFinTmp = (HashMap)hshFinValues.get("55");	
%>			
    <tr> 
      <td width="39%"><font size="1" face="MS Sans Serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font size="1" face="MS Sans Serif"><b>Short term borrowings 
        from Banks</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>			
<%
		}
		if( hshFinValues.containsKey("56") )
		{//System.out.println(hshFinValues.containsKey("56"));
			hshFinTmp = (HashMap)hshFinValues.get("56");
%>			
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>			
	 <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1">From applicant Bank</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("57") )
		{//System.out.println(hshFinValues.containsKey("57"));
			hshFinTmp = (HashMap)hshFinValues.get("57");
%>		
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">From other Banks</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("58") )
		{//System.out.println(hshFinValues.containsKey("58"));
			hshFinTmp = (HashMap)hshFinValues.get("58");
%>					
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Sub Total </font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("59") )
		{//System.out.println(hshFinValues.containsKey("59"));
			hshFinTmp = (HashMap)hshFinValues.get("59");
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
	  <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>      
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Short term loan</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("60") )
		{//System.out.println(hshFinValues.containsKey("60"));
			hshFinTmp = (HashMap)hshFinValues.get("60");
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>&nbsp;Sundry Creditors 
        purchases</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("61") )
		{//System.out.println(hshFinValues.containsKey("61"));
			hshFinTmp = (HashMap)hshFinValues.get("61");
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>			
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>&nbsp;Sundry Creditors 
        expenses</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("62") )
		{//System.out.println(hshFinValues.containsKey("62"));
			hshFinTmp = (HashMap)hshFinValues.get("62");
%>				
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>	
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>&nbsp;Provision for 
        taxation</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("63") )
		{//System.out.println(hshFinValues.containsKey("63"));
			hshFinTmp = (HashMap)hshFinValues.get("63");
%>	
    <tr> 
      <td colspan="5"><font color="#333333">
	  	<b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b>
	  </font></td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td colspan="5"><font color="#333333">
	  	<b><font face="ms sans serif" size="1">Provision for dividend</font></b>
	  </font></td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("64") )
		{//System.out.println(hshFinValues.containsKey("64"));
			hshFinTmp = (HashMap)hshFinValues.get("64");
%>
    <tr> 
      <td width="39%">
	  	<b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
<tr> 
      <td width="39%">
	  	<b><font size="1" face="ms sans serif">&nbsp;Other statutory liabilities</font></b>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%	
		}
		if( hshFinValues.containsKey("65") )
		{//System.out.println(hshFinValues.containsKey("65"));
			hshFinTmp = (HashMap)hshFinValues.get("65");
%>						
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">&nbsp;Deposits/Debentures/Installments/DPGs,etc</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>	
<%
		}
		if( hshFinValues.containsKey("66") )
		{//System.out.println(hshFinValues.containsKey("66"));
			hshFinTmp = (HashMap)hshFinValues.get("66");
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">&nbsp;Other Cr.liabilities</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("67") )
		{//System.out.println(hshFinValues.containsKey("67"));
			hshFinTmp = (HashMap)hshFinValues.get("67");
%>			
    <tr> 
      <td colspan="5"> 
        <div align="left"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></div>
      </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td colspan="5"> 
        <div align="left"><font size="1" face="ms sans serif"><b>Sub Total </b></font></div>
      </td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("68") )
		{//System.out.println(hshFinValues.containsKey("68"));
			hshFinTmp = (HashMap)hshFinValues.get("68");
%>			
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td bgcolor="#F2F2F2" align="right" width="16%">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" align="right" width="17%">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" align="right" width="15%">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" align="right" width="13%">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Total Cr.liabilities</font></b></td>
      <td bgcolor="#F2F2F2" align="right" width="16%">&nbsp;
	  
	  </td>
      <td bgcolor="#F2F2F2" align="right" width="17%">&nbsp;</td>
      <td bgcolor="#F2F2F2" align="right" width="15%">&nbsp;</td>
      <td bgcolor="#F2F2F2" align="right" width="13%">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("69") )
		{//System.out.println(hshFinValues.containsKey("69"));
			hshFinTmp = (HashMap)hshFinValues.get("69");
%>					
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="17%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="13%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Non Convertible Debentures</font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="17%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="13%" align="right">&nbsp;</td>
    </tr>

<%
		}
		if( hshFinValues.containsKey("70") )
		{//System.out.println(hshFinValues.containsKey("70"));
			hshFinTmp = (HashMap)hshFinValues.get("70");
%>					
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="17%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="15%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td bgcolor="#F2F2F2" width="13%" align="right">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font size="1" face="ms sans serif">Preference Shares</font></b></td>
      <td bgcolor="#F2F2F2" width="16%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="17%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="15%" align="right">&nbsp;</td>
      <td bgcolor="#F2F2F2" width="13%" align="right">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("71") )
		{//System.out.println(hshFinValues.containsKey("71"));
			hshFinTmp = (HashMap)hshFinValues.get("71");
%>					
    <tr> 
      <td colspan="5"> 
        <div align="left">
			<font face="MS Sans Serif" size="1" color="#333333"><b><%=hshFinTmp.get("fin_desc")%></b></font>
		</div>
      </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td colspan="5"> 
        <div align="left">
			<font face="MS Sans Serif" size="1" color="#333333"><b>Term loans</b></font>
		</div>
      </td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("72") )
		{//System.out.println(hshFinValues.containsKey("72"));
			hshFinTmp = (HashMap)hshFinValues.get("72");
%>					
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1">Foreign Currency 
        loan</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("73") )
		{//System.out.println(hshFinValues.containsKey("73"));
			hshFinTmp = (HashMap)hshFinValues.get("73");
%>			
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><b><font face="ms sans serif" size="1">Public Deposits</font></b></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("74") )
		{//System.out.println(hshFinValues.containsKey("74"));
			hshFinTmp = (HashMap)hshFinValues.get("74");
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>HP loans</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("75") )
		{//System.out.println(hshFinValues.containsKey("75"));
			hshFinTmp = (HashMap)hshFinValues.get("75");
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>			
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Trade deposits</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("76") )
		{//System.out.println(hshFinValues.containsKey("76"));
			hshFinTmp = (HashMap)hshFinValues.get("76");
%>			
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Other term liabilities</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>

<%
		}
		if( hshFinValues.containsKey("77") )
		{//System.out.println(hshFinValues.containsKey("77"));
			hshFinTmp = (HashMap)hshFinValues.get("77");
%>					
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Total term liabilities</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("78") )
		{//System.out.println(hshFinValues.containsKey("78"));
			hshFinTmp = (HashMap)hshFinValues.get("78");
%>		
	 <tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="17%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="13%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
	<tr> 
      <td width="39%"><font face="ms sans serif" size="1"><b>Total outside liabilities</b></font></td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="17%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="13%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
%>			
	
  </table>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <table width="95%" border="1" cellspacing="0" cellpadding="5" bgcolor="#E2E2E2"  bordercolorlight="#EBEBF8" bordercolordark="#000000" >
    <tr> 
      <td colspan="5"> 
        <div align="left"><font face="MS Sans Serif" size="1" color="#333333"><b><font size="2">Networth</font></b></font></div>
      </td>
    </tr>
<%
		if( hshFinValues.containsKey("79") )
		{//System.out.println(hshFinValues.containsKey("79"));
			hshFinTmp = (HashMap)hshFinValues.get("79");
%>		
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1">Ordinary Share Capital</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("80") )
		{//System.out.println(hshFinValues.containsKey("80"));
			hshFinTmp = (HashMap)hshFinValues.get("80");
%>					
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif">Share Premium</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("81") )
		{//System.out.println(hshFinValues.containsKey("81"));
			hshFinTmp = (HashMap)hshFinValues.get("81");
%>		
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1">General Reserve</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("82") )
		{//System.out.println(hshFinValues.containsKey("82"));
			hshFinTmp = (HashMap)hshFinValues.get("82");
%>			
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1">Debenture redemption 
        Reserve</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("83") )
		{//System.out.println(hshFinValues.containsKey("83"));
			hshFinTmp = (HashMap)hshFinValues.get("83");
%>					
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
  		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1">Other Reserves</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("84") )
		{//System.out.println(hshFinValues.containsKey("84"));
			hshFinTmp = (HashMap)hshFinValues.get("84");
%>						
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>			
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1">Surplus(+)or Deficit(-)in 
        P&amp;L A/c</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("85") )
		{//System.out.println(hshFinValues.containsKey("85"));
			hshFinTmp = (HashMap)hshFinValues.get("85");
%>			
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1">Networth</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("86") )
		{//System.out.println(hshFinValues.containsKey("86"));
			hshFinTmp = (HashMap)hshFinValues.get("86");
%>					
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font face="ms sans serif" size="1">Total Liabilities</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
%>					
	
    <tr> 
      <td colspan="5" height="24">&nbsp; 
		
      </td>
    </tr>
    <tr> 
      <td colspan="5" height="24"> 
        <div align="left"><font face="ms sans serif" size="2"><b>3.3 Current Assets</b></font></div>
      </td>
    </tr>
<%	
		if( hshFinValues.containsKey("87") )
		{//System.out.println(hshFinValues.containsKey("87"));
			hshFinTmp = (HashMap)hshFinValues.get("87");
%>	
    <tr> 
      <td width="38%"><font size="1" face="MS Sans Serif"><%=hshFinTmp.get("fin_desc")%></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="MS Sans Serif"><b>Cash &amp; Bank balances</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("88") )
		{//System.out.println(hshFinValues.containsKey("88"));
			hshFinTmp = (HashMap)hshFinValues.get("88");
%>			
    <tr> 
      <td width="38%">&nbsp;<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("fin_desc")%></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		 <font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="MS Sans Serif" size="1" color="#333333"><b>Investments(Other 
        than long term investments)</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>			
<%
		}
		if( hshFinValues.containsKey("89") )
		{//System.out.println(hshFinValues.containsKey("89"));
			hshFinTmp = (HashMap)hshFinValues.get("89");
%>			
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif">&nbsp;Government 
        &amp; other trustee securities</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("90") )
		{//System.out.println(hshFinValues.containsKey("90"));
			hshFinTmp = (HashMap)hshFinValues.get("90");
%>					
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif">Fixed Deposits with 
        banks</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("91") )
		{//System.out.println(hshFinValues.containsKey("91"));
			hshFinTmp = (HashMap)hshFinValues.get("91");
%>					
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif">Receivables other 
        than deferred &amp; exports</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("92") )
		{//System.out.println(hshFinValues.containsKey("92"));
			hshFinTmp = (HashMap)hshFinValues.get("92");
%>					
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif">Export Receivables</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("93") )
		{//System.out.println(hshFinValues.containsKey("93"));
			hshFinTmp = (HashMap)hshFinValues.get("93");
%>	
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif">Instalments of deferred 
        receivables</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		
%>
    
    <tr> 
      <td width="38%" colspan=5>
	  	<b><font size="1" face="ms sans serif">Inventory</font></b>
	</td>
      
    </tr>

    <tr> 
      <td width="38%" colspan=5>
	  	<b><font size="1" face="ms sans serif">Raw Materials</font></b>
	  </td>
    </tr>
<%
		if( hshFinValues.containsKey("96") )
		{//System.out.println(hshFinValues.containsKey("96"));
			hshFinTmp = (HashMap)hshFinValues.get("96");		
%>	
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><b><font size="1" face="ms sans serif">Imported</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("97") )
		{//System.out.println(hshFinValues.containsKey("97"));
			hshFinTmp = (HashMap)hshFinValues.get("97");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
	<tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b>Indigenous</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("98") )
		{//System.out.println(hshFinValues.containsKey("98"));
			hshFinTmp = (HashMap)hshFinValues.get("98");		
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Stocks in process</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("99") )
		{//System.out.println(hshFinValues.containsKey("99"));
			hshFinTmp = (HashMap)hshFinValues.get("99");		
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Finished goods</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("100") )
		{//System.out.println(hshFinValues.containsKey("100"));
			hshFinTmp = (HashMap)hshFinValues.get("100");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="2"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="2"><b>Other consumable 
        spares</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("101") )
		{//System.out.println(hshFinValues.containsKey("101"));
			hshFinTmp = (HashMap)hshFinValues.get("101");		
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Imported</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("102") )
		{//System.out.println(hshFinValues.containsKey("102"));
			hshFinTmp = (HashMap)hshFinValues.get("102");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b>Indigenous</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("103") )
		{//System.out.println(hshFinValues.containsKey("103"));
			hshFinTmp = (HashMap)hshFinValues.get("103");		
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Advance payments</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("104") )
		{//System.out.println(hshFinValues.containsKey("104"));
			hshFinTmp = (HashMap)hshFinValues.get("104");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Advance payments</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("105") )
		{//System.out.println(hshFinValues.containsKey("105"));
			hshFinTmp = (HashMap)hshFinValues.get("105");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>		  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b>Other Current Assets</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("106") )
		{//System.out.println(hshFinValues.containsKey("106"));
			hshFinTmp = (HashMap)hshFinValues.get("106");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b>Deposit with EB</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("107") )
		{//System.out.println(hshFinValues.containsKey("107"));
			hshFinTmp = (HashMap)hshFinValues.get("107");		
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Other deposits</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("108") )
		{//System.out.println(hshFinValues.containsKey("108"));
			hshFinTmp = (HashMap)hshFinValues.get("108");		
%>	
    <tr> 
      <td width="38%"><font size="2" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="2" face="ms sans serif"><b>Others</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("109") )
		{//System.out.println(hshFinValues.containsKey("109"));
			hshFinTmp = (HashMap)hshFinValues.get("109");		
%>			
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b>Total Current Assets</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("110") )
		{//System.out.println(hshFinValues.containsKey("110"));
			hshFinTmp = (HashMap)hshFinValues.get("110");		
%>				
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font> </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Gross Block(Land 
        &amp; Buildings,Machinery,work</b></font> </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("111") )
		{//System.out.println(hshFinValues.containsKey("111"));
			hshFinTmp = (HashMap)hshFinValues.get("111");		
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Depreciations to 
        date</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("112") )
		{//System.out.println(hshFinValues.containsKey("112"));
			hshFinTmp = (HashMap)hshFinValues.get("112");		
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>NET BLOCK</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("113") )
		{//System.out.println(hshFinValues.containsKey("113"));
			hshFinTmp = (HashMap)hshFinValues.get("113");		
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Investments/Book 
        debts/Advances deposits which are not in Current Assets</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("114") )
		{//System.out.println(hshFinValues.containsKey("114"));
			hshFinTmp = (HashMap)hshFinValues.get("114");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b>Investments</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("115") )
		{//System.out.println(hshFinValues.containsKey("115"));
			hshFinTmp = (HashMap)hshFinValues.get("115");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("116") )
		{//System.out.println(hshFinValues.containsKey("116"));
			hshFinTmp = (HashMap)hshFinValues.get("116");		
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("117") )
		{//System.out.println(hshFinValues.containsKey("117"));
			hshFinTmp = (HashMap)hshFinValues.get("117");		
%>	
    <tr> 
      <td width="38%"><font size="1"><b><font face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1"><b><font face="ms sans serif">Others</font></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("118") )
		{//System.out.println(hshFinValues.containsKey("118"));
			hshFinTmp = (HashMap)hshFinValues.get("118");		
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b>Capital expenditure</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("119") )
		{//System.out.println(hshFinValues.containsKey("119"));
			hshFinTmp = (HashMap)hshFinValues.get("119");
%>			
	<tr> 
      <td width="38%"><b><font size="1" face="ms sans serif"><%=hshFinTmp.get("fin_desc")%></font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
	<tr> 
      <td width="38%"><b><font size="1" face="ms sans serif">Non-consumable stores 
        and spares</font></b></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("120") )
		{//System.out.println(hshFinValues.containsKey("120"));
			hshFinTmp = (HashMap)hshFinValues.get("120");
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
   <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Other non current 
        assets</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("121") )
		{//System.out.println(hshFinValues.containsKey("121"));
			hshFinTmp = (HashMap)hshFinValues.get("121");
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Total other Non-Current 
        Assets</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("122") )
		{//System.out.println(hshFinValues.containsKey("122"));
			hshFinTmp = (HashMap)hshFinValues.get("122");
%>	
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font size="1" face="ms sans serif"><b>Intangible assets(patents,goodwill,prelim.exp,bad/doubtful 
        debt</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
		if( hshFinValues.containsKey("123") )
		{//System.out.println(hshFinValues.containsKey("123"));
			hshFinTmp = (HashMap)hshFinValues.get("123");
%>	
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b><%=hshFinTmp.get("fin_desc")%></b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year1")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year2")%></font>	  
	  </td>
      <td width="15%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year3")%></font>	  
	  </td>
      <td width="16%" align="right" bgcolor="#F2F2F2">
		<font face="MS Sans Serif" size="1" color="#333333"><%=hshFinTmp.get("finval_year4")%></font>	  
	  </td>
    </tr>
<%
		}
		else
		{
%>
    <tr> 
      <td width="38%"><font face="ms sans serif" size="1"><b>Total Assets</b></font></td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="15%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="16%" align="right" bgcolor="#F2F2F2">&nbsp;</td>
    </tr>
<%
		}
%>	
	
  </table>
  <br>
  <br>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bgcolor="#E2E2E2" bordercolorlight="#EBEBF8" bordercolordark="#000000">
    <tr> 
      <td colspan="6">
	  <font size="2" face="MS Sans Serif"><b><font color="#333333">4. Collateral Details</font></b></font></td>
    </tr>
    <tr> 
	  <td width="16%"> <b><font face="MS Sans Serif" size="1" color="#333333">Security 
        Type</font></b> </td>
      <td width="7%"> <b><font face="MS Sans Serif" size="1" color="#333333">Code</font></b> 
      </td>
      <td width="28%"> <b><font face="MS Sans Serif" size="1" color="#333333">Description</font></b> 
      </td>
      <td width="16%"> <b><font face="MS Sans Serif" size="1" color="#333333">Ownership</font></b> 
      </td>
      <td width="15%"> <b><font face="MS Sans Serif" size="1" color="#333333">Market 
        Value</font></b> </td>
      <td width="18%"> <b><font face="MS Sans Serif" size="1" color="#333333">Current 
        Liens</font></b> </td>
    </tr>
	
<%
	int size=hshColl.size();
	if(size > 0)
	{
		for(int i=1;i<=size;i++)
		{
			String strTmp = String.valueOf(i);
			HashMap hshTmp = (HashMap)hshColl.get(strTmp);
%>	
    <tr bgcolor="#F2F2F2">
	  <td width="16%" bgcolor="#F2F2F2">
	 	 <font face="MS Sans Serif" size="1" color="#333333">
	  		<%= hshTmp.get("coll_securitytype") %>
		 </font>
	  </td>
      <td width="7%" bgcolor="#F2F2F2">
		  <font face="MS Sans Serif" size="1" color="#333333">
		  	<%= hshTmp.get("coll_serialno") %>
		  </font>
	  </td>
      <td width="28%">
		  <font face="MS Sans Serif" size="1" color="#333333">
			  <%= hshTmp.get("coll_desc") %>
		  </font>
  	  </td>
      <td width="16%">
		  <font face="MS Sans Serif" size="1" color="#333333">
			  <%= hshTmp.get("coll_owner") %>
		  </font>	  
	  </td>
      <td width="15%" align="right">
		  <font face="MS Sans Serif" size="1" color="#333333">
		  	<%= hshTmp.get("coll_marketval") %>
		  </font>
	  </td>
      <td width="18%" align="right">
		  <font face="MS Sans Serif" size="1" color="#333333">
			  <%= hshTmp.get("coll_currliens") %>
		  </font>	  
	  </td>
    </tr>
<%
		}
	}
	else
	{
%>	
    <tr bgcolor="#F2F2F2">
	  <td width="16%" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="7%" bgcolor="#F2F2F2">&nbsp;</td>
      <td width="28%">&nbsp;</td>
      <td width="16%">&nbsp;</td>
      <td width="15%" align="right">&nbsp;</td>
      <td width="18%" align="right">&nbsp;</td>
	</tr>	
<%
	}
%>
  </table>
  <p>&nbsp;</p>
  <div align="center">
<p>&nbsp;</p>
  </div>
</form>
<p>&nbsp;</p></body>
</html>
