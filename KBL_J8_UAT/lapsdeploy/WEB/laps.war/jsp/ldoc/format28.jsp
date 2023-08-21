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
        <div align="right"><b><u>FORMAT 28</u></b></div>
      </td>
    </tr>
    <tr> 
      <td>
      </td>
    </tr>
    <tr> 
      <td> 
        <div align="center"><b>OMNIBUS- COUNTER INDEMNITY FOR LETTER OF GUARANTEE 
          LIMIT</b><br>
        </div>
      </td>
    </tr>
    <tr> 
      
    <td>The <br>
      Branch Manager,</td>
    </tr>
    <tr> 
      
    <td><b>Karnataka Bank Ltd.,</b></td>
    </tr>
    <tr> 
      <td> <b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b> Branch.<br>
      </td>
    </tr>
    <tr> 
      <td> <font face="Times New Roman" size="3"> 
              <p align="justify">  
        In consideration of your having at our request, executed and agreed to 
        execute from time to time at the discretion of the Bank, various performance 
        and other guarantees whether already issued or to be issued hereafter 
        (hereinafter referred to as &#145;guarantees&#146;) in the form(s) furnished 
        by us as approved by the Bank subject to the outstanding amounts under 
        the Guarantees not exceeding the aggregate guarantee limit of Rs.<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%> </b> 
        (Rupees <b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b> only) at any time 
        in favour of our Indian and foreign customers / suppliers etc., we ___________________________ 
        a Limited Company incorporated in India under the Companies Act, and having 
        our Registered Office at __________________________ hereinafter referred 
        to as &#147;the company&#148; (which expression shall unless repugnant 
        to the context or meaning thereof be deemed to include its successors-in-interest 
        and permitted assigns) hereby irrevocably and unconditionally agree and 
        undertake to indemnify you, your successors and assigns at all times and 
        from time to time from and against all types, of claims, losses, damages, 
        actions, suits, proceedings, accounts and costs (as between Attorney and 
        client) charges and expenses whatsoever together with interest which may 
        be brought ormade against or sustained or incurred by you (and whether 
        paid by you or not) or for which you may become liable under or in respect 
        of the Guarantees and any subsequent renewal or renewals thereof the company 
        agrees that you may in your absolute and unqualified discretion and without 
        your being required to ascertain whether or not there was in fact any 
        breach on the part of the Company of the agreements with our customers 
        / suppliers only and without your being required to go into the validity 
        or otherwise of the demand for payment made by all or any one of them 
        against you and notwithstanding any direction to the contrary given by 
        the company or any other persons on the ground of a dispute as to the 
        liability of the Company or otherwise admit or compromise and pay or submit 
        to arbitration or dispute or resist any claim or demand made against you 
        under or in respect of the Guarantees already issued or to be issued and 
        any subsequent renewal or renewals thereof, the Counter Indemnity hereby 
        executed by the company being available to you in respect of any action 
        you may take or payment which you make and the company agrees to pay you 
        on demand without demur all such moneys as the Company may be liable to 
        pay under this Counter Indemnity including all claims, losses, damages, 
        actions together with interest at the prevailing rate with quarterly compounding 
        rest and the costs, charges and expenses whatsoever which may be brought 
        or made against you or sustained or incurred by you or for which you may 
        become liable under or in respect of the Guarantees and any subsequent 
        renewal or renewals thereof and that you have our express authority to 
        proceed against and recover / collect from any property of the Company 
        including any credit balance held by you and any security for the time 
        being held by you on account of the Company by sale or otherwise and allocate 
        and apply the net proceeds of sale and realisation thereof and any other 
        moneys in your hands standing to the credit of or belonging to the company 
        on any account whatsoever independently, the one or the other in such 
        order and in such manner as you may think fit in or towards payment of 
        all amounts found payable by the company to you hereunder and the company 
        agrees and undertakes forthwith on demand made by you to deposit with 
        you such sum or security or further sum or security as you may from time 
        to time specify as security for the due fulfilment of obligations of the 
        company hereunder and the securities so deposited with you may be sold 
        / realised by you after giving to the company a week&#146;s notice of 
        sale realisation and the said sum or the proceeds of the sale / realisation 
        of the security(ies) may be appropriated by you in or towards satisfaction 
        of the said obligations and any liability arising out of non fulfilment 
        thereof by the company and the company lastly agrees that this Counter 
        Indemnity will be continuing one and will remain in force and effect until 
        you are finally discharged of all liabilities under all or anyone of such 
        Guarantees and all subsequent renewal or renewals thereof and have had 
        the discharge confirmed in writing and received the Guarantees and any 
        subsequent renewal or renewals thereof duly redeemed.</p> 
      </font> <br>
    </td>
    </tr>
    <tr>  
      <td> <font face="Times New Roman" size="3"> 
              <p align="justify">  
        The company hereby agrees to submit to the jurisdiction of the court within 
        which your office is functioning for the enforcement of this counter indemnity.</p> </font> 
      </td>
    </tr>
    <tr> 
      <td><br>
        Date----this <b> 
            <%=date%>th <%=Months[a]%>, <%=year%></b>..<br>
        <br>
    
       
      </td>
    </tr>
    <tr> 
      <td>
        <table width="96%" border="1" cellspacing="0" cellpadding="0">
          <tr>
            
          <td width="53%"> THE COMMON SEAL OF_________________<br>
              ____________________________________<br>
              was hereunto affixed, in pursuance of a Resolution of the Board 
              of Directors of ____________________________ passed in that behalf 
              on the <b> 
            <%=date%>th <%=Months[a]%>, <%=year%></b>...<br>
              <br>
            </td>
            
          <td width="47%">&nbsp;</td>
          </tr>
          <tr>
            
          <td width="53%" height="73"> In the presence of 
            <p>1.__________________________________</p>
              <p>2.__________________________________
              </p>
            </td>
            
          <td width="47%" height="73">&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>
</body>
</html>
