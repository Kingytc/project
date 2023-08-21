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
            <p><b><u>LETTER OF UNDERTAKING FROM PARTNERS </u>(AD-11) <br>
              (Advances To Partnership Accounts)</b></p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="73%">&nbsp;</td>
                <td width="27%"> 
                  <p>Place:<%=Helper.correctNull((String)hshValues.get("branchName"))%></p>
                  <p>Date:<%=Helper.correctNull((String)hshValues.get("currentDate"))%></p>
          </td>
              </tr>
            </table>
            To, <br>
            The Branch Manager,<br>
              <b>Karnataka Bank Ltd.,</b><br>
              <%=Helper.correctNull((String)hshValues.get("branchName"))%> Branch
            <p>Sir,<br>
            </p>
            <p align="center"><b>Sub: <u>Letter of Undertaking </u></b></p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td>
                  <p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;In consideration of the Bank having 
                    advanced to us Cash Credit (Hyp) facility to the extent of 
                    Rs._______________________________________<br>
                    (Rupees______________________only) we have executed the hypothecation 
                    agreement dated ___________________________ whereby we have 
                    hypothecated the firm's machinery/stocks which are more particularly 
                    set out in the schedule to the aforesaid Hypothecation Agreement.</p>
                  <p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This it to confirm to the Bank 
                    specifically that there are no charges/encumbrances over the 
                    firm's machinery/stock other than those charge in your favour 
                    covered by the Hypothecation Agreement. We hereby further 
                    undertake that till such time our liability to the Bank is 
                    outstanding, we will not create any charge / further charge 
                    in any manner whatsoever on the partner's stake and investments 
                    in the firm and also on the capital of the firm without the 
                    Bank's prior written consent.</p>
                </td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td>(Full Names)<br> <%=Helper.correctNull((String) hshValues.get("appname"))%> </td>
                <td>(Signatures) <br> <%=Helper.correctNull((String) hshValues.get("appname"))%> </td>
              </tr>
            </table>
            <p align="center">&nbsp;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
