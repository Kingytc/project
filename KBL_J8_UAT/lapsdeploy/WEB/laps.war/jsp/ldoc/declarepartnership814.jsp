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
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td align="center"><b> DECLARATION OF PARTNERSHIP (AD-07) <br>
            <br>
            </b> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="2%"><b>To</b></td>
                <td width="98%">&nbsp;</td>
              </tr>
              <tr>
                <td width="2%">&nbsp;</td>
                <td width="98%"> 
                  <p><b>Karnataka Bank Ltd.,</b><br>
                    <%=Helper.correctNull((String)hshValues.get("branchName"))%>  Branch
                  </p>
            </td>
              </tr>
            </table>
           
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="67%" align="right">A/c. No</td>
                <td width="33%">._____________________</td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="3%" valign="top">1</td>
                <td width="97%"> 
                  <p align="justify"> As the firm of ____________________ carrying on business 
                    of ______________at ________________________and elsewhere 
                    (hereinafter referred to as &quot;the said firm''), have or 
                    desire to have dealing with KARNATAKA BANK LTD. (hereinafter 
                    referred to as &quot;the Bank&quot;), we, the undersigned, 
                    hereby declare that we are the partners for the said firm 
                    and authorise the Bank until any notice in writing to the 
                    contrary is given to the Bank by either/any of us, to honour 
                    all Cheques, Bills of Exchange, Promissory Notes and any other 
                    Orders drawn, accepted or made on behalf of, and in the names 
                    of the firm by __________________________________________________and 
                    to act on any instructions so given relating to the account/s 
                    of the said firm, whether the said account/s be in credit 
                    or overdrawn. In the event of any such notice the account 
                    will be operated by both/all of us partners jointly. 
                    <br>
                  </p>
            </td>
              </tr>
              <tr>
                <td width="3%" valign="top">2</td>
                <td width="97%">
                  <p align="justify">We further declare that each one of us has 
                    full and unrestricted authority to act on behalf of and bind 
                    the said firm in respect of all and every transaction and 
                    matter relating to the firm's business and agree that we are 
                    jointly and severally responsible for all liabilities of the 
                    said firm to the Bank and that the Bank may recover its claims 
                    from the assets of the said firm and also from the assets 
                    of of any or all of the partners of the firm and in case any 
                    of us is a member of a Hindu Undivided Family from the estate 
                    of the joint family and the interest therein of every co-parcener 
                    of the family. In the event of death or insolvency of either/anyone 
                    of us, his estate shall be liable for all the liabilities 
                    of the said firm to the Bank.<br>
                  </p>
                 
                </td>
              </tr>
              <tr>
                <td width="3%" valign="top">3</td>
                <td width="97%">
                  <p align="justify">We undertake to advise the Bank in writing 
                    of any change that may occur in the constitution of the said 
                    firm and until receipt of such notice by the Bank, the Bank 
                    will be entitled to regard each of us as a partner of the 
                    said firm and all acts, dealings and transactions purporting 
                    to have been on behalf of the firm before the Bank shall have 
                    received notice in the manner aforesaid shall be binding on 
                    the firm and each of us as such partner and in case of death 
                    or insolvency of the respective estate of each of us. We shall, 
                    however, continue to be liable, jointly and severally, to 
                    the Bank for all dues and obligations of the firm in the Bank's 
                    Books, on the date of the receipt of such notice by the Bank 
                    and until all such dues and obligations shall have been liquidated 
                    and discharged.<br>
                  </p>
                  
                </td>
              </tr>
              <tr>
                <td width="3%" valign="top">4</td>
                <td width="97%">
                  <p align="justify">We confirm that as of the date of this declaration 
                    we are the only partners of the said firm.<br>
                  </p>
                  
                </td>
              </tr>
              <tr>
                <td width="3%" valign="top">5</td>
                <td width="97%">
                  <p align="justify">We have received and read a copy of the Bank's 
                    rules for the conduct of Current Deposit Accounts and we agree 
                    to comply with and be bound by the said rules, now in force 
                    or any changes that may be made therein from time to time.<br>
                  </p>
                   
                </td>
              </tr>
               
            </table>
 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="25%">NAMES OF PARTNERS </td>
                <td width="75%" align="center">(Full Personal Signatures)</td>
              </tr>
              <tr>
                <td width="25%"><br>
                </td>
                <td width="75%">&nbsp;</td>
              </tr>
            </table><br><br><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="5%">Place</td>
                <td width="95%"><%=Helper.correctNull((String)hshValues.get("branchName"))%></td>
              </tr>
              <tr>
                <td width="5%">Date</td>
                <td width="95%"><b><%=Helper.correctNull((String)hshValues.get("Curdate"))%></b></td>
              </tr>
            </table>
            <br>
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
