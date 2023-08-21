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
<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr> 
    <td align="right" colspan="2"> 
      <p><u> FORMAT - 16</u></p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td align="center" colspan="2"> 
      <p><u> <b>LETTER OF FREE ACCESS TO THE PREMISES WHERE HYPOTHECATED GOODS 
        ARE STORED</b></u> </p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td align="left" colspan="2"> 
      <p>From <br>
        ------------------------<br>
        (Address of the landlord) </p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td align="left" colspan="2"> 
      <p>To,<br>
        M/s _________<br>
        <b>Karnataka Bank Ltd.</b><br>
        <b><%=Helper.correctNull((String)hshValues.get("branchName"))%></b> Branch 
      </p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td align="left" colspan="2"> 
      <p>Sir, </p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <p align="justify">M/s. ____________________________________________________(NAME 
        & ADDRESS OF THE Borrower) who has been rented out my premises for storing 
        the articles/goods pertaining to their business activities/ who are carrying 
        on business/manufacturing activities on job-work basis in the premises 
        rented out by me to _______ (Strike out which is not applicable) has informed 
        me that the goods being stored/processed are charged to your Bank for 
        the credit facilities availed by him from your Bank, and has requested 
        me to give my consent for allowing your Bank Officials to visit my premises 
        as stated above for the purpose of inspection of the stock/goods. I/We 
        hereby convey my/our consent for the same. Your officials are permitted 
        to have entry into the premises for the purpose of inspection or any other 
        purposes associated with the same.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="88%"> 
      <p align="right">Yours truly,</p>
    </td>
    <td width="12%">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left" colspan="2"> 
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>
</body>
</html>
