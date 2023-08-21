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
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td colspan="2">
      <p align="center"><u><b>SIMPLE LOAN AGREEMENT (SD-13) (For Agricultural 
        Advances)<br>
        </b></u></p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <p align="justify"><b>KARNATAKA BANK LTD.</b>,<br>
          <b> <%=Helper.correctNull((String)hshValues.get("branchName"))%></b>  Branch</p>
      <p align="justify">&nbsp;</p>
      <p align="justify"> IN CONSIDERATION OF Karnataka Bank Ltd. (hereinafter 
        called the Bank) at the request of <b><%=Helper.correctNull((String)hshValues.get("Title"))%></b> 
        &nbsp;<b><%=Helper.correctNull((String)hshValues.get("appname"))%></b> residing 
        at <b><%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>,<%=Helper.correctNull((String)hshValues.get("perapp_address2"))%> 
        <%=Helper.correctNull((String)hshValues.get("perapp_address3"))%>,<%=Helper.correctNull((String)hshValues.get("perapp_city"))%>,<%=Helper.correctNull((String)hshValues.get("perapp_state"))%> 
        </b>,<b><%=Helper.correctNull((String)hshValues.get("perapp_zip"))%></b>(hereinafter 
        called the Borrower/s) having from time to time advanced/agreed to advance 
        a loan of Rs <b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> 
        (hereinafter called the loan or loan account depending on the context) 
        granted by the Bank to enable the Borrower to carry out the purpose for 
        which the loan is granted on the terms and conditions hereinafter contained. 
        NOW IT IS HEREBY AGREED BY AND BETWEEN THE PARTIES AS FOLLOWS: </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(ccxlviii)</td>
    <td width="96%"> 
      <p align ="justify">)The Borrower&#146;s application shall constitute the 
        basis of this agreement and of the loan to be advanced by the Bank hereunder 
        and the Borrower hereby confirms the correctness of each and every statement 
        and particulars therein set forth.</p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(ccxlix)</td>
    <td width="96%"> 
      <p align ="justify">The Borrower agrees and undertakes to notify the Bank 
        in writing of any circumstances affecting the correctness of any of the 
        particulars mentioned in the Borrower&#146;s application within 7 days 
        of the occurrence of any circumstance.</p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">3.</td>
    <td width="96%"> 
      <p align ="justify">The Borrower shall repay the said advance to the Bank 
        at <b><%=Helper.correctNull((String)hshValues.get("lreqterms"))%></b>..instalments and on the days hereinafter 
        mentioned:<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td colspan="2" valign="top"> <u>Amount of instalment</u> <u>Date of Payment</u> 
      <br>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(ccl)(a) </td>
    <td width="96%"> 
      <p align ="justify">The Borrower shall repay to the Bank the loan along 
        with the interest on the amount of outstanding for the time at the rate 
        of <b> <%=Helper.correctNull((String)hshValues.get("mintrate"))%></b> . Percentage per annum with  <b><%=loanperiodicity %></b> rests 
        or such other rates as may be prescribed by the Bank from time to time 
        depending upon the changes in the Prime Term Lending Rate of the Bank 
        or the directives of Reserve Bank of India from time to time, such interest 
        shall be payable whether debited to the loan account or not, and until 
        so paid shall form part of the loan and the Borrower hereby waives the 
        requirement of notice on the revision of interest and the notice in the 
        newspaper or the Bank&#146;s notice Board shall be deemed to be sufficient 
        notice to the Borrower.</p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(ccli)</td>
    <td width="96%"> 
      <p align ="justify">The Borrower further agrees that if default shall be 
        made in payment of three instalments on due dates then the Borrower shall 
        pay penal interest at such rate as the Bank in its absolute discretion 
        determines on the amount then outstanding.</p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cclii)</td>
    <td width="96%"> 
      <p align ="justify">If default shall be made in payment of three instalments 
        on due dates then the entire amount of the loan or the balance then remaining 
        outstanding (inclusive of penal interest) and owing to the Bank shall 
        at once become due and payable and on demand being made by the Bank the 
        Borrower shall repay to the Bank all moneys or liabilities then outstanding 
        and owing to the Bank together with interest (inclusive of penal interest) 
        and all other charges and expenses.</p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(ccliii)</td>
    <td width="96%"> 
      <p align ="justify">The Borrower agrees to accept as conclusive proof of 
        the correctness of any sum claimed to be due from them to the Bank under 
        this Agreement a statement of account made out from the books of the Bank 
        and signed by the Accountant or other duly authorised officer of the Bank 
        without production of any voucher, document or paper and the Borrower 
        further agrees to pay to the Bank the interest accrued as per this Agreement 
        but not actually debited to the loan account.</p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(ccliv)</td>
    <td width="96%"> 
      <p align ="justify">Any notice of demand or otherwise hereunder may be given 
        by the Bank to the Borrower at the last known place of business or residence 
        in India of the Borrower and may be sent by post it shall be deemed to 
        have been given at the time when it would be delivered in due course of 
        post and shall be sufficient to prove that the envelope containing the 
        notice was posted.</p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cclv)</td>
    <td width="96%"> 
      <p align ="justify">Should the Borrower be more than one individual, all 
        shall be bound jointly and severally and the firm or members of the firm, 
        such firm and all members from time to time thereof shall be bound hereby 
        jointly and severally notwithstanding any changes in the constitution 
        or style thereof and whether such firm consists of or be reduced to one 
        individual at any time and also such individual members and their respective 
        heirs, executors and administrators.<br>
      </p>
      <p align ="justify">&nbsp; </p>
    </td>
  </tr>
  <tr> 
    <td colspan="2" valign="top"> 
      <p align ="justify">IN WITNESS WHEREOF the Borrower has hereto subscribe 
        his/her/their respective hands to this Deed on this day of <b> 
            <%=date%>th <%=Months[a]%>, <%=year%></b>.</p>
    </td>
  </tr>
  
</table>
</body>
</html>
