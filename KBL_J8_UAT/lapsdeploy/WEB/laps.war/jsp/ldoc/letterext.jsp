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
            <div align="center"><b><u>LETTER OF EXTENSION OF MORTGAGE</u></b></div>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <table width="33%" border="0" cellspacing="0" cellpadding="5" height="85">
        <tr> 
          <td>The branch Manager/Chief manager</td>
        </tr>
        <tr>
          <td><b>Karnataka Bank Ltd.,</b></td>
        </tr>
        <tr>
          <td><b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b> 
            Branch,</td>
        </tr>
      </table>
      <p>Dear Sir,</p>
      <div align="center"> 
        <table width="66%" border="0" cellspacing="0" cellpadding="5" height="175">
          <tr> 
            <td>This is to confirm that I/we called on your Branch on_______________________________________</td>
          </tr>
          <tr> 
            <td>And deposited the title deeds/writings in respect of the below 
              described properties with an intent to create</td>
          </tr>
          <tr> 
            <td>equitable mortgage thereon,as security for due repayment of monies 
              lent/to be lent to me/us.</td>
          </tr>
        </table>
      </div>
      <p>&nbsp;</p>
      <div align="center">
        <table width="68%" border="1" cellspacing="0" cellpadding="5" height="223">
          <tr> 
            <td height="43">Regd.Sale Deed No.&amp; Date</td>
            <td>Name of the Property Holder</td>
            <td>Description of Property</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <p>&nbsp;</p>
        <table width="68%" border="0" cellspacing="0" cellpadding="5" height="73">
          <tr> 
            <td>While acknowledging our liability as mortgagors ,I/We agree to 
              extend the said equitable mortgage as </td>
          </tr>
          <tr>
            <td>security for due repayment of Top-up Loan sanctioned to me/us,by 
              the bank.</td>
          </tr>
        </table>
        <p>&nbsp;</p>
        <div align="right">
          <table width="22%" border="0" cellspacing="0" cellpadding="5" height="85">
            <tr> 
              <td height="41"><b>Signature of Executant[s]</b></td>
            </tr>
            <tr>
              <td height="51">Address of Executant[s]</td>
            </tr>
          </table>
          <div align="left">
            <table width="36%" border="0" cellspacing="0" cellpadding="5" height="89">
              <tr> 
                <td>Place: <b><%=Helper.correctNull((String) hshValues.get("cityName"))%></b></td>
              </tr>
              <tr>
                <td>Date: <b> <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
              </tr>
            </table>
          </div>
          <p>&nbsp;</p>
        </div>
        <p>&nbsp;</p>
      </div>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>

</body>
</html>
