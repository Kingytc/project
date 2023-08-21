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
      <div align="center">
        <p><u><b>HYPOTHECATION (GOODS) AGREEMENT (SD-03)</b></u></p>
        <p><u><b><br>
          </b></u></p>
      </div>
    </td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <p align="justify">IN CONSIDERATION of Karnataka Bank Ltd. (hereinafter 
        called the Bank) at the request of <b><%=Helper.correctNull((String)hshValues.get("Title"))%></b> 
        &nbsp;<b><%=Helper.correctNull((String)hshValues.get("appname"))%></b>(hereinafter 
        called the Borrower) opening and/or continuing in the books of the Bank 
        a Banking Account or Accounts of the Borrower and from time to time at 
        the request of the Borrower giving him such advances as he may require 
        and the Bank may be willing to make to the extent of Rs <b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b>(say 
        ____________________) it is hereby agreed between the Bankand the Borrower 
        as follows:-<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxiv)</td>
    <td width="96%"> 
      <p align="justify">That the Borrower hereby hypothecates in favour of the 
        Bank the goods described in general terms in the Schedule hereto (hereinafter 
        referred to as &#147;the hypothecated goods&#148;) which expression shall 
        include (whether specifically mentioned in the schedule or otherwise) 
        all raw materials, semi-finished goods and finished goods, products and 
        moveable property of any kind belonging to the Borrower which now or hereinafter 
        from time to time during this security shall be brought in, stored or 
        to be in or about the Borrower&#146;s premises or godown/s at &#133;&#133; 
        or in the godowns / premises hired by the Borrower for storing them and/or 
        in transit or which may be made to the Borrower or any one or more of 
        them whether alone or jointly on any account current or otherwise and 
        for any liability on bills discounted or held by the Bank at the Borrower&#146;s 
        request or bearing the Borrower&#146;s name and also for other liability 
        on the Borrower&#146;s part to the Bank incurred or which may be incurred 
        at the Borrower&#146;s request on any account whatsoever (including monies 
        owing from a survivor or survivors on any joint account) and whether as 
        principal debtor, surety or guarantor, together with interest and all 
        customary charges thereon. <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxv)</td>
    <td width="96%"> 
      <p align="justify">That the hypothecated goods and realisation therefrom 
        and insurance proceeds shall be held in trust for and on account of the 
        Bank and specially appropriated to this security as Banks exclusive security 
        and the Borrower shall not create any mortgage, charge, lien or encumbrance 
        affecting them or any part thereof nor do anything which would prejudice 
        this security and the Borrower shall not part with the hypothecated goods 
        save by way of sale in the ordinary course of the Borrowers business and 
        as hereinafter provided, nor shall any sale be made after prohibition 
        in writing by the Bank against selling.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxvi)</td>
    <td width="96%"> 
      <p align="justify">That the Borrower shall with the previous consent of 
        the Bank be at liberty from time to time to sell or dispose of in any 
        manner, the hypothecated goods or any part thereof provided the value 
        of such goods is paid to the Bank towards reduction of the Borrowers liability 
        or goods of a similar nature to those or any of those mentioned in the 
        Schedule hereto and of at least equal value are substituted for the goods 
        so sold or disposed of after prior approval of the Bank obtained in writing.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxvii)</td>
    <td width="96%">  
      <p align="justify">That the Borrower shall permit the Bank, their Agents 
        and servants from time to time and at all times to enter upon any godowns 
        or premises wherein the hypothecated goods or any part thereof may for 
        the time being be and to view, inspect and value the same and take inventories 
        thereof or to take possession thereof and render to the Bank and their 
        servants all facilities as may be required for any of the purposes aforesaid.</p>
      <p align="justify">&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxviii)</td>
    <td width="96%"> 
      <p align="justify">That the Borrower shall punctually pay all rents, rates, 
        taxes and other outgoings of the godowns and premises wherein the hypothecated 
        goods shall be and keep the said hypothecated goods free from distress 
        or such claims.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxix)</td>
    <td width="96%"> 
      <p align="justify">That all the hypothecated goods, the subject of this 
        Agreement, shall be insured by the Borrower against fire and theft or 
        any other risk as may be necessary and required by the Bank in its discretion 
        in the joint names of the Borrower and the Bank with some insurance company/companies 
        approved by the Bank to the extent of at least 10% in excess of the invoice 
        value or the market value whichever is less of the hypothecated goods 
        and that the Cover Note/s or the Insurance Policy/policies, certificate/s 
        shall be delivered to the Bank. If the Borrower fails to effect such insurance 
        the Bank may (without being bound to do so and at its discretion) insure 
        the said hypothecated goods against fire and theft or any other risk as 
        may be deemed necessary by the Bank in such joint names and debit the 
        premium and other expenses to such account or accounts as aforesaid as 
        the case may be. The Borrower expressly agrees that the Bank would be 
        entitled to adjust, settle, compromise or refer to arbitration any dispute 
        between the insurance Company and the insured arising under or in connection 
        with such Cover Note/s or policy/Policies and Certificate/s` or under 
        any claim made thereunder and to give valid receipt thereof and the amount 
        so received shall be credited in the account having reference to the said 
        goods in respect of which such amount is received and that the Borrower 
        shall not raise any question that a larger sum might or ought to have 
        been received or be entitled to dispute his liability for the balance 
        remaining due on such account after such credit.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxx)</td>
    <td width="96%"> 
      <p align="justify">The Borrower shall make and furnish to the Bank every 
        month or at such intervals as the Bank may prescribe from time to time, 
        all statements and returns of the cost and market value of the hypothecated 
        goods and full description thereof and produce such evidence in support 
        thereof as the Bank may from to time require and shall from time to time 
        maintain in favour of the Bank a margin of <b> <%=Helper.correctNull((String)hshValues.get("downpay"))%></b>  percent between the invoice 
        value or market value (whichever is less) of the hypothecated goods and 
        the balance due to the Bank for the time being. Such margin shall be calculated 
        on the invoice and/or open market value of the hypothecated goods, whichever 
        is lower and shall be maintained by the Borrower either by hypothecation 
        of further goods to be approved by the Bank in writing or by cash payment 
        by the Borrower immediately on the market value of the time being of the 
        hypothecated goods becoming less than the aggregate of the balance due 
        to Bank plus the amount of the margin calculated above.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxxi) (a) </td>
    <td width="96%"> 
      <p align="justify">That the Borrower shall pay to the bank interest on the 
        amount of the advance/advances for the time being outstanding at the rate 
        of <b> <%=Helper.correctNull((String)hshValues.get("mintrate"))%></b> 
        percentage per annum with <b><%=loanperiodicity %></b> rests or at such 
        other revised rate/s as may be prescribed by the Bank from time to time 
        depending upon the changes in the Prime Lending Rate of the Bank or upon 
        the directives of Reserve Bank of India from time to time or the policy 
        of the Bank on advances, such interest to be payable, whether actually 
        debited to the account or not, and until so paid shall form part of the 
        advance/s granted by the Bank to the Borrower and the Borrower agrees 
        to execute necessary Promissory notes and/or debit balance confirmations 
        accordingly from time to time.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxxii)</td>
    <td width="96%"> 
      <p align="justify">In the event of any revision in the rate of interest, 
        the Borrower shall be deemed to have notice of revision in the rate of 
        interest whenever such revision in Prime Lending Rate is displayed/notified 
        by the bank on the notice board in the Branch premises where the advance/advances 
        is/are availed by the borrower or published in the Newspaper/s, or made 
        known through entry of interest charged in the statement of account given 
        to the Borrower/s.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(c)</td>
    <td width="96%"> 
      <p align="justify">Provided further that, without prejudice to the Banks 
        other rights and remedies, the Bank shall also be entitled to charge, 
        in its discretion, additional/penal rate/s of interest at the rate of 
        2% p.a. or at such other rate as the Bank may from time to time prescribe 
        in accordance with its policy determine as payable on the outstanding 
        dues or any portion thereof for any delay in repayment/adjustment of the 
        advances and/or interest as agreed or in default or irregularity in observing 
        the terms and conditions of this Agreement by the Borrower which in the 
        opinion of the Bank warrants charging of penal interest for such period 
        as the Bank may deem fit.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxxiiii)</td>
    <td width="96%"> 
      <p align="justify">That on demand being made by the Bank, the Borrowers 
        shall repay to the Bank all monies or liabilities then outstanding and 
        owing to the Bank on such account/s as aforesaid together with interest 
        at the rate aforesaid and the amount of all other charges and expenses, 
        if any, provided that nothing contained shall be deemed to prevent the 
        Bank from demanding payment of interest for the time being due at the 
        abovementioned rate without at the same time demanding payment of the 
        balance due to the Bank in the abovementioned rate exclusive of such interest. 
        <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxxiv)</td>
    <td width="96%"> 
      <p align="justify">)That in default of such payment as aforesaid and/or 
        on failure of the Borrower to furnish to the Bank the stock statements 
        and/or margin money as referred to in clause 7 above, the Bank and their 
        officers and Agents shall be entitled at any time as if absolute owners 
        and without notice to the Borrower to enter and remain at any place where 
        the hypothecated goods shall be and to take possession of, recover and 
        receive the same and/or appoint any officer or officers of the Bank as 
        Receiver or Receivers of the hypothecated goods and/or sell by public 
        auction or private contract or otherwise dispose of or deal with all or 
        any part of the hypothecated goods and to enforce, realise, settle, compromise 
        and deal with any of the rights aforesaid without being liable for any 
        loss in the exercise thereof and without prejudice to the Banks rights 
        and remedies of suit against the Borrower and to apply the net proceeds 
        of such sale in or towards liquidation of the balance due to the Bank. 
        The Borrower hereby agrees to accept the Bank?s account of sales, realisation 
        and to pay any shortfall or deficiency therein shown.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxxv)</td>
    <td width="96%"> 
      <p align="justify">That if the net sum realised by such sale be insufficient 
        to cover the balance then due to the Bank, the Bank shall be at liberty 
        to apply any other monies or money in the hands of the Bank standing to 
        the credit of or belonging to the Borrower in or towards payment of the 
        balance for the time being to the Bank and in the event of there not being 
        any such money or monies as aforesaid in the hands of the Bank or in the 
        event of such money or monies being insufficient for the discharge in 
        full of such balance the Borrower promises and agrees forthwith on production 
        of the account prepared and signed as hereinafter provided to any further 
        balance which may appear to be due by the Borrower thereon PROVIDED ALWAYS 
        that nothing herein contained shall be deemed to negative, qualify or 
        otherwise prejudicially affect the right of the Bank (which it is hereby 
        expressly agreed the bank shall have) to recover from the Borrower the 
        balance for the time being remaining due from the Borrower to the Bank 
        upon the said Accounts notwithstanding that all or any of the said hypothecated 
        goods may not have been realised.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxxvi)</td>
    <td width="96%"> 
      <p align="justify">That in the event of their being a surplus available 
        of the net proceeds of such sale after payment in full of the balance 
        due to the Bank it shall be lawful for the Bank to retain and apply the 
        said surplus together with any other money or monies belonging to the 
        Borrower whether solely or jointly with any other person or persons, firm 
        or company to the Bank by way of loans, discounted bills, Letter of Credit, 
        Guarantees, Charges or of any other debt or liability including Bills, 
        Notes, Credits and other obligations current though not then due or payable 
        or other demands, legal or equitable which the Bank may have against the 
        Borrower or which the law of set-off or mutual credit would in any case 
        admit and whether the Borrower shall become or be adjudicated bankrupt 
        or insolvent or be in liquidation or otherwise, and interest thereon from 
        the date on which any or all the advance or advances in respect thereof 
        shall have been made at the rate or respective rates at which the same 
        shall have been so advanced.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxxvii)</td>
    <td width="96%"> 
      <p align="justify">That the Borrower agrees to accept as conclusive proof 
        of the correctness of any sum claimed to be due from them to the Bank 
        under this Agreement a statement of account made out from the books of 
        the Bank (with or without interest being debited therein) and signed by 
        a duly authorised officer of the Bank without the production of any other 
        voucher, document or paper as also agrees to pay all the interest accrued/to 
        accrue and not debited in the account. <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxxxviii)</td>
    <td width="96%"> 
      <p align="justify">That this Agreement is to operate as security for the 
        ultimate balance or aggregate balances with interest thereon to become 
        payable upon the said account or accounts as aforesaid and the said account 
        or accounts is/are not considered to be closed for the purpose of this 
        security and the security is not to be considered exhausted merely by 
        reason of the said account or accounts or either or any of them being 
        brought to credit at any time or from time to time or of the Borrower 
        having drawn to the full extent of the aforesaid sum of Rs <b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b>.if 
        afterwards an account or accounts is/are opened by the payment to credit, 
        and if the whole of the banks advances shall be repaid and the whole of 
        the security be withdrawn the account or accounts or either or any of 
        them may nevertheless at any time before such account or accounts has 
        or have been closed be continued under this Agreement upon security as 
        aforesaid being again furnished / continued.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%"valign="top">(cxxxix)</td>
    <td width="96%"> 
      <p align="justify">)That the Borrower hereby declares that all the hypothecated 
        goods are the absolute property of the Borrower at the sole disposal of 
        the Borrower and free from any prior charge or encumbrance and that all 
        future goods and property hereunder shall be likewise their unencumbered 
        property and that the Borrower has not done or knowingly suffered or been 
        a party or privy to anything whereby he is anyway prevented from hypothecating 
        the hypothecated goods in the manner aforesaid and assuring the hypothecated 
        goods or any part thereof in favour of the Bank as shall be required by 
        the Bank and/or their officer/s, attorney/s for and in the name of the 
        Borrower to act on behalf of the Borrower and to execute and do any act, 
        assurance and things which the Borrower ought to execute and do under 
        these Presents and generally to do all the acts in the name of the Borrower 
        in exercise of the powers hereby conferred.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxl)</td>
    <td width="96%"> 
      <p align="justify">That the Borrower shall not during the continuance of 
        this Agreement hypothecate or otherwise charge or encumber any of the 
        hypothecated (ii)goods over which the lien of the Bank shall extend or 
        be expressed or intended to extend nor do or permit any act whereby the 
        security hereinbefore expressed to be given to the Bank shall be in any 
        way prejudicially affected. <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxli)</td>
    <td width="96%"> 
      <p align="justify">Without prejudice to the terms contained hereinabove, 
        it shall be lawful for the Bank to debit the Borrowers current or cash 
        credit account the expenses incurred by the Bank towards inspection or 
        valuation of the said goods or legal expenses or any other reasonable 
        expenses incurred by the Bank for preservation and protection of the hypothecated 
        goods or in pursuance of this Agreement.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxlii)</td>
    <td width="96%"> 
      <p align="justify">The Borrower hereby further agrees that in case the Borrower 
        commits default in the repayment of the loan or in the repayment of interest 
        thereon on due date/s, the Bank and/or Reserve Bank of India will have 
        an unqualified right to disclose or publish the name of the Borrower or 
        its Directors/partners/proprietor as defaulters in such manner and through 
        such medium as the Bank or Reserve Bank of India in their absolute discretion 
        may think fit.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxliii)</td>
    <td width="96%"> 
      <p align="justify">The Borrower further agrees that if the advance is eligible 
        for the cover of the Credit Guarantee Fund Scheme formulated by Small 
        Industries Development Bank of India or any other such Scheme formulated 
        by Government of India, the Borrower agrees to pay the guarantee fee and 
        annual service fee thereon and in the absence of such payment Bank may 
        debit the current or cash credit account of the Borrower for the said 
        amount/s and it is further agreed that such payment/debit shall not reduce 
        the liability of the Borrower under these Presents nor the Borrower shall 
        be entitled to claim or receive any benefit thereof or to dispute its 
        liability on the ground that the Bank has received any benefit thereunder. 
        <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td width="4%" valign="top">(cxliv)</td>
    <td width="96%"> 
      <p align="justify">That should the Borrower be more than one individual, 
        all shall be bound hereunder jointly and severally and if a firm or members 
        of a firm, such firm and all members from time to time thereof shall be 
        bound hereby jointly and severally notwithstanding any changes in the 
        constitution or style thereof and whether such firm consists of or reduced 
        to one individual at any time and that should the Borrower be a Limited 
        Company, a corporate or unincorporated body, committee, firm, partnership, 
        trustees or debtors on a joint account, the provisions hereinbefore contained 
        shall be construed and take effect where necessary as if words importing 
        the singular number included also the plural number and lastly that if 
        the Borrower be more than one individual at any time any notice served 
        on any one of such individuals shall be deemed to be service of such notice 
        on all such individuals.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td valign="top"> (cxlv) </td>
    <td> 
      <p align="justify">Notwithstanding anything to the contrary contained in 
        the above or any other agreement for the time being in force, the Bank 
        has a right to recall the advances or any part thereof if it apprehends 
        or has reason to believe that the advances covered by this Agreement is 
        not utilised for any purpose for which it has been sanctioned.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td colspan="2">
      <p>&nbsp;</p>
      <p>SCHEDULE OF GOODS REFERRED TO IN WITNESS WHEREOF the Borrower has hereunto 
        put his hand seal this---<b> <%=date%>th <%=Months[a]%>, <%=year%></b>. 
      </p>
    </td>
  </tr>
</table>


</body>
</html>
