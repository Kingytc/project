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
<table width="100%" border="0" cellspacing="0" cellpadding="3">
<tr><td colspan="3" align="center"><u>Annexure A-1<br> (Contd?..Format  11)</u></td></tr>
<tr>
    <td colspan="3">Draft of letter to be addressed by the proposed borrower to 
      the First Lender ( who has granted the first home loan) <br>
    </td>
  </tr>
<tr>
    <td colspan="3" align="left">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="4%">From</td>
          <td width="96%">&nbsp;</td>
        </tr>
        <tr>
          <td width="4%">&nbsp;</td>
          <td width="96%"> <b><%=Helper.correctNull((String) hshValues.get("appname"))%></b>,<br>
            <b><%=Helper.correctNull((String) hshValues.get("perapp_address1"))%></b>,<br>
            <b><%=Helper.correctNull((String) hshValues.get("perapp_address2"))%></b><br>
            <b><%=Helper.correctNull((String) hshValues.get("perapp_address3"))%></b>,<br>
            <b><%=Helper.correctNull((String) hshValues.get("perapp_city"))%></b><br>
            <b><%=Helper.correctNull((String) hshValues.get("perapp_state"))%></b><br>
          </td>
        </tr>
      </table>
      <br>    
      ( Borrower/s)<br><br><br>
Annexure A-1 : Draft Letter to be addressed by the proposed Borrower to the First Lender</td></tr>
<tr>
    <td colspan="3" align="left">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="6%">To</td>
          <td width="94%">&nbsp;</td>
        </tr>
        <tr>
          <td width="6%">&nbsp;</td>
          <td width="94%"> 
            <b>KARNATAKA BANK LTD.</b><br>
            <b><%=Helper.correctNull((String)hshValues.get("branchName"))%> </b> Branch
            <br>
          </td>
        </tr>
      </table>
    </td>
  </tr>
<tr><td colspan="3" align="left">Dear Sir,<br><br></td></tr>
<tr>
    <td colspan="3" align="center"><b>Sub: Additional Housing Loan sanctioned 
      by Karnataka Bank Ltd.</b><br>
    </td>
  </tr>
<tr>
    <td colspan="3">
      <p align="justify">In terms of sanction Advice no-------------dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> 
        you had granted a housing loan of Rs <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
        on <%=Helper.correctNull((String) hshValues.get("currentDate"))%> and 
        in consideration of the same I/we had deposited the title deeds of the 
        house property at your office. To meet the additional cost of the project/extension 
        or modification of the house I/we have approached Karnataka Bank Ltd. 
        whose address is given below:<br>
        The said Karnataka Bank Ltd. has given an in-principle approval for sanction 
        of an additional loan of Rs<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
        interalia on the following conditions:</p> 
    </td>
  </tr>
<tr> 
    <td width="4%" valign="top">1)</td>
    <td colspan="9" width="96%">
      <p align="justify">Pari-passu first charge over the house-property to be 
        created in favour of Karnataka Bank Ltd. by constructive delivery of title 
        deeds which are already in deposit with you.<br>
      </p> 
    </td>
  </tr>	
<tr> 
    <td width="4%"  valign="top">2)</td>
    <td colspan="9" width="96%">
      <p align="justify">Additional home loan sanctioned by Karnataka Bank Ltd. 
        will involve a E.M.I. of Rs.---------commencing from <%=Helper.correctNull((String) hshValues.get("currentDate"))%><br>
      </p>
    </td>
  </tr>	
<tr> 
    <td colspan="9">
      <p align="justify">The draft documents to be executed for creation of pari-passu 
        charge as stipulated by Karnataka Bank Ltd. are enclosed herewith.<br>
      </p> 
    </td>
  </tr>	
<tr> 
<td colspan="9"><p align="justify">Kindly let us have your approval for the above terms. Kindly let us have your approval on the draft documents also.  Your reply may be addressed directly to Karnataka Bank Ltd.</p>
</td></tr>
<tr><td colspan="3" align="right">Yours truly,<br><br><br>
      <b>(Borrower/s)</b></td>
  </tr>
<tr><td colspan="3" align="left">Copy to :<br><br>
      <b>Karnataka Bank Ltd.</b><br>
      <b><%=Helper.correctNull((String)hshValues.get("branchName"))%></b> Branch<br>
      (Full Address)</td></tr>











</table>

</body>
</html>
