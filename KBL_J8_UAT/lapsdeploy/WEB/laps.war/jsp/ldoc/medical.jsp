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
            <div align="right">Annexure VII</div>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td>
            <p>Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b><br>
            </p>
            <p>To <br>
              (Proposed/existing Housing Loan Borrower)<br>
              ________________________________________<br>
              ________________________________________<br>
              ________________________________________<br>
              ________________________________________ <br>
            </p>
          </td>
          <td>From:(Please write complete postal address)<br>
            <b>Karnataka Bank Ltd.</b>.<br>
            ____________________________<br>
            ____________________________<br>
            <table width="71%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td>Tel.No</td>
                <td>Fax.No:</td>
              </tr>
            </table>
          Email Id</td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td>
            <div align="center">
              <table width="99%" border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td>Dear Sir/Madam,</td>
                </tr>
              </table>
              <br>
              <u><b>Group Life Insurance Scheme for Housing Loan Borrowers of 
              Karnataka Bank Ltd. Medical<br>
              Examination </b></u>
              <table width="98%" border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td>
                    <p>With reference to your request to be admitted to the captioned 
                      Scheme to avail of Life Insurance cover with regard to your 
                      Housing Loan Proposal/Loan Outstanding, we, on behalf 0f 
                      SBI Life, and as the Administrator of the Scheme, request 
                      you to undergo a medical examination on your health as given 
                      below (tick whichever is applicable):</p>
                    <table width="98%" border="1" cellspacing="0" cellpadding="5">
                      <tr> 
                        <td colspan="2">Sum Assured(Rs)</td>
                        <td width="72%" colspan="2">Age at entry</td>
                      </tr>
                      <tr> 
                        <td width="21%">&nbsp;</td>
                        <td width="7%">&nbsp;</td>
                        <td width="36%">18-45 years</td>
                        <td width="36%">46 years and above</td>
                      </tr>
                      <tr> 
                        <td width="21%">750001/- to 1500000/-</td>
                        <td width="7%">&nbsp;</td>
                        <td width="36%">FMR,ECG,SB115</td>
                        <td width="36%">FMR,ECO,SB115</td>
                      </tr>
                      <tr> 
                        <td width="21%">1500001/- to 3000000</td>
                        <td width="7%">&nbsp;</td>
                        <td width="36%">FMR,ECG,SB115</td>
                        <td width="36%">FMR,TMT,SB115</td>
                      </tr>
                      <tr>
                        <td width="21%">3000001/- to above</td>
                        <td width="7%">&nbsp;</td>
                        <td width="36%">FMR,TMT,SB115,Chest X Ray</td>
                        <td width="36%">FMR,TMT,SB115,Chest X Ray</td>
                      </tr>
                    </table>
                    <table width="98%" border="0" cellspacing="0" cellpadding="5">
                      <tr>
                        <td>2) <u><b>For this purpose, please call on any of SBI 
                          Life's authorized TPAs. Please take a prior appointment 
                          with the TPA before your visit the medical practioner. 
                          </b></u> 
                          <p>3. Please submit the attached introductory letter 
                            of SBI Life to the medical examiner and/or the clinic 
                            at the time of the test.</p>
                          <p>4. Kindly carry a suitable photo identity card (e.g. 
                            passport, driving license. employment identity card 
                            etc.), or any other suitable paper to prove your identity 
                            to the satisfaction of the medical examiner clinic.</p>
                          <p>5.Please do not Pay any charges for the medical examination/clinical 
                            test. The charge, \\'ill be settled directly by SBI 
                            Life.</p>
                          <p>6. Please note that in case of a proposal for housing 
                            loan under consideration of the Bank. this letter 
                            should in no way be construed or treated as an explicit 
                            or implicit approval or sanction of the proposal by 
                            the Bank. A decision on the housing loan proposal 
                            will be taken by the Bank at its sole discretion.</p>
                          <p>7.We shall advise you shortly about your admission 
                            into the Group Insurance Scheme after SBI Life: advises 
                            us in the matter and the Bank agrees to grant you 
                            a housing loan.<br>
                          </p>
                          <p>Yours sincerely,</p>
                          <p>&nbsp;</p>
                          <p><b>Branch Manager </b></p>
                          <p>&nbsp; </p>
                        </td>
                      </tr>
                    </table>
                    <p>&nbsp;</p>
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
      <br>
      <p>&nbsp;</p>
      
    </td>
  </tr>
</table>
</body>
</html>
