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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center"><b><u>DEMAND PROMISORY NOTE</u></b></div>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="78%"> 
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp; </p>
      <p>&nbsp;</p>
    </td>
    <td width="22%">Place: <%=Helper.correctNull((String) hshValues.get("cityName"))%> <br>
      Date: <b><%=Helper.correctNull((String) hshValues.get("currentDate"))%></b> </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>Rs: &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%> </td>
  </tr>
  <tr>
    <td>
      <p>&nbsp;</p>
      <p>On demand ,I <%=Helper.correctNull((String) hshValues.get("appname"))%> 
        promise to pay KARNATAKA BANK LTD. or order sum of Rupees &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%> 
        together with insert on such sum at the rate of &nbsp;<%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%> 
        % with <%=loanperiodicity%> rests,for value received.<br>
      </p>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="72%" height="75"> 
            <p>&nbsp;</p>
            <p>&nbsp;</p>
          </td>
          <td width="28%" height="75"> 
            <table width="30%" border="1" cellspacing="0" cellpadding="0" height="56">
              <tr>
                <td>
                  <div align="center">Revenue <br>
                    stamp</div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <p>&nbsp; </p>
    </td>
  </tr>
</table>  
</body>
</html>
