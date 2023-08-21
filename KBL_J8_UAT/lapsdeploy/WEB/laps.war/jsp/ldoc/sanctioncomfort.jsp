<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
 <%
 
 



 String installment=Helper.correctNull((String)hshValues.get("loan_periodicity"));
 if(installment.equalsIgnoreCase("m"))
 {
 	 installment="Monthly";
 }else if(installment.equalsIgnoreCase("q"))
 {
 	 installment="Quarterly";
 }else if(installment.equalsIgnoreCase("h"))
 {
 	 installment="Half-Yearly";  
 }else if(installment.equalsIgnoreCase("y"))
 {
 	 installment="Yearly";    
 }
 ArrayList arryCol = null;
 ArrayList arryRow = (ArrayList) hshValues.get("arrTermsId");
 
 ArrayList arrydocCol = null;
 ArrayList arrydocRow = (ArrayList) hshValues.get("arrDocsId");
 ArrayList vecCol = null;
 ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");
 ArrayList vecCoApp_col = null;
 ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
 ArrayList arrCol1 = null;
 ArrayList arrRow1 = (ArrayList) hshValues.get("arrDocsId");
 int calMonth=0;
 String date="";
 String Month="0";
 String year="0";
 String calYear="";
// String loan_noofinstallment = "0";	
 String dates=Helper.correctNull((String) hshValues.get("app_processdate"));
 String installments=Helper.correctNull((String)hshValues.get("loan_noofinstallment"));

 int x=0;
  x=Integer.parseInt(installments)+1;

 if(!dates.equals(""))
 {

 	StringTokenizer tokenizer1 = new StringTokenizer(dates, "/");

 	while (tokenizer1.hasMoreTokens()) 
 	{
 		date=Helper.correctNull((String)tokenizer1.nextToken()).trim();
 		Month=Helper.correctNull((String)tokenizer1.nextToken()).trim();
 		year=Helper.correctNull((String)tokenizer1.nextToken()).trim();
 		calYear=year;
 		
 	}

 }
 else
 {
 	 Month="0";
 }

 int month=0;
 month=Integer.parseInt(Month);
 int TOTMonths=0;
 TOTMonths=month+x;
 int valMonth1=0;
 int valMonth2=0;
 int valMonth=TOTMonths;
 int a=0;
 int temp=0;
 int curyear=0;

 if(valMonth<12 || valMonth==12)
 {
 	if(!calYear.equalsIgnoreCase(""))
 	{
 		curyear=0+Integer.parseInt(calYear);
 	}
 	else
 	{
 		curyear=0;
 	}
 }
 if(valMonth>12)
 {
 	 valMonth1=valMonth/12;
 	 valMonth2=valMonth%12;
 	 if(valMonth2==0)
 	 {
 		 calMonth=12;
 		 
 	 }
 	 else
 	 {	 
 		temp=valMonth1*12;
 		if(!calYear.equals(""))
 		{				
 			curyear=(valMonth1)+Integer.parseInt(calYear);
 		}
 		
 		 valMonth2=valMonth-temp;
 		 calMonth=valMonth2;	 
 	}
 }
 else
 {
 	 calMonth=valMonth;
 }
 	
 	 String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
 	 if(!dates.equals(""))
 	 {
 	 	a=calMonth;
 	 }
 	 else
 	 {
 		 a=0;
 	 }
 
%>
<html>
<head>
<title>Sanction Letter for Union Home scheme</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="80%" border="0" cellspacing="0" cellpadding="5" align="center">
  
  <tr> 
          <td  align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
         </tr>
       <tr> 
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td colspan="2" align="center"><b>
          		KARNATAKA BANK LTD.</b></td>
          		
         </tr>
         <tr>
          <td colspan="2" align="center"><b>
           	<%=Helper.correctNull((String) hshValues.get("orgname"))%> &nbsp; Branch</b>
          </td>
        </tr>
        <tr> 
		<td align="center" colspan="2"><strong ><b> <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
				<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
				<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
				. <br> Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></b></strong>
		     <hr/>
		</td>
	   </tr>
        <tr> 
          <td width="64%">Ref.No.&nbsp;:<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
          <td width="36%"><font size="2" face="MS Sans Serif">Date: &nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b></font></td>
        </tr>
      </table>
     
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td align="center"><b><u>LETTER OF SANCTION</u></b>
          </td>
        </tr>
        <tr>
          <td>
            To:<br>
            	&nbsp; <b><%=Helper.correctNull((String) hshValues.get("Title"))%></b>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("appname"))%></b><br>
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
        				 &nbsp; <b><%=title%>.&nbsp;<%=CoApplicantName%></b><br>
        <%			}
        		}
        	}%>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_address1"))%></b><br>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_address2"))%></b><br>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_city"))%> -<b><%=Helper.correctNull((String) hshValues.get("perapp_zip"))%></b></b><br>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_state"))%></b><br>
            </TD></TR>
		<TR><TD>
            Dear Sir / Madam,
          </TD></TR>
		  <TR><TD ALIGN="CENTER">
			<b>SUB: UNION COMFORT SCHEME </b><br>
              <u>Conveying of sanction Terms and conditions<br>
              <br>
              </u> 
		</TD></TR>
		<TR><TD>
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
               
                <td>
				<P>With reference to your loan application dated 
                  &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%></b> 
                  we are pleased to inform you that a Term Loan of Rs.&nbsp;<b><%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b> 
                  (Rupees &nbsp;<b><%=Helper.figtoWords(Helper.correctDouble((String) hshValues.get("sancamount")))%></b>) 
                  is sanctioned to you for the purpose of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%></b> 
                  under Union Comfort Scheme on the following terms and conditions: </p>
				 <ul>
				<li><p align="justify">A <b><%=Helper.correctNull((String) hshValues.get("loan_inttype"))%></b> interest of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("mintrate"))%></b>% 
                    per annum at monthly rests will be charged on your loan a/c
				</li>
				<li>
					<p valign="justify">The following security documents are to be 
                    executed at the time of disbursement of loan:
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
                       %></p>
				</li>
				<li> <p align="justify"> The loan amount for purchase of consumer durables will be
                     released directly in the name of the Dealer/Seller of the goods  by way
                     of a Demand draft/Pay Order.
				
				</li>
				<li>
				<%
					String installment_year="";
          			installment_year = Integer.toString(curyear);
          			if(installment_year.equalsIgnoreCase("0"))
          			{
          				installment_year="";
          			}
          			
          	%>
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
				<p>The Loan is repayable in&nbsp;<b><%=val%></b>  &nbsp;
                  Equated <b><%=installment%> </b> &nbsp; installments of Rs.&nbsp;<b><%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("loan_emi"))))%></b> 
                 &nbsp; commencing from <b><%=Months[a]%> <%=installment_year%></b>  &nbsp;month .</p>
				</li>
				<li>
				<p>A penal interest @ 2% will be levied on the overdue 
                  installment if any ?.</p>
				</li>
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
      					<li><p>
            				<b><%=title%>.&nbsp;<%=GuarantorName%></b>        
      
		                  with means of Rs.<b><%=Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(GuarantorMeans)))%>  Lacs</b>&nbsp;is acceptable 
		                  to bank to stand as guarantor to your loan</p></li>
                  <%}
        		}
        	}
        	else
        	{%>
					<li><p>Personal guarantee of	with means of Rs. is to be provided in lieu of the interim security (wherever stipulated)</p></li>
      		
        	<%}
        %>
					<li><p>Processing charges of Rs. &nbsp;<b><%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b>	
                  &nbsp;is to be paid before availment of loan.</p></li>
					<li><p>An irrevocable undertaking from your Employer 
                  is to be submitted to recover the EMIs directly from your salary 
                  every month and to remit the proceeds regularly to Bank.</p></li>
				  <li><p>An irrevocable undertaking from your Employer 
                  to adjust the loan dues if any, directly from the Terminal benefits 
                  payable to you in case of any eventually / cessation in service 
                  by you or not to release terminal benefits until no dues certificates 
                  is produced from the bank</p></li>
				  <li><p>All other terms and conditions as applicable 
                    to the scheme from time to time.<br>
 <% 
                     if(arryRow!=null)
                     {
                       for(int i=0;i<arryRow.size();i++)
                       {				
                    	  arryCol=(ArrayList)arryRow.get(i);
							if(arryCol!=null)
							{
							%>
                      <br> <%=i+1%>)&nbsp;<%=Helper.correctNull((String)arryCol.get(1))%>
                      <%
							}
                       }
                       	}
                       %>

				  </p></li>


				</ul>
				
                </td>
              </tr>
			  <tr>
				<td><p>We now request you to convey your acceptance (or) 
                  otherwise of the above terms and conditions and call on us any 
                  working day to enable us to disburse the loan after proper documentation. </P></td>
			  </tr>
             </table>
            </td>
			</tr>
			</table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="4%">&nbsp;</td>
                <td width="91%"> 
                  <p align="justify">&nbsp;</p>
                  <table width="98%" border="0" cellspacing="0" cellpadding="5" height="140">
                    <tr> 
                      <td width="59%" height="135">&nbsp;</td>
                      <td width="41%" height="135"> 
                        <p>For Karnataka Bank Ltd.</p>
                        <p><br>
                          <br>
                          <b>CHIEF / BRANCH MANAGER</b></p>
                        <p></p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                      </td>
                    </tr>
                  </table>
                  <table width="98%" border="1" cellspacing="0" cellpadding="5" height="197">
                    <tr> 
                      <td height="203"> 
                        <p>Accepted the above Terms and Condition</p>
                        <table width="98%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td width="59%"> 
                              <p>&nbsp;</p>
                              <p><b>Signature of the Applicant/s</b></p>
                              <p>&nbsp;</p>
                            </td>
                            <td width="41%"> 
                              <p>&nbsp;</p>
                              <p><b>Signature of Guarantors</b></p>
                              <p>&nbsp;</p>
                            </td>
                          </tr>
                         <tr> 
                            <td width="59%"> 
                             
                               <p>&nbsp;</p>
                              <p>&nbsp;</p>
                            </td>
                            <td width="41%"> 
                            
                               <p>&nbsp;</p>
                              <p>&nbsp;</p>
                            </td>
                          </tr>
                        </table>
                        <table width="98%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td width="59%">Date: <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
                            <td width="41%">Date: <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
                          </tr>
                        </table>
                       
                      </td>
                    </tr>
                  </table>
                  
                </td>
              </tr>
            </table>
           </td>
        </tr>
      </table>
    </td>

</table>
</body>
</html>
