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
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td align="center" colspan="3">
      <div align="right"><u><b>FORMAT -10</b></u></div>
    </td>
  </tr>
   <tr> 
    <td  colspan="3" align = "center"><u><b>FORMAT OF AFFIDAVIT IN LIEU OF I.T.C.</b><br>
      (Annexure -I to I.C. No. 6118 Dated November 15, 2000)</u></td>
  </tr>
 <tr> 
    <td  colspan="3" align = "center">
(Draft of affidavit to be obtained where income tax Clearance Certificate not produced
(To be executed subsequent to the date of creation of E.M.)<br>
<u>(Where there are more than one mortgagor, this affidavit has to be suitably modified)</u>
</td></tr>
<tr>
    <td colspan="3" align="center"><u><b>AFFIDAVIT<br>
      </b></u></td>
  </tr>
<tr>
    <td colspan="3">I, Shri----------------------------------------------------Son 
      of Shri--------------------aged <b><%=Helper.correctNull((String) hshValues.get("agecal"))%> </b>years, Occupation ------------------residing 
      at------------------ ----------------------------------------------------------------do 
      solemnly affirm and state as follows: </td>
  </tr>
<tr><td colspan="3">I am the absolute owner of the immovable property situated at -----------------------------------------------------------------. On   /  /   , I had deposited with Karnataka Bank Ltd. the title deeds pertaining to my immovable property situated at--------------------------------------------with intention to create security for the repayment of the loans availed by me/M/s ------------------------- While creating the said equitable mortgage I had already informed Karnataka Bank Ltd.  that neither any proceeding under the Income Tax Act is pending against me nor any such proceeding is contemplated  against me and that   no notice under Rule 2 of Schedule II of the Income Tax Act is served on me and no arrears of tax or  any other sums are pending payable by me to the Income Tax Department.
</td></tr>
<tr>
    <td colspan="3" align="right"><b>DEPONENT</b></td>
  </tr>
<tr>
    <td colspan="3">Solemnly affirmed at ________this<b> <%=date%>th <%=Months[a]%>, 
      <%=year%></b>. and the deponent signed before me .</td>
  </tr>





</table>
</body>
</html>
