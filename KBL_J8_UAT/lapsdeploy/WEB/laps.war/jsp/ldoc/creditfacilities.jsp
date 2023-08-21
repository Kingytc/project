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
      <div align="center"><b>APPLICATION FOR IMPORT LETTER OF CREDIT (AD-04)</b></div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center"><b><u>Karnataka Bank Ltd.</u></b></div>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
<div align="center">
  <table width="63%" border="1" cellspacing="0" cellpadding="0" height="251">
    <tr> 
      <td width="34%" height="115"> 
        <div align="center">
          <p><u>Irrevocable Documentary Credit</u></p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
        </div>
      </td>
      <td width="29%" height="115"> 
        <div align="center">
          <p><u>Issuing Bank&#146;s Credit No.</u></p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
        </div>
      </td>
      <td width="37%" height="115">
        <p><b>Advising Bank</b></p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </td>
    </tr>
    <tr> 
      <td width="34%" > 
        <div align="center">
          <p><b>Applicant</b></p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
        </div>
      </td>
      <td width="29%"> 
        <div align="center">
          <p><b>Beneficiary</b></p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
        </div>
      </td>
      <td width="37%">
        <p>Amount not exceeding : ______ CIF/FOB<br>
          C&amp;F/FOR<br>
          In Figures : _______________________<br>
          In Words : ________________________<br>
          _________________________________<br>
          to cover Shipment __________________</p>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
  <table width="63%" border="1" cellspacing="0" cellpadding="0" height="74">
    <tr>
      <td width="45%"> 
        <p>Expiry Date :</p>
        <p>For Shipment :<br>
        </p>
      </td>
      <td width="55%"> 
        <p>For Negotiation :</p>
        <p>at the counters of Advising Bank ____________</p>
        </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="6%">&nbsp;</td>
      <td width="94%">The Manager,<br>
        <b>Karnataka Bank Ltd.,</b><br>
        <b><%=Helper.correctNull((String)hshValues.get("branchName"))%></b> Branch</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" height="148">
    <tr> 
      <td width="6%" valign="top">1.</td>
      <td width="94%">Please open by Mail/ Airmail an Irrevocable Documentary 
        Credit available to the aggregate Cable at urgent/Ordinary rate 
        <p>sum not exceeding ____________________ negotiation/acceptance / payment 
          of beneficiary's sight/ ________ days usance drafts drawn on _______________________________________<br>
          ________________________________ (name &amp; address) and accompanied 
          by Signed Commercial Invoices for a value not exceeding the draft amount 
          quoting import licence No. _____________________ and certifying goods 
          are per order/indent ___________________. The gross FOB/CIF/C&amp;F 
          value of the goods before deduction of Agent&#146;s Commission, if any, 
          must not exceed the credit amount. </p>
      </td>
    </tr>
    <tr>
      <td width="6%">lxxxiii)</td>
      <td width="94%">Certificate of (Name of Country) origin issued by a Chamber 
        of Commerce.</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="6%" valign="top">3.</td>
      <td width="94%">Full set, signed, &#147;Clean&#148;, &#147;On Board&#148;, 
        Ocean Bills of Lading of a Conference Line Vessel made out to order of 
        Karnataka Bank Ltd. marked &#147;Freight prepaid/Freight payable at destination&#148; 
        and notify (Bank-full address and importer-full address) L/C No. and date 
        evidencing current shipment of merchandise stated above.<br>
        Short form Bill of Lading and Third Party Bill of Lading or document produced 
        by reprographic process/computerized system/carbon copies marked original 
        are not acceptable. </td>
    </tr>
    <tr>
      <td width="6%" valign="top">3</td>
      <td width="94%">a) Airway Bills/Air consignment notes addressed to Karnataka Bank Ltd.
       ___________________________ for account openers indicating 
        letter of credit number and marked Freight Prepaid/Payable at destination. 
        Airway Bills/Air Consignment notes must indicate flight number and date.</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="6%">4.</td>
      <td width="94%">Lloyds Certificate that carrying steamer is seaworthy and 
        not more than 15 years old.</td>
    </tr>
    <tr> 
      <td width="6%" valign="top">lxxxiv)</td>
      <td width="94%">Marine Insurance Policies/Certificate dated not later than 
        the date of Bill of Lading unto order and blank endorsed for 10% over 
        invoice value covering Institute Cargo Clause (A), Institute War Clause 
        (Cargo) and Institute Strikes Clauses (Cargo), Warehouse to Warehouse 
        Clauses with claims payable in India irrespective of percentage. Transhipment 
        risks must be covered if goods are subject to transhipment.</td>
    </tr>
    <tr> 
      <td width="6%" valign="top">lxxxv)</td>
      <td width="94%">Test Certificate/Inspection Certificate dated ______________________ 
        and issued by _____________________________ specifying date, content, 
        wording etc.</td>
    </tr>
    <tr> 
      <td width="6%" valign="top">lxxxvi)</td>
      <td width="94%">Packing List with the same details as in No. 6 above.</td>
    </tr>
    <tr>
      <td width="6%" valign="top">lxxxvii)</td>
      <td width="94%">Certificate by _________________________________ certifying 
        that the goods have been loaded On Board the vessel.</td>
    </tr>
  </table>
  <p>&nbsp;</p>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>Shipment/Despatch should be effected from _________________ to ________________ 
      (specify port) Bill of Lading must be dated not later than ___________________________ 
      nor prior to the date of this credit.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>Bills of exchange must be dated and negotiated not later than ____________________ 
      days after the date of Shipment/Despatch, in any case not later than the 
      expiry date of the credit.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>Transhipment is permitted/prohibited.</td>
  </tr>
  <tr>
    <td>Part-shipment is permitted/prohibited.</td>
  </tr>
</table>
<p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><b>ADDITIONAL CONDITIONS :</b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">lxxxviii)</td>
    <td width="95%">All bank charges outside India are for beneficiary/Opener&#146;s 
      account.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="5%">2.)</td>
    <td width="95%">A transport document which is produced -</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="5%">lxxxix)</td>
    <td width="90%">by reprographic system or</td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="5%">xc)</td>
    <td width="90%">by or as a result of automated or computerised systems or</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="5%">xci)</td>
    <td width="90%">as carbon copy</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>will not be accepted as an original document even if it is marked as original 
      or appears to have been authenticated.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="5%">3)</td>
    <td width="95%">The transport document -</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="5%">xcii)</td>
    <td width="90%">must contain all the conditions of carriage on the original 
      document</td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="5%">xciii)</td>
    <td width="90%">must not indicate the place of final destination as being 
      different from the port of discharge</td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="5%" valign="top">xciv)</td>
    <td width="90%">must not contain the indication &#147;intended&#148; or similar 
      qualification in relation to the vessel or other means of transport or port 
      of loading or port of discharge</td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="5%">xcv)</td>
    <td width="90%">must be issued by the carrier or his agent and not by any 
      freight forwarder</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="5%">xcvi)</td>
    <td width="90%">must not contain a provision that goods may be carried on 
      deck.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="5%">4)</td>
    <td width="95%">&#147;LASH&#148; transport documents are not acceptable.</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="5%">xcvii)</td>
    <td width="90%">Transport documents bearing reference by stamp or otherwise 
      to costs additional to the freight charges are not acceptable.</td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="5%">xcviii)</td>
    <td width="90%">Short form or blank-back transport documents are not acceptable.</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="5%">xcix)</td>
    <td width="90%">A transport document bearing a date of issuance prior to that 
      of the credit is not acceptable.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>IN CONSIDERATION of your opening the above credit, I/We hereby agree and 
      undertake as follows:</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%" valign="top">1)</td>
    <td width="95%">I/We hereby agree and undertake to accept and pay all bills 
      of exchange drawn and purported to be drawn pursuant to the terms of the 
      credit and take up and pay for all the documents negotiated thereunder in 
      accordance with the terms thereof, as also for any disbursement made or 
      liability incurred by you for my/our account under the Credit, together 
      with interest, costs, charges and expenses due to you in respect thereof 
      as hereinafter mentioned.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">2)</td>
    <td width="95%">I/We further agree to pay interest to you on the amount/s 
      payable in respect of my/our liability to you on the amount/s payable in 
      respect of my/our liability under the credit at the rate of _______% points 
      per annum over Karnataka Bank Ltd.&#146;s Prime Lending Rate or such other 
      rate as may be prescribed by the Bank from time to time. The interest at 
      the aforesaid rate shall be payable from the date of negotiation of the 
      bill/documents under the credit upto and inclusive of ten days from the 
      date of receipt of documents by you shall be at the rate of ______% points 
      over Karnataka Bank Ltd. prime Lending rate or such other higher rate as 
      may be prescribed by the Bank from time and time and that this shall be 
      subject to provisions contained in Clause 5 (1) below.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">3)</td>
    <td width="95%">I/We further agree to pay to you on demand (i) the charges 
      that may be levied as per Foreign Exchange Dealers&#146; Association of 
      India Rules in force from time to time for any early/late delivery of the 
      relevant foreign exchange/currency under the Forward Exchange Contract, 
      if any, booked by me/us and (ii) the commission or handling charges at the 
      rate of 0.15% on the amount of the bill(s) drawn under the Credit.</td>
  </tr>
  <tr>
    <td width="5%" valign="top">4)</td>
    <td width="95%">I/We also agree to pay to you on demand, all costs (legal 
      costs on full indemnity basis) customs duty, penalty, demurrage, storage 
      charges, clearing and forwarding charges and all other charges and expenses 
      which you may be put to or suffer or incur in connection with the goods 
      and /or the documents of title to goods covered by the Credit including 
      for re-shipment thereof for any reason whatsoever, or in the exercise or 
      enforcement of any right or power hereby conferred or otherwise howsoever, 
      and further agree and undertake to hold you safe and harmless and keep you 
      indemnified against any claim, action or proceeding made or brought against 
      you, your correspondents or agents, as also against any liability or loss 
      incurred or suffered by you, your correspondents or agents by reason of 
      your having established the Credit pursuant to my/our application or otherwise 
      howsoever in the premises.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%" valign="top">5)</td>
    <td width="3%" valign="top">i)</td>
    <td width="92%">&#147;I/We agree that on receipt of the documents drawn under 
      a foreign currency Letter of Credit to be established by you as per my/our 
      request, you have irrevocable authority to convert our foreign currency 
      liability represented by the said documents towards yourselves, into a Rupee 
      liability, on the tenth day from date of receipt of documents at your end 
      at your Bank&#146;s prevailing BC Selling rate for the currency in which 
      the documents have been drawn, whether I/We have received the presentation 
      memo or not provided no forward sale contract for the retirement of the 
      said documents have been entered into between the Bank and me/us. Where 
      the documents received under L/C are covered by a forward contract you are 
      authorised to convert the foreign currency at the contracted rate in case 
      the delinking results in early/late delivery under the forward contract 
      it would be in order for you to levy early/late delivery charges, if any, 
      as per FEDAI Rules. Such conversion when made from time to time shall be 
      fully and completely binding on me/us. Our above irrevocable authority to 
      you will also hold and apply whereby you are to establish usance letters 
      of credit on our behalf. However, the conversion of our foreign currency 
      liability into a rupee liability towards yourselves be on the date of maturity 
      of the bill.&#148; </td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="3%">ii)</td>
    <td width="92%">The rate of exchange applicable to such conversion of the 
      foreign currency amount into Indian Rupees shall be</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="3%">&nbsp;</td>
    <td width="3%" valign="top">a)</td>
    <td width="89%">your applicable bill selling rate prevailing on the date falling 
      on the 10th day after the date of receipt of documents by you under the 
      Credit in the case of a sight bill or on the date of maturity in the case 
      of a usance bill Provided. However that if the relevant rate of exchange 
      is not quoted or available for any reason on such 10th day in the case of 
      a sight bill or on the date of maturity in the case of a usance bill, then 
      the rate prevailing on the immediately next working day when such rate shall 
      be quoted or be available, shall be the applicable rate of exchange; or</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="3%">&nbsp;</td>
    <td width="3%" valign="top">b)</td>
    <td width="89%">the forward exchange contract rate in case a forward exchange 
      contract has been booked by me/us with you.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="3%">iii)</td>
    <td width="92%">The rate of receipt of documents by you under the Credit as 
      registered in your record shall be conclusive and binding on me/us.</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="3%" valign="top">iv)</td>
    <td width="92%">I/We confirm that crystallisation of my/our liability on the 
      foreign currency bill by you and the charging/payment of interest at a higher 
      rate as aforesaid shall not be deemed to create any right in me/us to keep 
      any unpaid when due.</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%" valign="top">6)</td>
    <td width="95%">I/We further agree that you shall have a pledge upon all goods 
      and documents of title to goods and other documents covered under the Credit 
      which may have been already delivered or shall be hereafter delivered into 
      your possession or into the possession of your agents by me/us or by any 
      person, firm or company on my/our behalf as a result of your opening the 
      Credit or in connection with the transaction thereunder. The said goods 
      and the documents shall be deemed to be so delivered in pursuance of my/our 
      this agreement to pledge them to you as security for all payments which 
      may be made by you or your correspondents or agents under the Credit for 
      my/our account as also for any liability whatsoever incurred or which may 
      be hereafter incurred by you or your correspondents or agents as a result 
      of the opening of this Credit, together with interest, costs, charges and 
      expenses as hereinabove mentioned.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">7)</td>
    <td width="95%">In the event of my/our committing a default in making due 
      payment of any bill drawn or purported to be drawn under the Credit or in 
      making reimbursement on demand of any payment made by you for my/our account 
      in respect of any liability that may be suffered or incurred by you or your 
      correspondents or agents under or in connection with the Credit, then you 
      shall be entitled without prejudice to any of your rights and without notice 
      to me/us (which I/We hereby expressly waive) to sell the goods covered under 
      the credit (the said &#147;goods&#148;) whether before or after their arrival, 
      either by public auction or tender or by private contract and subject to 
      such conditions as you may deem fit to impose or otherwise dispose of or 
      deal with the said goods or any part thereof and or with the relative documents 
      of title to goods in any manner whatsoever, without being bound to exercise 
      any of these powers or liable for any loss in the exercise or non-exercise 
      thereof. The net proceeds realised from sale of the said goods or transfer 
      of any document of title, remaining after deducting there from the costs 
      and expenses of and incidental to such sale or transfer, shall be applied 
      in or towards payment or satisfaction of the amount(s) due to you in respect 
      of any payment or disbursement made by you under the Credit for my/our account 
      and interest thereon and all costs, charges and expenses as hereinabove 
      mentioned. I/We agree to accept Bank&#146;s account of sale or realisation 
      as conclusive evidence both in and out of court as to the amount(s) realised 
      and expenses incurred, and to pay forthwith any shortfall or deficiency 
      remaining after such application. I/We further agree that you shall not 
      be liable to me/us for any loss which may occur pending sale or disposal 
      of the goods and/or documents of title to goods, whether by reason of theft, 
      damage, deterioration or decay of the goods or depreciation in the value 
      thereof or otherwise whatsoever be the cause.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">8)</td>
    <td width="95%">I/We agree to keep the said goods further insured from the 
      time of expiry of insurance cover under the initial policy or policies insurance, 
      against all risks which are normally covered for goods of the nature purchased 
      under the Credit as also against such other risk(s) as may be required by 
      you, and in the event of my/our failing to do so, you shall be at liberty 
      to insure the said goods at my/our cost and expense without prejudice to 
      your rights hereunder. Until all your dues in respect of the credit are 
      paid in full, I/We agree to pay to you forthwith all moneys if received 
      by me/us under any policy or policies of insurance and until payment to 
      you of such insurance moneys, I/We undertake to hold the same in trust for 
      you.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">9)</td>
    <td width="95%">I/We further agree and undertake to sign, execute and deliver 
      to you from time to time on demand made by you, such further or other deeds, 
      documents and writings and do all such acts, matters and things as may be 
      required by you for better perfecting your title to the said goods and the 
      documents covered under the Credit and or to render the same readily saleable 
      or transferable by you to any purchaser(s) at all times.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">10)</td>
    <td width="95%">It is understood that the transmission of all instructions 
      and communications under the above Credit and the shipping of documents 
      and goods thereunder is entirely at my/our risk. You and your correspondents 
      or agents shall not be responsible for any error or delay in such transmission 
      or loss or delay in delivery of the documents or the goods nor shall you 
      or your correspondents or agents be liable in any respect beyond ensuring 
      that the bill(s) drawn under the Credit and the relative documents covered 
      thereunder purport to comply with the terms and conditions of the Credit.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">11)</td>
    <td width="95%">I/We have made adequate arrangements for retiring the bills 
      under the Credit and do not contemplate to seek any financial assistance 
      from you for the purpose.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">12)</td>
    <td width="95%">I/We agree to the negotiations of the drafts drawn under the 
      Credit being confined to your branches or agencies or to any bank acceptable 
      to you.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">13)</td>
    <td width="95%">I/We confirm that the goods described above are covered under 
      my/our below mentioned Import Licence.</td>
  </tr>
  <tr>
    <td width="5%" valign="top">14)</td>
    <td width="95%">I/We enclose for your perusal :</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="4%">c)</td>
    <td width="91%">Order together with the order confirmation of overseas supplier, 
      or</td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="4%">ci)</td>
    <td width="91%">Proforma Invoice of overseas supplier duly countersigned by 
      us; or</td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="4%">cii)</td>
    <td width="91%">Indent/Offer from overseas supplier or his authorised agent 
      together with the exchange control copy of the relative import licence.</td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="4%" valign="top">ciii)</td>
    <td width="91%">I/We undertake to submit to you the exchange control copy 
      of the relative Customs Bill of Entry within 3 months from the date of remittance 
      in case of sight bills and before effecting remittance in case documents 
      are received on DA terms, as required in terms of Exchange Control Regulations. 
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="5%" valign="top">15)</td>
    <td width="95%">This application shall be deemed to have been accepted and 
      the credit deemed to have been established when written advice thereof has 
      been sent to the beneficiary.</td>
  </tr>
  <tr> 
    <td width="5%" valign="top">16)</td>
    <td width="95%">We agree and confirm that this Credit may be amended and/or 
      modified by you in your absolute discretion, including for an increased 
      limit, on our giving you written instructions for the same and in such an 
      event, such amendment/modification will be deemed to form part of this Credit 
      application and will be governed by the terms thereof and I/We agree, covenant, 
      record and confirm that I/We shall be bound by the same as if such amendment/modification 
      including the increased limit had originally constituted the term of this 
      credit.</td>
  </tr>
  <tr>
    <td width="5%" valign="top">17)</td>
    <td width="95%">This agreement shall be binding upon me/us, my/our heirs, 
      executors and administrators/ successors and shall ensure to the benefit 
      if and be enforceable by you, your successors, transferees and assigns.</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>EXCEPT AS OTHERWISE EXPRESSLY STATED TO THIS CREDIT IS TO BE OPENED SUBJECT 
      TO THE UNIFORM CUSTOMS AND PRACTICE FOR DOCUMENTARY CREDITS (1993 REVISION) 
      AS CONTAINED IN THE INTERNATIONAL CHAMBER OF COMMERCE PUBLICATION NO. 500 
      AS AMENDED FROM TIME TO TIME. </td>
  </tr>
</table>
<p>&nbsp;</p>
<div align="center">
  <table width="55%" border="1" cellspacing="0" cellpadding="0" height="158">
    <tr> 
      <td height="100" width="34%">Licence No:___________<br>
        Dated ______________<br>
        for Rs ______________<br>
        Valid Upto ____________</td>
      <td height="100" width="30%">&nbsp;</td>
      <td height="100" width="36%"> 
        <p>Yours faithfully,</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </td>
    </tr>
    <tr> 
      <td height="28" width="34%">&nbsp;</td>
      <td height="28" width="30%">&nbsp;</td>
      <td height="28" width="36%">signature</td>
    </tr>
    <tr> 
      <td width="34%">Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
      <td width="30%">&nbsp;</td>
      <td width="36%">&nbsp;</td>
    </tr>
  </table>
</div>
<p>&nbsp;</p>
</body>
</html>
