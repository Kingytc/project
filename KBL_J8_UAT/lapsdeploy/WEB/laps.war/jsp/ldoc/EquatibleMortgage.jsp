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
<body bgcolor="#FFFFFF" text="#000000">


<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td align="center" colspan="3"><b>FORMAT - 2</b></td>
  </tr>
  <tr> 
    <td align="center" colspan="3"><b>DECLARATION BY BORROWER  (EQUITABLE MORTGAGE)</b></td>
  </tr>
  <tr> 
    <td colspan="3"><p align="justify">(Appendix-B to Instruction Circular No. 3072 Dated 13-06-1985 for creation of Equitable Mortgage)</p></td>
  </tr>
<tr> 
    <td colspan="3"><p align="justify"> On non-judicial stamp paper of Rs.<b><%=Helper.correctNull((String)hshValues.get("sancamount"))%></b> 
      (depending on the State Stamp Act)</p></td>
  </tr>
  <tr> 
    <td align="center" colspan="3"><b>DECLARATION</b></td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="4%">&nbsp;</td>
          <td width="96%">I/We <b><%=Helper.correctNull((String) hshValues.get("appname"))%></b> 
            all of Indian Inhabitant/s residing at<b><%=Helper.correctNull((String) hshValues.get("perapp_address1"))%>,</b><b><%=Helper.correctNull((String) hshValues.get("perapp_address2"))%>,</b><b><%=Helper.correctNull((String) hshValues.get("perapp_address3"))%>,</b><b><%=Helper.correctNull((String) hshValues.get("perapp_city"))%>,</b><b><%=Helper.correctNull((String) hshValues.get("perapp_state"))%></b>do 
            each of us hereby solemnly and sincerely declare and say as follows:<br>
          </td>
        </tr>
      </table>
       
    </td>
  </tr>
<tr> 
    <td width="4%">1</td>
    <td colspan="9" width="96%"><p align="justify">I am the Sole Proprietor of and carry on business 
      in the name and firm of Messrs__________________________ at ________________ </p>
    </td>
  </tr>		
<tr> 
    <td width="4%"></td>
    <td colspan="9" align="center" width="96%">OR </td>
  </tr>				
<tr> 
    <td width="4%"></td>
    <td colspan="9" width="96%"><p align="justify">We are the partners of and carry on business in 
      the firm name and style of Messrs_____________________________ at __________________ </p>
    </td> 
  </tr>				
<tr> 
    <td width="4%"></td>
    <td colspan="9" align="center" width="96%">OR </td>
  </tr>							
<tr> 
    <td width="4%"></td>
    <td colspan="9" width="96%"><p align="justify">I alongwith my co-partners Shri _________________ 
      carry on business in partnership in the firm name and style of Messrs___________________________ 
      at _____________________ </p></td>
  </tr>						 
<tr> 
    <td width="4%"></td>
    <td colspan="9" align="center" width="96%">OR </td>
  </tr>		
 <tr> 
    <td width="4%"></td>
    <td colspan="9" width="96%"> 
      <p align="justify">I am one of the Directors of Messrs_________________________ 
        having its Registered Office at ___________________ (hereinafter referred 
        to as "the Company?) and I am authorised by a resolution of the Board 
        of Directors of the Company dated the ____________ day of ________________ 
        to make this Declaration.<br>
        <br>
      </p> 
  </tr>
<tr> 
    <td width="4%" valign="top">2</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We/The Company am/are/is the sole and absolute owner/s 
        of the pieces or parcels of land or ground together with the building/s 
        hereditaments and premises standing thereon in the Registration, Sub-District 
        of __________________________ and more particularly described in the First 
        Schedule hereunder written (hereinafter referred to as ?the said property?) 
        and no other person has any share, right title or interest of any kind 
        or nature whatsoever in the said property. <br>
        <br>
      </p>
    </td>
  </tr>	
<tr> 
    <td width="4%">3</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We say that I/We/ the Company am/are/is entitled to 
        deal with the said property as I/We/the Company like/s.<br>
        <br>
      </p>
    </td>
  </tr>	  
  <tr> 
    <td width="4%" valign="top">4</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We say that I/We /the Company have/has not created 
        any mortgage, charge or encumbrance of any kind or nature whatsoever on 
        or in respect of the said property. I/We further declare that the said 
        property is free from all encumbrances, claims or demands of any kind 
        or nature whatsoever. I/We further declare that no adverse claim of any 
        kind exists against the said property. I/We further say that I/We/the 
        Company have/has not received any notice of any intended or compulsory 
        acquisition of the said property or any notice that the said property 
        is reserved for any particular purpose.<br>
        <br>
      </p> 
    </td>
  </tr>	  
 <tr> 
    <td width="4%" valign="top">5</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We further say that the only title deeds documents 
        or writing to the said property which are in my/our/the Company?s possession 
        are those specified and mentioned in the Second Schedule hereunder written 
        and that I/We do not have in my/our/the Company?s possession any other 
        title deeds, documents or writings in respect of the said property. I/We 
        further declare and say that I/We/the Company have/has not at any time 
        deposited any of the title deeds relating to the said property with any 
        person or persons whomsoever as and by way of security, equitable mortgage 
        by deposit of title deeds, charge, lien or trust or in any manner whatsoever 
        and that the said property is free from all encumbrances, claims and demands. 
        No claim has ever been made against me/us/the Company or against the said 
        property on the ground of any deposit of all or any of the title deeds 
        documents or writings or any one or more of them as security or on any 
        other ground whatsoever. <br>
        <br>
      </p>
    </td>
  </tr>	 
<tr> 
    <td width="4%" valign="top">6</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We say that I/We/the Company am/are/is the absolute 
        owner/s of the plants, engines, boilers etc. which are affixed to and/or 
        installed in/or the said property (hereinafter referred to as ?the said 
        plant?) and that the said plant is free from any mortgage, charge or encumbrance 
        of any kind or nature whatsoever and I/We/the Company am/are/is entitled 
        to deal with to dispose of the said plant in any manner I/We/Company like/s.<br>
        <br>
      </p> 
    </td>
  </tr>	 
<tr> 
    <td width="4%" valign="top">7</td>
    <td colspan="9" width="96%"> 
      <p align="justify">(ii)I/We say that there are no land revenue assessment, 
        income-tax, wealth-tax, expenditure tax or any other taxes, cesses, dues, 
        assessment due and payable by me/us/the Company for which the said property 
        and/or the said plant is/are liable to be attached nor have I/We/the Company 
        received any notice under the payment of Taxes Act. The Transfer of Property 
        (Amendment) Act. The Income-tax Act, The Wealth Tax Act, The Expenditure 
        Tax Act, The Gift Tax Act or any other Act issued or pending against me/us/the 
        Company over the said property and/or the said plant.<br>
        <br>
      </p>
    </td>
  </tr>	 
<tr> 
    <td width="4%" valign="top">8</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We say that the said property and/or the said plant 
        is/are not subject matter of any suit or legal proceedings nor any attachment 
        before or after judgement nor has any trust secret or otherwise, been 
        created in respect of the said property and/or the said plant. <br>
        <br>
      </p>
    </td>
  </tr>
 <tr> 
    <td width="4%" valign="top">9</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We further say that Karnataka Bank has given and 
        has agreed to continue to give me/us/the Company various banking and financial 
        facilities to enable me/us/the Company to carry on my/our/the Company 
        business on the faith of the assurances which are hereby given viz. that 
        I/We/the Company will not sell, exchange, partition, mortgage, charge, 
        encumber lease dispose of or deal with any of our properties and the said 
        plant in any manner whatsoever until such time all the liabilities under 
        the various facilities granted to me/us/the Company have been paid in 
        full by me/us/the Company and I/We/the Company have got the discharge 
        confirmed in writing by the Bank.<br>
        <br>
      </p>
    </td>
  </tr>	 
 <tr> 
    <td width="4%" valign="top">10</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We hereby further declare and say that I/We/the Company 
        have/has agreed and undertaken to indemnify and keep indemnified the Bank 
        fully and effectually against all claims demands charges and expenses 
        whatsoever in respect of our properties and the said plant.<br>
        <br>
      </p>
    </td>
  </tr>	    
 <tr> 
    <td width="4%" valign="top">11</td>
    <td colspan="9" width="96%"> 
      <p align="justify">I/We make this declaration solemnly sincerely and conscientiously 
        knowing the same to be true and knowing that on the faith of the said 
        declaration the Bank has given and agreed to continue to give to us the 
        said banking and financial facilities.<br>
        <br>
      </p>
    </td>
  </tr>	
  <tr> 
    <td colspan="3">
      <p align="justify">THE FIRST SCHEDULE ABOVE REFERRED TO: (Description of 
        the said property)<br>
      </p>
</td>
  </tr> 

<tr> 
    <td colspan="3"><p align="justify">THE SECOND SCHEDULE ABOVE REFERRED TO:
(List of Title Deeds, Documents and Writings)</p>
</td>
  </tr>    
<tr>  
    <td colspan="3"> 
      <p align="justify">Solemnly affirmed/Sworn by the Aforesaid Shri ______________ 
        ___________ this day <b><%=date%>th <%=Months[a]%>, <%=year%></b> Before 
        me,THE FIRST SCHEDULE ABOVE REFERRED TO: (Description of the said property) 
      </p>
    </td>
  </tr>     
  <tr> 
    <td colspan="3"> <tr> 
    <td colspan="3">&nbsp;</td>
</tr>	 
    
  
  </table>
  </body>
</html>
