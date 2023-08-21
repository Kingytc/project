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
      <td colspan="3">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <div align="center"><b>KARNATAKA BANK LTD.<br>
                </b></div>
            </td>
          </tr>
          <tr> 
            <td>
              
            <div align="center"><b>CENTRAL LAW DEPARTMENT</b></div>
            </td>
          </tr>
          <tr>
            <td>
              <div align="center">Motlibai Wadia Bldg., 22-D, S.A. Brelvi Street, 
                Bombay 23<br>
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="2"><br>
        Legal Circular letter CLD:PSP:276 </td>
      <td width="30%"><br>
        Date: <b>: <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">To : ALL BRANCHES/OFFICES<br>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div align="center"><b><br>
          NOTING OF MORTGAGE CHARGE CREATED<br>
          BY BORROWER/GUARANTOR WITH THE<br>
          <u>CONCERNED REVENUE AUTHORITIES<br>
          </u></b></div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="3%">&nbsp;</td>
            <td width="97%"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
              You are aware that for securing the loans/advances granted to the 
              borrowers, the bank obtains mortgage of immovable property from 
              the borrower/guarantor. After creation of the securities the charge 
              so created by the borrower/guarantor on their immovable properties 
              if noted in the revenue records maintained by Talathi/Gram Panchayat/City 
              Survey Office would serve as a notice to those who may subsequently 
              deal with the property.</p> </font> 
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
              Where the borrower executes and registers a simple mortgage, the 
              relevant extract of Index No. II is sent by the Sub-Registrar to 
              the concerned Village Officer/Talathi where the mortgaged property 
              is situated. This procedure takes considerably long time in the 
              office of the Sub-Registrar which consequently delays noting of 
              the charge. It is, therefore, in the interest of the bank that the 
              branch official obtains extract of Index II with the help of the 
              borrower and arranges to send it to the concerned revenue authorities 
              with a request to note the charge created in favour of the bank 
              in the revenue records. Where the property is situated within the 
              Gram Panchayat limits, or city survey limits, the concerned Gram 
              Panchayat/City Survey Officer should be informed about the creation 
              of charge by sending Index No. II tonote the same in their respective 
              records. A format of the letter to be addressed to the concerned 
              Talathi/Gram Panchayat/City Survey Officer is appended as Annexure 
              I </p> </font>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
              Where the borrower creates mortgage by deposit of title deeds with 
              the bank, much mortgage does not require registration as per Section 
              59 of the Transfer of Property Act and Section 17 of the Indian 
              Registration Act. In such cases the branch official should address 
              suitable letter to the concerned Talathi/Gram Panchayat/City Survey 
              Officer as the case may be which can be treated as vardi under the 
              provisions of State Land Revenue Code and the concerned authorities 
              will note the charge after following the procedure. A format of 
              the letter to be addressed to the concerned Talathi/Gram Panchayat/City 
              Survey Officer is appended as Annexure II. It should be carefully 
              noted that registration of a document with Sub-Registrar of Assurances 
              should not be confused with noting of charge with Talathi/Gram Panchayat/City 
              Survey Office.</p> </font>
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
              After creation of the mortgage by the borrower/guarantor, the branch 
              should inform the concerned Talathi/Gram Panchayat/City Survey Office 
              about noting the Bank&#146;s charge in their records. The branch 
              official should insist the borrower for production of the relevant 
              extracts from village Register No. 6, 7X12 Register, Property Card 
              Register issued by concerned authorities properly noting the charge 
              created in favour of the bank </p></font>  <br>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="3">
        <div align="right"><br>
          <br>
        <br>
        <b>CHIEF MANAGER (LAW)</b></div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"><br>
    </td>
    </tr>
    <tr>
      <td colspan="3">&nbsp;</td>
    </tr>
  </table>
</body>
</html>
