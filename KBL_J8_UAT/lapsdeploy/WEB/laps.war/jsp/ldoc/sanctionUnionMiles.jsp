<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror /> 
<%
String installment=Helper.correctNull((String)hshValues.get("loan_periodicity"));
if(installment.equalsIgnoreCase("m"))
{
	 installment="Monthly";
}else if(installment.equalsIgnoreCase("q"))
{
	 installment="Quarterly";
}else if(installment.equalsIgnoreCase("h"))
{
	 installment="Haly-Yearly";  
}else if(installment.equalsIgnoreCase("y"))
{
	 installment="Yearly";
}

String loan_inttype=Helper.correctNull((String) hshValues.get("loan_inttype"));
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">Karnataka Bank Ltd.<br>
      <b><%=Helper.correctNull((String)hshValues.get("branchName"))%></b> Branch</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="67%">Ref.</td>
    <td width="33%">Date:<b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
  </tr>
</table>
 
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><b>LETTER OF SANCTION</b><br>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="5%">To</td>
    <td width="95%">&nbsp;</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="95%"><b><%=Helper.correctNull((String)hshValues.get("Title"))%> 
      <%=Helper.correctNull((String)hshValues.get("appname"))%>,<br>
      </b><b><%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>,</b><br>
      <b><%=Helper.correctNull((String)hshValues.get("perapp_address2"))%> ,</b><br>
      <b><%=Helper.correctNull((String)hshValues.get("perapp_city"))%> -<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>. 
      </b> <br>
      <b> <%=Helper.correctNull((String)hshValues.get("perapp_state"))%>.</b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="15%">Dear Sir/Madam,<br>
      <br>
    </td>
    <td width="85%"><br>
      <br>
    </td>
  </tr>
  <tr>
    <td width="15%" align="right" valign="top">Sub:</td>
    <td width="85%"><b>UNION MILES SCHEME</b> <br>
      <br>
    </td>
  </tr>
  <tr>
    <td width="15%">&nbsp;</td>
    <td width="85%">Conveying of sanction Terms and Conditions</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">With reference to your loan application dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> 
      we are pleased to inform that a Term Loan / SOD of Rs. <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
      [ Rs. <b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b>] 
      is sanctioned in your favour for the purpose of under Union Miles Scheme, 
      on the following terms and conditions. <br>
      <br>
    </td>
  </tr>
  <%if(loan_inttype.equalsIgnoreCase("Fixed")){%>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">A fixed interest of <b><%=Helper.correctNull((String) hshValues.get("mintrate"))%></b> 
      % per annum at <b><%=installment%> </b>rests will be charged on your Loan a/c. 
      <br>
      <br>
    </td>
  </tr>
  <%}%>
   <%if(loan_inttype.equalsIgnoreCase("Floating")){%>
        <tr> 
          
    <td width="4%" valign="top">&nbsp; </td>
          <td width="96%"> 
            <p align="justify"> A floating interest of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("mintrate"))%>% </b>
              per annum at monthly rests will be charged to your loan /SOD account.<br>
              <br>
            </p>
          </td>
        </tr>
		<%}%>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">The following security documents are to be executed at the 
      time of disbursement of loan:<br>
    </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">DP Note<br>
      <br>
    </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">Consumer goods (Vehicle Agreement) SD-10<br>
      <br>
    </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%"> From 'E'duly signed by the borrower instructing the supplier 
      / dealer to register Bank's lien with RTA.<br>
      <br>
    </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">Letter of gurantee from the gurantor ( SD-01) <br>
      <br>
    </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">Blank Forms 28, 29, 30. <br>
      <br>
    </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">The loan amount with margin money will be released directly 
      in the name of the Dealer / Seller of the vehicle by way of a Demand Draft 
      / Pay Order<br>
      <br>
    </td>
  </tr><tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">The loan is repayable in <b><%=Helper.correctNull((String) hshValues.get("lreqterms"))%></b> 
      Equated <b><%=installment%></b> installments of Rs. <b><%=Helper.correctNull((String) hshValues.get("loan_emi"))%></b> 
      commencing from <b><%=Helper.correctNull((String) hshValues.get("currentDate"))%></b> 
      month.<br>
      <br>
    </td>
  </tr><tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">A penal interest <b>2% </b>will be levied on the overdue installment 
      if any<br>
      <br>
    </td>
  </tr><tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">The vehicle financed by us is to be insured comprehensively 
      covering all risks with Bank Clause<br>
    </td>
  </tr><tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">Bank's lien on the vehicle financed is to be registered with 
      RTA and a copy of the same to be submitted for our records. <br>
      <br>
    </td>
  </tr><tr>
    <td width="3%">&nbsp;</td>
    <td width="97%"><b> <%=Helper.correctNull((String)hshValues.get("Title"))%> 
      <%=Helper.correctNull((String)hshValues.get("appname"))%></b> with means 
      of <b>Rs. <%=Helper.correctNull((String) hshValues.get("sancamount"))%> Lacs</b>is acceptable to Bank to stand as 
      guarantor to your loan. <br>
      <br>
    </td>
  </tr><tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">Processing charges of Rs.<b><%=Helper.correctNull((String)hshValues.get("procfee"))%></b> 
      is to be paid before availment of loan <br>
      <br>
    </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">An irrevocable undertaking from your employer is to be submitted 
      to recover the EMls directly from your salary every month and to remit the 
      proceeds regularly to Bank. <br>
      <br>
      <br>
    </td>
  </tr><tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">An irrevocable undertaking from your Employer to adjust the 
      loan dues if any, directly from the Terminal benefits payable to you in 
      case of any eventuality / cessation in service by you or not to release 
      terminal benefits until a no due certificate is produced from the Bank. 
      <br>
      <br>
    </td>
  </tr>
  <tr>   
    <td width="3%">&nbsp;</td>
    <td width="97%">We now request you to convey your acceptance (or) otherwise 
      of the above terms and conditions and call on us any working day to enable 
      us to disburse the loan after proper documentation. <br>
    </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">&nbsp;</td>
  </tr>
   
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="54%">&nbsp;</td>
    <td width="46%">For Karnataka Bank Ltd.</td>
  </tr>
  <tr>
    <td width="54%">&nbsp;</td>
    <td width="46%">&nbsp;</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="54%">&nbsp;</td>
    <td width="46%">CHIEF/BRANCH MANAGER</td>
  </tr>
  <tr>
    <td width="54%">&nbsp;</td>
    <td width="46%">&nbsp;</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>The above terms and conditions are acceptable to us</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Signature of Applicant [s]</td>
    <td>Signature of Guarantor [s]</td>
  </tr>
  <tr>
    <td>Date :<b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> </td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
