<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
   ArrayList vecGold=new ArrayList();
   vecGold=(ArrayList)hshValues.get("vecGold");
    
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
      <div align="center"><b>GOLD LOAN' PLEDGE FORM</b><br>
      </div>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div align="center">G.L.NO.</div>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="55%"><b>KARNATAKA BANK LTD. </b></td>
    <td width="45%"> 
      <div align="center">Place: <b><%=Helper.correctNull((String) hshValues.get("cityName"))%></b></div>
    </td>
  </tr>
  <tr>
    <td width="55%"><b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b> 
      Branch</td>
    <td width="45%">
      <div align="center">Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></div>
    </td>
  </tr>
</table>
<p>&nbsp;</p><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> 
      <p align="justify">I/We hereby pledge the following gold jewels worth approximately 
        Rs. <b><%=Helper.correctNull((String) hshValues.get("AGRESTRATE"))%></b> 
        weighing about <b><%=Helper.correctNull((String) hshValues.get("AGRARTMKTRATE"))%></b> 
        grams as security<br>
        as per appraisers valuation enclosed for the loan of Rs <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b></p> 
      <p> I/We have raised this day as per accompanying promissory note. I/We 
        also hereby declare that I/We have read the terms on which this loan is 
        granted by the Bank to me/us and hereby agree to be bound by the rules 
        printed overleaf and any amendment thereof in force from time to time. 
        I/We also agree to pay interest, service charges, inddental charge, surcharge, 
        etc. as may be fixed by the Bank from time to time. I/We further hereby 
        declare that I/We do not own or have in my possession, custody or control 
        gold ornaments and/or articles in excess of the limits permissible under 
        the Gold Control Ordinance 1968 which are to be included in the declaration 
        to be made under the ordinance. I/We further declare that the stones, 
        if any, with which the following gold ornaments are studded are imitation 
        stones of no value whatsoever. I/We declare that the jewellery pledged 
        to the Bank is/an~ either my/our own property or that I/We have such an 
        interest therein so as to entitle me/us to pledge them with the Bank.<br>
      </p>
    </td>
  </tr>
</table>
<div align="center"><br>
  <table width="63%" border="1" cellspacing="0" cellpadding="0" height="165">
    <tr> 
      <td width="13%">
        <div align="center"><b>Sr. No.</b><br>
        </div>
      </td>
      <td width="53%">
        <div align="center"><b>Description</b><br>
        </div>
      </td>
      <td width="34%">
        <div align="center"><b>Quantity</b><br>
        </div>
      </td>
    </tr>
	<%
   ArrayList vecGolddet=new ArrayList();
   vecGold=(ArrayList)hshValues.get("vecGold");
   if(vecGold!=null)
   {
   //out.println("vecGoldvecGold"+vecGold);
   for(int i=0;i<vecGold.size();i++)
   {
	   vecGolddet=(ArrayList)vecGold.get(i);
	   
	   %> 
   
    <tr> 
      <td width="13%" align="center">&nbsp;<%=i+1%></td>
      <td width="53%" align="center">&nbsp;<%=Helper.correctNull((String)vecGolddet.get(0)) %></td>
      <td width="34%" align="center"><%=Helper.correctNull((String)vecGolddet.get(1))%></td>
    </tr>
     
    <%}}%>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><b>Terms and Conditions</b></td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="4%" valign="top">1.</td>
      <td width="96%">Gold ornaments and jewellery pledged with the Bank shall 
        be kept at the risk of the borrower in Bank's ordinary safes and the Bank 
        exercising only the ordinary care of safe custody. The Bank shall not 
        be liable in case of any damage to the articles by reason of accident, 
        theft etc. 
        <p></p>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="4%" valign="top">2.</td>
      <td width="96%">The borrower shall maintain at/east a margin.of <b><%=Helper.correctNull((String) hshValues.get("downpay"))%></b> 
        % on gold ornaments and in case of fluctuations of price or accrual of 
        interest, the Bank may demand repayment to cover the margin on one week's 
        notice. </td>
    </tr>
    <tr> 
      <td width="4%" valign="top">3.</td>
      <td width="96%">The Bank shall be entitled to revalue the ornaments/jewels 
        at any time and if the borrower does not attend the Bank for the purpose 
        on notice sent to him, the Bank may proceed to do the same in his absence.</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">4.</td>
      <td width="96%">The Bank shall not be bound to receive part payment of the 
        loan and delivery 'of ornaments/jewellery can be obtained only on payment 
        in full of principal, interest and, costs.</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">5.</td>
      <td width="96%">The loan is repayable on demand and interest will be payable 
        at the end of every I month/quarter/half year during the time the loan 
        is allowed to run and in defaUlt of . payment, such interests will be 
        added on to the principal and thereafter the total amount , will bear 
        the same rate of interest. In case of advame to seasC'-'1al Agricultural 
        I Operations, the interest should be compounded if loan is not fully adjusted 
        on due date.</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">6.</td>
      <td width="96%">Interest for a minimum period of 15 days with a minimum 
        of Rs.I0j- will be charged on the loan even if the account is closed earlier</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">7.</td>
      <td width="96%">InCidental charges, if any incurred by the Bank will be 
        recovered from the loanee. ,</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">8.</td>
      <td width="96%">If the Pawner has other loans, overdrafts, advance or other 
        debts due to the Bank at any of its branchjes either solely or jointly 
        with other persons or in any manner unless and <br>
        until such debts are fully repaid by the pawner, the jewels pledged under 
        this loan or any&quot;: <br>
      </td>
    </tr>
    <tr> 
      <td width="4%" valign="top">9.</td>
      <td width="96%">If the loan is not paid upon a demand being made, the jewels 
        pledged will be sold in public auction or through private negotiations 
        and the pawner will be held personally liable for any deficit and if there 
        is any balance left, it will be appropriated by the Bank towards any other 
        loan, overdraft or debt owing by the pawner as debtor, guarantor or in 
        any other loan, overdraft or dept owing by the pawner as debtor, guarantor 
        or in any other capacity. It is expressly understood that such sale made 
        by the Bank shall not be disputed by the pawner in a,ny manner whatsoever. 
        <p></p>
      </td>
    </tr>
    <tr> 
      <td width="4%" valign="top">10.</td>
      <td width="96%">Notice in respect of the loan shall be deemed to have been 
        duly served if the letter containing the notice of demand is delivered 
        to the pawner in person or is posted properly addressed and prepaid to 
        the address given or if any alteration in address has been duly notified 
        to the Bank then to such address</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">11.</td>
      <td width="96%">If the jewels pledged do not belong to the pawner, he should 
        correctly state the nature of the claim he has on them. Jewels over which 
        pawner,' has neither the ownership r,or a lien will not be accepted for 
        pledge. </td>
    </tr>
    <tr> 
      <td width="4%" valign="top">12.</td>
      <td width="96%">When the loan is closed and jewels redeemed, dischaIge should 
        be endorsed by the pawner</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">13.</td>
      <td width="96%">At the time of pledging as well as redeeming the jewels 
        pawner should affix his thllmb impression/signature in the pledge note 
        if the Bank Officer so desires</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">14.</td>
      <td width="96%">The Bank is at liberty to repledge the jewels.</td>
    </tr>
    <tr> 
      <td width="4%" valign="top">15.</td>
      <td width="96%">The Bank reserves to itself the right to alter, add or delete 
        these rules at any time. For this purpose the Bank will not be required 
        to give a separate notice to each account holder. All announcements of 
        any change in the rules put up on the Bank's notice bO,3rd <br>
        or publiShed in the press shall be deemed sufficient notice to all accountholders. 
        <br>
      </td>
    </tr>
    <tr>
      <td width="4%" valign="top">16.</td>
      <td width="96%">In the event of the borrower failing to pay the valuation 
        charges on demand, the bank I:&middot;as the authority to debit the same 
        to the loan account of the concerned borrower. the valuation charges will 
        be added to the principal amount and will also carry interest thereon.</td>
    </tr>
  </table>
  <br>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>All the above terms and conditions are explained to me/us and agreeable 
        to me/us.<br>
      </td>
    </tr>
  </table>
  <br>
  <br>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="48%">&nbsp;</td>
      <td width="52%"> 
        <div align="center"><b>SIGNATURE OF THE BORROWER</b><br>
        </div>
      </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>Received back the above said pledged jewels in good condition.<br>
      </td>
    </tr>
  </table>
  <br>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b><br>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="48%">&nbsp;</td>
      <td width="52%"> 
        <div align="center"><b>Signature of Borrower</b><br>
        </div>
      </td>
    </tr>
  </table>
  <br>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="48%">Particulars of Auction (if any)<br>
      </td>
      <td width="52%">
        <div align="center">Amount Rs. <b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b><br>
        </div>
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
    </tr>
  </table>
  <br>
  <p><br>
    <br>
    <br>
  </p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>
        <div align="center"><b>Signature of Bidder</b><br>
        </div>
      </td>
      <td>
        <div align="center"><b>Branch Manager/Officer-in-charge</b><br>
        </div>
      </td>
    </tr>
  </table>
  <br>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>Details regarding payment/adjustment of surplus net sale proceeds (if 
        any)<br>
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
</div>
</body>
</html>
