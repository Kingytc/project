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
      <td colspan="3"> 
        <div align="center">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td colspan="2">Annexure to I.C. 3570 </td>
            </tr>
            <tr> 
              <td width="71%">on creation of equitable mortgage.<br>
                <br>
              </td>
              <td width="29%">Date: <b>: <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
            </tr>
            <tr> 
              <td colspan="2">
                <div align="center"><b>Karnataka Bank Ltd.<br>
                  </b></div>
              </td>
            </tr>
          </table>
          <b><u>MEMORANDUM OF ENTRY<br>
          </u></b></div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div align="center">(For additional limits/ Advances in States with stamp 
          Duty on memorandum)<br>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
        Shri _______________________________ Director of M/s. _________________________, 
        a company incorporated under the Companies Act 1956 and having its registered 
        office at ___________________________(hereinafter called the Company) 
        attended the office of Karnataka Bank Ltd., __________________________________________________ 
        (hereinafter called the &#145;UBI&#146;) and saw Shri (Bank officer) of 
        the Bank. The said Shri _______________________ stated that the documents 
        of title, evidences, deeds and writings more particularly described in 
        the First Schedule (hereinafter called &#145;the title deeds&#146;) in 
        respect of Company&#146;s land and other immovable properties situated 
        at ______________________________________________more particularly described 
        in the Second Schedule hereunder written, have already been deposited 
        by the Company with the bank on _____________________ with intent to create 
        a security on the said lands together with buildings and other structures, 
        fixed plant and machinery, constructed/erected or installed thereon, both 
        present and future (herein after referred to as the &#145;said immovable 
        properties&#146;) for securing the due repayment and discharge by the 
        Company to the Bank, all the amounts outstanding under the various credit 
        facilities granted or to be granted by the bank to the Company together 
        with interest, costs, charges, expenses and other monies outstanding in 
        respect of the various credit facilities.</p> </font> <br>
      </td>
    </tr>
    <tr> 
      <td colspan="3"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
        Shri ___________________________ accorded and gave oral consent on behalf 
        of the Company in the presence of Shri ___________________________ and 
        Shri ________________________ to hold and to retain the said title deeds 
        by constructive delivery of the Company&#146;s said immovable properties 
        as security also for the due repayment and discharge by the Company to 
        UBI in respect of enhanced/additional credit facilities as under : 
        <p>Together with interest, compound interest, additional interest in case 
          of default, liquidated damages, commitment charges, premia on repayment 
          or redemption, costs, charges, expenses and other monies payable by 
          the Company to UBI. </p> </font> <br>
       
      </td>
    </tr>
    <tr> 
      <td colspan="3"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
        Whilst giving such oral assurance and consent, Shri _________________ 
        stated that he did so in his capacity as a Director of the Company with 
        intent to create security on the said immovable properties as aforesaid. </p> </font> <br>
      </td>
    </tr>
    <tr> 
      <td colspan="3"><br>
        Shri _________________________ also stated that he was authorised to give 
        such oral consent pursuant to the resolution passed by the Board of Directors 
        of the Company at their meeting held on _________________ and he furnished 
        certified copies of the said resolution to Shri ___________________ and 
        Shri _____________________ and further stated that the said resolution 
        is in full force and effect.<br>
      </td>
    </tr>
    <tr> 
      <td colspan="3">
        <div align="center"><br>
          THE FIRST SCHEDULE ABOVE REFERRED TO (the description of title deeds, 
          documents and writings).<br>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3">
        <div align="center"><br>
          <br>
          <br>
          <br>
          <br>
          THE SECOND SCHEDULE ABOVE REFERRED TO (description of immovable property) 
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">Dated this--- <b><%=date%>th <%=Months[a]%>, <%=year%></b>.<br>
      </td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2"><br>
      (<b>Signature</b>)<br>
        <br>
        Bank Officer <br>
        <br>
      </td>
      <td width="32%"> <br>
      (<b>Signature</b>)<br>
        <br>
        Bank Officer</td>
    </tr>
    <tr> 
      <td width="3%"><br>
        (ii)</td>
      <td width="65%"><br>
        Not to be signed by the borrower/depositor of title deeds.</td>
      <td width="32%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%"><br>
        (iii) </td>
      <td width="65%"> <br>
        To be stamped before signing as per State Law, if any.</td>
      <td width="32%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%">(iv)</td>
      <td width="65%"><br>
        In case of doubt, the Memorandum may be got adjudicated by Collector as 
        to proper amount of stamp duty payable under Section 31 of Indian Stamp 
        Act.</td>
      <td width="32%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%"><br>
        
        (v)</td>
      <td width="65%" rowspan="2"><br>
        Regarding Appendix &#145;E&#146; and &#145;F&#146; to I.C. No. 3072, after 
        the words &#147;all the amounts under the various facilities granted or 
        to be granted by the Bank&#148; and before the words &#147;to the &#133;&#133;&#133;&#133;&#133;&#133;&#148; 
        please add the words &#147;as under&#148; and mention the credit facilities 
        to be secured below that para in Maharashtra State to make clear the credit 
        facilities/limits to be secured for the purpose of calculating stamp duty 
        amount. In case of doubt, please consult a local Advocate.<br>
      </td>
      <td width="32%" rowspan="2">&nbsp;</td>
    </tr>
    <tr>
      <td width="3%">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
  </table>
</body>
</html>
