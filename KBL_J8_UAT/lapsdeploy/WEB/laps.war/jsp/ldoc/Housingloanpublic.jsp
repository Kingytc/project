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
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td align="center" colspan="3"><b>FORMAT -5</b></td>
  </tr>
  <tr> 
    <td align="center" colspan="3"><b>LETTER OF AUTHORITY &#150; HOUSING LOAN 
      TO PUBLIC <br>
      </b></td>
  </tr> 
  <tr> 
    <td  colspan="3"><p align="justify">(ANNEXURE &#145;E&#146; TO INSTRUCTION CIRCULAR NO.6073 DATED16.08.200 ) 
  (SPECIMEN OF LETTER OF AUTHORITY TO BE OBTAINED IN DUPLICATE ONE FOR THE BANK 
  DULY ACKNOWLEDGED BY THE EMPLOYER AND THE OTHER FOR EMPLOYER. WITNESSES WHEREVER 
  NECESSARY)</p> <br>
  <center>
        (Housing Loan for public &#150; in case of applicants who are in service)<br>
      </center>
</td>
  </tr>  
<tr> 
    <td colspan="3"><center>
        <b>TO BE STAMPED WITH Rs.<%=Helper.correctNull((String) hshValues.get("sancamount"))%><br>
        </b> 
      </center></td>
  </tr>    
<tr> 
<td colspan="3"><center>
        <b>(Stamp duty to be ascertained from the provisions of respective Stamp 
        Act in the states)<br>
        </b> 
      </center>
</td>
  </tr> 
<tr> 
    <td align="center" colspan="3"><b>LETTER OF AUTHORITY<br>
      </b></td>
  </tr>   
 <tr> 
    <td align="right" colspan="3">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="72%" align="right">Place:<br>
          </td>
          <td width="28%"><b><%=Helper.correctNull((String) hshValues.get("cityName"))%></b></td>
        </tr>
        <tr>
          <td width="72%" align="right">Date : </td>
          <td width="28%"><b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
        </tr>
      </table>
    </td>
  </tr>   
 <tr> 
    <td align="left" colspan="3">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="3%">To:</td>
          <td width="97%">&nbsp;</td>
        </tr>
        <tr>
          <td width="3%">&nbsp;</td>
          <td width="97%"><br>
            Pay Disbursing Officer,<br>
            ---------------------------,<br>
            ---------------------------.</td>
        </tr>
      </table>
      <br>
      Dear Sir,
</td>  </tr>   
 <tr> 
    <td  colspan="3">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="6%">&nbsp;</td>
          <td width="94%"><font face="Times New Roman" size="3">I hereby authorise _____________________________________to 
            deduct from my (employer&#146;s name)salary each month an amount of 
            Rs <%=Helper.correctNull((String) hshValues.get("sancamount"))%><b>(Rs.<%=Helper.figtoWords((String)hshValues.get("sancamount"))%></b> 
            only) towards repayment of principal and interest and incidental charges 
            as advised by Karnataka Bank Ltd. and credit the same to my loan Account 
            No<b> <%=Helper.correctNull((String) hshValues.get("perapp_bankaccno"))%> 
            </b>at Karnataka Bank Ltd., <%=Helper.correctNull((String) hshValues.get("branchName"))%> 
            branch. (The recovery will commence from the month of <b><%=loanperiodicity%></b> 
            as per Bank&#146;s advice to you in this regard).</font> <br>
          </td>
        </tr> 
      </table>
    </td>
  </tr>   
 <tr> 
    <td width="6%" height="24">&nbsp;</td>
    <td colspan="9" height="24" width="94%"><font face="Times New Roman" size="3">I hereby declare that this authority 
      shall not be revoked by me so long as I remain indebted to the Union Bank 
      of India.</font><br>
      <br>
    </td>
  </tr>	    
 <tr> 
    <td align="right" colspan="3"> Yours faithfully,
	</td>
  </tr>    
 <tr> 
    <td align="center" colspan="3" height="61"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="70%" align="right">Signature: <br>
          </td>
          <td width="30%">&nbsp;</td>
        </tr>
        <tr>
          <td width="70%" align="right">Name: </td>
          <td width="30%">&nbsp;</td>
        </tr>
        <tr>
          <td height="17" width="70%" align="right">Address: </td>  
          <td height="17" width="30%">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>  
 <tr> 
    <td align="center" colspan="3">&nbsp;</td>
  </tr>     
 <tr> 
    <td align="left" colspan="3">WITNESS:</td>
  </tr>   
<tr> 
    <td align="center" colspan="3">&nbsp;</td>
  </tr>   
 
 </table>
</body>
</html>
