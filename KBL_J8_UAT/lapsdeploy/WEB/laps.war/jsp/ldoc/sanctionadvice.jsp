
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
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td colspan="5"> 
      <div align="center"><u><b>PART VII : PROFORMA OF SANCTION ADVICE/LETTER 
        TO THE PARTY </b> </u> </div>
    </td>
  </tr>
  <tr> 
    <td colspan="5">To, <br>
      <p>_______________________ <br>
        _______________________ <br>
        _______________________ </p>
      <p>Dear Sir/s,</p>
      <p>Sub: Sanction of Credit Facilities<br>
        <br>
        With reference to your Proposal/letter dated  <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> and the discussions 
        from time to time on the subject matter, we are pleased to convey our 
        sanction/renewal/enhancement of the following credit facilities:<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td colspan="3">
      <div align="center"><b>Type of Facility</b></div>
    </td>
    <td width="28%">
      <div align="center"><b>Existing </b>(Rs. In lacs) </div>
    </td>
    <td width="38%">
      <div align="center"><b>Now approved</b> (Rs. In lacs)</div>
    </td>
  </tr>
  <tr> 
    <td height="116" colspan="3" valign="top">A. Fund-Based Facilities</td>
    <td height="116" width="28%"></td>
    <td height="116" width="38%"></td>
  </tr>
  <tr> 
    <td height="110" colspan="3" valign="top">B. Non-Fund Based Limits</td>
    <td height="110" width="28%"></td>
    <td height="110" width="38%"></td>
  </tr>
  <tr> 
    <td height="46" colspan="5">The above sanction is subject to the fulfilment 
      of the following conditions:</td>
  </tr>
  <tr> 
    <td height="32" width="5%" valign="top" colspan="2">(ii)</td>
    <td height="32" colspan="3"> 
      <p align="justify">Conditions relating to margin:</p>
    </td>
  </tr>
  <tr> 
    <td height="30" width="5%" valign="top" colspan="2">(iii)</td>
    <td height="30" colspan="3">Conditions relating to Rate of interest/Penal 
      interest/Other Charges/Commissions </td>
  </tr>
  <tr> 
    <td height="34" colspan="5" >(Please note in respect of Forex facilities, 
      full details of interest and commission to be given in the form of an annexure)</td>
  </tr>
  <tr> 
    <td height="26" width="5%" valign="top" colspan="2">(iv)</td>
    <td height="26" colspan="3">Condition relating to Change of PLR/Interest rate</td>
  </tr>
  <tr> 
    <td height="46" valign="top"> 
      <p align="justify">&nbsp;</p>
    </td>
    <td height="46" valign="top">&nbsp;</td>
    <td height="46" colspan="3" valign="top">The following clause to be stated 
      here: &#147;Notwithstanding anything contained in the documents executed/to 
      be executed, the rate of interest stipulated will be subject to revision 
      depending on the change in the PLR of the Bank or depending on the directives 
      of Reserve Bank of India or the policy of the Bank from time to time which 
      change will be displayed on the notice Board in the Branch or published 
      in the newspaper and no separate notice may be issued by the Bank to the 
      Borrower/guarantor regarding such revision.&#148;</td>
  </tr>
  <tr> 
    <td height="30" width="5%" valign="top" colspan="2">(v)</td>
    <td height="30" colspan="3">Conditions relating to creation of securities/Mode/Schedule 
      etc.</td>
  </tr>
  <tr> 
    <td height="29" width="5%" valign="top" colspan="2">5.</td>
    <td height="29" colspan="3">Conditions relating to creation of securities 
      and security documents</td>
  </tr>
  <tr> 
    <td height="32" width="5%" valign="top" colspan="2">(vi)</td>
    <td height="32" colspan="3">Conditions relating to financial parameters</td>
  </tr>
  <tr> 
    <td height="30" width="5%" valign="top" colspan="2">7.</td>
    <td height="30" colspan="3">Conditions relating to re-payment Schedule with 
      default clause</td>
  </tr>
  <tr> 
    <td height="28" width="5%" valign="top" colspan="2">8.</td>
    <td height="28" colspan="3">Conditions relating to submission of Stock/Book 
      Statements, MSOD. QPR etc.</td>
  </tr>
  <tr> 
    <td height="26" width="5%" valign="top" colspan="2">(vii)</td>
    <td height="26" colspan="3">Conditions relating to insurance</td>
  </tr>
  <tr> 
    <td height="23" width="5%" valign="top" colspan="2">(viii)</td>
    <td height="23" colspan="3">Conditions relating to Inspection</td>
  </tr>
  <tr> 
    <td height="26" width="5%" valign="top" colspan="2">(ix)</td>
    <td height="26" colspan="3">Validity of the limit</td>
  </tr>
  <tr> 
    <td height="25" width="5%" valign="top" colspan="2">(x)</td>
    <td height="25" colspan="3">General Conditions</td>
  </tr>
  <tr> 
    <td height="26" colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td height="46" colspan="5" > 
      <p align="right">Yours truly, </p>
      <p align="right">&nbsp;</p>
      <p align="right"><b>(BRANCH MANAGER)</b></p>
    </td>
  </tr>
</table>
</body>
</html>
