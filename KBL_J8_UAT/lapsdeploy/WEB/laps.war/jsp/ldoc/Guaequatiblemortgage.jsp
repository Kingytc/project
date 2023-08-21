
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
    <td align="center" colspan="3">
      <div align="right"><u><b>FORMAT -3</b></u></div>
    </td>
  </tr>
  <tr> 
    <td align="center" colspan="3"><u><b>DECLARATION BY MORTGAGOR (GUARANTOR) 
      (EQUITABLE MORTGAGE)</b><br>
      (Annexure to Circular Letter No.CLD:BBT:1113 dt. 21.12.1995.) </u></td>
  </tr>
<tr> 
    <td align="center" colspan="3"><u><b>DECLARATION<br>
      </b></u></td>
  </tr>  
<tr> 
    <td colspan="3"> I / We ____________________________________________________ 
      all of Indian Inhabitant/s residing at _____________________ do each of 
      us hereby solemnly and sincerely declare and say as follows:<br>
    </td>
  </tr>  
<tr> 
    <td width="6%" valign="top">1)</td>
    <td colspan="9" width="94%">I / We / The Company am / are / is the sole and 
      absolute owner/s of the pieces or parcels of land or ground together with 
      the building/s hereditaments and premises standing thereon in the Registration, 
      Sub-District of ________________________ and more particularly described 
      in the First Schedule hereunder written (hereinafter referred to as the 
      said property) and no other person has any share, right, title or interest 
      of any kind or nature whatsoever in the said property. <br>
    </td>
  </tr>	  
 <tr> 
    <td width="6%" valign="top">2)</td>
    <td colspan="9" width="94%">I / We say that I / We the Company am / are / 
      is entitled to deal with the said property as I / We / the Company like/s. 
      <br>
    </td>
  </tr>	   
 <tr> 
    <td width="6%" valign="top">3)</td>
    <td colspan="9" width="94%">I / We declare that I / We / the Company have 
      / has not created any mortgage, charge or encumbrance of any kind or nature 
      whatsoever on or in respect of the said property. I / We further declare 
      that the said property is free from all encumbrances, claims or demands 
      of any kind or nature whatsoever. I / We further declare that no adverse 
      claim of any kind exists against the said property. I / We say that I / 
      We / the company have / has not received any notice of any intended or compulsory 
      acquisition of the said property or any notice that the said property is 
      reserved for any particular purpose. <br>
    </td>
  </tr>	  
 <tr> 
    <td width="6%" valign="top">4)</td>
    <td colspan="9" width="94%">I / We further say that the only title deeds documents 
      or writing to the said property which are in my / our / the companys possession 
      are those specified and mentioned in the Second Schedule hereunder written 
      and that I / We do not have in my / our / the companys possession any other 
      title deeds, documents or writings in respect of the said property. I / 
      We further declare and say that I / We / the Company have / has not any 
      time deposited any of the title deeds relating to the said property with 
      any person or persons whomsoever as and by way of security, equitable mortgage 
      by deposit of title deeds, charge, lien or trust or in any manner whatsoever 
      and that the said property is free from all encumbrances, claims and demands. 
      No claim has ever been made against me / us / the Company or against the 
      said property on the ground of any deposit of all or any of the title deeds, 
      documents or writings or any one or more of them as security or on any other 
      ground whatsoever. <br>
    </td>
  </tr>	   
 <tr> 
    <td width="6%" valign="top">5)</td>
    <td colspan="9" width="94%">I / We say that there are no land revenue assessment, 
      income-tax, wealth-tax, expenditure-tax or any other taxes, cesses, dues, 
      assessments due and payable by me / us the company for which the said property 
      and / or the said plant is / are liable to be attached nor have I / We / 
      the Company received any notice under The Payment of Taxes Act, The Transfer 
      of Property (Amendment) Act, The Income-Tax Act, The Wealth Tax Act, The 
      Expenditure Tax Act, The Gift Tax Act or any other Act issued or pending 
      against me us / the Company over the said property and / or the said plant. 
      <br>
    </td>
  </tr>	    
 <tr> 
    <td width="6%" valign="top">6)</td>
    <td colspan="9" width="94%">I / We say that the said property and / or the 
      said plant is / are not subject matter of any suit or legal proceedings 
      nor any attachment before or after judgement nor has any trust secret or 
      otherwise, been created in respect of the said property and / or the said 
      plant. <br>
    </td>
  </tr>	    
 <tr> 
    <td width="6%" valign="top">7)</td>
    <td colspan="9" width="94%">I / We further say that Karnataka Bank Ltd. has 
      given and has agreed to continue to give various banking and financial facilities 
      to M/s.____________ on the strength of the guarantee given by me / us / 
      the Company and I / We hereby agree and undertake not to mortgage, charge, 
      encumber, lease, dispose of or deal with the property mortgaged by me / 
      us / by the Company to cover the guarantee during the continuance of the 
      said facilities to M/s.______________________ by the bank. <br>
    </td>
  </tr>	    
<tr> 
    <td width="6%" valign="top">8)</td>
    <td colspan="9" width="94%">I / We hereby further declare and say that I / 
      We / the Company have / has agreed and undertaken to indemnify and keep 
      indemnified the Bank fully and effectually against all claims, demands, 
      charges and expenses, whatsoever in respect of our properties and the said 
      plant. <br>
    </td>
  </tr>	   
<tr> 
    <td width="6%" valign="top">9)</td>
    <td colspan="9" width="94%">I / We make this declaration solemnly sincerely 
      and conscientiously knowing the same to be true and knowing that on the 
      faith of the said declaration the Bank has given and agreed to continue 
      to give to us the said banking and financial facilities. <br>
    </td>
  </tr>	 
 <tr> 
    <td align="center" colspan="3"><b>THE FIRST SCHEDULE ABOVE REFERRED TO</b><br>
      <br>
      (Description of the said property) <br>
    </td>
  </tr>
<tr> 
    <td align="center" colspan="3"><b>THE SECOND SCHEDULE ABOVE REFERRED TO</b><br>
      <br>
      (List of Title Deeds, Documents and Writings) <br>
    </td>
  </tr>
<tr> 
<td colspan="3">N.B.. Separate declaration clauses, if more than one declarant
</td>
  </tr>
<tr> 
    <td  colspan="3">Solemnly affirmed / sworn by the aforesaid Shri____________________________this 
      <b> 
            <%=date%>th <%=Months[a]%>, <%=year%></b> before me, </td>
  </tr>









  
   




  </table>
  </body>
  </html>