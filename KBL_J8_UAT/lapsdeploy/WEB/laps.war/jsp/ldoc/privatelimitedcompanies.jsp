<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><b>LETTER TO BE OBTAINED FROM THE DIRECTORS IN CASES WHERE ADVANCES HAVE 
      BEEN PERMITTED TO PRIVATE LIMITED/LIMITED COMPANIES (AD-10)</b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="2%">To,</td>
    <td colspan="3">&nbsp;</td>
  </tr> 
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="46%"><b>Karnataka Bank Ltd.,</b></td>
    <td width="19%">&nbsp;</td>
    <td width="33%">Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td colspan="3"><b><%=Helper.correctNull((String)hshValues.get("branchName"))%></b> 
      Branch</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">Dear Sirs,</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%">&nbsp;</td>
    <td width="96%"> 
      <p align="justify">In consideration of Karnataka Bank Ltd. having granted/or 
        agreed to grant in favour of _____________________ various credit facilities 
        and/or any other Banking accommodation from time to time as may be required 
        by the said _______________________ and conveyed by the Bank, I/we, the 
        undersigned, do hereby undertake to abide as follows:<br>
        <br>
      </p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%" valign="top">cxxxii)</td>
    <td width="95%"> 
      <p align="justify">that in the event of the said Company___________________ 
        having depicted cash losses or adverse current Ratio or any other adverse 
        features as may be apparent to the Bank, like diversion of funds, etc, 
        we, the undersigned, in our capacity as the Directors of the company, 
        do hereby undertake to execute the guarantees in our joint and several 
        personal capacities to the Bank against the various credit facilities 
        sanctioned or to be sanctioned by Karnataka Bank Ltd. to the said Company 
        and/or any other banking accommodation from time to time to the said Company 
        as and when called upon by the Bank.<br>
        <br>
      </p>
    </td>
  </tr>
  <tr>
    <td width="5%" valign="top">cxxxiii)</td>
    <td width="95%"><p align="justify">I/We hereby declare that I/we shall not receive any consideration 
      by way of commission, brokerage, fees or in any other form from the said 
      Company and I/we hereby undertake that until such time as I/We shall be 
      liable under the aforesaid Letter of Guarantee or any other Letter of Guarantee 
      that I/we may execute at anytime, I/we shall not demand any commission, 
      brokerage, fees or any other consideration in any form from the said Company 
      for continuing my/our aforesaid guarantee or executing any other guarantee.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="69%">&nbsp;</td>
    <td width="31%">Yours faithfully, </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="38%">&nbsp;</td>
    <td width="31%" align="center">Full Name
    </td>
    <td width="31%">Signature</td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
