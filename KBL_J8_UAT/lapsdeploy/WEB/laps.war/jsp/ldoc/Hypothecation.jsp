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
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="right"><b><u>FORMAT 18</u></b></div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <div align="center"><b><u>AGREEMENT OF HYPOTHECATION (Foreign Currency Loan)<br>
        </u></b></div>
    </td>
  </tr>
  <tr>
    <td><b>(Annexure 1 to IC No.5712 dated 3.8.1998 )</b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>To</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td><b>KARNATAKA BANK LTD.</b></td>
  </tr>
  <tr>
    <td> <b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b> Branch</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justify">IN CONSIDERATION of KARNATAKA BANK LTD. (hereinafter called &#147;the 
      Bank&#148;), at the request of _____________________________________________ 
      _______________________________________________ (hereinafter called &#147;the 
      Borrowers&#148;) opening and or continuing in the books of the Bank a Banking 
      Account or Accounts of the Borrower and from time to time at the request 
      of the Borrower granted/agreeing to grant credit facilities to the Borrower 
      in the nature of Working Capital Demand Loan (WCDL) or Foreign Currency 
      Loan (FCL) the Borrower agrees as hereunder written :</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>IT IS HEREBY AGREED between the Bank and the Borrower as follows :</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%">(ii)</td>
    <td width="98%"> The expression &#147;the Borrower&#148; shall when the borrower 
      is :</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%">&nbsp;</td>
    <td width="98%"> 
      <p align="justify">(ii)An individual include his or her heirs, executors, administrators 
        and assigns;<br>
        (iii)A firm include its partners for the time being of the firm; their 
        respective heirs, executors, administrators and assigns and/or the surviving 
        partners.<br>
        (iv)A company include its successors and assigns;<br>
        (v)A joint and undivided Hindu family or a joint family firm include its 
        co-parceners;<br>
        (vi)An Association corporate or incorporate include its successors and 
        assigns and all members and their respective heirs, executors, administrators 
        and assigns<br>
        (ii)A trust, whether public or private, the trustee or trustees for the 
        time being.</p>
      </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td width="98%"><p align="justify"> At the request of Borrower, the Bank has agreed to grant 
      FCL facility to the extent of US $ ___________ (US Dollars _______________), 
      separately or out of WCDL facility of Rs. ________ (Rs. _______________________________) 
      for payment towards the goods imported/to be imported and more particularly 
      described in the Schedule hereunder written, on the following terms and 
      conditions.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the Borrower hereby hypothecates by way of first charge in favour 
      of the Bank all the goods described in general terms in the Schedule hereto 
      (hereinafter referred to as &#147;the hypothecated goods&#148;) which expression 
      shall include all products, good and moveable property of any kind belonging 
      to the Borrower which now or hereinafter from time to time during this security 
      shall be bought in, stored or be in or about the Borrower&#146;s premises 
      or godown/s at ________________________________ and/or in transit or with 
      Borrower&#146;s Agents or wherever else they may be as security for advances 
      made or which may be made to the Borrower or any one or more of them whether 
      alone or jointly on any account, current or otherwise and for any liability 
      on bills discounted or held by the Bank at the Borrower&#146;s request or 
      bearing the Borrower&#146;s name and also for other liability on the Borrower&#146;s 
      part to the Bank incurred or which may be incurred at the Borrower&#146;s 
      request on any account whatsoever (including monies owing from a survivor 
      or survivors on any joint account) and whether as principal debtor, surety 
      or guarantor, together with interest and all customary charges thereon. 
      And the Borrower agrees that in so far as the Borrower is a party to this 
      Agreement by way of surety or guarantor the Bank may enter into any contract 
      with the principal debtor for the purpose of giving time for payment or 
      for any other purpose without prejudice to the rights of the Bank against 
      the Borrower as such surety or guarantor.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the hypothecated goods and all sales and realisation therefrom 
      and Insurance proceeds thereof shall be held in trust for and on account 
      of the Bank as the Bank&#146;s exclusive property especially appropriated 
      to this security and the Borrower shall not create any mortgage, lien or 
      encumbrance affecting them or any part thereof nor do anything which would 
      prejudice this security and the Borrower shall not part with the hypothecated 
      goods save by way of sale in the ordinary course of the Borrower&#146;s 
      business and as hereinafter provided nor shall any sale be made after prohibition 
      in writing by the Bank against selling.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the Borrower shall with the previous consent of the Bank be 
      at liberty from time to time to sell or dispose of in any manner, the hypothecated 
      goods or any part thereof provided the advance value of such goods is paid 
      to the Bank towards reduction of the Borrower&#146;s liability or goods 
      of a similar nature to those or any of those mentioned in the Schedule hereto 
      and of at least equal value are substituted for the goods so sold or disposed 
      off after approval of the Bank obtained in writing.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the Borrower shall permit the Bank, their Agents and servants 
      from time to time and at all times to enter upon any godowns or premises 
      wherein the hypothecated goods or any part thereof may for the time being 
      be and to view, inspect and value the same and take inventories thereof 
      or to take possession thereof and render to the Bank and their servants 
      all facilities as may be required for any of the purposes aforesaid.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> That the borrower shall punctually pay all rents, rates, taxes and 
      other outgoings of the godowns and premises wherein the hypothecated goods 
      shall be kept/stored and keep the hypothecated goods free from distress 
      or attachment of any kind whatsoever.<br>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify"> That all the hypothecated goods, the subject of this Agreement, shall 
      be insured by the Borrower against fire risk and any other risk as may be 
      necessary and required by the Bank in its discretion in the joint names 
      of the Borrower and the Bank, with some Insurance Company/Companies approved 
      by the Bank to the extent of at least 10% in excess of the Invoice value 
      or the market value whichever is lesser of the hypothecated goods and that 
      the Cover Note/s or the Insurance Policy/Policies Certificate/s shall be 
      delivered to the Bank. If the Borrower fails to effect such insurance the 
      Bank may insure the said hypothecated goods against fire and any other risk 
      as may be deemed necessary by the Bank in its discretion in such joint names 
      and debit the premium and other charges to such account/s as aforesaid as 
      the case may be. The Borrower expressly agrees that the Bank would be entitled 
      to adjust, settle, compromise or refer to arbitration any dispute between 
      the Insurance Company and the insured, arising under or in connection with 
      such Cover Note/s or Policy/Policies and Certificate/s and such adjustment, 
      settlement, compromise and any award made on such arbitration shall be valid 
      and binding on the Borrower and also to receive all monies payable under 
      any such Cover Note, Policy or Certificate or under any claim made thereunder 
      and to give a valid receipt thereof and the amount so received shall be 
      credited in the account having reference to the said goods in respect of 
      which such amount is received and that the Borrower shall not raise any 
      question that a large sum might or ought to have been received or be entitled 
      to dispute his liability for the balance remaining due on such account after 
      such credit.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the Borrower shall make and furnish to the Bank every month 
      or at such intervals as the Bank may prescribe from time to time, all statements 
      and returns of the cost and market value of the hypothecated goods and full 
      description thereof and produce such evidence in support thereof as the 
      Bank may from time to time require and shall maintain in favour of the Bank 
      a margin of ______ percent between the Invoice value or market value (whichever 
      is less) from time to time of the hypothecated goods, and the balance due 
      to the Bank for the time being. Such margin shall be calculated on the Invoice 
      and/or open market value of the hypothecated goods, whichever is lower and 
      shall be maintained by the Borrower either by hypothecation of further goods 
      to be approved by the Bank in writing or by cash payment in Dollars by the 
      Borrower immediately, if the market value for the time being of the hypothecated 
      goods becoming less than the aggregate of the balance due to the Bank plus 
      the amount of the margin as calculated above.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the Borrower shall pay to the Bank interest on amount of the 
      advance/s for the time being outstanding, at a rate of <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("strLoanModIntrate"))%></b> percentage 
      points over LIBOR rate fixed at six monthly intervals viz. ________ and 
      ________ with quarterly rests in US Dollars and/or at such other rests as 
      may be prescribed by the Bank from time to time such interest to be charged 
      in Borrower/s account/s kept separately and to be paid by Borrower in US 
      Dollars by quarterly rests and until so paid shall form part of the advance(s) 
      granted by the Bank to the Borrower</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> That Borrower agrees to repay the outstandings under FCL including 
      principal, interest and costs in US Dollars within 180 days from the date 
      of disbursal of the FCL. The borrower undertakes to repay the FCL together 
      with interest as narrated in clause 10 above on maturity date or the extended 
      date as mentioned in clause 12 hereinbelow in any of the following ways 
      :</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%"><p align="justify">(ii)By submission of export documents<br>
      (iii)From proceeds of exports bills on collection basis<br>
      (ii)By purchase of foreign currency from the bank on maturity at Bank&#146;s 
      spot selling rate or at the agreed rate in the case of forward contracts.<br>
      (iii)By deposit of Foreign Currency amount in the FCL account equivalent 
      to the dues.</p> </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That in case the FCL is required to be extended for a further period, 
      the Borrower shall give an advance notice of a minimum of 2 weeks, to enable 
      the Bank to consider the same. It is understood by the borrower that any 
      extension/roll over of the FCL is at the absolute discretion of the Bank 
      and subject to availability of Foreign Currency funds and subject to other 
      terms and conditions which will be prescribed by the Bank at that time including 
      rate of interest. In the event the Bank does not accede to the request of 
      the borrower for extension/roll over, the Borrower hereby agrees to repay 
      outstanding under the FCL forthwith. In the event of the request of the 
      Borrower for extension/roll over, being accepted the Bank is hereby authorised 
      to debit to CD/CC accounts of the borrower the accrued interest in FCL till 
      such date at appropriate TT selling rate.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify"></p>That the Borrower understands that FCL is exposed to Exchange Risk 
      and accordingly undertakes to hedge the exchange risk, either by matching 
      export receivables to the loan amount at maturity or by booking of Forward 
      contract and that Exchange cover is to be taken unless the Bank permits 
      waiver of the same and in case of waiver, the bank may stipulate a suitable 
      margin, in lieu of Exchange Cover, which the Borrower undertakes to maintain 
      with the Bank and in case the Exchange risk of Foreign Currency Loan remains 
      uncovered, Borrower undertakes to repay the loan plus interest thereon by 
      purchase of Foreign Currency from the Bank at appropriate rate prevalent 
      on the date of repayment and depositing the same in the Bank.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That in case of Borrower&#146;s default to repay the Foreign Currency 
      Loan together with interest within 180 days or within the extended period, 
      or as per the terms of this agreement, the Bank shall at its option may 
      convert the outstandings under the FCL into Indian Rupees at the rate of 
      exchange prevailing on 180th day or on the last day of extended period and 
      the borrower shall accept his liability to repay the said outstanding in 
      Indian Rupees so informed to him by the Bank and forthwith repay the same 
      and till then outstandings under FCL shall stand secured and charged by 
      the securities mentioned herein. However, the Bank may at its discretion 
      call upon the borrower to repay the outstandings under FCL in US Dollars 
      only and nothing stated hereinabove in this clause shall prevent the Bank 
      from insisting on the borrower to repay the dues in Dollars or other appropriate 
      foreign currency only.</p>/td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify">That in default of such payment as aforesaid and/or on failure of 
      the borrower to furnish to the bank the stock statements and/or margin money, 
      as referred in clause 9 above, the Bank and their officers and Agents shall 
      be entitled at any time as if absolute owners and without notice to the 
      Borrower but at the Borrower&#146;s risk and expenses and if so required 
      as attorneys for and in the name of the Borrower to enter and remain at 
      any place where the hypothecated goods shall be and to take possession of, 
      recover and receive the same and/or appoint any officer or officers of the 
      bank as receiver or receivers of the hypothecated goods and/or sell by public 
      auction or private contract or otherwise, dispose off or deal with all or 
      any part of the hypothecated goods and to enforce, realise, settle, compromise 
      and deal with any of the rights aforesaid without being bound to exercise 
      any of these powers or being liable for any loss in the exercise thereof 
      and without prejudice to the bank&#146;s rights and remedies of suit against 
      the borrowers and to apply the net proceeds of such sale in or towards liquidation 
      of the balance dues to the bank. The borrower hereby agrees to accept the 
      bank&#146;s account of sale realisation and to pay any shortfall or deficiency 
      therein shown.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the Borrower agrees that in the event of breach of any of the 
      terms mentioned hereinabove and/or contained in this agreement or in any 
      request letter for FCL executed by the Borrower, the bank shall be entitled 
      to recall the said loan along with interest due as specified in clause 10 
      above. The borrower further undertakes to adjust the outstanding under the 
      said FCL along with interest as stated above within one week of the date 
      of receipt of notice from the bank.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify">That if the net sum realised by such sale be insufficient to cover 
      the balance then due to the Bank, the Bank shall be at liberty to apply 
      any other monies or money in the hands of the Bank standing to the credit 
      of or belonging to the Borrower in or towards payment of the balance for 
      the time being due to the Bank and in the event of there not being any such 
      money or monies as aforesaid in the hands of the Bank or in the event of 
      such money or monies being still insufficient for the discharge in full 
      of such balance, the Borrower promises and agrees forthwith on production 
      of any account prepared and signed as hereinafter provided to pay any further 
      balance which may appear to be due by the borrower thereon PROVIDED ALWAYS 
      that nothing herein contained shall be deemed to negative, qualify or otherwise 
      prejudicially affect the right of the Bank (which it is hereby expressly 
      agreed the bank shall have) to recover from the borrower the balance for 
      the time being remaining due from the borrower to the Bank upon the said 
      accounts notwithstanding that all or any of the said hypothecated goods 
      may not have been realised.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That in the event of there being a surplus available of the net proceeds 
      of such sale after payment in full of the balance due to the Bank it shall 
      be lawful for the Bank to retain and apply the said surplus together with 
      any other money or monies belonging to the Borrower for the time being in 
      the hands of the Bank in or under whatever account as far as the same shall 
      extend against in or towards payments or liquidation of any and all other 
      monies which shall be or may become due from the Borrower whether solely 
      or jointly with any other person or persons, firm or company to the Bank 
      by way of loans, discounted bills, letter of credit, Guarantees, charges 
      or of any other debt or liability including bills, notices, credits and 
      other obligation current though not then due or payable or other demands, 
      legal or equitable which the Bank may have against the Borrower or which 
      the Bank may have against the Borrower or which the law of set-off of mutual 
      credit would in any case admit and whether the Borrower shall become or 
      be adjudicated bankrupt or insolvent, or be and in liquidation or otherwise 
      and interest thereon from the date on which any and all advance/s in respect 
      thereof shall have been made at the respective rates at which the same shall 
      have been so advanced.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify"> That the Borrower agrees to accept as conclusive proof of the correctness 
      of any sum claimed to be due from them to Bank under this agreement a statement 
      of account made out from the books of the Bank and signed by the accountant 
      or other duly authorised officer of the Bank without the production of any 
      other voucher, document or paper.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify"> That this agreement is to operate as security for the ultimate balance 
      or aggregate balance with interest thereon to become due upon the said account 
      or accounts as aforesaid and in the case of FCL derived out of/carved out 
      of WCDL, the payment in full of outstandings under FCL shall no way affect 
      the continuation of WCDL facility as per the limit then existing and/or 
      modified from time to time and nothing in this agreement shall have the 
      effect of releasing the hypothecated securities as per schedule annexed 
      hereto, for the purpose of the WCDL, being continued after closure of FCL.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify">The Branch agrees to comply with the provisions of all the statutes, 
      rules and regulations made from time to time in respect of import or export 
      of goods and directives issued by the Bank, RBI, SEBI, or Government of 
      India or other statutory authorities from time to time.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the Borrower hereby declares that all the hypothecated goods 
      are the absolute property of the Borrower at the sole disposal of the Borrower 
      and free from any prior charge or encumbrance and that all future goods 
      and property hereunder shall be likewise their unencumbered, undisposed 
      property and that the Borrower has not done or knowingly suffered or been 
      a party or privy to anything whereby he is in any way prevented from hypothecating 
      the hypothecated goods in the manner aforesaid and that the borrower will 
      do and execute at its cost all such acts and things for further and more 
      particularly assuring the hypothecated goods or any part thereof in favour 
      of the Bank as shall be required by the Bank and for giving better effect 
      to these presents, the Borrower authorises and irrevocably nominates and 
      appoints the Bank and/or their officer/s attorney/s for and in the name 
      of the Borrower to act on behalf of the Borrower and to execute and do any 
      act, assurance and things which the Borrower ought to execute and do under 
      these presents and generally as the Borrower in the exercise of the powers 
      hereby conferred.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify">That the Borrower shall not during the continuance of this agreement 
      hypothecate or otherwise charge or encumber any of the hypothecated goods 
      over which the lien of the Bank shall extend or be expressed or intended 
      to extend nor do or permit any act whereby the security hereinbefore expressed 
      to be given to the Bank shall be in any way prejudicially affected.</p></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td> <p align="justify">That the borrower confirms that the representations made to the Bank 
      for availing FCL/WCDL vide his letter dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> are correct 
      and further agrees that the said letter and the terms of sanction communicated 
      by the Bank vide its Sanction Advice dated <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> shall form part 
      of this Agreement and be binding on the Borrower.<br></p>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="2%" valign="top">(ii) </td>
    <td><p align="justify"> That should the Borrower be more than one individual, all shall be 
      bound hereby jointly and severally and if a firm or members of a firm, such 
      firm and all members from time to time thereof shall be bound hereby jointly 
      and severally notwithstanding any changes in the constitution or style thereof 
      and whether such firm consists of or be reduced to one individual at any 
      time and that should borrower be a Limited Company, a Corporate or Unincorporate 
      body, Committee, Firm, Partnership, Trustees or Debtors on a joint account, 
      the provisions hereinbefore contained shall be construed and take effect 
      where necessary as if words importing the singular number included also 
      the plural number and lastly that if the Borrower be more than one individual 
      at any time any notice served on any one of such individual shall be deemed 
      to be service of such notice on all such individuals.</p></td>
  </tr>
</table>
<p>&nbsp;</p>
<p><br>
</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center"><b>SCHEDULE OF GOODS REFERRED TO</b></div>
    </td>
  </tr>
</table>
<p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> IN WITNESS WHEREOF the Borrower has hereunto put his hand and seal this.. 
      <b><%=date%>th <%=Months[a]%>, <%=year%></b></td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
