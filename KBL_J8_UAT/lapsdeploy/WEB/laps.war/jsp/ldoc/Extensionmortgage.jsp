<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
String date=Helper.correctNull((String)hshValues.get("Date"));
String Month=Helper.correctNull((String)hshValues.get("Month"));
String year=Helper.correctNull((String)hshValues.get("year"));

String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
int a=Integer.parseInt(Month);
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td colspan="3" align="center"><u>Annexure A-3<br>
      (Contd?..Format 11)</u></td>
  </tr>
  <tr> 
    <td colspan="3"><b>MEMORANDUM OF ENTRY (EXTENSION OF MORTGAGE IN FAVOUR OF 
      THE BANK. TO BE RECORDED BY THE FIRST LENDER) </b></td>
  </tr>
  <tr> 
    <td width="5%">1)</td>
    <td colspan="3">On the_______________________dayof______________________20_____ 
      Shri/Smt_________________________ residing at ___________________attended 
      office of ______________________________________* at _____a.m/p.m. and saw 
      Shri/Smt________________________of__________________* </td>
  </tr>
  <tr> 
    <td width="5%">2)</td>
    <td colspan="3">The said Shri/Smt ______________stated that the documents 
      of title, evidences, deeds and writings more particularly described in the 
      first schedule hereunder written (hereinafter called ?the said title deeds?) 
      in respect of his/her immovable property/flat for securing the due repayment 
      and discharge of the loan granted to him/her by the ____________.* together 
      with interest, compound interest, costs, charges, expenses and other monies 
      outstanding in respect thereof. </td>
  </tr>
  <tr> 
    <td width="5%">3 i)</td>
    <td colspan="3"> Shri/Smt_________.accorded and gave oral consent to Shri/Smt___________.acting 
      for the ___________* and the _________* acting for itself and as agent of 
      Karnataka Bank to continue to hold and retain the title deeds by constructive 
      delivery as and by way of joint mortgage by deposit of title deeds of his/her 
      immovable property/flat (more particularly described in the second schedule 
      hereunder written) as security also for the due repayment and discharge 
      and redemption of his/her dues to : </td>
  </tr>
  <tr> 
    <td width="5%">3 ii)</td>
    <td colspan="3">the ___________________.* Rs___________________.Loan Amount 
    </td>
  </tr>
  <tr> 
    <td width="5%">3 iii)</td>
    <td colspan="3">Karnataka Bank Rs_________________Home Loan amount </td>
  </tr>
  <tr> 
    <td colspan="3">(hereinafter collectively referred to as ?the lenders?) together 
      with interest, interest by way of liquidated damages, compound interest, 
      commitment charges, premia on prepayment, costs, charges, expenses and other 
      monies payable on the loan amounts under their respective loan agreements 
      from time to time. </td>
  </tr>
  <tr> 
    <td width="5%">4)</td>
    <td colspan="3"> Shri/Smt_______________further stated that he/she is the 
      sole and absolute owner of the said immovable property/flat and he/she has 
      full authority and power to extend the mortgage created in favour of _____________________* 
      to the bank for the said home loan granted by the Bank. </td>
  </tr>
  <tr> 
    <td colspan="3">The aforesaid oral consent was given by Shri/Smt______________in 
      the presence of Shri/Smt_____________________representative of Union Bank 
      of India. </td>
  </tr>
  <tr> 
    <td colspan="3" align="center">
      <p>FIRST SCHEDULE ABOVE REFERRED TO<br>
        (List of title deeds & writings, evidences)</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <br>
  <br>
  <br>
  <br>
  <br>
  <tr> 
    <td colspan="3" align="center">
      <p>SECOND SCHEDULE ABOVE REFERRED TO<br>
        (Description of immovable property/flat)</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td colspan="3" align="left">Dated -----<b><%=date%><%=Months[a]%>, 
      <%=year%></b></td>
  </tr>
  <tr> 
    <td colspan="2" align="right">Signature<br>
      Name:<br>
      Designation</td>
    <td width="42%" align="right">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2" align="right">Signature<br>
      Name:<br>
      Designation</td>
    <td width="42%" align="right">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3" align="left">*mention the name of the financial institution/Bank.</td>
  </tr>
</table>
</body>
</html>
