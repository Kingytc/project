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
      <td colspan="2"> 
        <div align="center"><b>DRAFT LETTER TO BE OBTAINED ALONG WITH THE DEMAND 
          PROMISSORY NOTE OBTAINED PREFORSHIPMENT ADVANCE</b><br>
        <br>
      </div>
      </td>
    </tr>
    <tr> 
      <td width="6%">FROM:</td>
      <td width="94%">&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      
    <td> <b><%=Helper.correctNull((String) hshValues.get("appname"))%></b>,<br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_address1"))%></b>,<br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_address2"))%></b>,<br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_address3"))%></b>,<br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_city"))%></b><br>
      <b><%=Helper.correctNull((String) hshValues.get("perapp_state"))%></b>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      
    <td> <br>
      </td>
    </tr>
     
     
    <tr> 
      
    <td height="18">TO:</td>
      
    <td height="18">&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      
    <td>Branch Manager,<br>
      <b>Karnataka Bank Ltd.,</b> <br>
      <b><%=Helper.correctNull((String)hshValues.get("branchName"))%></b> Branch 
      <br>
      </td>
    </tr>
     
    <tr> 
      <td>&nbsp;</td>
      
    <td><br>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">Sir,<br>
      </td>
    </tr>
    <tr> 
      <td colspan="2"><br>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="3%" valign="top">Sub: </td>
          <td width="97%">Interest Rate on export advance &#150; Pre-shipment 
            (Packing Credit) Facility<br>
            <br>
          </td>
        </tr>
      </table>
      
      </td>
    </tr>
    <tr> 
      <td colspan="2">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="3%">&nbsp;</td>
          <td width="97%"><p align="justify"><font face="Times New Roman" size="3">After examining 
            the above difficulties in depth, the following clarifications are 
            issued for the guidance of the branches and for speedy creation of 
            Equitable Mortgages and consequent speedy disbursal of the advances 
            We refer to the Sanction letter from you dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> 
            according us a sanction of various facilities including the Pre-shipment 
            facility. As per your request, we have executed a Demand Promissory 
            Note for an amount of Rs.<b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> 
            (Rupees <b><%=Helper.figtoWords((String)hshValues.get("sancamount"))%></b>) 
            along with interest at the rate of <b><%=Helper.correctNull((String)hshValues.get("mintrate"))%></b>% 
            per annum with <%=loanperiodicity%> rests. </font></p></td>
        </tr>
      </table>
      <br>
      <font face="Times New Roman" size="3"> 
      
      </font> <font face="Times New Roman" size="3"> </font>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="3%">&nbsp;</td>
          <td width="97%"><font face="Times New Roman" size="3">
            <p align="justify">We understand that the interest rates applicable 
              for the said facility are graded rates depending on period of advance 
              from the date of availment. We also understand that we are liable 
              to pay higher interest rates if the shipment/s is/are not carried 
              out within the time stipulated. We also confirm having received 
              from the Bank interest rate chart applicable for export advances 
              and we agree to the same rates. We further understand that these 
              rates are subject to change from time to time depending upon the 
              directives of Reserve Bank of India and/or the change in the Prime  
              Lending Rate of the Bank.</p>
            </font> </td>
        </tr>
      </table>
      <font face="Times New Roman" size="3">
      <p align="justify"><br>
      </p>
      </font></td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <div align="right"><br>
          Yours faithfully,</div>
      </td>
    </tr>
    <tr> 
      
    <td colspan="2">Date:<%=Helper.correctNull((String) hshValues.get("currentDate"))%><br>
        <br>
      </td>
    </tr>
    <tr>
      <td colspan="2">&nbsp;</td>
    </tr>
  </table>
</body>
</html>