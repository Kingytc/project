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
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td colspan="2"><b><u>(SD-21G)______________________________________________________________________________________________________________</u></b></td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <div align="center"><b><font size="+1">PARTNERSHIP CLIENTS</font></b></div>
          </td>
        </tr>
        <tr> 
          <td width="60%">Rs.<%=Helper.correctNull((String)hshValues.get("sancamount"))%></td>
          <td width="40%">Place:<%=Helper.correctNull((String)hshValues.get("branchName"))%><br>
            Date:<b><%=Helper.correctNull((String)hshValues.get("Curdate"))%></b></td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
            <p align="justify">On demand,we&nbsp;<%=Helper.correctNull((String)hshValues.get("appName"))%> 
              ,<b><%=Helper.correctNull((String) hshValues.get("perapp_address1"))%></b>,<b><%=Helper.correctNull((String) hshValues.get("perapp_address2"))%></b>,<b><%=Helper.correctNull((String) hshValues.get("perapp_address3"))%></b>,<b><%=Helper.correctNull((String) hshValues.get("perapp_city"))%></b>,<b><%=Helper.correctNull((String) hshValues.get("perapp_state"))%></b> 
              Promise to pay jointly and severally KARNATAKA BANK LTD. or order 
              sum of Rupees Rs. <%=Helper.correctNull((String)hshValues.get("sancamount"))%> 
              together with intrest on such sum from this date at the rate of 
              <%=Helper.correctNull((String)hshValues.get("mintrate"))%>% over 
              Karnataka Bank Ltd. Prime Lending Rate or such other rates as may 
              be prescirbed by the Bank from time or time with a minimum of&nbsp;<%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%>% 
              per annum with <b><%=loanperiodicity%></b> rests for value received</p>
            <p>&nbsp;</p>
            <div align="right">
              <table width="9%" border="1" cellspacing="0" cellpadding="5" height="63">
                <tr> 
                  <td> 
                    <div align="center">Revenue<br>
                      Stamp </div>
                  </td>
                </tr>
              </table>
            </div>
            <p>&nbsp;</p>
          </td>
        </tr>
        <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
