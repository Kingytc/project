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
  <div align="right">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td colspan="3"> 
          <div align="right"><b><u>FORMAT 25 (B)<br>
            </u></b></div>
        </td>
      </tr>
      <tr> 
        <td colspan="3"> 
          
        <div align="center"><b><u>FORMAT OF LETTER OF LIEN (FOR LETTER OF GUARANTEE 
          MARGIN)<br>
          </u></b><u>(Third party Deposits) </u><b><u><br>
          </u></b></div>
        </td>
      </tr>
      <tr> 
        <td colspan="3">
          <div align="center"><br>
            <b>KARNATAKA BANK LTD.<br>
            </b></div>
        </td>
      </tr>
      <tr> 
        <td colspan="3"><br>
          Dear Sir,<br>
        </td>
      </tr>
      <tr> 
        <td width="6%">&nbsp;</td>
        <td width="94%" colspan="2"> <br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
          In consideration of your agreeing to issue a Letter of Guarantee for 
          a sum of Rupees ____________________in favour of _________________________________________________________ 
          (hereinafter called the &#148;Beneficiary&#148;) on behalf of_____________________ 
          interalia on condition to offer a margin of__________% as a security/additional 
          security for you for the said purpose, I / We hand you herewith Short 
          / Fixed Deposit Receipt bearing No.____________________________dated 
          <b><%=Helper.figtoWords((String) hshValues.get("Curdate"))%></b> for Rs. <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> </b>(Rupees <b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b> 
          only) issued by you and I/We hereby agree that all monies under the 
          said Deposit Receipt or any renewals thereof and standing to the credit 
          of my / our Short / Fixed Deposit account shall be and remain as security 
          for the liability of the Bank towards the said beneficiary covered by 
          the said Letter of Guarantee. </p> </font> 
        </td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td colspan="2"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
          I / We further agree that in the event of invocation of the said Letter 
          of Guarantee by the Beneficiary at any time and you have to effect the 
          payment of the amount covered by the Guarantee to the Beneficiary, you 
          will have an undisputed right of set-off against the amount covered 
          under the aforesaid Short / Fixed Deposit Receipt/s and to that intent 
          and purpose, I / We hereby authorise you to transfer from my / our said 
          Short / Fixed Deposit, whether matured or not, without any notice to 
          me / us such amount or amounts as may be necessary to facilitate payment 
          of the guarantee to the Beneficiary.</p> </font>  
        </td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td colspan="2"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
          It is also understood and agreed by me/us that during the period the 
          said Letter of guarantee is in force and/or till such time the guarantee 
          is duly discharged by the Beneficiary, the Deposit Receipt referred 
          to herein will be renewed by me / us on due dates from time to time 
          and the amount thereunder continue to be deposited with you as security 
          as aforesaid.</p> </font> 
        </td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td colspan="2"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
          Lastly, I / We agree that this shall be a continuing Guarantee to the 
          extent of Rs.<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> </b>(Rupees 
          <b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b> only).</p> </font> <br>
        </td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td> 
          <div align="right"><br>
            Yours faithfully, </div>
        </td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td></td>
        <td><br>
        Date :  <b> <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b><br>
        </td>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td><br>
          Encl : <br>
        </td>
        <td></td>
      </tr>
    </table>
  </div>
</body>
</html>

