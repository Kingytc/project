<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

 <%


ArrayList vec = null;
int vecsize=0;
if (hshValues != null)
 {  vec = (ArrayList)hshValues.get("vecVal");
   
 }
if(vec!=null)
{
	vecsize =vec.size();
	
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI - WEBTEAM</title>
<style type="text/css">
body
{
font-family:"Arial";
font-size:11px;
color:#000000;
}
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="90%" border="0" align="center" cellpadding="3" cellspacing="0">
  <tr>
    <td align="center"><strong>FORMAT TO BE SUBMITTED BY BRANCHES RECOMMENDING FILING OF SUIT </strong></td>
  </tr>
  <tr>
    <td align="center"><span class="style1">KARNATAKA BANK LTD. </span></td>
  </tr>
  <tr>
    <td align="center"><strong><u> <%=Helper.correctNull((String)hshValues.get("strOrgName"))%></u> BRANCH </strong></td>
  </tr>
  <tr>
    <td align="center">(34-Point Format) </td>
  </tr>
  <tr>
    <td height="25" align="center" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td><p>&nbsp;</p></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td width="50%">1. Name of the Borrower </td>
        <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("exec_name")) %></td>
      </tr>
      <tr>
        <td width="50%"><blockquote>
          <p>Branch</p>
        </blockquote></td>
        <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strOrgName")) %></td>
      </tr>
      <tr>
        <td width="50%" valign="middle"><blockquote>
          <p>Region</p>
        </blockquote></td>
        <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("comapp_regadd1")) %></td>
      </tr>
      <tr>
        <td width="50%">a) Sectorol Category </td>
        <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("comapp_regadd1")) %></td>
      </tr>
      <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%">&nbsp;</td>
      </tr>
      <tr>
        <td width="50%">2. Address of the Borrower </td>
        <td width="50%"><p>a) Office / Factory :<%=Helper.correctNull((String)hshValues.get("comapp_regadd1")) %></p>
          <p>b) regd. Office :<%=Helper.correctNull((String)hshValues.get("comapp_regadd2")) %><br>
            <%=Helper.correctNull((String)hshValues.get("comapp_regcity")) %><br>
            <%=Helper.correctNull((String)hshValues.get("comapp_regstate")) %></p></td>
      </tr>
      <tr>
        <td width="50%">3. Constitution </td>
        <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("comapp_ownership")) %></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td colspan="4">4. Name(s) Residential Address/es and Telephone Number/s </td>
        </tr>
      <tr>
        <td width="4%" align="center">No</td>
        <td width="46%" align="center">Name of Proprietor / Partners / Directors of the Firm </td>
        <td width="38%" align="center">Address/s</td>
        <td width="12%" align="center">Telephone Numbers </td>
      </tr>
      
      
      
      
      
      
      
      
      
      
      <tr>
        <td width="4%">1.</td>
        <td width="46%">&nbsp;</td>
        <td width="38%">&nbsp;></td>
        <td width="12%">&nbsp;</td>
      </tr>
      <tr>
        <td width="4%">&nbsp;</td>
        <td width="46%">&nbsp;</td>
        <td width="38%">&nbsp;</td>
        <td width="12%">&nbsp;</td>
      </tr>
      <tr>
        <td width="4%">&nbsp;</td>
        <td width="46%">&nbsp;</td>
        <td width="38%">&nbsp;</td>
        <td width="12%">&nbsp;</td>
      </tr>
      <tr>
        <td width="4%">&nbsp;</td>
        <td width="46%">&nbsp;</td>
        <td width="38%">&nbsp;</td>
        <td width="12%">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
     
      <tr>
        <td colspan="2">5. Nature of Business </td>
        <td width="38%">&nbsp;<%=Helper.correctNull((String)hshValues.get("comapp_businessnature")) %></td>
        <td width="12%">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td width="50%">6. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a) Date of Establishment / Incorporation </td>
        <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("comapp_yrsinbusiness")) %></td>
      </tr>
      <tr>
        <td width="50%"><blockquote>
          <p> b) Date account opened </p>
        </blockquote></td>
        <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_accountopeneddate")) %></td>
      </tr>
      <tr>
        <td width="50%"><blockquote>
          <p>c) Date of credit facilities &amp; sanctioning Authority</p>
          <blockquote>
            <p>i) Originally sanctioned</p>
            <p>ii) Disbursed date</p>
            <p>iii) Last Reviewed  <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_lastrevieweddt")) %></td> </p>
          </blockquote>
        </blockquote></td>
       
        
      </tr>

    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td colspan="3">7. Details of Limits sanctioned </td>
        <td colspan="2" align="right">(Rs. in lacs) </td>
        </tr>
      <tr>
        <td width="7%" align="center">No</td>
        <td width="26%" align="center">Nature of Facility(ies) </td>
        <td width="17%" align="center">Amount</td>
        <td width="21%" align="center">Rate of Int. </td>
        <td width="29%" align="center">Security / Documents obtained with dates thereof </td>
      </tr>
      <tr>
        <td width="7%">&nbsp;</td>
        <td width="26%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_documents")) %></td>
        <td width="17%">&nbsp;</td>
        <td width="21%">&nbsp;</td>
        <td width="29%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_documentsdt")) %></td>
      </tr>
      
      
      
      
      
      
      
      
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td width="50%">8. Sanctioning Authority(ies) </td>
        <td width="50%" align="center">MCM / MD / ED / GM / DGM </td>
      </tr>
      <tr>
        <td colspan="2">9. Whether Collateral Security(ies) held _____________ Yes _______________ No (Tick Suitably) </td>
        </tr>
      <tr>
        <td height="124" colspan="2" valign="top">If held, give detailed particulars there of here below :-<br />
          Details of Coll. Sec. (Location; owner of the property; description, Date of EM etc):- <br>
           <%=Helper.correctNull((String)hshValues.get("npasuit_pledgeof")) %>
          <br><%=Helper.correctNull((String)hshValues.get("npasuit_pledgeamt")) %><br>
          <%=Helper.correctNull((String)hshValues.get("npasuit_pledgedt")) %>
          <%= Helper.correctNull((String)hshValues.get("npasuit_equitat")) %></td>
          
        </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">

      <tr>
        <td width="100%" height="124" valign="top">10. In case of Private Limited and Corporate Bodies, please inform whether our Bank's charge/s is / are registered with the Register of Companies and the nature thereof :- 
         <br>
          <%= Helper.correctNull((String)hshValues.get("npasuit_bankreg")) %>
       </td>
      </tr>
 
      
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td colspan="4">11. Name / s and Address/es of the Guarantor(s) surety (ies) with their occupation and means </td>
        </tr>
      <tr>
        <td width="7%" align="center">No</td>
        <td width="26%" align="center">Name of Guarantor </td>
        <td width="24%" align="center">Address</td>
        <td width="14%" align="center">Means</td>
        </tr>
      <tr>
        <td width="7%">&nbsp;</td>
        <td width="26%">&nbsp;</td>
        <td width="24%">&nbsp;</td>
        <td width="14%">&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td width="100%" height="149" valign="top"><p>12. Whether the terms and conditions are stipulated in the Sanction Advice and / or as required for while granting credit facility(ies) to the borrower(s) originally and subsequently were fulfilled or not: -<br/></p>
          <p>If no, brief reasons :- 
          <br><%= Helper.correctNull((String)hshValues.get("npasuit_termsandconds")) %> </p></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td height="114" colspan="2" valign="top">15. Whether credit facility (ies) were subsequently renewed and / or enhanced. If so, give detailed particulars thereof as follows:- </p>
        <br>
         <%= Helper.correctNull((String)hshValues.get("npasuit_creditfacrenew")) %></td>
      </tr>
      <tr>
        <td height="139" colspan="2" align="left"><p>16. In case of Term Loan Advance, Please specify What type of loan :-</p>
        <br>
          <%=Helper.correctNull((String)hshValues.get("npasuit_termloan")) %>
           </td>
        </tr>
      <tr>
        <td colspan="2"><p>17. The term loan was repayable in <u><%=Helper.correctNull((String)hshValues.get("npasuit_repcapacity")) %></u> equal monthly installments of Rs.<u><%=Helper.correctNull((String)hshValues.get("npasuit_emi")) %></u> each with interest commencing from ______________ <br />
          <br />          
          till __________________ due date.</p>          </td>
        </tr>
      <tr>
        <td colspan="2"><p>18. Date of loan first disbursed :</p>
          <p>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_disburseddate")) %> </p></td>
        </tr>
      <tr>
        <td width="78%">19. The total number of installments received from the borrowers :- </td>
        <td width="22%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_totinstal")) %></td>
        </tr>
      <tr>
        <td>20. Amount of instalments received from the date of 1st disbursement </td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_amtofinst")) %></td>
        </tr>
      <tr>
        <td>21. Date of last installment received </td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_lastinstaldt")) %></td>
        </tr>
      <tr>
        <td>22. Date from when the default in payment started </td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_defaultpaymentdate")) %></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td colspan="3">23. Interest accured in the account facility wise :- </td>
        <td align="right">(Rs. in actuals) </td>
      </tr>
      <tr>
        <td width="7%" align="center">Nature</td>
        <td width="26%" align="center">Interest recovered<br />
          up to ___________ </td>
        <td width="24%" align="center">Interest in Dummy Ledger<br />
          From _________ to ________ </td>
        <td width="14%" align="center">Total Interest payable<br />
          as on ____________ </td>
      </tr>
      <tr>
        <td width="7%">&nbsp;</td>
        <td width="26%">&nbsp;</td>
        <td width="24%">&nbsp;</td>
        <td width="14%">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td width="100%" height="168" valign="top">24. Brief History of the account from the date of availing facilities first with dates and detailed particulars of the changes in constitution, together with a renewals of the limit (s) from time to time and security documents taken, etc. <br><%=Helper.correctNull((String)hshValues.get("npasuit_brief_history_account")) %></td>
        
      </tr>
      <tr>
        <td height="103" align="left" valign="top"><p>25. When and what were the signs and symptoms of the irregularities / sickness, etc. in the account first observed and the remedial measures taken :- </p>
          <blockquote>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_signsandsymp")) %></blockquote></td>
      </tr>
      <tr>
        <td height="99" valign="top"><p>26. Does the borrower(s) Bank with any of the other branches of our Bank, and/or with any other Bank, financial institution, etc. and credit facility (ies) availed there from? If so, give detailed particulars thereof here below:- 
        <br>
        <%=Helper.correctNull((String)hshValues.get("npasuit_creditfacility")) %></p></td>
      </tr>
      <tr>
        <td height="82" valign="top">27. Does the borrower(s) have any other associate / Sister / and /or other connected account(s) with any of our Bank's branches and /or with any other Bank, and availing credit (ies) there from) If so, give detailed particulars thereof here below:- 
        <br>
         <%=Helper.correctNull((String)hshValues.get("npasuit_associate_information")) %></td>
      </tr>
      <tr>
        <td height="126" valign="top"><p>28. Does the borrower(s) have any Saving Bank Account and/or Term Deposit Account, either in the personal name(s) of the partners, their family members, etc. in your branch, or with any other Branch of our Bank and /or with any other Bank? If so, please give particulars thereof here below:- </p>
        <br>
          <%=Helper.correctNull((String)hshValues.get("npasuit_borrowers_saving")) %> </td>
      </tr>

    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td colspan="3">29. Present position of the account :- </td>
        <td align="right">(Rs. in actuals) </td>
      </tr>
      <tr>
        <td width="14%" align="center">Nature</td>
        <td width="34%" align="center">Outstanding in R/L <br />
          As on ___________ </td>
        <td width="31%" align="center">Interest in Dummy Ledger<br />
          From _________ to ________ </td>
        <td width="21%" align="center">Total Dues payable as <br />
          on ____________ </td>
      </tr>
      <tr>
        <td width="14%">&nbsp;</td>
        <td width="34%">&nbsp;</td>
        <td width="31%">&nbsp;</td>
        <td width="21%">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td width="48%" height="32">30. Present rate of interest applicable to the facilities: </td>
        <td width="52%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_presinterest")) %></td>
      </tr>
      <tr>
        <td width="48%" height="32"><p> Date up to which interest is charged </p></td>
        <td width="52%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_interestratedt")) %></td>
      </tr>

    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td colspan="3">31. a) Details of DBC Letters obtained :- </td>
        <td align="right">&nbsp;</td>
      </tr>
      <tr>
        <td width="6%" align="center">No.</td>
        <td width="42%" align="center">Facility (ies) </td>
        <td width="31%" align="center">Amount of DBC </td>
        <td width="21%" align="center">Date of DBC </td>
      </tr>
      <tr>
        <td width="6%" align="center">1.</td>
        <td width="42%"><%=Helper.correctNull((String)hshValues.get("npasuit_DBCfacility1"))%></td>
        <td width="31%"><%=Helper.correctNull((String)hshValues.get("npasuit_DBCAmount1"))%></td>
        <td width="21%"><%=Helper.correctNull((String)hshValues.get("npasuit_DBCDate1"))%></td>
      </tr>
      <tr>
        <td align="center">2.</td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_DBCfacility2"))%></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_DBCAmount2"))%></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_DBCDate2"))%></td>
      </tr>
      <tr>
        <td align="center">3.</td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_DBCfacility2"))%></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_DBCAmount2"))%></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_DBCDate2"))%></td>
      </tr>
      <tr>
        <td align="center">4.</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="center">5.</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td colspan="3">31. b) Cash Deposit entries in the account with Amount and Dates of Entries </td>
        <td align="right">(Rs. in actuals) </td>
      </tr>
      <tr>
        <td width="6%" align="center">No.</td>
        <td width="42%" align="center">Facility (ies) </td>
        <td width="31%" align="center">Amount deposited </td>
        <td width="21%" align="center">Details of remittance </td>
      </tr>
      <tr>
        <td width="6%" align="center">1.</td>
        <td width="42%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_CDFacility1"))%></td>
        <td width="31%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_amtdeposited1"))%></td>
        <td width="21%">&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_remittancedt1"))%></td>
      </tr>
      <tr>
        <td align="center">2.</td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_CDFacility2"))%></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_amtdeposited2"))%></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_remittancedt2"))%></td>
      </tr>
      <tr>
        <td align="center">3.</td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_CDFacility3"))%></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_amtdeposited3"))%></td>
        <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("npasuit_remittancedt3"))%></td>
      </tr>
      <tr>
        <td align="center">4.</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="center">5.</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td width="100%" height="149" valign="top"><p>32. Please elaborate the actions taken by your branch for the safeguard of the securities held and the recovery of the outstanding advance granded to the borrower : </p> <br>
        <%=Helper.correctNull((String)hshValues.get("npasuit_safegurad_securities"))%>           </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF">
      <tr>
        <td width="100%" height="149" valign="top"><p>33. Please elaborate the future course of action, towards the recovery of the advances :- <br>
        <%=Helper.correctNull((String)hshValues.get("npasuit_future_class"))%></p></td>
      </tr>
      <tr>
        <td height="149" valign="top">34. Any further comments you wish to incorporate therein :-
<br><%=Helper.correctNull((String)hshValues.get("npasuit_further_comments"))%></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="78"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50%" height="69" align="center"><strong>ACCOUNTANT<br />
          MANAGER</strong></td>
        <td align="center"><strong>CHIEF / BRANCH </strong></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
