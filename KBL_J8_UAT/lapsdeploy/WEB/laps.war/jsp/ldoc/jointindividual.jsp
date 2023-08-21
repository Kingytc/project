<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
   String loanperiodicity=Helper.correctNull((String)hshValues.get("loan_periodicity"));
   
  if(loanperiodicity.equalsIgnoreCase("m"))
  { 
	  loanperiodicity="Monthly"; 
  }else if(loanperiodicity.equalsIgnoreCase("q"))
  {
	  loanperiodicity="Quarterly"; 
  }else if(loanperiodicity.equalsIgnoreCase("h"))
  {
	  loanperiodicity="Haly-Yearly"; 
  }else if(loanperiodicity.equalsIgnoreCase("y"))
  {
	  loanperiodicity="Yearly"; 
  }else if(loanperiodicity.equalsIgnoreCase("o"))
  {
	  loanperiodicity="Others"; 
  } 
  

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
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr> 
    <td colspan="2"><b>Fixed Rate of Interest</b></td>
  </tr>
  <tr> 
    <td width="661" rowspan="2"> 
      <p>&nbsp;</p>
      <p align="center"><b><u>JOINT INDIVIDUALS</u></b></p>
      <p align="center">&nbsp;</p>
    </td>
    <td width="305">&nbsp;</td>
  </tr>
  <tr> 
    <td width="305">Place: <%=Helper.correctNull((String) hshValues.get("cityName"))%> 
      <br>
      Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%> </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr> 
    <td colspan="2">Rs: &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></td>
  </tr>
  <tr> 
    <td width="76">&nbsp; </td>
    <td width="890">
      <p>&nbsp;</p>
      <p>On demand,we <%=Helper.correctNull((String) hshValues.get("appname"))%> 
        promise to pay KARNATAKA BANK LTD. or order sum of Rupees <%=Helper.correctNull((String) hshValues.get("sancamount"))%> 
        together with interest on such sum at the rate of &nbsp;<%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%> 
        % with <b><%=loanperiodicity%></b> rests,for value received.</p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" height="178">
  <tr>
    <td height="180"> 
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <div align="right">
        <table width="107" border="1" cellspacing="0" cellpadding="5" height="58">
          <tr> 
            <td> 
              <div align="center">Revenue <br>
                Stamp </div>
            </td>
          </tr>
        </table>
      </div>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr> 
    <td width="814" rowspan="2"> 
      <p>&nbsp;</p>
      <p align="center"><u><b> INDIVIDUALS</b></u></p>
      <p align="center">&nbsp;</p>
    </td>
    <td width="151" height="49">&nbsp;</td>
  </tr>
  <tr>
    <td width="151">Place: <%=Helper.correctNull((String) hshValues.get("cityName"))%><br>
      Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%> </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" height="277">
  <tr>
    <td height="287"> 
      <p>Rs:&nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></p>
      <p>On demand ,I  <%=Helper.correctNull((String) hshValues.get("appname"))%> promise 
        to pay KARNATAKA BANK LTD. or order sum of Rupees<%=Helper.correctNull((String) hshValues.get("sancamount"))%>
        together with interest on such sum at the rate of <%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%> % 
        with  <b><%=loanperiodicity%></b> rests,for value received.</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <div align="right">
        <table width="94" border="1" cellspacing="0" cellpadding="5" height="63">
          <tr> 
            <td> 
              <div align="center">Revenue <br>
                Stamp </div>
            </td>
          </tr>
        </table>
      </div>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      </td>
  </tr>
</table>
</body>
</html>
