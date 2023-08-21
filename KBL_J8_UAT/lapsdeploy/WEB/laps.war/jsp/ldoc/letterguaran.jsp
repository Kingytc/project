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
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td>
            <p align="center"><b><u>LETTER OF GUARANTEE(SD-01)</u></b></p>
            <p>To,<br>
              <b>KARNATAKA BANK LTD.<br></b>
              <b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b> 
              Branch </p>
            <p>&nbsp;</p>
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="6%">&nbsp;</td>
                <td width="94%">IN CONSIDERATION OF Karnataka Bank Ltd. (hereinafter 
                  called 'the Bank' which expression shall include its successors 
                  and assigns) giving credit</td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td> 
                  <p align="justify">or accommodation or granting facilities by making or continuing 
                    advances, or otherwise at my lour request to________________________________________<br>
                    _________________________________________________________________________________________________________________________<br>
                    _________________________________________________________________________________________________________________________<br>
                    _________________________________________________________________________________________________________________________<br>
                    (hereinafter called the 'the Principal') I We jointly and 
                    severally guarantee to the Bank the due payment and discharge 
                    two days after demand of all present and future advances, 
                    liabilities, bills and promissory notes whether made, incurred 
                    or discounted before or after the date hereof to or for the 
                    Principal either alone or jointly with any other person or 
                    persons and also of bills, promissory notes, of guarantees 
                    held by the Bank from time to time in any manner together 
                    with all relative interest, commission and other banking charges 
                    including legal charges and expenses. </p>
                  <p><br>
                    And I/ We jointly and severally further agree as follows:<br>
                  </p>
                  <table width="100%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                      <td width="5%">&nbsp;</td>
                      <td width="95%"><p align="justify">MY /OUR liability to the Bank hereunder 
                        shall be that of a Principal debtor and at the Bank's 
                        option, the Bank may treat me I us as primarily liable 
                        for </p></td>
                    </tr>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td colspan="2">
                        <p align="justify">debt of the Principal or the balance 
                          from time to time due in respect thereof provided always 
                          that the amount for which II We shall be liable under 
                          the Guarantee shall not exceed Rs.__________________________________(Rs.___________________________________________________________________)<br>
                          and interest on such amount or on such less sum as may 
                          be due at the rate which the Principal is or may become 
                          liable to pay to the Bank from the date of the principals 
                          default until payment. </p>
                      </td>
                    </tr>
                    <tr> 
                      <td width="5%">&nbsp;</td>
                      <td width="95%">
                        <p align="justify">THIS GUARANTEE shall be continuing 
                          security binding me I us and my lour personal representatives 
                          until the receipt by the Bank of notice in writing</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">to discontinue it and notwithstanding 
                          the discontinuance by or any release or granting of 
                          time or indulgence to any one or more of us this Guarantee 
                          shall remain a continuing security as to the other or 
                          others and if discontinued by notice this Guarantee 
                          shall nevertheless as to the party or parties giving 
                          such notice continue to be available (subject to the 
                          aforesaid limit of total amount) for and shall extend 
                          to all indebtedness and liabilities of the Principal 
                          to the Bank at the date of the receipt of such notice 
                          whether then certain or contingent and whether then 
                          payable forthwith or at some future time or times and 
                          also for and to all credits then established by the 
                          Bank for the Principal and for and to all cheques, drafts, 
                          bills, notes and negotiable instruments drawn by or 
                          for the account of the Principal on the Bank and dated 
                          or purporting to be dated on or before such date although 
                          presented to or paid by the Bank after such date.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">THIS GUARANTEE is additional and without 
                          prejudice to any securities or obligations which the 
                          Bank may now or hereafter have in respect of any</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">indebtedness or liabilities hereby 
                          guaranteed and all rights and remedies in respect thereof 
                          are reserved.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">THIS GUARANTEE shall not be discharged 
                          by any partial payment or any fluctuation or settlement 
                          of accounts or existence of a credit balance of any 
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">account at any time and shall continue 
                          in force notwithstanding that the Principal (being a 
                          Corporation) had or has no power to obtain such credit, 
                          accommodation, facilities or advances as aforesaid or 
                          that it has exceeded its powers in obtaining the same 
                          and notwithstanding the discharge of the Principal by 
                          operation of law or by death or the death of anyone 
                          or more of us and in the event of my death or the death 
                          of anyone or more of us, the liability of my lour legal 
                          personal representatives and of my lour estate shall 
                          continue until the receipt by the Bank of notice in 
                          writing of the intention of my lour executors or administrators 
                          to determine this Guarantee but this Guarantee' shall 
                          cease at any time on payment by me / us or anyone of 
                          us of the full amount payable under this Guarantee.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">THE BANK shall have full discretionary 
                          power with or without reference or notice or consent 
                          t%r from me I us to grant time or other indulgence to 
                          or</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">accept or make any composition or arrangement 
                          with the Principal or any person or persons liable in 
                          respect of any indebtedness or liability hereby guaranteed 
                          and also vary, abstain from perfacting, exchange, renew, 
                          discharge, release, enforce and deal with in whole or 
                          in part and from time to time any bills, notice, mortgages, 
                          charges, liens or any securities obligations or decrees 
                          now or hereafter held by the Bank in respect thereof 
                          and generally to treat me I us as though I / We were 
                          primarily and severally liable with the Principal.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">It is also agreed that any admission 
                          or acknowledgment in writing by the principal debtor 
                          of the amount of indebtedness of the principal debtor 
                          or</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">otherwise as in relation of the subject 
                          matter of this guarantee, shall be binding on me I us 
                          and I / We accept the correctness of any statement of 
                          account served on the principal debtor which is duly 
                          certified by any Manager or Officer of the Bank and 
                          the same shall be binding and conclusive as against 
                          me / us also, and I / We further agree that in making 
                          an acknowledgement or making a payment the principal 
                          debtor shall be treated as my / our duly authorised 
                          agent for purpose of Indian Limitation Act, 1963.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">I / We further specifically agree that 
                          the guarantee shall continue to remain in force and 
                          I I We shall continue to be liable thereunder for all 
                          amounts due</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">and payable to you by the principal/s 
                          even though the principal/s has / have not renewed the 
                          documents and even though the amounts due from the principal/s 
                          gets time barred and you cannot recover the same from 
                          the principal/s by filing a suit or any legal proceedings 
                          against the principal/s.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">I / We hereby consent to your making 
                          any variance that you may think fit in terms of your 
                          contract and with the principal/s and to your determining</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">enlarging or varying any credit to 
                          him I them to your making any composition with him / 
                          them or promising to give him I them time or not to 
                          sue him / them and to your parting with any security 
                          you may hold for the guaranteed debt and accordingly, 
                          I / We shall not be entitled to claim any of the rights 
                          conferred on sureties by Sections 133,134, 135, 139 
                          and 141 of Contract Act.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">I / We waive all suretyship or other 
                          rights at any time inconsistent with any of the terms 
                          hereof.</p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">If the Bank should receive payment 
                          from the Principal or any person or persons as aforesaid 
                          liable to the Bank or from any security held by the 
                          Bank</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">or if the Principal being an individual 
                          or individuals for any person or persons as aforesaid 
                          liable to the Bank shall become bankrupt or insolvent 
                          or enter into any arrangements or composition with his 
                          or their creditors or being a Company shall go into 
                          liquidation, the Bank shall be at liberty withcut discharging 
                          my / our liability to make or assent to any compromises, 
                          compositions or arrangements or to prove and to rank 
                          as creditors in respect of the general balance of the 
                          Bank's account or any item or items thereof, and to 
                          receive dividends thereupon and all such payments and 
                          dividends received shall be treated as payments in gross 
                          and my/ our liability shall extend to the ultimate balance 
                          after deducting such payments other than payments made 
                          by any co-surety for the full sum hereby guaranteed 
                          and to the entire exclusion and surrender of all my 
                          / our rights as surety in competition with the Bank, 
                          the status of Bankruptcy or any rule of law or equity 
                          to the contrary notwithstanding.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td height="36">&nbsp;</td>
                      <td height="36">
                        <p align="justify">I / We agree that a copy f)f the account 
                          of the Principal contained in the Bank's book of account 
                          (or of the account for preceding six months if the </p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify">account shall have extended beyond 
                          that period) signed by the Manager for the time being 
                          of the office at which such account shall be kept or 
                          any office of the Bank, shall be conclusive evidence 
                          against me / us of amount for the time being due to 
                          the Bank from the Principal in any action or other proceeding 
                          brought against me/us upon this guarantee.<br>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>
                        <p align="justify">SHOULD the Principal be a Limited Company, 
                          corporate or unincorporate body, committee, firm. partnership, 
                          trustees or debtors on a joint account</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p align="justify"> the provisions herein before contained 
                          shall be construed and take effect where necessary as 
                          if words importing the singular number included also 
                          the plural number, This my lour Guarantee shall then 
                          remain effective notwithstanding any death, retirement, 
                          change, accession or addition, as fully as if the person 
                          Of persons constituting or trading or acting as such 
                          body, committee, firm, partnership, trustees or debtors 
                          or joint account at the 'date of the Principal's d~fault 
                          or at any time previously was or were the same as at 
                          the date hereof. And further the Bank shall not be bound 
                          to enquire into the powers of the Principal or any Agents 
                          acting or purporting to act on the Principal's behalf 
                          and the Bank may recover against me / us to the extent 
                          herein before mentioned notwithstanding , that any security 
                          given or to be given to the Bank may be void, defective 
                          or formal or informal or~notwithstanding that the principal 
                          being a Limited Company, corporate o( unincorporate 
                          body or committee may have had no borrowing powers or 
                          may have exceeded its borrowing powers or that the borrowing 
                          from the Bank may have been ultravires. <br>
                          .</p>
                      </td>
                    </tr>
                    <tr> 
                      <td height="23">&nbsp;</td>
                      <td height="23"> 
                        <p align="justify">If this Guarantee is given by a Limited 
                          Company alone the various joint and several agreement 
                          herein contained shall be read or construed as if they 
                          were several.</p>
                      </td>
                    </tr>
                    <tr> 
                      <td> <br>
                      </td>
                      <td>
                        <p align="justify">Any notice by way of request, demand 
                          or otherwise hereunder may be given by the Bank to me 
                          I us or any of us personally or may be left at then 
                          or last</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2">
                        <p align="justify">known place of business or residence 
                          in India of me I us or any of us addressed as aforesaid 
                          to me/us or may be sent by post to me/us any of us addressed 
                          as aforesaid and if sent by post it shall be deemed 
                          to have been given at the time when it would be delivered 
                          in due course of post and shall be sufficient to prove 
                          that the envelope containing the notice was posted. 
                          If by reason of absence from India or otherwise, II 
                          We or any of us cannot be given any such notice the 
                          same if inserted once as an advertisement in a newspaper 
                          circulating in the town mentioned at the commencement 
                          of this Guarantee, shall be deemed to have been effectively 
                          given and received on the day which such advertisement 
                          appears.</p>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="2"> 
                        <p>&nbsp;</p>
                        <p>Dated this ....<b> <%=date%> <%=Months[a]%>, <%=year%></b> 
                        </p>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp; </p>
                  <p> <br>
                  </p>
                </td>
              </tr>
            </table>
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>

</body>
</html>
