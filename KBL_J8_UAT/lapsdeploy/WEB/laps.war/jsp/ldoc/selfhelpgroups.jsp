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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="right"><b><u>FORMAT 22</u></b></div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <div align="center"><b>ARTICLES OF AGREEMENT FOR USE</b></div>
    </td>
  </tr>
  <tr>
    <td>
      <div align="center"><b>BY BANKS WHILE FINANCING SELF-HELP GROUPS</b></div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">(Annexure III to IC 6119 (SHG) DATED 16-11-2000)</td>
  </tr>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <div align="right">[To be stamped as an agreement]</div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="204">
      <p align="justify">The Articles of Agreement made on this <b> 
            <%=date%>th <%=Months[a]%>, <%=year%></b> at ____________By and Between M/s. _________________________ 
        [name of SHG] _____________________an unregistered association of persons/individuals 
        having its office at ____________________________________ Represented 
        by its authorised representative Shri/Smt______________ ________________________________ 
        [name],______________[designation] and Shri/Smt._______________________[name],______________[designation] 
        who are fully authorised by all the members of the SHG, ( a copy of such 
        authorisation as interse Agreement is annexed hereto and forms part of 
        this agreement), hereinafter referred to as the &#147;borrower&#148; which 
        expression shall unless repugnant to the subject or context thereof, mean 
        and include members of the unregistered association for the time being, 
        their respective successors, legal heirs, administrators and assigns of 
        the one part and Karnataka Bank Ltd., a body Corporate constituted under 
        the Banking Companies (Acquisition and Transfer of Undertakings) Act 1970 
        having its head Office at 239, Vidhan Bhavan Marg, Nariman Point, Mumbai 
        400 021 and the Branches, interalia, one at _______________ hereinafter 
        called &#147;the Bank&#148; (which expression shall unless repugnant to 
        the subject or context thereof mean and include its successors and assigns) 
        of the second part.<br>
      </p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify">Whereas the borrower is an unregistered association of persons who have 
      interse agreed to help each other as self-help group with a view to developing 
      and ameliorating the socio-economic conditions of their members.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="105">
      <p align="justify">Whereas having formed the association as a self help 
        group, the Borrower as per application dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> made by the 
        said Shri/Smt_______________________[name] __________________ [designation] 
        and Shri/Smt____________________[name]__________________[designation] 
        duly authorised to borrow in terms of its resolution dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> 
        [copy enclosed], requested the Bank to &#145;grant a loan/extend credit 
        facility of *Rs.<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> 
        </b>/ upto the limit of Rs.<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> 
        </b>/- (Rupees <b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b> 
        only) for on lending to its members.<br>
      </p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify">And whereas the bank has agreed to grant the loan/extend credit facility 
      to the borrower on certain terms and conditions.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify">And whereas the bank and the borrower are desirous of reducing the agreed 
      terms into writing.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify">Now, therefore, this agreement witnesseth as follows:<br>
        1. The Bank has agreed to grant and the borrower has agreed to borrow 
        by way of term loan/cash credit (clean) upto the limit of Rs. <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> </b> /- (Rupees <b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b> 
        only) and the bank has opened</p>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>----------------------------------------- a/c. No_______________ of date <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>in the name of the borrower in its book of account.<br>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td><p align="justify">.In case the facility availed is cash credit the Borrowers will operate 
 
      the cash credit account satisfactory and within the limit and the borrower 
      shall repay the outstanding liability in the account inclusive of interest 
      and other charges debited from time to time on demand without demur. </p></td>
 
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify">In case loan availed is Demand Loan, without prejudice to the right of 
      the Bank to recall the loan on demand, the Borrower undertakes to repay 
      the loan with interest and other charges within the period stipulated in 
      terms of sanction.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
   <td width="4%" valign="top">(ii)</td><td><p align="justify"> In case the credit facility availed of by the borrower is a term 
 
      loan the same shall be repayable in instalments in the manner specified 
      hereinbelow in the repayment schedule. Besides, the borrower will pay interest 
      at the rates that may be prescribed for such lending by Bank/RBI/NABARD 
      from time to time.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     <td width="4%" valign="top">(ii)</td><td><p align="justify"> It is clearly understood by and between the parties hereto that in 
 
      the event of the borrower&#146;s failure to utilise the proceeds of the 
      credit facility for the purpose for which the same has been made available 
      by the Bank to the borrower, the borrower shall repay immediately on demand 
      without demur together with interest without prejudice to Bank&#146;s right 
      to initiate other legal action. Balances in the loan account and be debited 
      thereto at quarterly rests or as the Bank may decide.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td><p align="justify">The borrower shall pay interest on the loans to be calculated on 
      the daily balances in the loan account and be debited thereto at rests or 
      as the Bank may decide.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td> <p align="justify">The borrower should utilise the proceeds of the credit facility for 
      the purpose of lending to its members to improve the socio-economic conditions 
      of their members and their families.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td>
      <p align="justify">The borrower shall repay the credit facility availed 
        of together with interest payable as per the interest rates that may be 
        fixed by Bank/RBI/NABARD from time to time for such lendings. The present 
        rate is <b> <%=Helper.correctNull((String)hshValues.get("mintrate"))%></b> 
        %.</p>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
   <td width="4%" valign="top">(ii)</td><td> <p align="justify">The borrower shall be liable to repay the facility on demand together 
      with interest payable as per the interest and other charges payable by the 
      borrower to the Bank in accordance with the rules of the Bank.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     <td width="4%" valign="top">(ii)</td><td><p align="justify"> That the borrower shall pay to the bank interest on the amount of 
 
      the advance/advances for the time being outstanding at the rate of <b> <%=Helper.correctNull((String)hshValues.get("mintrate"))%></b>
      percentage per annum with <b><%=loanperiodicity %></b> rests or at such other revised rate/s 
      as may be prescribed by the bank from time to time depending upon the directives 
      of Reserve Bank of India from time to time or the policy of the Bank on 
      advances or the policy of NABARD for charging interest on loans for which 
      refinance is availed from them, such interest to be payable, whether actually 
      debited to the account or not, and until so paid shall form part of the 
      advance/s granted by the Bank to the Borrower and the Borrower agrees to 
      execute necessary Promissory notes and/or debit balance confirmations accordingly 
      from time to time.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td> <p align="justify">The borrower shall be liable to pay overdue interest at the rate 
      of <b> <%=Helper.correctNull((String)hshValues.get("mintrate"))%></b>  or the rate as may be fixed by bank from time to time in the 
      event of failure to repay the facility availed in the stipulated manner 
      and/or failure to pay interest as stipulated.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify">The borrower agrees to bear and pay interest tax as may be applicable 
      at the rate as in force. The bank shall have the discretion to decide the 
      manner of computation of interest tax and charging thereof in the account.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td><p align="justify"> The borrower agrees that its members&#146; liability to the bank 
      for its dues under the credit facility availed is joint and several.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     <td width="4%" valign="top">(ii)</td><td> <p align="justify">Bank will always be at liberty to stop making fresh advance at any 
 
      time without previous notice, which notice is hereby expressly waived and 
      without assigning any reason even though the said limit has not been fully 
      availed of.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     <td width="4%" valign="top">(ii)</td><td><p align="justify"> That the borrower does further agree and hereby give to the bank 
 
      during currency and for the payment of its dues a general lien and right 
      of set off and charge on all movable property of every description coming 
      into the possession of the bank on account of the borrowers or any one of 
      them or for the time being held by the bank on behalf of the borrowers or 
      any one of them whether alone or jointly with others in India or elsewhere  
      including without prejudice to this generally, any moneys, bullion, deposit, 
      deposit receipts for moneys, promissory notes, bills of exchange, hundies, 
      stocks, goods and merchandise, bill of lading including railway receipts, 
      Government bills, with inspection notes and other bills in course of collection, 
      articles in safe custody and other documents or title to goods and any other 
      negotiable or transferable instruments or securities, instruments and documents 
      of title and mercantile documents of every description including hire purchase 
      agreement or contracts other than those affecting immovable property and 
      requiring registration under the Acts of laws relating to registration and 
      other documents evidencing the title of the borrowers as creditors or members 
      of any corporation, association, company or syndicate in India or elsewhere.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="4%" valign="top">(ii)</td><td> <p align="justify">That the borrower hereby agrees that any notice in writing requiring 
      to be served here under shall be sufficiently served if addressed to anyone 
      of them at their address registered with the bank or, in the event of no 
      such address being registered, at their own or anyone of their last known 
      place of residence or business and left at such address or if forwarding 
      to anyone of them by post at the address or place aforesaid. And the borrower 
      do hereby further agree that any demand hereunder may effectually be made 
      by parole notice to any one of them by an officer of the said bank or by 
      notice in writing under the hand of such officer either served personally 
      on the borrowers or any one of them or left or sent by post to any one of 
      them at their usual or last known place of business.</p></td>
  </tr>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>
      <div align="center"><b>REPAYMENT SCHEDULE</b></div>
    </td>
  </tr>
  <tr>
    <td>
      <div align="center">[Please specify] </div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify">In witness whereof the parties hereto have affixed their signature on 
      the <b><%=Helper.correctNull((String) hshValues.get("Date"))%></b> [date] and the <b><%=Helper.correctNull((String) hshValues.get("Month"))%></b>[month] and <b><%=Helper.correctNull((String) hshValues.get("year"))%></b>[year] 
      first herein above written.</p></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="4%" valign="top">(ii)</td><td>FOR SHG</td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(ii)</td><td>AUTHORISED REPRESENTATIVE 2) AUTHORISED REPRESENTATIVE</td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(iii)</td>
    <td></td>
  </tr>
  <tr>
    <td width="4%" valign="top">(iv)</td>
    <td>FOR BANK</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><b>MANAGER</b></td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
