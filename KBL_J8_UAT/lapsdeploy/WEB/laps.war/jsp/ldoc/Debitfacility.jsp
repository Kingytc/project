<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

 

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


 
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td align="center" colspan="3"><b>FORMAT -13</b></td>
  </tr>
<tr>
    <td colspan="3">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center"><b>Specimen P.A. for Book Debts Facility (Against supply Bills)</b></td>
        </tr>
      </table>
      <br>
(In the case of Corporate clients) 
      (To be executed in non-judicial stamp paper of appropriate value. In the 
      case of other constituents like partnership/individual, this has to be suitably 
      modified)<br>
    </td>
  </tr>
<tr>
    <td colspan="3"> <br><p align="justify">
      We,_________________Limited a body corporate having its Registered Office 
      at _______________________________________SEND GREETINGS WHEREAS We are 
      carrying on business of ___________________________________ at ___________________________________________ 
      AND WHEREAS Karnataka Bank Ltd.<b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b> 
      Branch (hereinafter called ?the Bank?) has at our request on or about ________ 
      (date) has agreed to grant/granted to ________________.Limited (Name of 
      the concern) (hereinafter referred to as ?the said Company) as Cash Credit 
      hypothecation limit of Rs____________ against hypothecation of books debts 
      due and outstanding or that may be due hereafter and which are not older 
      than _________________.months/_____________.days. AND WHEREAS with a view 
      to ensure speedy recovery of the amounts advanced or to be advanced hereafter 
      by the Bank to the said Company, we are desirous of appointing Union Bank 
      of India <%=Helper.correctNull((String) hshValues.get("branchName"))%> Branch 
      as the true and lawful attorney to represent and act for and on behalf of 
      the said Company by various firms, Companies, Government Departments etc. 
      to whom the goods are sold on credit or on deferred payment basis and also 
      that may be sold hereafter for which the supply bills will be drawn from 
      time to time .</p> </td>
  </tr>
<tr>
    <td colspan="3" align="center"><b><u>NOW KNOW YE AND THESE PRESENTS WITNESSETH 
      THAT:<br>
      </u></b></td>
  </tr>
<tr>
    <td colspan="3"><p align="justify">We hereby nominate, constitute and appoint Karnataka Bank Ltd.<b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b>. 
      Branch to be the true and lawful Attorney (hereinafter referred to as ?the 
      said Attorney?) for and on behalf of the said company to do all or any of 
      the following acts, deeds, matters and things that is to say: </p><br>
    </td>
  </tr>
<tr>
    <td width="3%" valign="top">ii)</td>
    <td colspan="9" width="97%">
      <p align="justfiy">To present and/or submit all the bills drawn by M/s. 
        _________________Ltd. from time to time in respect of the goods sold or 
        to be sold hereafter to the various firms, Govt. bodies such as State 
        Government, Central Government, Limited Companies, Municipalities or any 
        other concerns on credit or on deferred payment basis and to receive directly 
        in its own name the amounts payable to the said Company in respect of 
        all the bills drawn and to appropriate the proceeds of the said bills 
        so realised towards the adjustment of the outstanding in the various accounts 
        of the said Company.</p><br>
      
    </td>
  </tr>
<tr>
    <td width="3%" valign="top">ii)</td>
    <td colspan="9" width="97%">
      <p align="justfiy">To receive payment/s in any form such as cash, cheques, 
        drafts pay orders etc. in satisfaction of the pending supply bills drawn 
        or to be drawn hereafter by the said Company and to pass receipt/s as 
        may be required for such payments. </p> <br>
     
    </td>
  </tr>
<tr>
    <td width="3%" valign="top">ii)</td>
    <td colspan="9" width="97%">
      <p align="justfiy">To ask, demand, sue for to recover and receive from all 
        the drawees of the bills all moneys and debts due and payable by the said 
        drawees to the said Company after making all necessary allowances or deductions 
        therefrom if any as may be lawfully or reasonably claimed or as may be 
        thought expedient by the said Attorney.</p><br>
      
    </td>
  </tr>
<tr>
    <td width="3%" valign="top">ii)</td>
    <td colspan="9" width="97%">
      <p align="justfiy">To receive and give valid receipts and discharge for 
        moneys so received and realised by the Bank. </p><br>
     
    </td>
  </tr>
<tr>
    <td colspan="9"><p align="justfiy">We hereby declare that all the receipts and writings signed 
      by the Bank and all other acts, deeds, matters and things done by it in 
      pursuance of this power of attorney shall be considered as if done by us 
      and shall be binding upon us.</p> <br>
    </td>
  </tr>
<tr>
    <td colspan="9"><p align="justfiy">We hereby declare this Power of Attorney is irrevocable and 
      shall continue to remain in force and in operation notwithstanding any disability 
      such as insolvency, winding up or merger of the said Company with any other 
      firm/Company due to any reasons whatsoever and shall be binding on us and 
      our assigns until such time all the dues of Karnataka Bank Ltd. payable 
      by the said Company are paid in full with interest and discharge in writing 
      is obtained from the Bank. We hereby agree to ratify and confirm all the 
      acts done by the said Bank or its successors and assigns in pursuance of 
      this power of attorney. We also hereby indemnify and agree to keep indemnified 
      the Bank against all costs charges and expenses that may be incurred on 
      account of any of the aforesaid acts done or caused to be done in pursuance 
      of this power of attorney.</p> <br>
       
    </td>
  </tr>
<tr>
    <td colspan="9"><p align="justfiy">IN WITNESS WHEREOF THE SAID ___________________LIMITED have 
      executed these Presents on <b><%=date%> <%=Months[a]%>, <%=year%></b></p><br>
    </td>
  </tr>
<tr>
    <td colspan="3" align="left"><p align="justfiy">The common Seal of_________ )  
      ____________ Limited ) 
      is affixed hereto in the presence of ) _____________) 
      (name of witness)___________________ ) 
      (Signature of witness) ) ________________)</p></td>
  </tr>
<tr><td colspan="3" align="center">Common Seal<br>of the Company.<br><br><br>Signature of Directors.</td></tr>




</table>
</body>
</html>
