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
            <p><b>LETTER TO BE OBTAINED FROM THE DIRECTORS IN CASES WHERE ADVANCES 
              HAVE BEEN PERMITTED TO PRIVATE LIMITED/LIMITED COMPANIES (AD-10)</b></p>
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="73%">&nbsp;</td>
                <td width="27%">Date :<%=Helper.correctNull((String) hshValues.get("currentDate"))%></td>
              </tr>
            </table>
            <p><b>Karnataka Bank Ltd.</b><br>
              <b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b> Branch</p>
            <p>Dear Sirs,</p>
            <p align="center"><b>Credit Facilities/Accommodation </b><br>
              Granted by the Bank</p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td>
                  <p align="justify">In consideration of Karnataka Bank Ltd. having granted/or 
                    agreed to grant in favour of ___________________________ various 
                    credit facilities and/or any other Banking accommodation from 
                    time to time as may be required by the said _______________________________ 
                    and conveyed by the Bank, I/we, the undersigned, do hereby 
                    undertake to abide as follows:</p>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                      <td width="9%">&nbsp;</td>
                      <td width="91%"><p align="justify">1.that in the event of the said Company 
                        . having depicted cash losses or adverse current Ratio 
                        or any other adverse features as may be apparent to the 
                        Bank, like diversion of funds, etc, we, the undersigned, 
                        in our capacity as the Directors of the company, do hereby 
                        undertake to execute the guarantees in our joint and several 
                        personal capacities to the Bank against the various credit 
                        facilities sanctioned or to be sanctioned by Union Bank 
                        of India to the said Company and/or any other banking 
                        accommodation from time to time to the said Company as 
                        and when called upon by the Bank.<br>
                        <br>
                        2. I/We hereby declare that lINe shall not receive any 
                        consideration by way of commission, brokerage, fees or 
                        in any other form from the said Company and I/we hereby 
                        undertake that until such time as I/We shall be liable 
                        under the aforesaid Letter of Guarantee or any other Letter 
                        of Guarantee that I/we may execute at anytime, I/we shall 
                        not demand any commission, brokerage, fees or any other 
                        consideration in any form from the said Company for continuing 
                        my/our aforesaid guarantee or executing any other guarantee.<br></p>
                      </td>
                    </tr>
                  </table>
                  <p align="right">Yours faithfully,</p>
                  <p align="right">&nbsp;</p>
                  <table width="100%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td width="54%">&nbsp;</td>
                      <td width="30%">Full Name</td>
                      <td width="16%">Signature</td>
                    </tr>
                  </table>
                  <p align="right">&nbsp;</p>
                </td>
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
