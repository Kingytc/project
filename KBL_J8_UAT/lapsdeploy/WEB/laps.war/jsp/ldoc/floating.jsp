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
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="5" height="1011">
  <tr>
    <td height="1018"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td width="81%" rowspan="2"> 
            <p><b><u>DP NOTE Floating Rate of Interest:</u></b></p>
            <p>&nbsp;</p>
            <p align="center"><b> JOINT INDIVIDUALS<br>
              <br>
              <br>
              <br>
              <br>
              <br>
              </b></p>
          </td>
          <td width="19%" height="44">&nbsp;</td>
        </tr>
        <tr>
          <td width="19%" height="2"><br>
            <br>
            Place: <%=Helper.correctNull((String) hshValues.get("cityName"))%> <br>
      Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%> </td>

        </tr>
      </table>
      <p>Rs:&nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></p>
      <p> On demand,I &nbsp; <%=Helper.correctNull((String) hshValues.get("appname"))%> promise 
        to pay KARNATAKA BANK or order sum of Rupees &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%> together 
        with interest on such sum from this date at the rate of<%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%>% 
        over Karnataka Bank's Prime Lending Rate or such other rates as may 
        be prescribed by the Bank from time to time with a minimum of <%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%>% 
        per annum with <b><%=loanperiodicity %></b> rests for value received</p>
      <p>&nbsp;</p>
      <div align="right">
        <table width="10%" border="1" cellspacing="0" cellpadding="5" height="69">
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
      <p>&nbsp;</p>
      <table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td width="86%" rowspan="2"> 
            <div align="center"> 
              <p><b>INDIVIDUALS</b></p>
              <p><br>
                <br>
                <br>
              </p>
            </div>
          </td>
          <td width="14%"><br>
          </td>
        </tr>
        <tr>
          <td width="14%">Place:<%=Helper.correctNull((String) hshValues.get("cityName"))%> <br>
      Date: <%=Helper.correctNull((String) hshValues.get("currentDate"))%> </td>
      
        </tr>
      </table>
      <p>Rs: &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%> <br>
      </p>
      <p>On demand,I &nbsp; <%=Helper.correctNull((String) hshValues.get("appname"))%> promise 
        to pay Karnataka Bank or order sum of Rupees &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%> together 
        with interest on such sum from this date at the rate of<%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%>% 
        over Karnataka Bank's Prime Lending Rate or such other rates as may 
        be prescribed by the Bank from time to time with a minimum of <%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%>% 
        per annum with <b><%=loanperiodicity %></b> rests for value received</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <div align="right">
        <table width="9%" border="1" cellspacing="0" cellpadding="5" height="70">
          <tr> 
            <td>
              <div align="center">Revenue <br>
                Stamp</div>
            </td>
          </tr>
        </table>
      </div>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
</table> 
</body>   
</html>
