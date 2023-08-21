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
            <div align="right"><b><u>Annexure II</u></b></div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div align="center"><b>Link letter to be obtained when additional 
              housing loan is granted</b></div>
          </td>
        </tr>
        <tr>
          <td> 
            <p>From, <br>
              &nbsp; &nbsp; &nbsp; &nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%><br>
	          &nbsp; &nbsp; &nbsp; &nbsp; <%=Helper.correctNull((String) hshValues.get("apaddress"))%><br>
			  &nbsp; &nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_city"))%><br>
			  &nbsp; &nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_state"))%><br>
             </p>
            <p>(Mortgagor/s)</p>
            <p><br>
              To,<br>
              <b>Karnataka Bank Ltd.</b><br>
            <%=Helper.correctNull((String) hshValues.get("branchName"))%> Branch<br>
          <%=Helper.correctNull((String) hshValues.get("cityName"))%><br> </p>
            <p>&nbsp;</p>
            <p>Dear Sirs,</p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="8%">&nbsp;</td>
                <td width="92%">I/We<%=Helper.correctNull((String) hshValues.get("appname"))%> residing 
                  at&nbsp; &nbsp; &nbsp; &nbsp; <%=Helper.correctNull((String) hshValues.get("apaddress"))%><br> hereby </td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td colspan="2"> 
                  <p align="justify">undertake and agree that________________ cents/acres of land 
                    in Survey No._____________of _____________ Village _________________. 
                    Taluk,______________ District already mortgaged by me/us to 
                    your Bank by way of equitable mortgage by deposit of title 
                    deeds created on ____________ at your - Branch will continue 
                    to be security to the' additional housing loan of Rs &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%>
                    granted to me/us.<br>
                  </p>
                  <p>&nbsp;</p>
                  <p>Place: <%=Helper.correctNull((String) hshValues.get("cityName"))%> <br>
      				 Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%><br>
                     </p>
                </td>
              </tr>
              <tr> 
                <td width="74%"> 
                  <p>&nbsp;</p>
                  </td>
                <td width="26%"> 
                  <p>Signature:</p>
                  <p>Name:</p>
                </td>
              </tr>
            </table>
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>
</body>
</html>
