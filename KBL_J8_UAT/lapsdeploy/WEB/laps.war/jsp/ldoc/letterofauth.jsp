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
<table width="97%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td colspan="2"> 
      <div align="center"><b><u>LETTER OF AUTHORITY</u></b></div>
    </td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <p>From :<br>
       &nbsp; &nbsp; &nbsp; &nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%><br>
          &nbsp; &nbsp; &nbsp; &nbsp; <%=Helper.correctNull((String) hshValues.get("apaddress"))%><br>
       </p>
      <p>&nbsp;</p>
      <p>To:<br>
        The Manager,<br>
        <b>Karnataka Bank Ltd.,</b><br>
         &nbsp; &nbsp;<%=Helper.correctNull((String) hshValues.get("branchName"))%> Branch<br>
         &nbsp;<%=Helper.correctNull((String) hshValues.get("cityName"))%><br>
       
      </p>
    </td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <p>&nbsp;</p>
      <p>Sir </p>
    </td>
  </tr>
  <tr> 
    <td width="6%"> 
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
    <td width="94%"><b>Sub:<u>Advance under UNION CASH Scheme for Pensioners</u></b></td>
  </tr>
</table>
<table width="97%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <p>&nbsp;</p>
      <p>With reference to the loan of Rs. &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%>
      granted to me by you for meeting my personal needs/medical expenses.I 
        give you my irrevocable authorisation to recover the monthly Installments 
        commencing from the month of __________<br>
        ________________________ from SB/CD Accounts No.__________________________with 
        you in which my pension is credited.This may be treated as a standing 
        instruction in my SB/CD Account<br>
      </p>
      <p>&nbsp;</p>
      <p align="right">Yours faithfully,</p>
      <p align="right">&nbsp;</p>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="62%"> 
            <p>Place:&nbsp;<%=Helper.correctNull((String) hshValues.get("cityName"))%><br>
              Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%> </p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp; </p>
          </td>
          <td width="38%">
            <p>&nbsp;</p>
            <p>_______________________<br>
              [Signature of the Applicant]<br>
              Name:_______________________<br>
              PPO No._____________________<br>
              Res.Address:___________________<br>
              ______________________________<br>
              ______________________________<br>
              ______________________________ </p>
          </td>
        </tr>
      </table>
      <p align="right">&nbsp;</p>
      </td>
  </tr>
</table>
</body>
</html>
