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
    <td align="center" width="3%">&nbsp;</td>
    <td align="center" colspan="3"><b>FORMAT - 7</b></td>
  </tr>
  <tr> 
    <td width="3%" align = "center">&nbsp;</td>
    <td  colspan="3" align = "center"><b>FORMAT OF NOC FROM BUILDER/DEVELOPER/SOCIETY</b></td>
  </tr>
  <tr> 
    <td width="3%" align = "center">&nbsp;</td>
    <td  colspan="3" align = "center"><b>(ANNEXURE- G TO I.C. 6073 DATED 16-08-2000)</b></td>
  </tr>
  <tr> 
    <td width="3%" align = "left">&nbsp;</td>
    <td  colspan="3" align = "center"><b>LETTER HEAD OF THE BUILDER/DEVELOPER/SOCIETY</b></td>
  </tr>
  <tr> 
    <td width="3%" align="right">&nbsp;</td>
    <td  width="35%"> 
      <div align="right"></div>
    </td>
    <td  width="51%"> 
      <div align="right">Date:</div>
    </td>
    <td  width="11%"><b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
  </tr>
  <tr> 
    <td align="left" width="3%" valign="top" height="130">&nbsp;</td>
    <td align="left" colspan="3" height="130">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="3%">To:</td>
          <td width="97%">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%">&nbsp;</td>
          <td width="97%"><b>Karnataka Bank Ltd.</b><br>
            <b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b> 
            Branch</td>
        </tr>
      </table>
      <br>
       
      
      Dear Sir,</td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td colspan="3">
      <p align="justify"> This is to confirm that I/we have sold flat No. ___ 
        on ______ floor in the building known as ________________ situated at 
        _________________ _________ to Mr./Mrs. ____________________ for a total 
        consideration of Rs._____________ (Rupees ______________________only) 
        under Agreement for Sale dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b>. The carpet area of the said 
        flat No. _______ is ____ sq. ft. <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td colspan="3">
      <p align="justify"> I/We hereby declare that the said flat as well as the 
        said building and the land appurtenant thereto are not subject to any 
        encumbrances, charges or liability of any kind whatsoever. I/We further 
        declare that I/we have not raised and will not raise any loan from any 
        agency or financial institution, person/s or Banks for purchase of the 
        said property and for the construction of the said building/s and we hereby 
        declare that the entire property is free and marketable. I/We further 
        declare that I/we have clear, legal and marketable title to the said property 
        and every part thereof.<br>
      </p> 
    </td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td colspan="3">
      <p align="justify"> I/We hereby state that I/We have no objection to your 
        giving a loan to the above buyer/s and his/her/their mortgaging the said 
        flat with you, by way of security for repayment, notwithstanding anything 
        to the contrary contained in the said Agreement for Sale dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b>
        and I/we further undertake that I/we will not sell, transfer the aforesaid 
        flat to any other person/s without Karnataka Bank Ltd.?s prior permission.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td colspan="3">
      <p align="justify"> Further in the event Karnataka Bank Ltd. will sell the 
        said flat to any person/s (either due to default of payment of the loan 
        or for any other reasons as Bank deems fit). I/we will not object to such 
        person/s as bonafide purchaser/s of the said flat.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td colspan="3">
      <p align="justify"> I/We are aware that Mr/Mrs. ________________________ 
        has approached you for a loan for purchase of the aforesaid flat and I/we 
        am/are prepared to register Bank?s charge in my/our books in respect of 
        the said flat and he/she will not be permitted to transfer, assign, sell 
        off or in any other way deal with the said flat prejudicial to the interest 
        of the Bank without the prior consent of the Bank. <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td colspan="3"><p align="justify"> I/We hereby undertake to duly register in the Co-operative 
      Housing Society books the aforesaid charges as and when the Co-operative 
      Housing Society is formed.</p> </td>
  </tr>
  <tr> 
    <td width="3%" align="right">&nbsp; 
    <td  colspan="3" align="right">Yours faithfully, 
  <tr> 
</table>
</body>
</html>
