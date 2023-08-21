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
    <td> 
      <div align="center">
        <table width="98%" border="0" cellspacing="0" cellpadding="5">
          <tr> 
            <td>
              <div align="center"><b>HYPOTHECATION(CONSUMER GOODS)AGREEMENT(SD-09)</b></div>
            </td>
          </tr>
        </table>
        <div align="left">
          <table width="98%" border="0" cellspacing="0" cellpadding="5" height="57">
            <tr> 
              <td>To<br>
                <b>KARNATAKA BANK LTD.</b><br>
                <%=Helper.correctNull((String)hshValues.get("branchName"))%>  Branch<br>
              </td>
            </tr>
          </table>
          <br>
           <p align="justify"> IN CONSIDERATION OF KARNATAKA BANK LTD. (hereinafter 
            called 'the Bank' at the request of&nbsp;&nbsp;<b><%=Helper.correctNull((String) hshValues.get("appname"))%> 
            </b> residing at<b> <%=Helper.correctNull((String) hshValues.get("perapp_address1"))%></b>&nbsp,<b> 
            <%=Helper.correctNull((String) hshValues.get("perapp_address2"))%>,<%=Helper.correctNull((String) hshValues.get("perapp_address3"))%>,<%=Helper.correctNull((String) hshValues.get("perapp_city"))%>,<%=Helper.correctNull((String) hshValues.get("perapp_state"))%> 
            </b> (hereinafter called &quot;the Borrower&quot;) having advanced/agreed 
            to advance a fixed loan of Rs. <b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> 
            /- (Rupees<b><%=Helper.figtoWords((String)hshValues.get("sancamount"))%></b>only) 
            to enable the borrower to purchase consumer durable goods more particularly 
            described. in the schedule hereto (hereinafter referred to as 'the 
            said goods') upon and <br>
            subject to the terms and conditions hereinafter contained.</p> <br>
            <br>
           
          <table width="98%" border="0" cellspacing="0" cellpadding="5">
            <tr> 
              <td><p align="justify">IT IS HEREBY AGREED BETWEEN THE BORROWER AND THE BANK as follows:</p></td>
            </tr>
          </table>
          <br>
          <table width="98%" border="0" cellspacing="0" cellpadding="5" height="80">
            <tr>
              <td>
                <p align="justify">(1) That the amount advanced shall be held by the Borrower 
                  for and on behalf of the Bank and utilised for the purchase 
                  of the said goods. If it is found that the said sum or any part 
                  thereof is not utilised for the purpose applied for thenthe 
                  Bank shall be entitled to call for immediate repayment of the 
                  loan without prejudice to the Bank's right to initiate criminal 
                  proceedings against the borrower for any misapplication thereof.</p>
               <p align="justify">(2) That the borrower hereby hypothecates in favour of the 
                  Bank the said goods as security for the due repayment by the 
                  Borrower to the Bank of the amount for the time being due to 
                  the Bank and shall hold the said goods in trust for and on account 
                  of the Bank under and by virtue of this agreement.</p>
              <p align="justify">(3) (a) That the Borrower shall pay to the Bank interest on 
                  the amount of the advance / advances for the time being outstanding 
                  at the rate of <b><%=Helper.correctNull((String)hshValues.get("mintrate"))%></b> 
                  percentage per annum with <b><%=loanperiodicity%></b> rests 
                  or at such other rate/s as maybe prescribed by the Bank from 
                  time to time depending on the changes in the Prime Lending Rate 
                  of the Bank or the directives of the Reserve Bank of India from 
                  time to time or the policy of the Bank on advances, such<br>
                  interest to be payable, whether actually debited to the account 
                  or not, and until so paid shall form part of the advance/s granted 
                  by the Bank to the Borrower and the Borrower agrees to execute 
                  necessary Promissory notes or Debit balance confirmations accordingly 
                  from time to time.</p>
                <p align="justify"> (b) In the event of any revision in the rate of interest, 
                  the Borrower shall be deemed to have notice of revision in the 
                  rate of interest whenever such revision in the Prime Lending 
                  Rate is displayed or notified by the Bank on the notice board 
                  in the branch premises where the advance/s as/are availed by 
                  the Borrower/s or published in the Newspaper/s,or made known 
                  through entry of interest charged in the statement of account 
                  given to the Borrower.</p>
               <p align="justify">(c) Provided further that, without prejudice to the Bank's 
                  other rights and remedies, that the Bank shall be entitledto 
                  charge, in its discretion, additional/penal rate/ s of interest 
                  at the rate of 2% p.a. or such other rate as the Bank may from 
                  time to time in accordance with itE policy determine as payable 
                  on the outstanding dues or any portion thereof for any delay 
                  ir repayment/adjustment of the advances and/or interest as agreed 
                  or in default or irregularity in observing the terms and conditions 
                  this agreement by the Borrower/s which in the opinion of the 
                  Bank warrants charging penal interest for such period as the 
                  Bank mal deem fit. This agreement by the Borrower/s which in 
                  the opinion of the Bank warrant! charging penal interest for 
                  such period as the Bank may deem fit.</p>
               <p align="justify">(4) That the said goods and all sale proceeds or realisations 
                  shall be held in trust for and on account of the Bank and as 
                  the Bank's exclusive property specially appropriated to this 
                  security and the Borrower shall not during the continuance of 
                  this agreement hypothecate, mortgage, charge or encumber any 
                  of the said goods or any part thereof nor do anything which 
                  would prejudice this security.</p>
               <p align="justify">(5) That the Borrower shall not without the previous permission 
                  in writing of the Bank sell or dispose of in any manner the 
                  said goods or any part thereof.</p>
               <p align="justify">(6) The Borrower shall permit the Bank their agents and servants 
                  from time to time and at all times to enter upon any premises 
                  wherein the said goods or any part thereof may for the time 
                  being be and to view, inspect and value the same and take inventories 
                  thereof or to take possession thereof and render to the Bank 
                  and their servants all facilities as may be required for any 
                  of the purposes aforesaid.</p>
                 <p align="justify">(7) The Borrower shall punctually pay all rents, taxes, licence 
                  fees and keep the said goods free from distress. The Borrower 
                  undertakes to meet all charges relating to maintenance, repairs, 
                  replacements and other outgoings in respect of the said goods 
                  and also of the premises where the said goods may be kept and 
                  to keep them free from distress, attachment or lien(s).</p>
                 <p align="justify">(8) The Borrower shall repay the loan together with accruing 
                  interest by monthly equated instalments, spread over a period 
                  of <b><%=Helper.correctNull((String)hshValues.get("lreqterms"))%></b> 
                  months and if default shall be made in payment of any two monthly 
                  instalments then the entire sum of Rs. <b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> 
                  or the balance then remaining outstanding (inclusive of pena~ 
                  interest) and owing to the Bank shall at once become due and 
                  payable and on demand being made by the Bank, the Borrower shall 
                  repay to the Bank all moneys or liabilities then outstanding 
                  and owing to the Bank together with interest (inclusive of penal 
                  interest) and all other charges and expenses.</p>
               <p align="justify">(9) That in 'default' of such payment on demand as aforesaid, 
                  the Bank and their Officers and Agents shall be entitled at 
                  any time as absolute owners and without notice to the Borrower, 
                  but at the Borrower's risk and expenses and if so required as 
                  attorneys for and in the name of the Borrower to enter and to 
                  remain at any place where the said goods shall be and to take 
                  possession of the said securities or recover and receive the 
                  same and / or appoint any officer or officers of the Bank as 
                  Receiver or Receivers of the said goods and / or sell by public 
                  auction or private contract or otherwise dispose of or deal 
                  with all or any part of the said goods and to enforce, realise, 
                  settle, compromise and deal with any of the rights aforesaid 
                  without being liable for any loss in the exercise thereof and 
                  without prejudice to the Bank's rights and ,remedies of suit 
                  against the Borrower and to apply the net proceeds of such sale 
                  in or towards liquidation of the balance due to the Bank. The 
                  Borrower hereby agrees to accept as correct the Bank's account 
                  of sales realisation and to pay any shortfall or deficiency 
                  therein shown.</p>
              <p align="justify">(10) That if the net sum realised by such sales be insufficient 
                  to cover the balance then due to the Bank, the Bank shall be 
                  at liberty to apply any other money or monies in the hands of 
                  the Bank standing to the credit of or belonging to tho Borrower 
                  in or towards payment of the balance for the time being due 
                  to the Bank and in the event of there not being any such money 
                  or monies as aforesaid in the hands of the Bank or in the event 
                  of such money or moneys being still insufficient for the discharge 
                  in full of such balance, the Borrower promises and agrees forthwith 
                  on production of an account prepared and signed as hereinafter 
                  provided to pay any further balance which may appear to be due 
                  to the Bank by the Borrower thereon PROVIDED ALWAYS that nothing 
                  herein contained shall be deemed to negative, qualify or otherwise 
                  prejudicially affect the right of the Bank (which it is hereby 
                  expressly agreed the Bank shall have) to recover from the Borrower 
                  the balance for the time being remaining due from the Borrower 
                  to the Bank upon the said account or accounts notwithstanding 
                  that all or any of the said goods may not have been realised. 
                </p>
               <p align="justify">(11) That in the event of there being a surplus available of 
                  the net proceeds of such sale after payment in full of the balance 
                  due to the Bank it shall be lawful for the bank to retain and 
                  apply the said surplus together with any other money or moneys 
                  belonging to the Borrower for the time being in the hands of 
                  the Bank in or under whatever account as far as the same shall 
                  extend against in or towards payment or liquidation of any and 
                  all other moneys which shall be or may become due from the Borrower 
                  whether solely or jointly with any other person or persons, 
                  firm or company to the Bank by way of Loans, Discounted Bills, 
                  Letters of Credit, Guarantees, Charges or of any other debt 
                  liability including Bills, Notes, Credits and other obligations 
                  current though not then due or payable or other demands, legal 
                  or equitable, which the Bank may have against the Borrower or 
                  which the law of set-off or mutual credit would in any case 
                  admit and whether the Borrower shall become or be adjudicated 
                  insolvent or otherwise, and interest thereon from the date on 
                  which any and all advance or advances in respect thereof shall 
                  have been made at the rate or respective rates at which the 
                  same shall have been so advanced.</p>
                 <p align="justify">(12) That the Borrower agrees to accept as conclusive proof 
                  of the correctness of any sum claimed to be due from them to 
                  the Bank under this Agreement on a statement 01 account made 
                  out from the books of the Bank and signed by the Accountant 
                  or other duly authorised officer of the Bank without the production 
                  of any other voucher, document or paper and also the Borrower 
                  agrees to pay the interest accrued in the account but not debited 
                  to the account in terms of the agreement between the Borrower 
                  and the Bank.</p>
                <p align="justify"> (13) The Borrower hereby further agrees that in case the Borrower 
                commits default in the repayment of the loan or in the repayment 
                of interest thereon on due date/s, the Bank and/or Reserve Bank 
                of India will have an unqualified right to disclose or publish 
                the name of the Borrower or its Directors/partners/proprietor 
                a  defaulter in such manner and through such medium as the Bank 
                or Reserve Bank of India in their absolute discretion may think 
                fit.
              <p align="justify">(14) That the Borrower hereby declares that the said goods 
                  are the absolute property of the Borrower at the sole disposal 
                  of the Borrower and free from any prior charges or encumbrances 
                  and that the Borrower has not done or knowingly suffered or 
                  been a party or privy to anything whereby he is in any vJay 
                  prevented from hypothecating the said goods in manner aforesaid 
                  and that the Borrower will do and execute at his cost all such 
                  acts and things for further and more particularly assuring the 
                  said goods or any part thereof to the Bank as shall be required 
                  by the Bank and for giving better effect to these presents.</p>
              </td>
            </tr>
          </table>
          
          <p>&nbsp;</p>
          <div align="center">
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td>
                  <div align="center"><b><u>SCHEDULE OF GOODS REFERRED TO :</u></b></div>
                </td>
              </tr>
            </table>
            <p>&nbsp;</p><p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5" height="55">
              <tr> 
                <td height="38"><b>IN WITNESS WHEREOF THE BORROWER</b> has hereunto 
                  set his hand this <b><%=date%> </b> day of <b><%=Months[a]%></b><b><%=year%>.</b> 
                </td>
              </tr>
              
            </table> 
            <p>&nbsp;</p> 
          </div> 
          <p>&nbsp; </p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
        </div>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </div>
    </td>
  </tr>
</table> 
</body>
</html>
