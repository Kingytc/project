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
<table width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <div align="center"><u><b>LETTER OF AUTHORITY/DECLARTION</b></u></div>
    </td>
  </tr>
  <tr>
    <td>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>From:</p>
      <p>&nbsp; &nbsp; &nbsp; &nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%><br>
          &nbsp; &nbsp; &nbsp; &nbsp; <%=Helper.correctNull((String) hshValues.get("apaddress"))%><br>
          
          </p>
      <p>To:<br>
        The Branch Manager,<br>
        <b>Karnataka Bank Ltd.,</b><br>
        <%=Helper.correctNull((String) hshValues.get("branchName"))%>  Branch</p>
      <p>&nbsp;</p>
      <p>Sir,</p>
      <p align="justify">My husband/Wife had availed a loan of Rs. &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%> on<br>
        _________________________under UNION CASH Scheme(For Pensioners).I hereby 
        agree and undertake that in the unfortunate event of the demise <br>
        of my husband/wife,the Bank shall have a lien on the family pension received 
        by me by being the spouse of Shri/Smt.  &nbsp; &nbsp; &nbsp; &nbsp; <%=Helper.correctNull((String) hshValues.get("appname"))%><br>
        The Bank shall have a right pension amount would be credited.I further 
        undertake and agree that I shall route the family pension payment only 
        through your Bank.</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p align="right">____________________________<br>
        <br>
        &nbsp; &nbsp; &nbsp; &nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%><br>
        <b>[Signature] </b></p>
      <p>&nbsp;</p>
      <p>&nbsp; </p>
    </td>
  </tr>
</table>
</body>
</html>
