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
    <td  align="center"><b>DECLARATION OF JOINT FAMILY (AD-08)</b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="69%" align="right">Date  </td>
    <td width="31%"><b>: <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
  </tr>
  <tr>
    <td width="69%" align="right" height="16"><font face="Times New Roman" size="3">Place</font></td>
    <td width="31%" height="16"><b>: <%=Helper.correctNull((String) hshValues.get("cityName"))%></b></td>
  </tr>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">To, </td>
    <td width="95%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="95%"><b>Karnataka Bank Ltd. </b></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="62%"><font face="Times New Roman" size="3"><%=Helper.correctNull((String) hshValues.get("branchName"))%></font> 
      Branch</td>
    <td width="33%">&nbsp; </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="5%" valign="top">1.</td>
    <td width="95%"> 
      <p align="justify"><font face="Times New Roman" size="3"> WHEREAS the Hindu 
        Undivided Family of _______________________(hereinafter called the &#147;the 
        said joint family&#148;) carrying on business in the firm name and style 
        of __________________ ____________________________________at_____________________________ 
        or elsewhere (hereinafter referred to as &#147;the said HUF firm&#148;) 
        have or desire to have dealings with the Karnataka Bank Ltd. (hereinafter 
        referred to as &#147;the Bank&#148;) we, the undersigned, hereby declare:</font><br>
        <br>
      </p>
    </td>
  </tr> 
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="4%" valign="top">a)</td>
    <td width="91%">
      <p align="justify"> <font face="Times New Roman" size="3">that we are the present adult co-parceners of the said 
        joint family;</font><br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="4%"  valign="top">b)</td>
    <td width="91%">
      <p align="justify"> <font face="Times New Roman" size="3">that ________________________ is the present Karta or 
        Manager of the said joint family;</font><br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="4%"  valign="top">b)</td>
    <td width="91%">
      <p align="justify"><font face="Times New Roman" size="3"> that the business carried on by the said HUF firm is 
        the ancestral business of the said joint family; and</font><br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="4%" valign="top">d)</td>
    <td width="91%">
      <p align="justify"><font face="Times New Roman" size="3">that each one of us have full and unrestricted authority 
        to act on behalf of, and bind, the said HUF firm and all the present as 
        well as future members, both adults and minors of the said joint family, 
        howsoever constituted from time to time.</font><br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="5%" valign="top">2</td>
    <td width="4%" valign="top">&nbsp;</td>
    <td width="91%">
      <p align="justify"><font face="Times New Roman" size="3">We confirm that the affairs of the said joint family 
        and the business of the said HUF firm are carried on mainly by the Karta, 
        the said __________________ on behalf of and in the interests and for 
        the benefit of all the co-parceners of the said family. We are however 
        jointly and severally responsible for all liabilities of the said HUF 
        firm to the Bank and agree and confirm that any claim due to the Bank 
        from the said HUF firm shall be recoverable from the assets of any or 
        all of us and also from the estate of the said joint family including 
        the interest thereon of every co-parcener of the said Joint Family including 
        the share of the minor co-parceners if any.</font><br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="5%" valign="top">3</td>
    <td width="4%" valign="top">&nbsp;</td>
    <td width="91%">
      <p align="justify"><font face="Times New Roman" size="3">we undertake to advise the Bank in writing of any change 
        that may occur in the karta-ship/managership of in the constitution of 
        the said joint family or of the said HUF firm and until receipt of such 
        notice by the Bank, the Bank will be entitled to regard each of us as 
        member of said joint family and partners of the said HUF firm and all 
        acts, dealings and transactions purporting to have been done on behalf 
        of the said joint family or of the said joint family and partner of the 
        said HUF firm before the Bank shall have received notice in the manner 
        aforesaid shall be binding on the said joint family and the said HUF firm 
        and each one of us as such members of the said joint family or such partner 
        of the said HUF firm and on other respective estates. We shall, however, 
        continue to be liable jointly and severally to the Bank for all dues and 
        obligations of the said HUF firm in the Bank&#146;s books on the date 
        of the receipt of such notice by the Bank and that all such dues and obligations 
        shall have been liquidated and discharged.</font><br>
      </p>
    </td>
  </tr>
  <tr>
    <td width="5%" valign="top">4</td>
    <td width="4%" valign="top">&nbsp;</td>
    <td width="91%">
      <p align="justify"><font face="Times New Roman" size="3">The names and dates of birth of the present minor co-parceners 
        of the said joint family are given below and we undertake to inform you 
        in writing as and when each of the said members attains the age of majority 
        and is authorized to act on behalf of the said HUF firm</font><br>
      </p>
    </td>
  </tr>
</table>
<br>
  <table width="83%" border="0" cellspacing="0" cellpadding="3">
    <tr> 
      <td align="center" width="36%"><font face="Times New Roman" size="3">Name of the Minor </font></td>
      <td align="center" width="36%"><font face="Times New Roman" size="3">Father&#146;s name</font> </td>
      <td align="center" width="28%"><font face="Times New Roman" size="3">Date of Birth</font></td>
    </tr>
    <tr> 
      <td width="36%">_______________________</td>
      <td width="36%">______________________</td>
      <td width="28%">______________________</td>
    </tr>
    <tr> 
      <td width="36%">_______________________</td>
      <td width="36%">_______________________</td>
      <td width="28%">_______________________</td>
    </tr>
    <tr> 
      <td width="36%">_______________________</td>
      <td width="36%">_______________________</td>
      <td width="28%">_______________________</td>
    </tr>
    <tr> 
      <td width="36%">_______________________</td>
      <td width="36%">_______________________</td>
      <td width="28%">_______________________</td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr>
      <td width="5%"  valign="top">5.</td>
      <td width="95%"><font face="Times New Roman" size="3">We have received and read a copy of the Bank&#146;s rules 
        for the Conduct of Current Deposit Accounts and we agree to comply with 
        and be bound by the said rules now in force or any changes that may be 
        made therein from time to time.</font></td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr>
      <td width="68%">&nbsp;</td>
      <td width="32%"><font face="Times New Roman" size="3">Yours faithfully,</font></td>
    </tr>
  </table>
 

</body>
</html>
