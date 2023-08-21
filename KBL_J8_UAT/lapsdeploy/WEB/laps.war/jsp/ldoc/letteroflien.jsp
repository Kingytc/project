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
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td>
            <div align="center"><b><font size="+1"><u>LETTER OF LIEN (DEPOSITS) 
              (AD-02) </u></font></b> </div>
            <p><b>KARNATAKA BANK LTD.</b><br>
            </p>
            <p>Dear Sir, <br>
            </p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="6%">&nbsp;</td>
                <td width="94%"><p align="justify">In consideration of your agreeing to advance and 
                  advancing to ______________________________________________________________</p></td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td colspan="2">____________________________________________________________________________________________________________________</td>
              </tr>
              <tr> 
                <td height="107" colspan="2"><p align="justify">(hereinafter called the borrower/s) 
                  a sum or sums of money up to Rs.___________________(Rupees_____________________________________<br>
                  __________________________ Only). I/ We hand you herewith Short 
                  / Fixed Deposit Receipt bearing No.___________________________ 
                  dated<br>
                  _______ for Rs. ________ (Rupees.______________________________ 
                  only) issued by you and hereby agree that all monies under the 
                  said Deposit Receipt or any renewals thereof and standing to 
                  the credit of my / our Short / Fixed Deposit account shall be 
                  and remains as security for the amount for the time being owing 
                  to you by the said Borrower/s_______________________________ </p>
                  <p></p>
                </td>
              </tr>
              <tr> 
                <td height="29" width="8%">&nbsp;</td>
                <td height="29" width="92%"><p align="justify">I / We further agree that in the event 
                  of any default in payment on demand of any balance due to you 
                  by the said borrower/s ______________</p></td>
              </tr>
              <tr> 
                <td height="29" colspan="2"><p align="justify">you will have an undisputed right 
                  of set-off against the amount covered under the aforesaid Short 
                  / Fixed Deposit Receipt and to that intent and purpose,<br>
                  I / We hereby authorize you to transfer from my / our said Short 
                  / Fixed Deposit account without any notice to me / us such amount 
                  or amounts as may be necessary to liquidate the indebtedness 
                  of the said borrower/s ______________________________________ 
                  to you</p></td>
              </tr>
              <tr> 
                <td height="29">&nbsp;</td>
                <td height="29"><p align="justify">It is also understood and agreed by me / us that 
                  during the continuance of the advance to the said borrower/s 
                  _________________________ </p></td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td colspan="2"><p align="justify">the Deposit Receipt referred to herein will be 
                  renewed by me / us on due dates from time to time and the amount 
                  there under continued to be deposited with you as security as 
                  aforesaid and in the event of my/our failure to renew the said 
                  deposit Receipt within the due dates of maturity, you are authorized 
                  to renew the said deposit on my/our behalf.</p></td>
              </tr>
              <tr> 
                <td width="11%">&nbsp;</td>
                <td width="89%"><p align="justify">Lastly, I / We agree that this shall be a continuing 
                  Guarantee to the extent of Rs._______________________________ </p>
                </td>
              </tr>
              <tr> 
                <td colspan="2">(Rupees______________________________________________ 
                  only).</td>
              </tr>
              <tr> 
                <td colspan="2">
                  <p>&nbsp;</p>
                  <p>Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></p>
                  <p>Encl :<br>
                  </p>
                  <p align="right">Yours faithfully</p>
                </td>
              </tr>
            </table>
            <p>&nbsp; </p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
