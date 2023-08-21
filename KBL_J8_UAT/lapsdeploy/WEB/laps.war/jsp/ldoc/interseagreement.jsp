
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
String date=Helper.correctNull((String)hshValues.get("Date"));
String Month=Helper.correctNull((String)hshValues.get("Month"));
String year=Helper.correctNull((String)hshValues.get("year"));

String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
int a=Integer.parseInt(Month);
%>


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> 
      <div align="right"><b><u>FORMAT 21 </u></b></div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center"><u><b>INTER-SE AGREEMENT TO BE EXECUTED BY</b></u></div>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center"><b><u>THE MEMBERS OF THE SELF HELP GROUP</u></b></div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="right"><b>(Annexure I to IC 6119 dt. 16.11.2000 on Self-Help 
        Groups)</b></div>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> 
      <div align="right">[To be stamped as a general power of attorney]</div>
    </td>
  </tr>
</table>
<p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>THIS AGREEMENT made ____________________this<b> <%=date%>th <%=Months[a]%>, 
      <%=year%></b> Between</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
   <td width="4%" valign="top">(ii)</td><td>Shri/Smt.Kum/_____________________________________________________<br>
      Son/Wife/Daughter of___________________________________________; aged ________________years 
      residing at __________________________; and </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
   <td width="4%" valign="top">(ii)</td><td> Shri/Smt.Kum/_____________________________________________________<br>
      Son/Wife/Daughter of___________________________________________; aged ________________years 
      residing at __________________________; and </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td> Shri/Smt.Kum/_____________________________________________________<br>
      Son/Wife/Daughter of___________________________________________; aged ________________years 
      residing at __________________________; and <br>
      etc.</td>
  </tr>
</table>
<p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>Who are members of the -------------------group, hereinafter referred 
      to collectively as &#147;The Self-Help Group (SHG) Members&#148;, which 
      expression shall, unless repugnant to the context or meaning, include every 
      member of the said SHG and their respective legal heirs, executors and administrators.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>WHEREAS all SHG members are residents of ____________Village in _________ 
      taluka of the __________________________State and are known to each other.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>WHEREAS the SHG members above named have joined voluntarily together and 
      formed the SHG with intent to carry on savings and credit and other economic 
      activities for mutual benefit subject to the terms and conditions hereinafter 
      appearing;</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>NOW THEREFORE THIS AGREEMENT WITNESSTH THAT:-</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td> Each member of the SHG shall save a sum of Rs.<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b>  
      (Rupees <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> </b> only) or such 
      sum as may be decided by the Group, on weekly/fortnightly/monthly basis 
      which shall be deposited with the authorised member of the group.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="4%" valign="top">(ii) Each member shall strive for the success 
      of the SHG and shall not act in a manner detrimental to the business interests 
      of the SHG.</td>
  </tr>
  <tr> 
    <td>(ii) The SHG members shall be jointly and severally liable for all the 
      debts contracted by the SHG.</td>
  </tr>
  <tr> 
    <td>(ii) All assets and goods acquired by the SHG shall be in the joint ownership 
      of all the members of the SHG and shall ordinarily be in the constructive 
      custody of such member as may be authorised by the Group and shall be kept 
      at the place of business at _______________which shall not be changed without 
      consent of the SHG members.<br>
    </td>
  </tr>
  <tr> 
    <td>(ii) The SHG members hereby duly elect and appoint <br>
    </td>
  </tr>
  <tr>
    <td>Shri/Smt/Kum._______________________________________as____________,<br>
      Shri/Smt/Kum________________________________________as ___________,<br>
      Shri/Smt/Kum________________________________________as ___________, </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>by whatever name designated to look after and manage the day to day affairs 
      of the SHG&#146;s activities and also act in their name and on their behalf 
      in all matters relating thereto. The authorised representatives, may however, 
      be removed at any time by majority vote of the members and new representatives 
      elected.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td> Each of the SHG members hereby agrees to abide by and ratify all 
      such acts, deeds and things as the authorised representatives may be in 
      the interest of the said activities.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td width="4%" valign="top">(ii)</td><td>The authorised representatives shall take decisions in the day to 
      day working of the SHG and each representative shall actively involve herself 
      or himself and co-operate in looking after the day-to-day affairs of the 
      SHG activities in particular to attend to the following activities: 
      <p>Every member of the SHG hereby authorises the representative to apply 
        for the loan on behalf of the SHG and execute necessary agreements/documents 
        on behalf of the SHG for the purpose. The authorised representative may 
        collect loan amounts from the bank on behalf of SHG, deposit the same 
        in the savings account of the SHG for on lending to members in accordance 
        with the decision of the SHG and also deposit recovery of loan instalment 
        from members in the loan account/s of SHG with the bank.</p>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>(ii) The SHG members hereby specifically authorise the representatives:</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%">&nbsp;</td>
    <td width="96%">(ii) To open Savings, Fixed Deposits and other accounts in 
      (......................) Bank approved by the SHG and operate the same under 
      the joint signature of any two of the following authorised representatives.<br>
      <br>
      Shri/Smt/Kum._______________________________<br>
      Shri/Smt/Kum________________________________<br>
      Shri/Smt/Kum________________________________
      <p>(ii) To keep or cause to be kept proper book of accounts of the savings, 
        made by the SHG Members, loans granted to them and the recoveries made 
        from them and render every year the full accounts to the SHG members for 
        their approval and adoption;</p>
      <p>(ii) To receive all payments due to the SHG and issue requisite receipts 
        or acknowledgements for and on behalf of the SHG;</p>
      <p>(ii) To institute and defend on behalf of the SHG members any legal proceedings 
        and safeguard the interests of each member of the said SHG and for this 
        purpose engage or disengage any lawyer or advocate or agent and incur 
        the necessary legal expenses in connection therewith.</p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
   <td width="4%" valign="top">(ii)</td><td> In the event of death of any of the members of the SHG, his/her legal 
      heirs shall be entitled for the benefits and be liable for the obligations 
      of the deceased member under this agreement.</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td> It is agreed that no new person shall be inducted as a member of 
      the SHG without consent of all the existing members. </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>IN WITNESS WHEREOF the aforesaid members of the SHG have set their respective 
      hands hereunto at the place <b><%=Helper.correctNull((String) hshValues.get("cityName"))%></b> and on <b><%=Helper.correctNull((String) hshValues.get("Date"))%></b>day of <b><%=Helper.correctNull((String) hshValues.get("Month"))%></b> month 
      <b><%=Helper.correctNull((String) hshValues.get("year"))%></b> year first herein appearing.</td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>Name of members of SHG</td>
  </tr>
</table>
<p>&nbsp;</p>
<p><br>
</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> 
      <div align="right">Signature/s/Thumb impression/s of <br>
        Members of the SHG</div>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>(1)</td>
  </tr>
  <tr>
    <td>(2)</td>
  </tr>
  <tr>
    <td>(3)</td>
  </tr>
  <tr>
    <td>(4)</td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>(20)</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><b>WITNESSES:-</b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>1.</td>
  </tr>
  <tr>
    <td>2.</td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
