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
          <td>
            <div align="center"><b>SBI Life - Home Loan Insurance for Borrowers 
              of Karnataka Bank Ltd. </b></div>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="66%">&nbsp;</td>
                <td width="34%">Place: <b><%=Helper.correctNull((String) hshValues.get("cityName"))%></b></td>
              </tr>
              <tr>
                <td width="66%">&nbsp;</td>
                <td width="34%"> Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
              </tr>
            </table>
            <p>Deal Sir,</p>
            <p align="center"><b>SBI Life Group Life Insurance Scheme - Housing 
              Loan Insurance <br>
              Consent-cum-Authorization-cum-Good Health Declaration</b></p>
            <p align="justify">I<b><%=Helper.correctNull((String) hshValues.get("appname"))%></b>, 
              son/daughter of __________________________________. and availing/maintaining 
              my Housing loan account at your Bank express r willingness to become 
              a member of the Union Home Plus Group Life Insurance Scheme for 
              Housing Loan Borrow( and I desire that the Bank should be the administrator 
              of the Group.</p>
            <p align="justify">I declare that my Date of Birth is  &nbsp;<b><%=Helper.correctNull((String) hshValues.get("perapp_dob"))%></b><br></p>
            <p align="justify">*I attach proof of age (Birth Certificate. Copy of Passport. School/College 
              Leaving Certificate/Baptism Certificate in case of Roman Catholics.Domic 
              Certificate, Admit cards / Hall tick&pound;ts (where date of birth 
              is mentioned) for SSC / HSC or equivalent examinations. with the 
              seal/stamp of the institutional personnel Identity card/. Certificate 
              of Nationality Certification of age from anyone of tire fallowing: 
              Any Govt/Ltd. company/Statutory governing body/ps companies/Banks 
              (Public and private).</p>
            <p align="justify">*I am availing a Housing loan of Rs. &nbsp;<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
              from your bank an the loan is repayable in &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loanEmi"))%></b> 
              EMIs.<br>
              Or <br>
              * I have availed a Housing loan from your bank and the present outstanding 
              amount of loan plus interest is Rs<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b><br>
              and there are _____________________ EMls remaining under the loan. 
              <br>
              (*Delete whichever is not applicable).</p>
            <p align="justify">I opt to join the Scheme for life insurance cover and I agree to 
              abide by the terms and the conditions of the Scheme.declare that 
              my cumulative life insurance cover under all schemes/policies of 
              SBI Life does not exceed Rs.1 Crore.</p>
            <p align="justify">I agree that all benefits due under the Scheme in the event of 
              my death would be payable to the Bank for applying toward~ liquidation 
              of the outstanding loan amount under the Housing loan or any other 
              loan provided by the Bank. In the event of any surplus remaining 
              with the Bank after liquidating the outstanding loans, I nominate 
              Shri/Smt/Kum___________________________________________who is related 
              to me as __________________________as the Nominee to receive such 
              surplus amount.</p>
            <p>I undertake to furnish any other personal details that you/ SBI 
              Life may require in regard to my cover under the Group Life Insurance 
              Scheme.</p>
            <p align="justify">* I authorise you to debit my Current / Savings bank Account No. 
              <b><%=Helper.correctNull((String) hshValues.get("appbobacc"))%> </b>
              with your bank for Rs<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b><br>
              towards the Single Premium amount for the Insurance cover.<br>
              or<br>
              *I request you to provide me with a loan amount of Rs &nbsp;<b><%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
              towards the Single Premium amount for the insurance cover. at the 
              same interest rate as applicable to the Housing loan and disburse 
              the amount to SBI Life Insurance Co. Ltd. directly towards; providing 
              the cover as per the terms and conditions of the Scheme.<br>
              I undertake to repay the above loan amount in &nbsp;<%=Helper.correctNull((String) hshValues.get("loanEmi"))%> 
              EMIs along with the EMls under the Housing loan.</p>
            <p align="justify"><u>Applicable only where the housing loan amount exceeds Rs. 7.5 
              lacs </u> </p>
            <p align="justify">I authorise the Bank to debit my account for the standard gross 
              insurance premium towards life insurance cover from SBI , ' Life 
              that may be granted subject to my undergoing the medical examination 
              and satisfying the health underwriting criteria of the Company '</p>
            <p align="justify"><br>
              'I also note that in the event of SBI Life Insurance Co. not being 
              in a position to accept my life insurance for any reason whatsoever, 
              the premium remitted by the Bank to them would then be refunded 
              without any interest by them and credited : back to my account&quot;<br>
            </p>
            <p> <b><br>
              <u>Good Health Declaration:</u></b><br>
              &quot; I declare that I am in sound health, do not have any physical 
              defect/deformity, perform my routine activities 'independently and, 
              that I have never suffered or have been suffering, or have been 
              hospitalized for any critical illness or a condition requiring medical 
              treatment for a critical illness, as on date.</p>
            <p align="justify">@Critical illness is defined as follows: The life to be insured 
              should not:<br>
              i.have suffered or be suffering from cancer,<br>
              ii.be taking treatment for heart disease,<br>
              iii. have undergone / or have been advised medically to undergo 
              chest and or' heart surgery within the following sis months.<br>
              iv.have irreversible kidney and/or irreversible liver failure,<br>
              v. have suffered or be suffering from paralysis,<br>
              vi.. have undergone or been advised to undergo a major organ transplantation 
              such as heart. lung, liver or kidney.<br>
              vii. have suffered or be suffering from AIDS or venereal diseases.</p>
            <p align="justify">.I hereby declare that the above statements are true and complete 
              in every respect and that I have not withheld or omitted . to give 
              any information that may influence my admission into the Group Insurance 
              Scheme of SBI Life Insurance Co. Ltd.<br>
              &quot;I hereby agree that this declaration shall form the basis 
              of my admission into the Group Insurance Scheme and if any . untrue 
              averment be contained therein, I, my heirs, executors, administrators 
              and assignees shall not be entitled to receive any benefits under 
              the Group Insurance Scheme.<br>
              <br>
              I hereby ,&quot;agree to your conveying the above particulars regarding 
              my admission into the Group Insurance Scheme to SBI . Life. I also 
              permit SBI Life to approach me directly for any clarification and 
              or 'other purpose:;. I hereby agree and understand that no insurance 
              cover will commence until the risk is accepted and requisite premium 
              has been remitted to SBI Life.</p>
            <p> <br>
              Signature of the Borrower: _________________________________Signature 
              of the witness:______________________</p>
            <p><br>
              Name of the Borrower: _____________________________________________________________________________________<br>
              Account No:______________________________________________________________________________________________</p>
            <p>Residential Tel No.: ______________________________________________________________________________________________________ 
              <br>
              _____________________________________________________________________________________________________________________<br>
              _____________________________________________________________________________________________________________________ 
              <br>
              Email address at residence (if any): ___________________________________ 
              Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></p>
            <p>&nbsp; </p>
            <p>&nbsp; </p>
            <p><br>
            </p>
            <p><b><br>
              </b> </p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
 
</body>
</html>
