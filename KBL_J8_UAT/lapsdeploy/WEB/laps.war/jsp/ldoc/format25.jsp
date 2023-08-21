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
      <td colspan="3"> 
        <div align="right"><b><u><br>
          FORMAT 25</u></b></div>
      </td>
    </tr>
    <tr> 
      <td colspan="3" height="43"> 
        <div align="center"><b>A) FORMAT OF LETTER OF LIEN (FOR LETTER OF GUARANTEE 
          MARGIN) (own deposits)<br>
          </b> </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3">
        <div align="center"><b>KARNATAKA BANK LTD.</b><br>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"><br>
        Dear Sir,<br>
      </td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="2"><br> <font face="Times New Roman" size="3"> 
              
      <p align="justify"> In consideration of your agreeing to issue a Letter 
        of Guarantee for a sum of Rupees ____________________in favour of _________________________________________________________ 
        (hereinafter called the &#148;Beneficiary&#148;) on behalf of_____________________ 
        interalia on condition that I/we should offer a margin of_________% as 
        a security/additional security for you for the said purpose, I / We hand 
        you herewith Short / Fixed Deposit Receipt bearing No.____________________________dated 
        <b> <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> for 
        Rs. <b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> (Rupees <b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b> only) issued 
        by you and I/We hereby agree that all monies under the said Deposit Receipt 
        or any renewals thereof and standing to the credit of my / our Short / 
        Fixed Deposit account shall be and remain as security for the liability 
        of the Bank towards the said beneficiary covered by the said Letter of 
        Guarantee. </p>
      </font> 
      </td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="2"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
        I / We further agree that in the event of invocation of the said Letter 
        of Guarantee by the Beneficiary at any time and you have to effect the 
        payment of the amount covered by the Guarantee to the Beneficiary, I/we 
        shall make available the funds necessary for the payment of the Letter 
        of Guarantee immediately on information from you on the same and in case 
        of my/our failure to furnish the money as stated above, you will have 
        an undisputed right of set-off against the amount covered under the aforesaid 
        Short / Fixed Deposit Receipt/s and to that intent and purpose, I / We 
        hereby authorise you to transfer from my / our said Short / Fixed Deposit, 
        whether matured or not, without any notice to me / us such amount or amounts 
        as may be necessary to facilitate payment of the guarantee to the beneficiary. 
        If the amount available as per the Short/Fixed Deposit account is not 
        sufficient to cover the same, I/We hereby authorise you to debit my/our 
        current/savings account maintained with you and the overdraft, if any 
        thus created shall attract the interest rate stipulated by you as per 
        your rules.</p> </font> 
      </td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="2"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
        It is also understood and agreed by me/us that during the period the said 
        Letter of guarantee is in force and/or till such time the guarantee is 
        duly discharged by the Beneficiary and my/our producing a Letter of discharge 
        from the Beneficiary/Letter of Guarantee duly discharged, the Deposit 
        Receipt referred to herein will be renewed by me / us on due dates from 
        time to time and the amount thereunder continue to be deposited with you 
        as security as aforesaid and in the event of my/our failure to renew the 
        said deposit Receipt within the due dates of maturity, you are authorised 
        to renew the said deposit on my/our behalf.</p> </font>
       
        <br>
      </td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="80%"> 
        <div align="right"></div>
      </td>
      <td width="17%">Yours faithfully,<br>
      </td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="2">Date : <b> <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b><br>
      </td>
    </tr>
    <tr> 
      <td width="3%">&nbsp;</td>
      <td colspan="2">Encl :<br>
      </td>
    </tr>
  </table>
</body>
</html>
