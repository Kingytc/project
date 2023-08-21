<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
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
<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td colspan="2" align="center"><b> HYPOTHECATION AGREEMENT OF GOODS & DEBTS 
      (SD-06)<br>
      </b></td>
  </tr>
  <tr> 
    <td colspan="2"><b>Karnataka Bank Ltd.,</b><br>
      <b><%=Helper.correctNull((String) hshValues.get("branchName"))%> Branch<br>
      </b></td>
  </tr>
  <tr> 
    <td colspan="2">
      <p align="justify">Dear Sir, Karnataka Bank Ltd., (hereinafter called "the 
        Bank" which includes its successors and assigns from time to time) at 
        the request of <b><%=Helper.correctNull((String) hshValues.get("appname"))%></b> 
        (hereinafter called "the Borrower") having granted/ agreed to grant accommodation 
        by way of opening and/or continuing in the books of the Bank, banking 
        account or accounts of the Borrower and from time to time at the request 
        of the Borrower giving him such advances as he may require and the Bank 
        may be willing to make to the extent of Rs.<b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> 
        (Rupees <b><%=Helper.figtoWords((String)hshValues.get("sancamount"))%></b>) 
        on the security hereof. IT IS AGREED AS FOLLOWS: </p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">1. </td>
    <td width="94%">
      
      <p align="justify">The Borrower hereby hypothecates by way of FIRST CHARGE IN FAVOUR OF 
        THE BANK:</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">(i) </td>
    <td width="94%"> <p align="justify">the goods described in general terms in the Schedule hereto 
      (hereinafter referred to as "the said goods") which expression shall include 
      (whether specifically mentioned or otherwise) all raw materials, semi finished 
      and finished goods, consumable stores & spares and moveable property of 
      any kind now or at any time hereafter belonging to or at the disposal of 
      the Borrower and which are now stored or being stored or which hereafter 
      may from time to time be brought into or stored or be in or about the Borrower's 
      premises or godown/s at ___________________ and at other places hired by 
      the Borrower for the purposes of storage in the Union of India and all other 
      places of storage whatsoever at or at any other place in the Union of India 
      or wherever else they may be including any of the said goods with any of 
      the Borrower's agents or at any of the Borrower's agencies or in course 
      of by the ship, rail or otherwise, and </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (ii) </td>
    <td width="94%"> <p align="justify">the Borrower's book-debts, outstandings, monies, deposits, 
      receivables, claims and bills, contracts, securities, investments which 
      are now due and owing or which may at any time hereafter during the continuance 
      of this security becoming due and owing to the Borrower in the course of 
      its business by any person or party including any Government or any local 
      or public body or authority (all of which are hereinafter collectively referred 
      to as "the said debts") as security for advances made or which may be made 
      to the Borrower or any one or more of them whether alone or jointly on any 
      account current or otherwise and for the payment to the Bank on demand of 
      the balance at any time on any account current or otherwise and also for 
      the payment and discharge of the Borrower's present and future indebtedness 
      and liabilities to the Bank (including any account guaranteed by the Borrower 
      and whether such guarantees are for the time being contingent only) of any 
      kind in any manner whether matured or not and whether incurred by the Borrower 
      alone or jointly with others and whether as principal or surety and whether 
      absolute or contingent and also for any liability on bills discounted or 
      held by the Bank at the Borrower's request or bearing the Borrower's name 
      and also for any other liability on the Borrower's part to the Bank incurred 
      or which may be incurred at the Borrower's request on any account whatsoever 
      (including monies owing from a survivor or survivors on any joint account) 
      and whether as principal debtor, surety or guarantor together with all interest, 
      discount, commission, charges, costs (as between attorney and client) and 
      expenses payable to or incurred by the Bank in relation to any such indebtedness 
      or liabilities and the Borrower agrees that in so far as the Borrower is 
      a party to this agreement by way of surety or guarantor the Bank may enter 
      into any contract with the principal debtor for the purpose of giving time 
      for payment or for any other purpose without prejudice to the rights of 
      the Bank against the Borrower as such surety or guarantor. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">2. (a)</td>
    <td width="94%"> 
      <p align="justify">That the Borrower shall pay to the bank interest on the 
        amount of the advance/advances for the time outstanding at the rate of 
        <b><%=Helper.correctNull((String)hshValues.get("mintrate"))%></b> percentage 
        per annum with <b><%=loanperiodicity%></b> rests or at such other revised 
        rate/s as may be prescribed by the Bank from time to time depending upon 
        the changes in the Prime Lending Rate of the Bank or the directives of 
        Reserve Bank of India from time to time or the policy of the Bank on advances, 
        such interest to be payable, whether actually debited to the account or 
        not, and until so paid shall form part of the advance/s granted by the 
        Bank to the Borrower and the Borrower agrees to execute necessary Promissory 
        notes or Debit balance confirmations accordingly from time to time.</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (b)</td>
    <td width="94%"> <p align="justify">In the event of any revision in the rate of interest, the 
      Borrower shall be deemed to have notice of revision in the rate of interest 
      whenever such revision in Prime Lending Rate is displayed/notified by the 
      Bank on notice board in the branch premises where the advance/advances is/are 
      availed by the Borrower or published in the Newspaper/s, or made known through 
      entry of interest charged in the statement of account given to the Borrower. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (c)</td>
    <td width="94%"><p align="justify"> Provided further that, without prejudice to the Bank's other 
      rights and remedies, that the Bank shall also be entitled to charge, in 
      its discretion, additional/penal rate/s of interest at the rate of 2% p.a. 
      or at such other rate as the Bank may from time to time provide in accordance 
      with its policy on the outstanding dues or any portion thereof for any delay 
      in repayment/adjustment of the advances and/or interest as agreed or in 
      default or irregularity in observing the terms and conditions of this agreement 
      by the Borrower which in the opinion of the Bank warrants charging of such 
      penal interest for such period as the Bank may deem fit.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">3. </td>
    <td width="94%"> 
      <p align="justify">The Bank shall not be required to make or continue advances 
        on the said account/s otherwise than at the Bank's discretion and in no 
        circumstances to an amount at any one time exceeding with interest the 
        sum of Rs.<b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> 
        and the Bank may at any time close the said account/s and demand payment 
        of the balance thereof. </p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">4. </td>
    <td width="94%"><p align="justify"> The Borrower shall on demand pay to the Bank all monies or 
      liabilities then outstanding and owing to the Bank on such account or accounts 
      as aforesaid together with interest at the rate aforesaid and the amount 
      of all other costs, charges and expenses and legal costs (as between attorney 
      and client), provided that nothing contained in this clause shall be deemed 
      to prevent the Bank from demanding payment of interest for the time being 
      due at the above-mentioned rate without at the same time demanding payment 
      of the balance due to the Bank exclusive of such interest.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">5. </td>
    <td width="94%"> <p align="justify">The advance so obtained shall be wholly applied in the ordinary 
      course of and for the purposes of the Borrower's business.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">6. </td>
    <td width="94%"> <p align="justify">Subject to the provisions herein and the Bank?s rights created 
      by this security, the Borrower may in the ordinary course of business sell 
      and dispose off any of the said goods. But the Borrower shall on each and 
      every such sale on receipt of the documents or sale proceeds deliver the 
      documents or pay the net proceeds of sale in satisfaction so far as the 
      same will extend to the balance then due and owing on the account or accounts 
      kept by the Bank in respect of such accommodation/s, and / or thereupon 
      goods of a similar nature to those or any of those mentioned in the schedule 
      hereto of equal value are substituted for the goods so sold or disposed 
      of so as to maintain the value of the security provided that the Borrower 
      shall not make any sale of any of the said goods upon being prohibited in 
      writing by the Bank from doing so.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> 7. </td>
    <td width="94%"> <p align="justify">The Borrower shall punctually pay all rents, rates, taxes 
      and other outgoings of the godowns and premises where the said goods shall 
      be and shall keep the said goods free from distress. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">8. </td>
    <td width="94%"> <p align="justify">The Borrower agrees to accept as conclusive proof the correctness 
      of any sum claimed to be due from the Borrower to the Bank as per statement 
      of account made out from the books of the Bank and signed by the Accountant 
      or other duly authorised officer of the Bank without the production of any 
      other voucher, document or paper and also the Borrower also agrees to repay 
      the amount accrued but not actually debited to the account/s. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">9.</td>
    <td width="94%"> <p align="justify">The Borrower shall at his risk, costs and expenses keep the 
      said goods in good marketable condition and re-condition all the said goods 
      from time to time. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> 10. (i)</td>
    <td width="94%"><p align="justify">The Borrower shall at all times during the continuance of 
      this security and from time to time insure the said goods and keep them 
      insured against loss or damage by fire, lightening, riot, civil commotion, 
      strike or any other risks as may be required by the Bank or by law in the 
      joint names of the Borrower and the Bank with insurance companies previously 
      approved of in writing by the Bank to the extent of at least 10% in excess 
      of full marketable value of the said goods as determined by the Bank in 
      its sole discretion and punctually pay the premia due for such insurance 
      and that the cover note/s, insurance policy/policies or certificate/s shall 
      be delivered to the Bank. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (ii) </td>
    <td width="94%"><p align="justify"> If the Borrower fails to effect such insurance the Bank may, 
      but without being bound to do so, insure the said goods against any one 
      or more of the aforesaid risks as may be deemed necessary by the Bank in 
      its absolute discretion either in its sole name or in the joint names of 
      the Borrower and the Bank and debit the premia and other charges to such 
      account or accounts as aforesaid.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (iii) </td>
    <td width="94%"><p align="justify"> In the event of loss, destruction by fire or otherwise or 
      damage to the said goods or any part thereof, the Bank shall be entitled 
      to recover and receive all monies payable in respect of the insurance and 
      to give receipts thereof. In the event of the Bank not receiving the amount 
      payable for any reason whatsoever the Borrower shall be bound to pay forthwith 
      the balance due to the Bank on demand.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (iv) </td>
    <td width="94%"><p align="justify">All sums of money recovered or received under the last preceding 
      clause may at the option of the Bank be applied towards the liquidation 
      and satisfaction of the balance due to the Bank and if after settlement 
      of all claims of the Bank against the Borrower any surplus remains such 
      surplus shall remain at the disposal of the Borrower but if the sum or sums 
      of money realised from the insurance be insufficient to cover the balance 
      due to the Bank the Borrower agrees forthwith to repay to the Bank the deficiency 
      on demand.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (v) </td>
    <td width="94%"><p align="justify">The Bank shall be entitled to adjust, settle, compromise or 
      refer to arbitration any dispute between the Insurance company and the Borrower 
      arising under or in connection with such cover note/s or policy/policies 
      and certificate/s and such adjustment, settlement, compromise and any award 
      made on such arbitration shall be valid and binding on the Borrower.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">(vi) </td>
    <td width="94%"> <p align="justify">The Borrower shall not at any time raise any question that 
      a larger sum might or ought to have been received under such settlement, 
      compromise or award as the case may be or be entitled to dispute his liability 
      for the balance remaining due on such account or accounts to the Bank.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">11.</td>
    <td width="94%"><p align="justify">The Borrower shall furnish to the Bank regularly once every 
      month and at any other time or times as the Bank may require a full and 
      correct statement of (i) all the said goods the quantity, description and 
      the place where they are stored for the time being or whether they are in 
      transit or with agents or agencies and whether they are insured as provided 
      for herein and produce evidence in support thereof and (ii) the said debts, 
      the amount of the said debts and the name and address of the debtors and 
      produce evidence in support thereof. The Borrower shall also supply the 
      Bank forthwith any particulars or information required by the Bank from 
      time to time. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> 12. </td>
    <td width="94%"><p align="justify">The Bank or any person appointed by the Bank shall have the 
      right to enter with or without notice to the Borrower at any time or times 
      the premises where the said goods are stored and to inspect and take inventories 
      and to take possession thereof and the Bank shall also be at liberty to 
      have all or any of the said goods valued at the expense of the Borrower 
      by an appraiser or other valuer to be appointed by the Bank and the Borrower 
      agrees and undertakes to render to the Bank or any person appointed by the 
      Bank all facilities as may be required for any of the purposes aforesaid. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">13. </td>
    <td width="94%"><p align="justify"> The Borrower shall maintain in favour of the Bank a margin 
      between the prevailing market value, invoice or landed cost, whichever is 
      lower in case of stocks, stores, spare parts and semi-finished and of the 
      net wholesale selling price, market price or cost price, whichever is lower 
      in case of finished goods. The Borrower shall maintain in favour of the 
      Bank margin of________% of the said debts if at any time the margin above 
      indicated shall be diminished, the Borrower agrees to lodge immediately 
      with the Bank additional security approved by the Bank or to pay to the 
      Bank sufficient sum of money so as to maintain unimpaired the said margin. 
      The Bank shall be the sole judge of the value of the said goods for the 
      purposes of this agreement. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">14. </td>
    <td width="94%"> <p align="justify">Subject to the powers of the Bank and the obligations of the 
      Borrower herein-contained, the Borrower may with the approval of the Bank 
      deal with the said debts or any that the margin of security provided in 
      clause 13 is fully maintained and on the express terms of payment or delivery 
      to the Bank of the proceeds thereof immediately on receipt / realisation 
      thereof. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">15. </td>
    <td width="94%"> <p align="justify">The Bank or any person authorised by the Bank, may at any 
      time or time after the power of sale hereinafter contained shall have become 
      exercisable, enter any premises or places where the said goods or any of 
      them may be and take and retain possession of the said goods or any of them 
      or seize and recover them or any of them and remove them and/or any of them 
      to any place or places as the Bank shall think fit with or without notice 
      to the Borrower and for those purposes or any of them break open any place 
      of storage where the said goods may be lying or stored. On being so required 
      by the Bank the Borrower shall take all steps necessary to give to the Bank 
      or its nominee or nominees possession and control of the said goods or any 
      of them and for that purpose the Borrower shall endorse and deliver to the 
      Bank all documents of title relating to the said goods or any of them and 
      sign all such documents and do all such acts and things as may be required 
      by the Bank. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">16. </td>
    <td width="94%"> <p align="justify">After the Bank shall have taken possession of, seized and/or 
      removed the said goods as aforesaid the Company shall from time to time 
      on demand by the Bank forthwith pay all rents chargeable in respect of any 
      place or places of storage where the said goods shall have been stored, 
      salary and wages of watchman/watchmen, peon/s or any other person/s employed 
      by the Bank and all other charges, costs and expenses incurred or paid or 
      chargeable by the Bank in the exercise of and giving effect to the powers 
      vested in the Bank.  </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> 17. </td>
    <td width="94%"> <p align="justify">In the event of one or more of the following events occurring 
      namely: </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (i) </td>
    <td width="94%"> <p align="justify">If the Borrower shall make default in payment on demand of 
      the balance due to the Bank the payment whereof is hereby secured; or (ii) 
      if the Borrower shall make default in the performance or observance of any 
      term or undertaking contained in this agreement in respect of the security 
      and on the part of the Borrower to be observed and performed; (iii) If there 
      is apprehension that the Borrower is unable to pay their debts; (iv) if 
      an order is made or a resolution passed for the winding up of the Borrower 
      or a petition for such winding up is filed or notice of a meeting to pass 
      such a resolution issued; (v) if the Borrower enters into a composition 
      with the creditors; (vi) if a Receiver is appointed over the Borrower or 
      of all or any part of the property of the Borrower; (vii) if the Borrower 
      ceases or threatens to cease to carry on business (viii) if any execution 
      or other similar process shall be levied or issued against the Borrower 
      or (ix) if any circumstances shall occur which in the opinion of the Bank 
      is prejudicial to or imperils or is likely to prejudice or imperil the security 
      of the Bank, the Bank shall be at liberty to realise the security hereby 
      created and (without being bound to do so) (a) to sell after reasonable 
      notice to the Borrower and the said goods or any portion thereof by public 
      auction or private contract and/or alternatively otherwise dispose of or 
      deal with all or any part of the said goods, and/or (b) to give notices 
      of demands to the Borrower and third parties liable therefore and to demand 
      sue for recover/ receive and give receipts and discharge for the same and 
      sell and realise by public auction or private contract or otherwise dispose 
      of all or any part of the said debts. Provided however, that this Clause 
      shall not be read sui generis with sub clause (i) to (ix) hereof, of which 
      the Bank shall be the sole judge, then the Bank shall be entitled to deduct 
      and appropriate from the sale proceeds all or any expenses incurred or paid 
      or chargeable in connection with the exercise by the Bank of the power of 
      sale herein and to appropriate the net sale proceeds towards the balance 
      due to the Bank under this agreement. The Bank shall also be at liberty 
      to endorse realise settle compromise and deal with any rights which may 
      be set against any of the said goods and the said debts. The Borrower shall 
      sign all such documents, furnish all such information deliver all relative 
      documents and do all such acts and things as may be required by the Bank 
      for enabling or facilitating any such sale or realisation of or dealing 
      with the said goods and/or enforcement realisation settlement compromise 
      or dealing with any rights as aforesaid. The Bank shall not be liable, in 
      the event of the said exercise of any of the powers of the Bank, for any 
      loss which may occur in or arise from such exercise and such exercise shall 
      be without prejudice to any other rights and remedies and notwithstanding 
      that there may be any pending suit or other proceedings relating to the 
      said goods. If, however, the net sale proceeds of the said goods and / or 
      the said debt are insufficient to cover the balance due to the Bank then 
      the Borrower shall forthwith pay to the Bank the deficiency on demand. In 
      the exercise of the power of sale and disposal given hereunder the Bank 
      shall be at liberty from time to time or at any time at the Bank's entire 
      discretion but at the risk and on account of the Borrower to enter into 
      all such hedge forward and other contracts in India or elsewhere for the 
      protection of its interest as the Bank shall think fit and the Borrower 
      shall pay to the Bank forthwith on demand any monies which may become payable 
      under or by virtue of such hedge forward or other contracts. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">18. </td>
    <td width="94%"> <p align="justify">The Borrower shall accept without question the Bank's accounts 
      of such sales dealings or other transactions signed by any agent or other 
      authorised officer of the Bank as sufficient proof of the amount realised 
      or due by or under the sale dealings or transactions and the costs charges 
      and expenses incurred in connection therewith. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">19. </td>
    <td width="94%"> <p align="justify">The Bank shall have all powers incidental to and necessary 
      for the realisations of its security.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> 20. </td>
    <td width="94%"> <p align="justify">On a sale by private contract or public auction under the 
      provision or clause 17 hereof, the Bank shall be entitled to charge and 
      retain as part of the costs, charges and expenses incurred in connection 
      therewith such commission as the Bank shall at its sole discretion fix and 
      shall not be liable to account for the same to the Borrower. Such commission 
      shall be in addition to any brokerage or outgoings payable in respect of 
      any such sale. If the sale proceeds are not sufficient to pay the amount 
      of such commission the Borrower shall pay the same forthwith to the Bank 
      on demand.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">21. </td>
    <td width="94%"><p align="justify">The Bank shall be at liberty at its entire discretion from 
      time to time and at all times to deliver and/or alternatively transfer to 
      the Borrower or any other person nominated by it the whole or any portion 
      of the said goods of which the Bank shall have taken possession and/or to 
      assign the said debts or any of them against payment to the Bank of any 
      sum or sums of money thereof. No partial delivery transfer to, assignment 
      or redemption by the Borrower of the said goods and/or the said debts as 
      aforesaid shall in any way affect or prejudice the rights of the Bank under 
      this Agreement against the remainder of the said goods and the said debts 
      including any powers of sale or disposal thereof and / or to recover the 
      deficiency / balance from the Borrower. Any partial delivery, transfer or 
      redemption as aforesaid shall not be deemed to affect or prejudice any previous 
      or subsequent demand made by the Bank against the Borrower for payment of 
      the said balance of any sums due to the Bank hereunder or any such proceedings 
      for sale, disposal or otherwise as aforesaid taken in relation to the said 
      goods.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">22. </td>
    <td width="94%"><p align="justify">The Bank shall be entitled to appoint any Receiver Agent, 
      Manager or other person to exercise all or any of the powers hereby vested 
      in the Bank with reference to the security hereby created and shall be entitled 
      to recover from the Borrower the remuneration and/or alternative charges 
      of such receiver agent manager or other person. The Bank shall not be held 
      liable for and in respect of all acts, defaults, negligence and mistakes 
      (whether arising in the usual course of business or otherwise) of any such 
      Receiver, Agent, Manager or person or for any losses, damages, claims, demands, 
      suits, proceedings costs charges and expenses sustained or occasioned by 
      their acts and shall be entitled to be indemnified and kept indemnified 
      by the Borrower.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">23. </td>
    <td width="94%"><p align="justify">The Bank shall not in any way be responsible in respect of 
      the quantity, quality or condition of the said goods or for any loss, destruction 
      or deterioration thereof or damage thereto occasioned by theft, pilferage, 
      robbery, fire, floods, riot, strike, civil commotion or otherwise howsoever, 
      arising from any reason whatsoever.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">24. </td>
    <td width="94%"> <p align="justify">The Borrower hereby convenants with the Bank as follows:</p></td>
  </tr>
  <tr> 
    <td width="6%"valign="top"> (a)</td>
    <td width="94%"> <p align="justify">That the Borrower has good right to hypothecate and charge 
      the said goods and the said debts by way of first charge as aforesaid and 
      declares that the same are and shall always be kept free from any other 
      claim either by way of lien pledge, charge, hypothecation or otherwise with 
      full power of disposition in the Borrower.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (b) </td>
    <td width="94%"><p align="justify">That until such time as the balance due to the Bank shall 
      have been paid to the Bank the Borrower will not create any pledge, hypothecation, 
      mortgage, charge, lien or encumbrance upon or in respect of the said goods 
      or the said debts or any part thereof in any manner whatsoever (whether 
      by way of specific mortgage or charge or floating charge or otherwise) in 
      favour of any person firm or company other than the Bank or otherwise deal 
      with the said goods or the said debts or any part thereof except in the 
      regular course of business until notice is received from the Bank of its 
      intention to enforce this Agreement by the realisation of the security herein 
      and will not permit or suffer to be done any act, deed, matter or thing 
      which may adversely affect or in any way prejudice the security and/or the 
      rights of the Bank hereunder. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (c)</td>
    <td width="94%"> <p align="justify">That the Borrower will not receive, compound or release any 
      of the said debts nor do anything whereby the recovery of the same may be 
      impaired, delayed or prevented without the previous consent in writing of 
      the Bank & will keep proper books of account and other records of its business 
      and will at any time when required produce such books and records for the 
      inspection of the Bank & its representatives, officers and agents and allow 
      them access thereto and to furnish copies of or extracts from the same.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (d)</td>
    <td width="94%"><p align="justify">That the Borrower agrees to execute on demand by the Bank 
      such further documents as may be required by the Bank to vest the said debts 
      or any of them in the Bank so as to render the same readily realisable or 
      transferable by the Bank at any time.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">25. </td>
    <td width="94%"> <p align="justify">For the purpose of enabling the Bank to enforce the aforesaid 
      charge and the rights hereby conferred on the Bank, the Borrower hereby 
      irrevocably appoints the Bank & its officers as the Attorney or Attorneys 
      of the Borrower in its name or otherwise.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (a)</td>
    <td width="94%"><p align="justify">To demand, sue for, recover and receive and give effectual 
      receipts and discharges for the said debts hereby charged and also to refer 
      to arbitration any difference or dispute raised by any debtor of the Borrower 
      in respect of the said debts or other claims of the Borrower against such 
      debtor.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (b) </td>
    <td width="94%"><p align="justify">To sign execute deliver for and on behalf of the Borrower 
      any and all such documents of First legal charge as the case may be, required 
      by the Bank on its moveable and immoveable assets, both present & future 
      which the Borrower may have failed or refused to execute.</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">26. </td>
    <td width="94%"> <p align="justify">The Borrower shall pay all costs, charges and expenses and 
      legal costs (as between attorney and client) in anywise incurred by the 
      Bank in the negotiation, execution, or carrying into effect of this agreement 
      or in relation to the exercise of any power of sale or other power in relation 
      to any act, deed, matter or thing arising out of this agreement or incidental 
      thereto and which shall be deemed to have been added to the advances and 
      shall also carry interest thereon at the aforesaid rate. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">27. </td>
    <td width="94%"><p align="justify"> This agreement shall operate as a continuing security for 
      the balance or balances due to the Bank and all other monies due by the 
      Borrower to the Bank as aforesaid and the security hereunder is not to be 
      considered exhausted by reason of the account or accounts with the Bank 
      being brought to credit at any time or from time to time or all monies due 
      and owing by the Borrower for the time being to the Bank having been paid 
      in full or that on a general balance of account the Borrower shall be in 
      credit with the Bank but shall continue in operation in respect of all subsequent 
      transactions also.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">28. </td>
    <td width="94%"> <p align="justify">The Bank shall be entitled at its discretion (if it in its 
      interest thinks necessary to do so) to exercise and to appoint any person 
      to exercise all the rights privileges and power conferred on the Bank hereunder 
      and to realise the security hereby created and to take all necessary steps 
      for the purpose.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">29.</td>
    <td width="94%"> <p align="justify">The Borrower hereby further agrees that in case the Borrower 
      commits default in the repayment of the loan or in the repayment of interest 
      thereon on due date/s, the Bank and/or Reserve Bank of India will have an 
      unqualified right to disclose or publish the name of the Borrower or its 
      Directors/partners/proprietor as defaulter in such manner and through such 
      medium as the Bank or Reserve Bank of India in their absolute discretion 
      may think fit. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">30. </td>
    <td width="94%"><p align="justify">Without prejudice to the terms contained hereinabove, it shall 
      be lawful for the Bank to debit the Borrower?s current or cash credit account 
      the expenses incurred by the Bank towards inspection or valuation of the 
      said goods or legal expenses or any other reasonable expenses incurred by 
      the Bank for preservation and protection of the said goods or in pursuance 
      of this Agreement. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top">31.</td>
    <td width="94%"> <p align="justify">The Borrower further agrees that if the advance is eligible 
      for the cover of the Credit Guarantee Fund Scheme formulated by Small Industries 
      Development Bank of India or any other such Scheme formulated by Government 
      of India, the Borrower agrees to pay the guarantee fee and annual service 
      fee thereon and in the absence of such payment Bank may debit the current 
      or cash credit account of the Borrower for the said amount/s and it is further 
      agreed that such payment/debit shall not reduce the liability of the Borrower 
      under these Presents nor the Borrower shall be entitled to claim or receive 
      any benefit thereof or to dispute its liability on the ground that the Bank 
      has received any benefit thereunder.</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">32. </td>
    <td width="94%"> <p align="justify">Any notice by way of request demand or otherwise hereunder 
      may be given by the Bank to the Borrower or may be left at the then or last 
      known place of business or residence in India of the Borrower addressed 
      to the Borrower at the then or last known place of residence or business 
      of the Borrower and if sent by post it shall be deemed to have been given 
      at the time when it would be delivered in due course by postal authorities 
      and in proving such notice when given by post it shall be sufficient to 
      prove that the envelope containing the notice was posted and a Certificate 
      signed by the Bank or its agent or officer that the envelope was so posted 
      shall be conclusive. </p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (a)</td>
    <td width="94%"><p align="justify">an individual, include his or her legal representatives, heirs, 
      executors and assigns,</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (b)</td>
    <td width="94%"><p align="justify"> More than one individual, shall include their respective 
      heirs, executors, administrators & assigns,</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (c) </td>
    <td width="94%"><p align="justify"> a partnership firm, all its partners from time to time thereof 
      notwithstanding any changes in the constitution or style of the said firm 
      and survivors / survivor of them and whether the said firm consists of or 
      be reduced to one individual at any time and their respective legal representatives, 
      heirs, executors and assigns,</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (d)</td>
    <td width="94%"> <p align="justify">a joint & undivided Hindu family shall include all its co-parceners 
      and members;</p></td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (e) </td>
    <td width="94%"><p align="justify">a company, shall include its successors, administrators and 
      assigns,</p> </td>
  </tr>
  <tr> 
    <td width="6%" valign="top"> (f) </td>
    <td width="94%"><p align="justify"> an Association (corporate or incorporate), shall include 
      all its Executive Committee members as also individual members and their 
      respective heirs, executors, administrators & assigns.</p></td>
  </tr>
  <tr> 
    <td colspan="2" valign="top"><p align="justify">The provision hereinbefore contained shall be construed and 
      take effect where necessary as if the words importing single number include 
      also plural number.</p></td>
  </tr>
  <tr> 
    <td colspan="2" valign="top">SCHEDULE ABOVE REFERRED TO</td>
  </tr>
  <tr>
    <td colspan="2" valign="top">IN WITNESS WHEREOF THE BORROWER HAS HEREUNTO 
      set his/its hand and seal this day <b><%=date%>th <%=Months[a]%>, <%=year%></b>.</td>
  </tr>
</table>
</body>
</html>
