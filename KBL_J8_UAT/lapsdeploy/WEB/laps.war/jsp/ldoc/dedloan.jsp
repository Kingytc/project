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
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="5%">From:</td>
                <td width="95%">&nbsp;</td>
              </tr>
              <tr>
                <td width="5%">&nbsp;</td>
                <td width="95%"><br>
                  ____________________<br>
                  ____________________<br>
                  ____________________<br>
                  ____________________ </td>
              </tr>
            </table>
             
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="4%">To, </td>
                <td width="96%">&nbsp;</td>
              </tr>
              <tr>
                <td width="4%">&nbsp;</td>
                <td width="96%"><br>
                  The Chief / Branch Manager,<br>
                  <b>KARNATAKA BANK LTD.,</b><br>
                  <%=Helper.correctNull((String)hshValues.get("branchName"))%> 
                  BRANCH.<br>
                </td>
              </tr>
            </table>
            
            <p>Dear Sir,</p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="6%">&nbsp;</td>
                <td width="94%">
                  <p align="justify"> SUB: Employers' undertaking letter in connection 
                    with Loan Sanctioned to Shri ____________________ under Union 
                    Home / Union Miles / Union Comfort Scheme <br>
                  </p>
                   </td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="6%">&nbsp;</td>
                <td width="94%">
                  <p align="justify">Mr./Ms.<%=Helper.correctNull((String)hshValues.get("appname"))%> 
                    is a permanent I confirmed employee of our Office since <%=Helper.correctNull((String)hshValues.get("appworksince"))%> 
                    years and presently working as <b><%=Helper.correctNull((String)hshValues.get("desig"))%></b> 
                    Your Communication regarding sanction of a Term Loan of Rs. 
                    <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
                    for the purpose of <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%></b> 
                    to the above employee repayable in <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("loan_noofinstallment"))%></b> 
                    EMls of Rs.<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("loanEmi"))%></b> 
                    per installment commencing from ________________________ month 
                    carrying a fixed I float interest @.<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("mintrate"))%></b> 
                    %p.a. is registered by us.<br>
                  </p>
                </td>
              </tr>
              <tr> 
                <td width="6%">&nbsp;</td>
                <td width="94%">
                  <p align="justify">In this connection, we undertake to recover 
                    the loan installments from his I her salary and remit the 
                    same towards repayment of the loan, every month till the closure 
                    of the entire loan with interest.<br>
                  </p>
                </td>
              </tr>
               
              <tr> 
                <td width="6%">&nbsp;</td>
                <td width="94%"><p align="justify">To recover all dues from the terminal benefits 
                  payable to the above named.</p></td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="34%">&nbsp;</td>
                <td width="5%">OR</td>
                <td width="61%">&nbsp;</td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
            
              <tr>
                <td colspan="2">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="5%">&nbsp;</td>
                      <td width="95%"><p align="justify">Not to release terminal benifits until a 
                        no due certificate is produced from bank by the above 
                        named employee.</p></td>
                    </tr>
                  </table>
                  <br>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="5%">&nbsp;</td>
                      <td width="95%"><p align="justify">Not to Permit the above named employee to 
                        shift his salary account with your branch during currency 
                        of the loan.</p></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="5%">&nbsp;</td>
                <td width="95%"><p align="justify">This is an irrevocable undertaking given by us 
                  and the undersigned is competent to issue this letter to the 
                  financing Bank.</p></td>
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
    						  Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%> </td>
                <td width="38%">(SIGNATURE)<br>
                  &amp;<br>
                  SEAL</td>
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
