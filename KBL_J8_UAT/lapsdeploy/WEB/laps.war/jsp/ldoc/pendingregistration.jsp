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
    <td align="center" colspan="3">
      <div align="right"><u>FORMAT -6</u></div>
    </td>
  </tr>
  <tr> 
    <td  colspan="3" align = "center"><u> <b>Draft of letter to sub-registry (Housing 
      Loan) (Where the title deeds are pending registration)</b><br>
      (Annexure -F- to instruction circular no. 6073 dated 16.08.2000)</u></td>
  </tr>
  <tr> 
    <td  colspan="3" align = "left"><u> Instructions:</u></td>
  </tr>
  <tr> 
    <td  colspan="3"><p align="justify"> This letter should be prepared in duplicate. The Original 
      should be submitted to the Sub-Registrar, taking his signature on the duplicate 
      and then submit the duplicate to Karnataka Bank Ltd.<br></p>
    </td>
  </tr>
  <tr> 
  <tr> 
    <td  colspan="3" align="right"> 
      <div align="left">From:</div>
    </td>
  </tr>
  <tr> 
    <td  colspan="2" align="right" height="59"> 
      <div align="left">Name & Address<br>
        Of the applicant:<br>
        <br>
      </div>
    </td>
    <td width="34%" align="right" height="59"> 
      <div align="left">Date:  <b> <%=Helper.correctNull((String)hshValues.get("Curdate"))%></b> </div>
    </td>
  </tr>
  <tr> 
    <td align="left" colspan="3">To:<br>
      The Sub-Registrar,<br>
      ---------------------------,<br>
      ---------------------------.<br>
      Dear Sir,</td>
  </tr>
  <tr> 
    <td align="center" colspan="3">Sub: Agreement for sale/Deed of confirmation 
      / Modification # dated ___________lodged for registration </td>
  </tr>
  <tr> 
    <td colspan="3"><p align="justify">The above document has been lodged with you for registration 
      on _________against your receipt bearing serial No____________ and Document 
      No________.of the same date.</p> </td>
  </tr>
  <tr> 
    <td colspan="3"><p align="justify">You are hereby requested and authorised to send the said document 
      to File No_____________.Karnataka Bank Ltd. at the following address: </p></td>
  </tr>
  <tr> 
    <td align="center" colspan="3">Karnataka Bank Ltd.<br>
      Address :</td>
  </tr>
  <tr> 
    <td colspan="3"><p align="justify">You are requested to make necessary entries and/or amendment/s 
      in your relevant register/s to give effect to the above request. This letter 
      may be treated as irrevocable authority from me/us until you receive no 
      objection from Karnataka Bank Ltd. </p></td>
  </tr>
  <tr> 
    <td  colspan="3" align="right">Thanking you,</td>
  </tr>
  <tr> 
    <td  colspan="3" align="right">
      <p>Yours faithfully, </p>
      <p>&nbsp; </p>
    <tr> 
    <td  colspan="3" align="left">&nbsp;</td>
  </tr>
</table>
</body>
</html>
