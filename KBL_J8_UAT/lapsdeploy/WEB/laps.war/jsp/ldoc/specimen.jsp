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
    <td colspan="3">(The format given herein is only a specimen. Suitable modifications 
      be made depending upon nature of credit facilities sanctioned in each case) 
    </td>
  </tr>
  <tr> 
    <td align="center" colspan="3"><b><u>SPECIMEN OF COMPANYS RESOLUTION<br>
      </u></b></td>
  </tr>
  <tr> 
    <td align="center" colspan="3">The Chairman informed the Board that he had 
      concluded negotiations with Karnataka Bank Ltd. and as a result the said 
      Bank had agreed to grant and make available to the Company the following 
      credit facilities, viz: (strike out whichever is not applicable) </td>
  </tr>
  <tr> 
    <td valign="top" colspan="2">i) Term Loan</td>
    <td align="left" width="20%">Rs.</td>
  </tr>
  <tr> 
    <td valign="top" colspan="2">-against equitable mortgage of immovable property 
      and hypothecation of plant and machinery, repayable in ______ years by equal 
      monthly / quarterly / half yearly instalments.</td>
    <td align="center" width="20%">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top" colspan="2">(i) <u>Term Loan</u></td>
    <td align="left" width="20%">Rs.</td>
  </tr>
  <tr> 
    <td valign="top" colspan="2"> (ii) <u>Cash Credit / Overdraft</u><br>
      -against hypothecation of raw materials in process and finished goods, stores, 
      spares and book debts repayable on demand. </td>
    <td align="left" width="20%">Rs.</td>
  </tr>
  <tr> 
    <td valign="top" colspan="2">iii)<u> Cash Credit/Overdraft</u><br>
      against pledge of raw materials, finished goods, stores and spares, etc., 
      repayable on demand.</td>
    <td align="left" width="20%">Rs.</td>
  </tr>
  <tr> 
    <td valign="top" colspan="2">iv) <u>Import/Inland Letter of Credit </u></td>
    <td align="left" width="20%">Rs.</td>
  </tr>
  <tr> 
    <td valign="top" colspan="2">v) Inland Documentary Bills Purchase</td>
    <td align="left" width="20%">Rs.</td>
  </tr>
  <tr> 
    <td valign="top" colspan="2">vi) Clean Bills purchase</td>
    <td align="left" width="20%">Rs.</td>
  </tr>
  <tr> 
    <td colspan="3">The Chairman also apprised the Board of the various terms 
      and conditions stipulated by the Bank in respect of the aforesaid facilities 
      whereupon the following resolutions were passed unanimously: </td>
  </tr>
  <tr> 
    <td  width="6%" valign="top">(Xi)(a)</td>
    <td colspan="2"> 
      <p align="justify"> <p align="justify"> RESOLVED that the Company do borrow by way of term loan 
        of a sum of Rs. __________ from Karnataka Bank Ltd. with interest thereon 
        payable at the rate of ____% over Karnataka Bank Ltd.? Prime Lending Rate 
        subject to a minimum ___% p.a. with ______________rests or at such rate 
        as may from time to time, be fixed by Karnataka Bank Ltd.</p>
    </td>
  </tr>
  <tr> 
    <td  width="6%" valign="top">(b)</td>
    <td colspan="2"> 
      <p align="justify"> <p align="justify"> FURTHER RESOLVED that the aforesaid Term Loan be secured 
        to the said Bank by ?</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">i)</td>
    <td colspan="2"> 
      <p align="justify"> a first charge by way of hypothecation of all the Company?s 
        tangible moveable machinery and plant, both present and future, whether 
        installed or not and whether lying loose or in cases at site or in transit 
        or which may at any time during the continuance of the security be installed 
        or lying loose or in cases or being in or upon or about the Company?s 
        factory premises and godowns at________________________________________ 
        _____________________________ or wherever else the same may be or be held 
        by any party anywhere to the order and disposition of the Company or in 
        course of transit; and</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">ii)</td>
    <td colspan="2"> 
      <p align="justify">A first charge by way of ?Equitable Mortgage? by deposit 
        of the Title Deeds of the Company?s immovable property situated at____________________ 
        ______________________ together with the buildings and structures now 
        standing or hereafter to be erected at or on any part thereof and all 
        the singular the plant and machinery now being or which are hereafter 
        affixed, installed or erected on the said property and also which may 
        be brought to the Company?s said property.</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">(c)</td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the title deeds of the Company?s 
        aforesaid immovable property situated at _________________________________ 
        be deposited by way of equitable mortgage by Shri ____________________ 
        with Karnataka Bank Ltd. with an intent to create a security on the Company?s 
        said immovable property to secure to the Bank the repayment of any monies 
        due and payable by the Company in respect of the aforesaid term loan including 
        interest thereon and all costs (as between Attorney and Clients) charges 
        and expenses incurred by the Bank. </p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">(xii)</td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the aforesaid term loan of Rs. 
        __________ be repaid by the Company in ___________ equal monthly/quarterly/half 
        yearly/yearly instalments together with interest accrued at the time of 
        payment of each such instalment, the first of such instalments to be paid 
        on or before the ________ day of _______.</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">2(a)</td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the Company do borrow by way of 
        Cash Credit facility to the extent of Rs._______ from Karnataka Bank Ltd. 
        repayable on demand with interest thereon payable at the rate of _____% 
        over Karnataka Bank Ltd. Prime Lending Rate subject to a minimum ___% 
        p.a. with ____________rests or at such rate of interest as may, from time 
        to time, be fixed by the Bank.</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">(b) </td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the aforesaid cash credit facility 
        of Rs._______ be secured to Karnataka Bank Ltd. by first charge by way 
        of hypothecation of all the Company?s stocks of raw materials, goods-in-process, 
        semi-finished goods, finished goods, stores and spares now or at any time 
        hereafter belonging to or at the disposal of the Company and which are 
        now stored or which hereafter may, from time to time, be brought into 
        or stored at the Company?s factory at ______________________________ or 
        at any other place, including any of the stocks with any of the Company?s 
        agents or agencies or in the course of transit by ship rail or otherwise 
        or in the process of manufacture, and all the Company?s Book Debts. </p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">(xiii)</td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the aforesaid cash credit facility 
        of Rs. _________ be secured to Karnataka Bank Ltd. by a first charge by 
        way of hypothecation of all the Company?s tangible moveable plant and 
        machinery, both present and future, whether installed or not and whether 
        lying loose or in cases at site or in transit or which may at any time 
        during the continuance of the security be installed or lying loose or 
        in cases or being in or upon or about the company?s factory premises and 
        godowns at _______________________________________ or wherever else the 
        same may be held by any party anywhere to the order and disposition of 
        the Company or in course of transit.</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">3(a) </td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the Company do borrow by way of 
        acsh credit facility to the extent of Rs.________ from Karnataka Bank Ltd. 
        repayable on demand with interest thereon payable at the rate of _____% 
        over Karnataka Bank Ltd. Prime Lending Rate subject to a minimum _____% 
        p.a. or at such rate of interest as may, from time to time, be fixed by 
        the Bank.</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">(xiv)</td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the aforesaid cash credit facility 
        to the extent of Rs. _________ be secured to Karnataka Bank Ltd. against 
        pledge of raw materials, goods in process, semi-finished goods, finished 
        goods, stores and spares stored in the Company?s godowns at ________________</p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">4.</td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the Common Seal of the Company 
        be affixed to all security documents as may be necessary or required in 
        respect of the aforesaid facilities in the presence of Mr.______________________ 
        and Mr._____________ two of Directors of the Company and countersigned 
        by Mr.__________________. </p>
    </td>
  </tr>
  <tr> 
    <td width="6%" valign="top">(xv)</td>
    <td colspan="2"> 
      <p align="justify">FURTHER RESOLVED that the Company do also avail of from 
        Karnataka Bank Ltd. following further credit facilities, viz.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td colspan="2" valign="top">a)<u>Import/inland Letters of Credit</u><br>
      a) for import/purchase of raw materials and other goods to the extent of 
    </td>
    <td width="20%" >Rs.</td>
  </tr>
  <tr> 
    <td colspan="2" valign="top">b)<u> Inland Documentary Bills Purchased (DP/DA)</u><br>
      for sight documentary bills &/or 60 days? usance bills drawn on approved 
      parties, to the extent of </td>
    <td width="20%" >Rs.</td>
  </tr>
  <tr> 
    <td colspan="2" valign="top"> <u>Clean Bills Purchase</u><br>
      of cheques and other negotiable instruments drawn in the Company?s favour 
      by third parties, to the extent of </td>
    <td width="20%" >Rs.</td>
  </tr>
  <tr> 
    <td colspan="3" valign="top">And on such terms, conditions and stipulations 
      as Karnataka Bank Ltd. may prescribe in that behalf from time to time.</td>
  </tr>
  <tr> 
    <td valign="top" width="6%">(xvii)</td>
    <td colspan="2" valign="top">
      
      <p align="justify"> 
      <p align="justify">FURTHER RESOLVED that the Company undertakes that it 
        will not create any mortgage, charge lien or other encumbrance whatsoever 
        on the said immovable and moveable property or any part thereof in favour 
        of any person, association, firm, company or any other incorporated body 
        or society other than the Bank so long as the Company is indebted to or 
        liable to the Bank on the aforesaid credit facilities availed of by the 
        Company or any other accounts or in any manner whatsoever and the Company 
        further declares that no proceedings for recovery of any taxes are pending 
        against it under the income-tax act or any other law. <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td valign="top" width="6%">(xviii)</td>
    <td colspan="2" valign="top">
      <p align="justify">FURTHER RESOLVED that the Company do hereby declares 
        and assures to the Bank that its total borrowing including the aforesaid 
        credit facilities are within the aggregate of its paid up capital and 
        free reserves as required by Section 239 (1) (d) of the Company?s Act 
        1956 that the borrowing is within the limit sanctioned by the resolution 
        passed at the General Meeting of the members of the Company held on<b> 
            <%=date%>th <%=Months[a]%>, <%=year%></b> . <br>
      </p>
    </td>
  </tr>
  <tr> 
    <td valign="top" width="6%">9. </td>
    <td colspan="2" valign="top"> 
      <p align="justify">FURTHER RESOLVED that (1)<br>
        (2) Directors of the Company be and are hereby requested jointly and severally 
        to personally guarantee to the Bank repayment of all amounts availed by 
        the Company from time to time under all the aforesaid facilities.<br>
      </p>
    </td>
  </tr>
  <tr> 
    <td valign="top" width="6%">10.</td>
    <td colspan="2" valign="top">
      <p align="justify">FURTHER RESOLVED that a certified copy of the minutes 
        and of the resolutions be furnished to Karnataka Bank Ltd. and the same 
        shall continue to remain in force until all the liabilities of the Company 
        are discharged in full.</p>
      <p align="justify">&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td valign="top" colspan="3" align="right">
      <p>&nbsp;</p>
      <p>Certified true copy Chairman<br>
        <b>Chairman </b> </p>
    </td>
  </tr>
  <br>
  <br>
</table>

</body>
</html>
