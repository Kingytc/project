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

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td align="center"><b>APPLICATION FORM (AD-05)</b></td>
  </tr>
  <tr>
    <td  align="center"><b>(FOR INLAND LETTER OF CREDIT)</b></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="4%">To</td>
    <td width="96%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="4%">&nbsp;</td>
    <td width="96%"><b>Karnataka Bank Ltd.</b></td>
  </tr>
  <tr>
    <td width="4%">&nbsp;</td>
    <td width="96%"><b> <%=Helper.correctNull((String)hshValues.get("branchName"))%> 
                  </b>Branch</td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="97%">Dear Sir,</td>
  </tr>
</table>
<br>
<table width="86%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><p align="justfiy">Please open on our behalf by Mail / Telex / Telegram an INLAND Irrevocable 
      Documentary Letter of Credit available to the aggregate sum not exceeding 
      Rs.<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> </b> (Rupees<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b>) 
      for payment / acceptance of beneficiary&#146;s draft for _________________________% 
      of the Invoice value payable at sight / ____ days usance / from the date 
      of transport documents, drawn on ________________________________________________________________________________________________________________________________________ 
      (name &amp; address) as per the following:</p><br>
</td>
  </tr> 
</table>
<div align="center">
  <table width="78%" border="0" cellspacing="0" cellpadding="0" height="249">
    <tr> 
      <td height="38">Inland Irrevocable Documentary Letter of Credit</td>
      <td height="38">Issuing Bank&#146;s ILC No.</td>
    </tr>
    <tr> 
      <td height="33">Applicant</td>
      <td height="33">Beneficiary</td>
    </tr>
    <tr> 
      <td height="107">Advising Bank / Branch<br>
        <br>
        <br> 
        <br>
        <br>
      </td>
      <td height="107">
        <p>Amount not exceeding:</p>
        <p>In Figures Rs.  <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> </p>
        <p>In Words : Rupees <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> </b></p>
      </td>
    </tr>
    <tr> 
      <td>
        <p>Station of<br>
        </p>
        <p>Despatch:<br>
          <br>
          Station of<br>
          <br>
          Destination: </p>
      </td>
      <td>
        <p>Expiry Date :</p>
        <p>For Shipment: _____________________</p>
        <p>For Negotiation: ___________________</p>
        <p>Date of Expiry: ____________________</p>
      </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>Accompanied by following original documents namely:-</td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="6%" valign="top">civ)</td>
      <td width="94%"><p align="justfiy">Signed Commercial Invoices for the gross value of the goods, 
        certifying goods are per order / indent and evidencing despatch of the 
        undernoted goods</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">cv)</td>
      <td width="94%">Receipted Delivery Chalans.</td>
    </tr>
    <tr> 
      <td width="6%" valign="top">cvi)</td>
      <td width="94%"><p align="justfiy">Air consignment note/RR/MLR showing goods consigned to UNION 
        BANK OF INDIA______________________________________indicating Letter of 
        Credit number and marked Freight Prepared/Payable at destination. The 
        transport document must indicate date of despatch and the name and address 
        of the Bank and the opener. The MLR should be issued by a transport operator 
        on the approved list of the Bank and MLR should be on approved format.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">cvii)</td>
      <td width="94%">Signed delivery orders made out in favour of bank or its 
        order. </td>
    </tr>
    <tr> 
      <td width="6%" valign="top">cviii)</td>
      <td width="94%"><p align="justfiy">Inland Transit Insurance Policy, in duplicate, for at least 
        the invoice value of the goods plus 10% with endorsement in blank, covering 
        inland transit risk as per Inland Transit Clause &#145;A&#148;, SRCC risk 
        as per Institute Strikes Clause (Cargo) with claims payable irrespective 
        of percentage.</p><br>
</td>
    </tr>
    <tr>
      <td width="6%" valign="top">&nbsp;</td>
      <td width="94%"><p align="justfiy">Bills of exchange must be dated and negotiated not later 
        than ___________ days after the date of Despatch and in any case not later 
        than the expiry date of the credit.</p><br>
</td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>Transhipment is allowed / not allowed.</td>
    </tr>
    <tr>
      <td>Partial despatches &#150; allowed / not allowed.</td>
    </tr>
  </table>
  <p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><b>ADDITIONAL CONDITIONS:</b></td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="6%">cix)</td>
      <td width="94%"><p align="justfiy">All advising / negotiating bank charges are on beneficiary 
        / opener&#146;s account.</p></td>
    </tr>
    <tr> 
      <td width="6%">cx)</td>
      <td width="94%">Interest is on beneficiary / opener&#146;s account.</td>
    </tr>
    <tr> 
      <td width="6%" valign="top">cxi)</td>
      <td width="94%"><p align="justfiy">A transport document bearing a date of issuance prior to 
        that of the credit is not acceptable.</p><br>
</td>
    </tr>
    <tr>
      <td width="6%" valign="top"> cxii)</td>
      <td width="94%"><p align="justfiy">Commercial invoices issued for amounts in excess of the 
        amount permitted by the credit are not acceptable.</p><br>
</td>
    </tr>
  </table>
  <p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><p align="justfiy">IN CONSIDERATION of your opening the above credit, I/We hereby agree 
        and undertake as follows:</p><br>
</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I/We hereby agree and undertake to accept and pay all bills 
        of exchange drawn and purported to be drawn pursuant to the terms of the 
        credit and take up and pay for all the documents negotiated thereunder 
        on presentation in the case of sight bills and on due dates in the case 
        of usance bills as also for any disbursement made or liability incurred 
        by you for my/our account under the Credit, together with interest, costs, 
        charges and expenses due to you in respect thereof as hereinafter mentioned.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I/We further agree to pay interest to you on the amount/s 
        payable in respect of my/our liability under the credit at the rate of 
        <b><%=Helper.correctNull((String)hshValues.get("mintrate"))%></b>  percentage s per annum over Karnataka Bank Ltd.&#146;s Prime Lending 
        Rate and/or at such other rate as may be prescribed by the Bank from time 
        to time. The interest at the aforesaid rate shall be payable from the 
        date of negotiation of the Bill/documents under the credit until payment 
        or at such other rate as may be prescribed by you from time to time.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I/ We further agree to pay to you on demand commission and 
        other charges that may be levied as per the bank rules in force from time 
        to time.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I / We also agree to pay all costs / legal costs (as between 
        attorney and client) on full indemnity basis, customs duty, penalty, demurrage, 
        storage charges and all other charges and expenses which you may be put 
        to or suffer or incur in connection with the goods and or the documents 
        of title to goods, covered by the Credit or in the exercise or enforcement 
        of any right or power hereby conferred or otherwise however incurred in 
        the premises, and further agree and undertake to hold you safe and harmless 
        and keep you indemnified against any claim, action, proceeding, liability 
        or loss whether due to any defect or discrepancy in the documents and 
        / or in respect of the goods covered under the Credit or otherwise howsoever.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I / We further agree that you all goods and documents of 
        title to goods and other documents covered under the credit which may 
        have been already delivered or shall be hereafter delivered into your 
        possession or into the possession of your agents by me / us on my / our 
        behalf or by any person, firm or company as a result of your opening the 
        Credit or in connection with the transaction thereunder shall stand hypothecated 
        before delivery and pledged when delivered in your favour. The said goods 
        and the documents shall be deemed to be so delivered in pursuance of my 
        / our this agreement to pledge them to you as security for all payments 
        which may be made by you or your agents under the Credit for my / our 
        account as also for any liability whatsoever incurred or which may be 
        hereafter incurred by you or your agents as a result of the opening of 
        this Credit, together with interest, costs, charges and expenses as hereinabove 
        mentioned.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">In the event of my / our default in making payment of any 
        bill drawn under the credit or of any disbursement made by you thereunder 
        for my / our account or any amount due to you in respect thereof, you 
        shall be entitled without prejudice to any of your rights and without 
        notice to me / us (which I / We hereby expressly waive), to sell the goods 
        covered under the credit, either by public auction or tender or by private 
        contract and subject to such conditions as you may deem fit to impose, 
        or otherwise dispose of or deal with the said goods or any part thereof 
        in any manner whatsoever and or with / without the relative documents 
        of title to goods without being bound or liable for any loss in the exercise 
        or non-exercise thereof. The net proceeds realised from sale of the said 
        goods or transfer of any document of title, remaining after deducting 
        therefrom the costs and expenses of and incidental to such sale or transfer, 
        shall be applied in or towards payment of the amount(s) due to you firstly 
        towards all costs, charges and expenses and thereafter towards any payment 
        or disbursement made by you under the Credit for my / our account, and 
        interest thereon as hereinabove mentioned. I / We agree to accept Bank&#146;s 
        account of sale or realisation as conclusive evidence as to the amount(s) 
        realised and expenses incurred, and to pay forthwith any shortfall or 
        deficiency remaining after such application. I / We further agree that 
        you shall not be liable to me / us for any loss which may occur pending 
        sale or disposal of the goods and / or documents of title to goods, whether 
        by reason of deterioration or depreciation in the value of the goods or 
        otherwise howsoever caused or for loss arising on account of such sale.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I / We agree to keep the insurance in respect of said goods 
        renewed on expiry of insurance cover under the initial policy or policies 
        of insurance and keep the policy in force and alive against all risks 
        which are normally covered for goods of the nature purchased under the 
        credit as also against such other risk(s) as may be required by you. Until 
        all your dues in respect of the Credit are paid in full, I / We agree 
        to pay to you forthwith all moneys if received by me / us under any policy 
        or policies of insurance towards the outstanding dues. Until payment to 
        you of such insurance moneys. I / We undertake to hold the same in trust 
        for you.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I /We further agree and undertake to sign, execute and deliver 
        to you from time to time on demand made by you, such further or other 
        deeds, documents and writings and to do all such acts, matters and things 
        as may be required by you for better perfecting your title to the said 
        goods and the documents covered under the Credit in order to render the 
        same readily Saleable or transferable by you to any purchaser(s) at all 
        times.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">It is understood that the transmission of all instructions 
        and communication under the above Credit and despatch of documents and 
        goods thereunder is entirely at my / our risk. You and your agents shall 
        not be responsible for any error or delay in such transmission or loss 
        or delay in delivering of the documents or the goods nor shall you or 
        your agents be liable in any respect beyond ensuring that the bill(s) 
        drawn under the credit and the relative documents covered thereunder purport 
        to comply with the terms and conditions of the Credit.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I / We have made adequate arrangement for retiring the bills 
        under the Credit and for payment of all duties and other charges payable 
        in respect of the said goods and do not contemplate to seek any financial 
        assistance from you for the purpose.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"> <p align="justfiy">I / We approve of the negotiations of the drafts drawn 
        under the credit being confined to your branches or agencies.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">This application shall be deemed to have been accepted and 
        the Credit deemed to have been established when written advice thereof 
        has been sent to the beneficiary.</p><br>
</td>
    </tr>
    <tr> 
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">I / We agree and confirm that this Credit may be amended 
        and / or modified by you in your absolute discretion, including for an 
        increased limit, on our giving you written instructions for the same and 
        in such an event, such amendment / modification will b deemed to form 
        part of this Credit application and will be governed by the terms hereof 
        and I / We agree, covenant, record and confirm that I / We shall be bound 
        by the same as if such amendment / modification including the increased 
        limit had originally constituted the term of this credit.</p><br>
</td>
    </tr>
    <tr>
      <td width="6%">&nbsp;</td>
      <td width="94%"><p align="justfiy">This agreement shall be binding upon me / us, my / our heirs, 
        executors, administrators / successors and shall enure for the benefit 
        of and be enforceable by you, your successors, transferees and assigns. 
        If this agreement should be terminated or revoked by operation of law 
        as to me / us, I / We will and I / We hereby agree to indemnify and save 
        you harmless from any loss which may be suffered or incurred by you in 
        acting hereunder prior to the receipt by you or your successors, transferees 
        or assigns of a notice in writing of such termination or revocation.</p><br>
</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><p align="justfiy">EXCEPT AS OTHERWISE EXPRESSLY STATED THIS CREDIT IS TO BE OPENED SUBJECT 
        TO THE UNIFORM CUSTOMS AND PRACTICE FOR DOCUMENTARY CREDITS (1993 REVISION) 
        AS CONTAINED IN THE INTERNATIONAL CHAMBER OF COMMERCE PUBLICATION NO.500 
        OR AS AMENDED FROM TIME TO TIME WHICH SHALL GOVERN THIS CREDIT AND BE 
        BINDING ON US.</p><br>
</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="62%">&nbsp;</td>
      <td width="38%">Yours faithfully</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="62%">Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
      <td width="38%"> <b>Signature </b></td>
    </tr>
  </table>
  <p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>(Name and address of the Borrower)</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>Dear Sir,</td> 
    </tr>
  </table> 
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><p align="justfiy">We enclose the delivery order and/or documents specified in the Schedule 
        hereunder written relating to goods or produce pledged to us, on the terms 
        that such delivery order and/or documents, goods and produce to which 
        they relate, and the proceeds of sale are held by you on trust for us, 
        and that you shall comply with the terms of the Trust Receipt annexed, 
        which please sign and return to us.</p><br>
</td>
    </tr>
    <tr> 
      <td><p align="justfiy">You may take delivery of the produce of goods on condition that you 
        hold them and realise them for us in accordance with the terms set out 
        in the Trust Receipt, and pay the proceeds of all sales to us immediately 
        and specifically as you receive them.</p><br>
</td>
    </tr>
    <tr>
      <td><p align="justfiy">You are to pay to us the sum of Rs&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;.. 
        on account of the moneys for which the documents and goods and produce 
        described in the schedule are pledged, not later than&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;. 
        even if the same have not been sold.</p><br>
</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><b>SCHEDULE :</b></td>
    </tr>
  </table>
  <br>
  <table width="49%" border="1" cellspacing="0" cellpadding="0" height="113">
    <tr>
      <td height="26">
        <div align="center"><b>Details of documents/delivery order</b></div>
      </td>
      <td height="26">
        <div align="center"><b>Details of produce or goods</b></div>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="58%">&nbsp;</td>
      <td width="42%"> <b>Yours faithfully,</b></td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="48%">&nbsp;</td>
      <td width="52%"><b>For &amp; On Behalf of Karnataka Bank Ltd.</b></td>
    </tr>
  </table>
  <p>&nbsp;</p>
</div>
</body>
</html>
