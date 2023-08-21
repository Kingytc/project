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
            <div align="center"><b>Letter of Undertaking from Guarantor[s]</b></div>
          </td>
        </tr>
      </table>
      <p>The Branch Manager, <br>
        <b>Karnataka Bank Ltd.,</b><br>
        <b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b>  Branch</p>
      <p></p>
      <p>Dear Sir,</p>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td width="6%">&nbsp;</td>
          <td width="94%">Union Home Loan A/c. No.<br>
            Dated _____________________________ for Rs.______________________ 
            in the name of<br>
            _________________________________________________________________________ 
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
            <p align="justify"> 1.I/we understand that as a pre-condition, relating to grant of 
              the loans/advances/other nonfund based credit facilities Mr./Ms/M/s 
              ___________________ and furnishing guarantee in relation thereto, 
              your Bank requires consent of the guarantor/s of the credit facility, 
              granted/to be granted by the bank for the disclosure of information 
              and data relating to guarantor/s, any credit facility availed of 
              by the guarantor/s obligations assumed/to be assumed by me/us, in 
              relation thereto and default, if any, committed by me/us, in discharge 
              thereof.</p>
            <p><br>
              2. Accordingly, I/we hereby agree and give consent for the disclosure 
              by your Bank of an or any such<br>
            </p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="5%">&nbsp;</td>
                <td width="95%">[i] information and data relating to me/us <br>
                  [ii] the information or data relating to my / our obligations 
                  in any credit facility granted/to be granted by the bank and 
                  guaranteed by me/us, as guarantor and <br>
                  [iii] default, if any, committed by me/us in discharge of my/our 
                  such obligation<br>
                </td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td height="85" colspan="2"><p align="justify">as the_______________________ bank 
                  may deem appropriate and necessary to disclose and furnish to 
                  Credit Information Bureau (India) Limited and any other agency 
                  authorized in this behalf by Reserve Bank of India</p> 
                  
                </td>
              </tr>
              <tr> 
                <td colspan="2">3. I/we declare that the information and data 
                  furnished by me/us to your Bank are true and correct </td>
              </tr>
              <tr> 
                <td colspan="2">4. I/we undertake that: 
                  <p align="justify">[a] the Credit Information Bureau [India ] Limited and any 
                    other agency so authorized may use, process the said information 
                    and data disclosed by the Bank in the manner as deemed fit 
                    by them and</p>
                  <p align="justify">[b] the Credit Information Bureau [India] Limited and any 
                    other agency so authorized may furnish for consideration, 
                    the processed information and data or products thereof prepared 
                    by them, to Banks/financial Institutions and other credit 
                    grantors or registered users, as may be specified by the Reserve 
                    Bank of India in this behalf<br>
                  </p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
              </tr>
              <tr> 
                <td width="66%">
                  <p><br>
                  </p>
                  <p>&nbsp;</p>
                  <p>Place: <b><%=Helper.correctNull((String) hshValues.get("cityName"))%></b><br>
                    Date <b> <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></p>
                </td>
                <td width="34%">
                  <p>Yours faithfully,</p>
                  <p>&nbsp;</p>
                  <p>Signature of Guarantor[s]</p>
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
