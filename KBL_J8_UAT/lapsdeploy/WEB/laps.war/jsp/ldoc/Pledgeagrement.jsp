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
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td colspan="2">
      <div align="center"><b>PLEDGE AGREEMENT (SD-02)</b></div>
    </td>
  </tr>
  <tr> 
    <td colspan="2">
      <p><b>Karnataka Bank Ltd.</b><br>
        <b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b> Branch 
      </p>
      <p>&nbsp; </p>
    </td>
  </tr>
  <tr> 
    <td colspan="2"><p align="justify">IN CONSIDERATION of KARNATAKA BANK LTD. (hereinafter called 
      &#145;the Bank&#146;) at the request of ______________________________________________<br>
      ___________________________________________________________________ (hereinafter 
      called &#145;the Borrower&#146;) opening and / or continuing in the books 
      of the Bank a Banking Account or Accounts of the Borrower and from time 
      to time at the request of the Borrower giving him such advances as he may 
      require and the Bank may be willing to make the Borrower hereby agrees that 
      the Bank shall have a pledge upon all Goods Produce and / or Merchandise 
      (hereinafter referred to as the &#145;said Goods&#146;) which are now or 
      shall be hereafter delivered by the Borrower into the possession of the 
      Bank or the Bank&#146;s Agent on the Bank&#146;s behalf and upon all Bills 
      of Lading, Warrants, Delivery Orders and upon all Documents of Title to 
      Goods and securities whatsoever (hereinafter referred to as the &#145;said 
      Documents of Title&#146;) which are now or which shall be hereafter deposited 
      by the Borrower with the Bank.</p></td>
  </tr>
  <tr> 
    <td colspan="2"><p align="justify">The Borrower agrees that the terms of the said pledge and 
      the rights which shall accrue to the Bank in respect of the said Goods when 
      they have been delivered into the possession of the Bank or the Agent of 
      the Bank on Bank&#146;s behalf and in respect of the said documents of Title 
      when they have been deposited are as follows:-</p></td>
  </tr>
  <tr> 
    <td width="4%" valign="top">1.</td>
    <td width="96%">
     
      <p align="justify">The said Goods, and the said Documents of Title are pledged as security 
        for advances made or which may be made to the Borrower or any one or more 
        of them whether alone or jointly on any account current or otherwise and 
        for any liability on bills discounted or held by the Bank at the Borrower&#146;s 
        request or bearing the Borrower&#146;s name and also for any other liability 
        on the Borrower&#146;s part to the Bank incurred or which may be incurred 
        at the Borrower&#146;s request on any account whatsoever (including monies 
        owing from a survivor or survivors on any joint account) and whether as 
        principal debtor surety or guarantor together with interest and all customary 
        charges thereon. And the Borrower agrees that in so far as the Borrower 
        is a party to this Agreement by way of surety or guarantor the Bank may 
        enter into any contract with the principal debtor for the purpose of giving 
        time for payment or for any other purpose without prejudice to the rights 
        of the Bank against the Borrower as such surety or guarantor.</p>
    </td>
  </tr>
  <tr>
    <td width="4%"  valign="top">2.</td>
    <td width="96%"><p align="justify">
      That the said goods or the said Documents of Title which have been already 
        deposited and the said goods or the said Documents of Title which shall 
        be hereafter deposited with the Bank under this Agreement shall be placed 
        in the Bank&#146;s possession and under its control in such a manner that 
        such possessionand control may be apparent and indisputable for which 
        purpose the Bank may without prejudice to the duties of the Borrower hereunder 
        do all such acts and things sign such documents and pay and incur such 
        cost, charges and expenses as may be necessary for preserving, protecting 
        and realising the same. The said Goods or the said Documents of Title 
        are hereby pledged to the Bank as security for the payment or discharging 
        to the Bank of the aggregate balance of such account or accounts or any 
        other liability of the Borrower as aforesaid together with rent and other 
        cost of and incidental to the warehousing of any goods so pledged on demand 
        by the Bank at any time.</p>
      
    </td>	
  </tr>
  <tr>
  <td width="4%"  valign="top">3.</td>
  <td width="96%"><p align="justify">That the Bank shall be at liberty to have any of the said Goods that may be pledged as aforesaid valued by an appraiser appointed by the Bank and the fees and expenses of such appraisement shall be debited to the said account or accounts.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">4.</td>
  <td width="96%"><p align="justify">That all the said Goods, the subject of this Agreement, shall be insured against fire, theft and natural calamities by the Borrower in the joint names of the Borrower and the Bank with an Insurance Company approved by the Bank to the extent of at least ten per cent in excess of the amount advanced by the Bank against them and that the Insurance Policies shall be delivered to the Bank.  If the Borrower fails to effect such insurance, the Bank may (without being bound and in its absolute discretion) insure the said Goods against fire, theft and natural calamities in such joint names and debit the premium and other charges to such account or accounts aforesaid as the case may be and in the event of the Bank being at any time apprehensive that the safety of the said Goods is likely to be endangered owing to civil commotion or riots or enemy action or war, it shall on failure by the Borrower to so insure the goods in the joint names against any damage arising from all or any of the said causes the Bank shall do so, the cost of such extra insurance being payable by the Borrower and being debited to such account or accounts as aforesaid.  The Borrower expressly agrees that the Bank shall be entitled to adjust settle compromise or refer to arbitration any dispute between the Insurance Company and the insured arising under or in connection with such policy or policies and such adjustment, settlement, compromise and any award made on such policy or policies shall be valid and binding on the Borrower and also to receive all monies payable under any such policy or policies or under any claim made thereunder and to give a valid receipt thereof and that the amount so received shall be credited in the account having reference to the said Goods in respect of which such amount is received and that the Borrower will not raise any question that a larger sum might or ought to have been received or be entitled to dispute his liability for the balance remaining due on such account after such credit.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">5.</td>
  <td width="96%"><p align="justify">That the Borrower shall furnish to the Bank forthwith upon the request of the Bank such margin money as may be demanded by the Bank from time to time either by cash payment or by depositing with the Bank further approved security sufficient to cover the amount of margin demanded by the Bank.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">6.</td>
  <td width="96%"><p align="justify">All sea and rail freights, demurrage, custom duties, terminal taxes, cartages godown rents and all other costs charges and expenses paid or incurred by the Bank in obtaining actual physical possession of and in clearing, storing and forwarding the said Goods for the time being pledged to the Bank shall be included in the advances made by the Bank and shall be debited to the said account or accounts of the Borrower accordingly.</p>
</td>
  </tr>
  <tr>
  <td width="4%"  valign="top">7. (a)</td>
  <td width="96%">
      <p align="justify">That the Borrower shall pay to the Bank interest on the 
        amount of the advance/advances for the time being outstanding at the rate 
        of _______.percentage per annum with _________.rests or at such other 
        revised rate/s as may be prescribed by the Bank from time to time depending 
        upon the changes in the Prime Lending Rate of the Bank or the directives 
        of the Reserve Bank of India from time to time or the policy of the Bank 
        on advances, such interest to be payable, whether actually debited to 
        the account or not, and until so paid shall form part of the advance/s 
        granted by the Bank to the Borrower and the Borrower agrees to execute 
        necessary Promissory notes or debit balance confirmations accordingly 
        from time to time.</p>
    </td>
  </tr>
  <tr>
  <td width="4%"  valign="top">(b)</td>
  <td width="96%"><p align="justify">In the event of any revision in the rate of interest, the Borrower shall be deemed to have notice of revision in the rate of interest whenever such revision in the Prime Lending Rate is displayed /notified by the Bank in the notice board in the branch premises where the advance/s  is/are availed by the Borrower or published in the newspaper/s, or made known through entry of interest charged in the statement of account given to the Borrower.</td>
  </tr>
  <tr>
  <td width="4%"  valign="top">(c) </td>
  <td width="96%"><p align="justify">Provided further that,  without  prejudice  to the Bank?s other rights and remedies, the Bank shall be entitled to charge, in its discretion, penal/additional rate/s of interest at the rate of 2% p.a. or such other  rate as the Bank may from time to time in accordance with its policy determine as payable on the outstanding dues or any portion thereof for any delay in repayment/adjustment of the advances and/or interest as agreed or in default or irregularity in observing the terms and conditions of this agreement by the Borrower/s which in the opinion of the Bank warrants charging of penal interest for such period as the Bank may deem fit.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">8.</td>
  <td width="96%"><p align="justify">That on demand being made by the Bank, the Borrower shall repay to the Bank all monies or liabilities then outstanding and owing to the Bank on such account or accounts as aforesaid together with interest at the rate aforesaid and the amount of all other charges and expenses, if any, provided that nothing contained shall be deemed to prevent the Bank from demanding payment of interest for the time being due at the abovementioned rate without at the same time demanding payment of the balance due to the Bank exclusive of such interest.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">9.</td>
  <td width="96%"><p align="justify">That in default of such payment as last aforesaid or on failure of the Borrower to furnish to the Bank upon request by the Bank margin monies as referred to in Clause 5 above the Bank may at any time or times thereafter and without any notice to the Borrower (without prejudice to the Bank?s right of suit against the Borrower) either by way of public auction or private contract absolutely sell or otherwise dispose of any of the said goods then remaining pledged to the Bank under this Agreement and assign, assure, transfer or negotiate any of the said Documents of Title and out of the proceeds thereof reimburse the Bank in respect of the said monies or liabilities or so much thereof as shall remain owing to the Bank on such account or accounts as aforesaid.</p>
</td>
  </tr>
  <tr>
  <td width="4%"  valign="top">10.</td>
  <td width="96%"><p align="justify">That the Bank shall not be under any liability whatsoever towards the Borrower or any other person for the counting, measurement,  quantity, quality or for any loss, damage, destruction, depreciation or shortage of or in the said Goods the subject of this Agreement from or in whatsoever cause or manner arising whether such said Goods shall be in the possession of the Bank or not at the time of such loss or damage or the happening of the cause thereof.  The Borrower shall at all times indemnify and keep indemnified the Bank from and against all suits, proceedings, costs, charges, claims and demands whatsoever that may at any time arise or be brought or made by any person against the Bank in respect of any acts, matters, and things lawfully done or caused to be done by the Bank in connection with the said Goods or in pursuance of the rights and powers of the Bank under this Agreement.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">11.</td>
  <td width="96%"><p align="justify">That this Agreement is to operate for the ultimate balance or aggregate balance with interest thereon to become payable upon the said account or accounts as aforesaid and the said account or accounts is / are not to be considered to be closed for the purpose of this security and the security is not to be considered exhausted merely by reason of the said account or accounts or either or any of them being brought to credit at any time or from time to time and if the whole of the Bank?s advances shall be repaid and the whole of the security be withdrawn the account or accounts or either or any of them maynevertheless at any time before such account or accounts has or have been closed be continued under this Agreement upon security as aforesaid being again furnished.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">12.</td>
  <td width="96%"><p align="justify">That at any time or from time to time before demand made by the Bank as aforesaid whenever the value of the security for time being held by the Bank under this Agreement shall be in excess of that which the Bank is entitled to demand under the terms of this Agreement as security for the amount of the Bank?s advances on any such account or accounts as aforesaid inclusive of interest the Bank shall at the request of the Borrower release to the Borrower such excess of security or any part of such excess provided always the Borrower to the Bank whatsoever absolute or contingent which in the opinion of the Bank might not be adequately secured.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">13.</td>
  <td width="96%"><p align="justify">The Borrower hereby solemnly declares that all the said Goods and all the said Documents of Title pledged to the Bank under this Agreement are and will on each occasion be at the time of advance the actual property of the Borrower or that the Borrower has or will have at the time of advance an interest in them entitling the Borrower to pledge the same as security for advance hereunder free  from any encumbrances.</p></td>
 </tr>
  <tr>
  <td width="4%"  valign="top">14.</td>
  <td width="96%"><p align="justify">That the Borrower shall not during the continuance of this Agreement pledge or otherwise charge or encumber any of the said Goods over which the lien of the Bank shall extend or be expressed, intended to extend nor do or permit any act whereby the security hereinbefore expressed to be given to the Bank shall be in any way prejudicially affected.</p>
</td>
  </tr>
  <tr>
  <td width="4%" valign="top">15.</td>
  <td width="96%"><p align="justify">That the Borrower hereby agrees to accept as conclusive proof of the correctness of any sum or sums claimed to be due from the Borrower to the Bank on such account or accounts as aforesaid or under this Agreement a statement of account made out from the books of the Bank and signed by the Accountant or other duly authorised officer of the Bank without the production of any other voucher, document or paper and also agrees to pay all the interest accrued/to accrue and not actually debited in the account.</p>
</td>
  </tr>
  <tr>
  <td width="4%" valign="top">16. </td>
  <td width="96%">The Borrower hereby further agrees that in case the Borrower commits default in the repayment of the loan or in the repayment of interest thereon on due date/s, the Bank and/or Reserve Bank of India will have an unqualified right to disclose or publish the name of the Borrower or its Directors/partners/proprietor as defaulters in such manner and through such medium as the Bank or Reserve Bank of India in their absolute discretion may think fit.</td>
  </tr>
  <tr>
  <td width="4%"  valign="top">17.  </td>
  <td width="96%"><p align="justify">Without prejudice to the terms contained hereinabove, it shall be lawfulfor the Bank to debit the Borrower?s current or cash credit account the expenses incurred by the Bank towards inspection or valuation of the said goods or legal expenses or any other reasonable expenses incurred by the Bank for preservation and protection of the said goods or in pursuance of this Agreement.</p></td>
  </tr>
  <tr>
  <td width="4%"  valign="top">18.</td>
  <td width="96%">
      
      <p align="justify">That should the Borrower be more than one individual all shall be bound 
        hereby jointly and severally and if a firm, all members of such firm and 
        all members from time to time thereof shall be bound hereunder jointly 
        and severally notwithstanding any changes in the constitution or style 
        thereof and whether such firm consists of or be reduced to one individual 
        at any time and that should the Borrower be a Limited Company a corporate 
        or unincorporated body, committee, firm, partnership, trustees, or debtors 
        on a joint account, the provisions hereinbefore contained shall be construed 
        and take effect where necessary as if words importing the singular number 
        included also the plural number and lastly that if the Borrower be more 
        than one individual at any time any notice served on any one of such individual 
        shall be deemed to be service of such notice on all such individuals. 
        IN WITNESS WHEREOF the Borrower has hereunto put his hand and seal this...<b> <%=date%> <%=Months[a]%>, <%=year%></b>  </p>
    </td>
  </tr>
  
</table>
</body>
</html>
