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
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center"><b>SIMPLE DEBIT BALANCE CONFIRMATION</b></div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="73%" align="right">Date </td>
    <td width="27%"><b>: <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
  </tr> 
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="7%">From,</td>
    <td width="93%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%"> <b><%=Helper.correctNull((String) hshValues.get("appname"))%></b>,<br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_address1"))%></b>,<br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_address2"))%></b>,<br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_address3"))%></b>,<br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_city"))%></b><br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_state"))%></b></td>
  </tr>
   
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="7%">To,</td>
    <td width="93%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%">Karnataka Bank Ltd.,</td>
  </tr>
  <tr> 
    <td width="7%">&nbsp;</td>
    <td width="93%"><b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b> Branch</td>
  </tr>
  <tr>
    <td width="7%">&nbsp;</td>
    <td width="93%">&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="5%" valign="top">1</td>
          <td width="95%">
            <p align="justify">I/We confirm the correctness of the balance of 
              Rs<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
              (Rupees<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b> 
              ) appearing to the debit of my/our__________________________account 
              with you on ____________.(This balance does not include interest 
              due but not charged from____________ .)<br>
            </p>
          </td>
        </tr>
        <tr>
          <td width="5%">2</td>
          <td width="95%">We have noted that rate of interest applicable in the 
            account is _________ percentage@ with effect from ________________________.</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
 
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="right"><b>BORROWER/S</b></div>
    </td>
  </tr>
</table>
 


</body>
</html>
