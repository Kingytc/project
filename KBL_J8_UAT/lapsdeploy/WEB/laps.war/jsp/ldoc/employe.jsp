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
          <td>From: (Name of the Employer) 
            <p>&nbsp;</p>
            <p><br>
              To <br>
              The Chief Manager/Branch Manager, <br>
              <b>Karnataka Bank Ltd.,<br>
              </b>&nbsp;<%=Helper.correctNull((String) hshValues.get("branchName"))%> 
              Branch</p>
            <p>&nbsp;</p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="11%">Dear Sir</td>
                <td width="89%">&nbsp;</td>
              </tr>
              <tr>
                <td width="11%">&nbsp;</td>
                <td width="89%"><br>
                  <b>&quot;EMPLOYERS&quot; UNDERTAKING LETTER IN CONNECTION WITH 
                  LOAN SANCTIONED TO MR/MS <%=Helper.correctNull((String) hshValues.get("appname"))%> 
                  UNDER UNION MILES LOANS</b></td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td>Mr/Ms <%=Helper.correctNull((String) hshValues.get("appname"))%> 
                  is a permanent/confirmed employee of our Office since <%=Helper.correctNull((String) hshValues.get("appworksince"))%> 
                  years and presently working as <%=Helper.correctNull((String) hshValues.get("desig"))%>. 
                  Your communication regarding sanction of a Term Loan of Rs.<%=Helper.correctNull((String) hshValues.get("sancamount"))%> 
                  to the above named employee repayable in <%=Helper.correctNull((String) hshValues.get("loan_terms"))%> 
                  EMls of Rs. <%=Helper.correctNull((String) hshValues.get("loan_emi"))%> 
                  per installment commencing from <%=Helper.correctNull((String) hshValues.get("currentDate"))%> 
                  month carrying <%=Helper.correctNull((String) hshValues.get("mintrate"))%> 
                  interest @ fixed / floating p.a. is registered by us. 
                  <p>In this connection, we undertake -</p>
                  <p>1) To recover the loan installments from his/her salary and 
                    remit the same towards repayment of the loan every month till 
                    the closure of the entire loan with interest.</p>
                  <p>2) Not to release terminal benefits until a no due certificate 
                    is produced from your Bank by the abovenamed employee (OR) 
                    to recover the Bank dues/outstanding, If any, from the terminal 
                    benefits payable to employee in case of any eventuality / 
                    cessation in service.</p>
                  <p>3) Not to permit the abovenamed employee to shift his salary 
                    account with your Branch during currency of the loan.</p>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                      <td width="8%">&nbsp;</td>
                      <td width="92%"><b>This is an irrevocable undertaking given 
                        by us and the undersigned is competent to issue this letter 
                        to the financing Bank.</b></td>
                    </tr>
                  </table>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td width="69%"><br>
                        Thanking you,<br>
                        <br>
                        <br>
                        <br>
                        <br>
                      </td>
                      <td width="31%">Yours faithfully, 
                        <p><br>
                          (Signature) <br><%=Helper.correctNull((String) hshValues.get("appname"))%><br>
                          Seal:</p>
                      </td>
                    </tr>
                    <tr>
                      <td width="69%">
                        <p>&nbsp;</p>
                        <p>Place: <%=Helper.correctNull((String) hshValues.get("cityName"))%> <br>
 						     Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%></p>
                   
                      </td>
                      <td width="31%">&nbsp;</td>
                    </tr>
                  </table>
                  <p><br>
                  </p>
                </td>
              </tr>
            </table>
            <p><br>
            </p>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table> 
</body>
</html>
