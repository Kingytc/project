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
    <td>
      <div align="center"><b>LETTER OF CONSENT FOR REFINANCE (AD-15)</b></div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="3%">To,</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td width="69%"><b>Karnataka Bank Ltd.,</b></td>
    <td width="28%">Place:<b><%=Helper.correctNull((String) hshValues.get("cityName"))%></b></td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="69%"><b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b> 
      Branch</td>
    <td width="28%">Date:<b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%">&nbsp;</td>
    <td width="96%">Dear sirs,</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>Sub: ______________________________________<br>
      <br>
      Loan/advance granted to M/s<b><%=Helper.correctNull((String) hshValues.get("appname"))%></b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify"> I/We understand that the advance availed by me/us is eligible for refinance 
      under Industrial Development Bank of India (IDBI)/National Bank for Agricultural 
      Development (NABARD). I/We have no objection to your availing refinance 
      from IDBI/NANARD. I/we give my/our consent for the same and agree to the 
      following:</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%" valign="top">cxli)</td>
    <td width="95%"><p align="justify">You shall be at liberty to furnish to IDBI/NABARD any information 
      or report whether received by your Bank from me/us or otherwise in your 
      Bank&#146;s possession.</p></td>
  </tr>
  <tr> 
    <td width="5%" valign="top">cxlii)</td>
    <td width="95%"><p align="justify">Where you avail refinance from IDBI/NABARD the rate of interest 
      payable by me/us shall be in accordance the terms of the Scheme of IDBI/NABARD 
      for the time being in force and such concessional rate shall be applicable 
      only until relative refinance is reimbursed by IDBI/NABARD. In the event 
      of the delay/default in repayment of any instalment by me/us to the Bank, 
      I/we shall be liable to pay interest and overdue interest as per the rules  
      of your Bank/directives of IDBI/NABARD as the case may be.</p></td>
  </tr>
  <tr> 
    <td width="5%" valign="top">cxliii)</td>
    <td width="95%"><p align="justify">The Borrower shall be bound by all such additional terms and 
      conditions as may be stipulated by IDBI/NABARD including payment of Commitment 
      charges in respect of the advance/loan granted/agreed to be granted and 
      I/we shall execute any additional documents if needed by your Bank or by 
      IDBI/NABARD, provided however it is not obligatory on the part of your Bank 
      to any such additional document and provided further if the IDBI/NABARD 
      prescribed any additional terms and conditions on your Bank to be complied 
      with by me/us, I/we shall comply with the same.</p></td>
  </tr>
  <tr> 
    <td width="5%" valign="top">cxliv)</td>
    <td width="95%"><p align="justify">During the currency of the advance/loan, if need be I/we shall 
      allow inspection of the properties secured to you by your officials and 
      the officials of IDBI/NABARD.</p></td>
  </tr>
  <tr>
    <td width="5%" valign="top">cxlv)</td>
    <td width="95%"><p align="justify">I/We agree to abide by the other rules of your Bank and IDBI/NABARD 
      with regard to refinance facility. I/We further agree for waiver of specific 
      notice on interest rate revision. Notice in the Notice Board of your Bank 
      premises shall be a deemed notice and the same shall be binding on me/us.</p></td>
  </tr>
</table>
<p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="61%">&nbsp;</td>
    <td width="39%">Yours faithfully,</td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
