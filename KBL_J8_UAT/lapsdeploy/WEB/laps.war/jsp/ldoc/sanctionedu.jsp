<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
 <%
 //out.print(hshValues);
 ArrayList arryCol = null;
 ArrayList arryRow = (ArrayList) hshValues.get("arrTermsId");
 ArrayList vecCol = null;
 ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");
 ArrayList vecCoApp_col = null;
 ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
 ArrayList arrCol1 = null;
 ArrayList arrRow1 = (ArrayList) hshValues.get("arrDocsId");
 ArrayList arrydocCol = null;
 ArrayList arrydocRow = (ArrayList) hshValues.get("arrDocsId");
 
 %>
<html>
<head>
<title>Sanction Letter for Education Scheme</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="98%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
  <tr> 
          <td colspan="2" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
         </tr>
    <td colspan="3"> 
      <div align="center"><b><font size="+1">KARNATAKA BANK LTD.</font></b><br>
        <strong>&nbsp; <%=Helper.correctNull((String)hshValues.get("orgname"))%> 
        Branch</strong>
        <br>
        <strong > <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      .<br> Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></strong>
      <hr/>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="90%">Ref.No.&nbsp;:<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
            <td width="10%">Date:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b></td>
          </tr>
        </table>
      </div>
    </td>
  
  
  <tr> 
    <td colspan="3"> 
      <div align="center"><b><br>
        LETTER OF SANCTION</b></div>
    </td>
  </tr>
  <tr> 
    <td colspan="2" height="162" > 
      <p>To:<br>
        <b>&nbsp;<%=Helper.correctNull((String) hshValues.get("Title")) %> &nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%>,<br>
         <% if(vecCoApp_Row!=null)
        	{
        		for(int i=0;i<vecCoApp_Row.size();i++)
        		{
        			vecCoApp_col=(ArrayList)vecCoApp_Row.get(i);
        			if(vecCoApp_col!=null)
        			{	
        				String title=Helper.correctNull((String) vecCoApp_col.get(0));
        				String CoApplicantName=Helper.correctNull((String) vecCoApp_col.get(1));
        %>
        				 <b><%=title%>.&nbsp;<%=CoApplicantName%></b><br>
        <%			}
        		}
        	}%>
        &nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_address1"))%><br>
        &nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_address2"))%>, 
        &nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_address3"))%><br>
        &nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_city"))%><br>
        &nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_state"))%><br>
        &nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_zip"))%></b><br>
      </p>
  </tr>
  <tr> 
    <td colspan="3"> 
      <p>Dear Sir / Madam,</p>
    </td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <div align="center"><b>SUB: UNION EDUCATION SCHEME </b><br>
        <u>Conveying of sanction Terms and conditions</u>
      </div>
    </td>
  </tr>
  <tr> 
    <td width="4%">&nbsp;</td>
    <td colspan="2">With reference to your loan application dated&nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%> &nbsp;
      </b> we are pleased to inform you that a Term Loan of Rs.&nbsp;<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%>&nbsp; 
      </b> (Rupees &nbsp;<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b>) &nbsp;
      is sanctioned to you for pursuing &nbsp;<b><%=Helper.correctNull((String) hshValues.get("edu_coursename"))%>&nbsp;</b> 
      course under&nbsp;<strong>Union Education Scheme</strong> on the following terms and conditions:</td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      	<tr> 
          <td width="4%" valign="top" height="39"><b>1)</b></td>
          <td width="96%" height="39"><b><u>Applicable Rate of interest: -</u></b>
            <p align="justify"><b><%=Helper.correctNull((String) hshValues.get("mintrate"))%>&nbsp;%&nbsp;(<%=Helper.correctNull((String) hshValues.get("loan_inttype"))%>).</b> 
              However,the loan amount would attract a simple rate of interest during the  the course and moratorium period.The moratorium period can be a maximum of 1 year after completion
              of course or 6 months after securing employment, whichever is earlier.<br>
            </p>
          </td>
        </tr>
        
        <tr> 
          <td width="4%" valign="top"><b>2)</b></td>
          <td width="96%"><b><u>Co-borrower / s: -</u></b>
            <p align="justify"> The parents i.e. father/ mother (if father is 
              not alive) or guardian (if both father and mother are not alive) should 
              join as co-borrower/s.<br>
            </p>
          </td>
        </tr>
        
        <tr> 
          <td width="4%" valign="top"><b>3)</b></td>
          <td width="96%"><b><u>Documents: -</u></b>
            <p align="justify"> The following documents are to be executed for disbursement of loan:<br>
            </p>
          </td>
        </tr>
         <tr>
               <td width="4%">&nbsp;</td>
              <td>
                <% 
                     if(arrydocRow!=null)
                     {
                       for(int i=0;i<arrydocRow.size();i++)
                       {				
                    	  arrydocCol=(ArrayList)arrydocRow.get(i);
							if(arrydocCol!=null)
							{
							%>
                      <br> 	<b><%=i+1%>)&nbsp;<%=Helper.correctNull((String)arrydocCol.get(1))%></b>
                      <%
							}
                       }
                       	}
                       %>
             </td>
              
            </tr>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="96%">&nbsp;</td>
        </tr>
        
        <%int val1=0,val2=0;
        String str1= Helper.correctNull((String)hshValues.get("lreqterms"));
        String str2= Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
        if(!str1.equals(""))
        {
        	 val1=Integer.parseInt(str1);
        }
        if(!str2.equals(""))
        {
        	 val2=Integer.parseInt(str2);
        }
        
        int val=0;
        val=val1-val2;
        %>
        <tr> 
          <td width="4%" valign="top" height="47"><b>4)</b></td>
          <td width="96%" height="47"><b><u>Repayment: -</u></b>
          <p align="justify">The Loan is repayable in &nbsp;<b><%=val%> &nbsp;
            Equated monthly installments </b> commencing immediately one year 
            after completion of the course or 6 months after the student secures employment, whichever is earlier. 
            Notionally, taking into consideration total moratorium.as 
            course period plus one year, the EMI works to Rs.&nbsp;<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_emi"))))%>&nbsp;</b></p><br/></td>
        </tr>
        
        <tr> 
          <td width="4%" valign="top" height="47"><b>5)</b></td>
          <td width="96%" height="47"><b><u>Step Up Repayment: -</u></b>
          <p align="justify">The student will also have an option to avail of <b>'Step-Up Repayment'</b> wherein a lower than usual
          EMI can be serviced for a maximum of 36 months from the start of repayment.Higher EMI is payable for the remainder of the repayment tenure. 
          The exact value of the EMI will be calculated at start of repayment depending on the loan amount outstanding then.</p><br/></td>
        </tr>
        
        <tr> 
          <td width="4%" valign="top" height="47"><b>6)</b></td>
          <td width="96%" height="47"><b><u>Disbursement: -</u></b>
          <ol>a)&nbsp;&nbsp;The loan amount together with margin money will be released directly in the name of the College / University / Institute way of a Demand Draft / Pay Order.</ol>
          <ol>b)&nbsp;&nbsp;Loan will be disbursed only after obtaining proof of selection / Visa of the student.</ol>
          <ol>c)&nbsp;&nbsp;Where loan is given for purchase of computers / laptop, the same has to be hypothecated to the bank.</ol>
          <br/></td>
        </tr>
        
        <tr> 
          <td width="4%" valign="top" height="47"><b>7)</b></td>
          <td width="96%" height="47"><b><u>Life Insurance: -</u></b>
          <p align="justify">Life Insurance Policy to be made out in the name of the student for an amount not less than the loan amount duly assigned in favor of the Bank. 
          The life insurance policy is completely optional and depends up on the borrower's discretion. However, it is always advisable to avail a life insurance policy. 
          The premium on life insurance can be considered as part of the loan.</p>
          <p align="justify">&nbsp;&nbsp;In case where parents cannot bear the burden of premium during the period of education loan, premium amount may be remitted to insurance authority by 
          debiting loan account.The policy should be in the name of student, for an amount not less than the loan amount and for the tenure covering course / moratorium & repayment period.</p><br/></td>
        </tr>
        
        <tr> 
          <td width="4%" valign="top" height="47"><b>8)</b></td>
          <td width="96%" height="47"><b><u>Security: -</u></b>
          <p align="justify">Equitable / Simple mortgage of property (wherever applicable).</p><br/></td>
        </tr>
        
        <tr> 
          <td width="4%" valign="top" height="47"><b>9)</b></td>
          <td width="96%" height="47"><b><u>Charges: -</u></b>
          <p align="justify">Following charges if applicable are to be borne by the borrower while availing education loan:</p>
          <ol>a)&nbsp;&nbsp;Professional fee charged by bank's advocate for title verification.</ol>
          <ol>b)&nbsp;&nbsp;Professional fee payable to approved valuer for valuation of property offered as mortgage.</ol>
          <ol>c)&nbsp;&nbsp;Stamp duty as levied by State Government on documents.</ol>
          <ol>d)&nbsp;&nbsp;Charges of foreign banks / correspondents.</ol>
          <ol>e)&nbsp;&nbsp;Fluctuations in currency exchange rate.</ol>
          <ol>f)&nbsp;&nbsp;Registration charge for Mortgage and mortgage charge.</ol>
          <ol>g)&nbsp;&nbsp;In case of studies abroad, a refundable upfront deposit of Rs. 5000 is mandatory. 
          The amount will be refunded only if the student avails the loan within a period of 3 months from the date of sanction. 
          If not, the amount will be appropriated as processing charges.</ol>
          <br/></td>
        </tr>
        
        <tr> 
          <td width="4%" valign="top" height="47"><b>10)</b></td>
          <td width="96%" height="47"><b><u>Validity of Sanction: - </u></b>
          <p align="justify">The sanction will be valid for a period of 3 months from the date of sanction, 
          i.e. the student has to avail the first disbursement within a period of 3 months from the date of sanction.</p><br/></td>
        </tr>
        
        <!-- <tr>
            <td width="4%" valign="top">9)</td>
           <td width="96%"> 
          	<%	
        	if(vecRow!=null && vecRow.size()>0)
        	{
        		for(int i=0;i<vecRow.size();i++)
        		{	
        			vecCol=(ArrayList)vecRow.get(i);
        			if(vecCol!=null)
        			{	
        				String title=Helper.correctNull((String) vecCol.get(0));
        				String GuarantorName=Helper.correctNull((String) vecCol.get(1));
        				String GuarantorMeans=Helper.correctNull((String) vecCol.get(9));%>
      					<tr> 
                			<td width="4%">-</td>
               			    <td width="96%"> Personal guarantee of
            				<b><%=title%>.&nbsp;<%=GuarantorName%></b>        
      
		                  with means of Rs.<b><%=Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(GuarantorMeans)))%></b>&nbsp;Lacs &nbsp;is to be provided. 
		                  </td>
                  	   </tr>
                  <%}
        		}
        	}
        	else
        	{%>
        	<tr> 
                <td width="4%">&nbsp;</td>
                <td width="96%">Personal guarantee of	with means of Rs. is to be provided .</td>
              </tr> 
        		
        	<%}%> -->
           
             <tr> 
          		<td width="4%" valign="top" height="47"><b>11)</b></td>
              	<td width="96%" height="47"><b><u>Other Terms and Conditions: -</u></b>
              <% 
                     if(arryRow!=null)
                     {
                       for(int i=0;i<arryRow.size();i++)
                       {				
                    	  arryCol=(ArrayList)arryRow.get(i);
							if(arryCol!=null)
							{
							%>
                      <br> 	<b><%=i+1%>)&nbsp;<%=Helper.correctNull((String)arryCol.get(1))%></b>
                      <%
							}
                       }
                       	}
                       %>
              	</td>
              </tr>         
      </table>
      <br/><br/>
      <p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We wish you with all best wishes and pray for a delightful journey towards a successful career.</p>
      </td>
  </tr>
  <tr> 
    <td> 
      <p align="right">For Karnataka Bank Ltd.</p>
      <p align="right"><br>
        <b>CHIEF / BRANCH MANAGER</b><br>
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="1" cellspacing="0" cellpadding="3">
        <tr>
          <td>
            <p><b>Accepted the above Terms and Condition</b></p>
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="58%"><b>Signature of the Applicant/s</b></td>
                <td width="42%"><b>Signature of Guarantors</b></td>
              </tr>
              <tr> 
                <td width="58%">&nbsp;</td>
                <td width="42%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="58%">&nbsp;</td>
                <td width="42%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="58%">&nbsp;</td>
                <td width="42%">&nbsp;</td>
              </tr>
              <tr>
                <td width="58%">Date: <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
                <td width="42%">Date: <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
              </tr>
            </table>
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
