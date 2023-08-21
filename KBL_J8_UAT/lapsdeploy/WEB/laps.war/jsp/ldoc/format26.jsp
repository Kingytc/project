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
      <td colspan="2"> 
        <div align="right"><b><u>FORMAT 26</u></b></div>
      </td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <div align="center"><b><br>
          DEMAND PROMISSORY NOTE FOR FOREIGN CURRENCY LOAN<br>
          (Specimen) (US DOLLARS)<br>
          </b></div>
      </td>
    </tr>
    <tr> 
      <td width="71%"><br>
      <b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b>  Branch<br>
      </td>
      <td width="29%"><br>
        Date :<b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b><br>
      </td>
    </tr>
    <tr> 
      <td colspan="2"><br>
        <br> <font face="Times New Roman" size="3"> 
              
        <p align="justify"> On demand, we__________________________________ promise 
          to pay Karnataka Bank, or order,the sum of ________________ (__________________only) 
          together with interest on such sum from this date at the rate
       
        of _______basis points over ___________LIBOR, subject to a minimum of 
        _______ percentage per annum (on 360 days basis)
    
        with ______________rests for value received.</p> </font> <br>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
  </table>
</body>
</html>
