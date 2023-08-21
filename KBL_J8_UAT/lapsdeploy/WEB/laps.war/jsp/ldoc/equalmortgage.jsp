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
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td>
            <p>SUPPLEMENTARY MEMORANDUM (EQUITABLE MORTGAGE)</p>
            <p align="center"><b>KARNATAKA BANK LTD.<br>
              </b></p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td colspan="2"><b>MEMORANDUM OF ENTRY<br>
                  </b></td>
              </tr>
              <tr> 
                <td width="5%">&nbsp;</td>
                <td width="95%">Shri/Smt.______________________________attended 
                  the office of Union Bank or India, ___________________ (hereinafter 
                  called the 'UBl')</td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td colspan="2">and saw Shri (Bank Officer) ________________________ 
                  and (Bank Officer)_________________ of the Bank. The said Shri/Smt._______________ 
                  stated that the documents of itle, evidences, deeds and writings 
                  more particularly described in the First Schedule (hereinafter 
                  called 'the title deeds') in respect of his/her/their land and 
                  other immovable properties situated at _________________ more 
                  particularly described in the second schedule hereunder written, 
                  have already been deposited by him/her/them with the bank on 
                  ___________________ with intent to create a security on the 
                  said lands together with buildings and other structures, constructed/erected 
                  or installed thereon, both present and future (hereinafter referred 
                  to as 'said immovable properties') for securing the due repayment 
                  and discharge by him/her/them together with interest costs, 
                  charges, expenses and other monies outstanding in respect of 
                  such Housing Loan.</td>
              </tr>
              <tr> 
                <td width="6%">&nbsp;</td>
                <td width="94%">Shri/Smt. _______________________________________________ 
                  accorded and gave oral consent on his/her/their behalf in the 
                  presence of</td>
              </tr>
              <tr> 
                <td colspan="2">Shri _________________________________ and Shri________________________________________ 
                  to hold and to retain the said title deeds by constructive delivery 
                  of the said immovable properties as security for the due repayment 
                  and discharge by him/her/them to UBI in respect of enhanced/additional 
                  Housing Loan as under:</td>
              </tr>
              <tr> 
                <td colspan="2"> 
                  <p>&nbsp;</p>
                  <p>[Details of Additional Housing Loan to be furnished]</p>
                </td>
              </tr>
              <tr> 
                <td> 
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
                <td><br>
                  &quot; Together with interest, compound interest, additional 
                  interest in case of default, liquidated damages,commitment charges, 
                  premia on repayment </td>
              </tr>
              <tr> 
                <td colspan="2">or redemption, costs, charges, expenses and other 
                  monies payable by him/her/them to UBI.</td>
              </tr>
              <tr> 
                <td colspan="2"> 
                  <p align="center">&nbsp;</p>
                  <p align="center"><b><font size="+1">THE FIRST SCHEDULE ABOVE 
                    REFERRED TO</font><br>
                    </b>(the description of title deeds, documents and writings) 
                  </p>
                  <p align="center">&nbsp;</p>
                  <p align="center">&nbsp;</p>
                  <p align="center">&nbsp;</p>
                  <p align="center">&nbsp;</p>
                  <p align="center">&nbsp;</p>
                  <p align="center"><b><font size="+1">THE SECOND SCHEDULE ABOVE 
                    REFERRED TO <br>
                    </font></b>(Description of immovable property) </p>
                  <p align="center">&nbsp;</p>
                  <p align="center">&nbsp;</p>
                  <p>Dated this ___<b><%=date%><%=Months[a]%>, 
      <%=year%></b></p>
                </td>
              </tr>
              <tr> 
                <td colspan="2"> 
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td width="75%"> 
                        <p>(Signature)</p>
                        <p>Bank Officer</p>
                      </td>
                      <td width="25%"> 
                        <p>(Signature)</p>
                        <p>Bank Officer</p>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp;</p>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>THIS SUPPLEMENTARY AGREEMENT TO HOUSING LOAN AGREEMENT executed 
                  by Shri/Ms_____________________________ </td>
              </tr>
              <tr> 
                <td colspan="2">hereinafter called the &quot;Borrower&quot; which 
                  expression shall whenever not repugnant to the context means 
                  and includes its successors and assigns from time-to-time) IN 
                  FAVOUR OF Union. Bank of India, a body-corporate constituted 
                  under Banking Companies (Acquisition and Transfer of Undertakings) 
                  Act, 1970 having its registered office at Mumbai and a Branch 
                  interalia at/named __________________________ (hereinafter referred 
                  to as &quot;the Bank&quot; which expression shall unless the 
                  context otherwise requires include its successors and assigns 
                  from time-to-time).<br>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>WHEREAS, the borrower has availed a Housing Loan from the 
                  Bank to the time of Rs.___________________________________________</td>
              </tr>
              <tr> 
                <td colspan="2">and had executed a Housing Loan Agreement dated 
                  _____ (hereinafter called the &quot;Principal Housing Loan Agreement) 
                  AND<br>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>WHEREAS, the Borrower aforesaid having requested for an additional 
                  housing loan of Rs._______________________________________</td>
              </tr>
              <tr> 
                <td colspan="2">(________________________________________________________________________)and 
                  the Bank having agreed to sanction the same and that the Borrower 
                  agrees that all the other terms and conditions in the Principal 
                  Housing Loan Agreement shall apply to the additional loan.<br>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>NOW IN CONSIDERATION of the above, the Borrower hereby agrees, 
                  records and confirms with the Bank as follows: .<br>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>This agreement shall be supplemental to the Principal Housing 
                  Loan Agreement<br>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>It is hereby agreed that the additional loan amount is requested 
                  by the Borrower and sanctioned by the Bank for payment of Single 
                  Premium </td>
              </tr>
              <tr> 
                <td colspan="2" height="49">to join the Union Home Plus Group 
                  Life Insurance Scheme.<br>
                </td>
              </tr>
              <tr> 
                <td height="32">&nbsp;</td>
                <td height="32">The balance outstanding in the Housing Loan account 
                  as on ____________________________ is Rs,______________________________).. 
                  <br>
                </td>
              </tr>
              <tr> 
                <td colspan="2">After debiting Rs______________________________ 
                  (________________________________)as additional Housing Loan 
                  for paying the insurance premium, the total outstanding in the 
                  loan account stands at Rs._______________________________ (____________________________________).<br>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>It is hereby agreed that the figure of Rs._________________________ 
                  (_______________________) in the Preamble&middot; as well as 
                  subsequent</td>
              </tr>
              <tr> 
                <td colspan="2">paragraph of the Principal Housing Loan Agreement 
                  shall stand revised to Rs,___________________ (___________________________ 
                  ) and the figure of Rs._____________ (_____________________ 
                  ) in Clause (b), i.e. Equated Monthly installments shall stand 
                  revised as Rs._______________.<br>
                  (______________________________________________________________________________).<br>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>The rate of interest applicable to the additional housing 
                  loan shall be __________________% p.a. with _______________________ 
                  rests <b>OR</b></td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>The rate of interest applicable to the additional housing 
                  loan shall be at _______________________% p.a. below _______________________<br>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>IN WITNESSWHERE OF THE BORROWER HAS HEREUNTO PUT HIS HAND 
                  AND SEAL ON THIS <b><%=date%><%=Months[a]%>, 
      <%=year%></b></td>
              </tr>
              <tr> 
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2">
                  <div align="right">
                    <p>&nbsp;</p>
                    <p>Signature of the Borrower [s]</p>
                  </div>
                </td>
              </tr>
              <tr> 
                <td colspan="2">&nbsp;</td>
              </tr>
            </table>
            <p align="center"><b> </b></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table> 
</body>
</html>
