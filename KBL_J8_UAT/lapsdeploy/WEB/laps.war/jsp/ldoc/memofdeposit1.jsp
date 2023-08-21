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
      <div align="center"><u><b>MEMORANDUM OF DEPOSIT OF TITLE DEEDS (AD-13)</b></u></div>
    </td>
  </tr>
  <tr>
    <td>
      <div align="center">(For individuals, firms etc. other than companies)</div>
    </td>
  </tr>
</table>
<p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> 
      <p align=justify"><b><%=Helper.correctNull((String) hshValues.get("Title"))%></b><b> 
        <%=Helper.correctNull((String) hshValues.get("appname"))%></b> had called 
        on us on <b><%=date%> </b> day of <b><%=Months[a]%></b><b><%=year%></b> 
        and deposited with us acting for and on behalf of Karnataka Bank Ltd. 
        the under-mentioned title deeds, documents and writings pertaining to 
        his/their/firm&#146;s immovable property bearing Survey No________ situate 
        at&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133; While 
        making the deposit with us, Shri/Sarvasrhri &#133;&#133;&#133;&#133;&#133;&#133; 
        had stated that he/they deposited the documents as security for the repayment 
        to the Bank of all the mounts advanced or to be advanced and of all the 
        amounts under the various facilities granted or to be granted by the Bank 
        to the extent of Rupees<b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> 
        to Shri/Smt____________________and/or his/their firm of Messrs&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133; 
        &#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;.together with interest, 
        compound and/or additional interest in case of default, exchange fluctuation, 
        costs, charges, expenses, etc.</p>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>(Description of title deeds, documents and writings with dates and registration 
      numbers, parties names, etc</td>
  </tr>
</table>
<br>
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
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>Dated this <b><%=date%>th <%=Months[a]%>, <%=year%></b> </td>
  </tr>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="56%">&nbsp;</td>
    <td width="44%"><b>For Karnataka Bank Ltd.</b></td>  
  </tr>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="48%">&nbsp;</td>
    <td width="27%"> Signature of</td>
    <td width="25%"> Signature of</td>
  </tr>
  <tr> 
    <td width="48%">&nbsp;</td>
    <td width="27%"> Shri</td>
    <td width="25%"> Shri</td>
  </tr>
  <tr>
    <td width="48%">&nbsp;</td>
    <td width="27%"> Bank Officer </td>
    <td width="25%"> Bank Officer </td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
