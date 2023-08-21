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
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td colspan="2"> 
            <p><b><u>GENERAL TERM LOAN AGREEMENT</u> (SD-18)</b></p>
            <p>&nbsp;</p>
          </td>
        </tr>
        <tr> 
          <td width="5%">&nbsp;</td>
          <td width="95%">THIS AGREEMENT made at _________________________this ---
            <b> 
            <%=date%>th <%=Months[a]%>, <%=year%></b></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td>
            <p>By <b><%=Helper.correctNull((String) hshValues.get("appname"))%> </b>
              (herein after called &quot;the Borrower&quot; <b>IN FAVOUR OF</b> Union Bank of 
              India, a Body Corporate constituted under Banking Companies (Acquisition 
              &amp; Transfer of Undertakings) Act, 1970 having its Head Office 
              at 239, Vidhan Bhavan Marg, Nariman Point, Mumbai 400021 and having 
              a branch at/named.&nbsp; &nbsp; &nbsp; &nbsp; <%=Helper.correctNull((String) hshValues.get("branchName"))%>.(Hereinafter 
              called &quot;the Bank&quot; which term unless the context otherwise 
              requires includes its successors and assigns from time to time.</p>
            <p><b>NOW IT IS HEREBY AGREED, DECLARED, RECORDED AND CONFIRMED BY 
              THE BORROWER AS FOLLOWS</b></p>
            <p>IN CONSIDERATION OF the Bank having advanced/agreed to advance 
              a loan of Rs. <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
              (hereinafter called &quot;the loan&quot; or &quot;loan account&quot; 
              depending on the context) granted by the Bank to enable the Borrower 
              to carry out the purpose for which the loan is granted the Borrower 
              hereby agrees, records and confirms the terms and conditions upon 
              which the loan is granted as under:</p>
            <p>1. The Borrower's application shall constitute the basis of the 
              agreement to grant the loan or loan to be advanced by the Bank and 
              the Borrower hereby confirms the correctness of each and every statement 
              and particulars therein set forth.</p>
            <p>2. The Borrower further hereby:<br>
            </p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="5%">&nbsp;</td>
                <td width="95%">(a) undertakes to carry out each and every conditions 
                  contained in the application submitted by the Borrower.
                  <p>(b) undertakes that the loan advanced by the Bank shall be 
                    utilized for the purposes and in the manner set forth in the 
                    loan application read with the sanction advice thereto and 
                    for no other purpose.</p>
                  <p>(c) agrees to furnish to the Bank all such information as 
                    the Bank may require from time to time and also to submit 
                    necessary financial data and/or statements as required by 
                    the Bank.</p>
                  <p>(d) expressly agrees with the Bank that the Bank shall be 
                    entitled to refuse to grant the said loan or any part thereof 
                    which may remain to be advanced in the event of: <br>
                  </p>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                      <td width="6%">&nbsp;</td>
                      <td width="94%">(i) any of the representations, assurances, 
                        statements and particulars contained in the proposal being 
                        found to be incorrect, in the opinion of the Bank.<br>
                        (ii) Failing to utilize the loan for the purpose for which 
                        or the manner in which or within the time stipulated in 
                        the sanction letter.</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td>Happening or occurrence of any of the matters, events or circumstances 
                  mentioned herein above, the opinion of the Bank shall be final.</td>
              </tr>
              <tr>
                <td>
                  <p><br>
                    3. The Borrower shall repay the said advance to the Bank in 
                    installments as hereinafter mentioned:</p>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td width="32%"> 
                        <div align="center"><u><b>Number of installments</b></u></div>
                      </td>
                      <td width="38%"> 
                        <div align="center"><u><b>Amount of installment</b></u></div>
                      </td>
                      <td width="30%"> 
                        <div align="center"><u><b>Tenure</b></u></div>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>It is agreed that notwithstanding the amount of each installment 
                    fixed as above, the Bank may at its discretion without being 
                    required to give any reasons to the Borrower alter and/or 
                    amend the amount of installment or number of installments 
                    as also the date of repayment. In the event of the Bank intimating 
                    to the Borrower the amendment/ alterations to the amount of 
                    each installment and the number of installments, then the 
                    same shall be deemed to have been substituted here in this 
                    Agreement.</p>
                  <p>4. The Borrower shall repay to the Bank the loan along with 
                    the interest on the amount of outstanding from time to time 
                    at the rate of <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%></b> %Percentage per annum with 
                    <b><%=loanperiodicity %></b>.rests.</p>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                      <td>&nbsp;</td>
                      <td>Strike out whichever is not applicable</td>
                    </tr>
                  </table>
                  <p>The Borrower shall repay to the Bank the loan along with 
                    the interest on the amount of outstanding from time to time 
                    at the rate of <b> <%=Helper.correctNull((String)hshValues.get("mintrate"))%></b> Percentage per annum with    <b><%=loanperiodicity %></b> rests 
                    or such other rates as may be prescribed by the Bank from 
                    time to time depending upon the changes in the Prime Term 
                    Lending Rate of the Bank or the directives of Reserve Bank 
                    of India from time to time, loan and the Borrower hereby waives 
                    the requirement of notice on the revision of interest and 
                    a notice in the Bank's notice Board or a report in the newspaper 
                    on change of interest shall be deemed to be sufficient notice 
                    to the Borrower.</p>
                  <p>Such interest shall be payable whether debited to the loan 
                    account or not, and until so paid shall form part of the loan 
                    covered by these Presents.</p>
                  <p>5. The Borrower further agrees that if default shall be made 
                    in payment of any installment on due dates the Borrower shall 
                    pay penal interest at such rate as the Bank in its discretion 
                    determine on the amount then outstanding. </p>
                  <p></p>
                  <p>6. If default shall be made in payment of any installment 
                    on due dates then the entire amount of the loan or the balance 
                    then remaining outstanding (inclusive of penal interest) and 
                    owing to the Bank shall at once become due and payable and 
                    on demand being made by the Bank the Borrower shall repay 
                    to the Bank all moneys or liabilities then outstanding and 
                    owing to the Bank together with interest (inclusive of penal 
                    interest) and all other charges and expenses.</p>
                  <p>7. The Borrower agrees to accept as conclusive proof of the 
                    correctness of any sum claimed to be due from them to the 
                    Bank under this Agreement a statement of account made out 
                    from the books of the Bank and signed by the Accountant or 
                    other duly authorised officer of the Bank without production 
                    of any voucher, document or paper and the Borrower further 
                    agrees to pay to the Bank the interest accrued as per this 
                    Agreement but not actually debited to the loan account</p>
                  <p>8. Notwithstanding anything contained herein above, upon 
                    the happening of any of the following events, the whole of 
                    the loan or the entire balance thereof outstanding at the 
                    time of happening of the event shall fall due and payable 
                    by the Borrower to the bank:</p>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                      <td width="8%">&nbsp;</td>
                      <td width="92%">(a) in default of payment of any installment 
                        as per this Agreement.
                        <p>(b) on committing any breach of any of the terms and 
                          conditions of the sanction/this Agreement.</p>
                        <p>(c) The Borrower entering into any arrangement or composition 
                          with its creditor/s or committing any act the consequence 
                          of which may lead the Borrower in case of an individual 
                          becoming insolvent and in case of Company being ordered 
                          to be wound up.</p>
                        <p>(d) Any process being issued in execution of as decree 
                          or attachment before judgment of the properties of the 
                          Borrower resulting in the Borrower losing control of 
                          his properties or on receipt of a notice of insolvency 
                          from appropriate court or for winding up from the Company 
                          Court, in case the Borrower is a Company.</p>
                        <p>(e) A Receiver being appointed on the properties of 
                          the Borrower and the Bank believes that the Borrower's 
                          properties will be taken possession of by the receiver.</p>
                        <p>(f) The occurrence of any other event or circumstance 
                          which would or is likely to prejudicially affect in 
                          any manner the capacity of the Borrower either to repay 
                          the said loan, the opinion of the Bank in this regard 
                          being conclusive.</p>
                        <p>(g) In case the Borrower is a Company and a resolution 
                          is passed for the winding up of the Company or the Borrower 
                          being a partnership firm files application in a court 
                          for dissolution of the firm. </p>
                        <p>(h) The borrower ceasing or threatening to cease business 
                          or gives notice of the Borrower's intention to do so.</p>
                      </td>
                    </tr>
                  </table>
                  <p>8. Any delay in exercise or omission to exercise any right, 
                    power or remedy occurring to the Bank upon any default under 
                    this Agreement shall not impair or prejudice any such right, 
                    power or remedy nor shall be construed to be a waiver thereof 
                    or any acquiescence in such default nor such inaction of the 
                    Bank in respect of any default affect or impair any right, 
                    power or remedy of the Bank in respect of any such default.</p>
                  <p>9. Any notice of demand or otherwise hereunder may be given 
                    by the Bank to the Borrower at the last known place of business 
                    or residence in India of the Borrower and may be sent by post 
                    it shall be deemed to have been given at the time when it 
                    would be delivered in due course of post and shall be sufficient 
                    to prove that the envelope containing the notice was posted.</p>
                  <p>10. The Borrower hereby further agrees that in case the Borrower 
                    commits default in the repayment of the loan or in the repayment 
                    of interest thereon on due date/s, the Bank and/or Reserve 
                    Bank of India will have an unqualified right to disclose or 
                    publish the name of the Borrower or its Directors/partners/proprietor 
                    as defaulter in such manner and through such medium as the 
                    Bank or Reserve Bank of India in their absolute discretion 
                    may think fit.</p>
                  <p>11. Should the Borrower be more than one individual, all 
                    shall be bound jointly and severally and the firm or members 
                    of the firm, such firm and all members from time to time thereof 
                    shall be bound hereby jointly and severally notwithstanding 
                    any changes in the constitution or style thereof and whether 
                    such firm consists of or be reduced to one individual at any 
                    time and also such individual members and their respective 
                    heirs, executors and administrators and that should the Borrower 
                    be a Limited company, a corporate or unincorporated body, 
                    committee, firm, partnership, trustees or debtors on a joint 
                    account, the provisions herein contained shall be construed 
                    and take effect where necessary as if the words importing 
                    the singular number also included the plural number and lastly 
                    that if the Borrower be more than one individual at any time 
                    any notice served on anyone of such individuals shall be deemed 
                    to be service of such notice on all such individuals.</p>
                  <p>IN WITNESS WHEREOF the Borrower has hereunto put his hand 
                    and seal this---<b> 
            <%=date%>th <%=Months[a]%>, <%=year%></b></p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>Signed, sealed and delivered by the <br>
                    within named <b>BORROWER. </b>.</p>
                  <br>
                    <br>
                    <b><%=Helper.correctNull((String) hshValues.get("appname"))%> </b>
                </td>
              </tr>
            </table>
            <p>&nbsp; </p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
