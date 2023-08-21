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
<form name="form1" method="post" action="">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td colspan="2"> 
        <div align="right"><b>FORMAT 29</b></div>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <div align="center"><b>LETTER OF UNDERTAKING/FRESH PROMISE IN CASES OF<br>
          TIME-BARRED DEBTS<br>
          </b></div>
      </td>
    </tr>
    <tr> 
      <td width="5%">From:<br>
      </td>
      <td width="95%">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">
      </td>
    </tr>
    <tr>
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">To:<br>
      </td>
    </tr>
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="95%">The Branch Manager,
      </td>
    </tr>
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="95%">Karnataka Bank Ltd.,
      </td>
    </tr>
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="95%"><b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b>  Branch<br>
      </td>
    </tr>
    <tr> 
      <td colspan="2"><br>
        Sir, </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td><br>  <font face="Times New Roman" size="3"> 
              <p align="justify">  
        I / We, the undersigned, understand that a sum of Rs.________________ 
        is due from me / us as of today to KARNATAKA BANK (hereinafter called 
        as Bank) on account of the credit facility/ies viz., ____________________________________________ 
        availed by me/us originally on/from ______________________. Though the 
        Demand Promissory Note / Security documents which I /we had executed earlier 
        had crossed the period of limitation, I/we consciously undertake to pay 
        the Bank on demand, the sum of Rs._____________________ alongwith the 
        interest accrued till the date and to becharged hereafter @ ________________ 
        % or applicable from time to time as I/we would desire to continue the 
        good relation with the Bank and in consideration of your forbearing to 
        resort to any legal action/RR action or any other proceedings against 
        me/us, I/we hereby agree to repay the loan/advance availed by me/us earlier 
        and in pursuance of this fresh promise to pay the debt as stated above, 
        I / We am / are executing afresh a Demand Promissory Note for the amount 
        of Rs. ____________________ being outstanding as of today in my / our 
        name.</p> </font> <br>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2"><br>
        Place: <b> <%=Helper.correctNull((String) hshValues.get("cityName"))%></b><br>
      </td>
    </tr>
    <tr> 
      <td colspan="2">Date : <b> <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"><b>SIGNATURE/S</b></div>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
  </table>
</form>
</body>
</html>