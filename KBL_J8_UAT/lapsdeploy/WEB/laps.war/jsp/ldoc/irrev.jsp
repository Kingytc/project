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
            <p align="center"><br>
              <b>IRREVOCABLE UNDERTAKING</b></p>
            <p>From:<br>
              ____________________<br>
              ____________________<br>
              ____________________<br>
              ____________________ </p>
            <p>To, <br>
              The Chief / Branch Manager,<br>
              <b>KARNATAKA BANK LTD.</b>,<br>
               <%=Helper.correctNull((String)hshValues.get("branchName"))%> Branch.</p>
            <p>Dear Sir,</p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="6%">&nbsp;</td>
                <td width="94%">
                  <p><b> Employers' undertaking letter in connection with Loan 
                    Sanctioned to Shri ____________________ </b></p>
                  <p align="center"><b><u>under Union Mortgage Scheme</u></b><u><br>
                    </u> </p>
                </td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="7%">&nbsp;</td>
                <td width="93%">Mr./Ms.<b> <%=Helper.correctNull((String)hshValues.get("appname"))%> </b> is a permanent I confirmed 
                  employee of our Office since   <%=Helper.correctNull((String)hshValues.get("appworksince"))%> years and presently 
                  working as <b><%=Helper.correctNull((String)hshValues.get("desig"))%></b> Your Communication regarding sanction 
                  of a Term Loan of Rs. <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> for the purpose of <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%></b> 
                  to the above employee repayable in <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("loan_noofinstallment"))%></b>  EMls of Rs.<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("loanEmi"))%></b> 
                  per installment commencing from ________________________ month carrying a fixed I float interest @.<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("mintrate"))%></b> %p.a. is registered 
                  by you.</td>
              </tr>
              <tr> 
                <td width="7%">&nbsp;</td>
                <td width="93%">In this connection, we undertake to recover the 
                  loan installments from his /her salary and remit the same towards 
                </td>
              </tr>
              <tr> 
                <td colspan="2">repayment of the loan, every month till the closure 
                  of the entire loan with interest.</td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td colspan="2">Not to release terminal benifits until a no due 
                  certificate is produced from your Bank by the above named employee.</td>
              </tr>
              <tr>
                <td colspan="2">Not to Permit the above named employee to shift 
                  his salary account from your branch during currency of the loan.</td>
              </tr>
              <tr> 
                <td width="7%">&nbsp;</td>
                <td width="93%"><b>This is an irrevocable undertaking given by 
                  us and the undersigned is competent to issue this letter to 
                  the financing Bank.</b></td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="62%">
                  <p>&nbsp;</p>
                  <p>Thanking You,</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
                <td width="38%">
                  <p>Yours faithfully</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="62%">Place:<%=Helper.correctNull((String) hshValues.get("cityName"))%> <br>
    						  Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%></td>
                <td width="38%"><b>(SIGNATURE)<br>
                  &amp;<br>
                  SEAL</b></td>
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
    </td>
  </tr>
</table>
</body>
</html>
