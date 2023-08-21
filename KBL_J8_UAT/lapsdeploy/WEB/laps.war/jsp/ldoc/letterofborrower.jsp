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
            <div align="center"><b>Letter of Undertaking from Borrower[s]</b></div>
          </td>
        </tr>
      </table>
      <p>The Branch Manager, <br>
        <b>Karnataka Bank Ltd.,</b><br>
        &nbsp;<b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b>   Branch</p>
      <p></p>
      <p>Dear Sir,</p>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td width="6%">&nbsp;</td>
          <td width="94%"> Union Home Loan A/c. No. <%=Helper.correctNull((String) hshValues.get("perapp_bankaccno"))%> <br>
            Dated <%=Helper.correctNull((String) hshValues.get("currentDate"))%> for Rs.&nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%>
            in the name of<br> <%=Helper.correctNull((String) hshValues.get("appname"))%>
            <br>
          </td>
        </tr>
        <tr>
          <td width="6%">&nbsp;</td>
          <td width="94%"><b>With reference to the above, I/we hereby undertake/authorize 
            the following:</b></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td> 
            <p> 1.I/We, understand that as a pre-condition, relating to grant 
              of loans/advances/other non-fundbased credit facilities to me/us, 
              the'_____________ bank_name bank, requires my/our consent for the disclosure 
              by the bank of information and data relating to me/us, of the credit 
              facility availed of/ to availed, by me/us, obligations assumed/ 
              to be assumed, by me/us, in relation thereto and default, if any, 
              committed by me/us, in discharge thereof.<br>
              <br>
              2. Accordingly, I/We, hereby agree and give consent for the disclosure 
              by the _______________________ bank of all or any such;</p>
            <p></p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="5%">&nbsp;</td>
                <td width="95%">(a) information and data relating to me/us;
                  <p>(b) the information or data relating to any credit facility 
                    availed of/ to be availed, by me/us, and</p>
                  <p>(c) default, if any, committed by me/us, in discharge of 
                    my/our such obligation.</p>
                  <p></p>
                </td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td height="85" colspan="2">as the________________ bank may deem 
                  appropriate and necessary, to disclose and furnished to Credit 
                  information Bureau (India) Ltd. and any other agency authorized 
                  in this behalf by RBI.
                  <p></p>
                  <p><br>
                  </p>
                </td>
              </tr>
              <tr> 
                <td colspan="2">3. I/We, declare that the information and data 
                  furnished by me/us to the<b><font size="+3">.</font></b> ____________________________ 
                  bank are true and correct.<br>
                </td>
              </tr>
              <tr> 
                <td colspan="2"> 
                  <p>4. I/We, undertake that:</p>
                  <p>(a) the Credit Information Bureau (India) Ltd. and any other 
                    agency so authorized may use, process the said information 
                    and data disclosed by the bank in the manner as deemed fit 
                    by them; and</p>
                  <p>(b) the Credit Information Bureau (India) Ltd. and any other 
                    agency so authorized may furnished for consideration, the 
                    processed information and data or products thereof prepared 
                    by them, to banks/financial institutions and other credit 
                    grantors or registered users, as may be specified by the Reserve 
                    Bank in this behalf.<br>
                  </p>
                  <p>&nbsp;</p>
                  <p><b><font size="+3">.</font></b>The expression 'bank' includes 
                    lending institutions for the purpose. </p>
                </td>
              </tr>
              <tr> 
                <td width="66%">
                  <p><br>
                  </p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
                <td width="34%">
                  <p>Yours faithfully,</p>
                  <p>&nbsp;</p>
                  
                   <%=Helper.correctNull((String) hshValues.get("appname"))%>
                  <p>Signature of Borrower[s]</p>
                </td>
              </tr>
            </table>
            <p> </p>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>
</body>
</html>
