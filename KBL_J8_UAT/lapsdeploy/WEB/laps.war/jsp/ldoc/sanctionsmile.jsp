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
	 installment="Haly-Yearly";  
}else if(installment.equalsIgnoreCase("y"))
{
	 installment="Yearly";
}
ArrayList arrydocCol = null;
ArrayList arrydocRow = (ArrayList) hshValues.get("arrDocsId");

ArrayList vecCol = null;
ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");
ArrayList vecCoApp_col = null;
ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
ArrayList arrCol1 = null;
ArrayList arrRow1 = (ArrayList) hshValues.get("arrDocsId");
String producttype=Helper.correctNull((String)hshValues.get("prd_type"));
String loan_inttype=Helper.correctNull((String) hshValues.get("loan_inttype"));
ArrayList arryCol = null;
ArrayList arryRow = (ArrayList) hshValues.get("arrTermsId");
int calMonth=0;
String date="";
String Month="0";
String year="0";
String calYear="";
//String loan_noofinstallment = "0";	
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 5px;
	margin-right: 0px;
	margin-bottom: 5px;
	font-family:Arial, Helvetica, sans-serif;
	line-height:20px;
	font-size:12px;
	color:#000000;
}
td {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	height:20px;
	font-family:Arial, Helvetica, sans-serif;
	line-height:20px;
	font-size:12px;
	color:#000000;
}
.td_bg {
	background-color: #E9E9E9;
}
-->
</style>
</head>

<body>
<form>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
   <tr> 
          <td colspan="2" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" width="75" height="75"></td>          		
         </tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5" bordercolor="#999999">
      <tr>
            <td width="100%" align="center"><strong >Karnataka Bank Ltd.<br>
		
			&nbsp;<%=Helper.correctNull((String)hshValues.get("orgname"))%>&nbsp;Branch</strong></td>
      </tr>
      <tr> 
  			
    <td align="center"><strong > <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      . <br> Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></strong>
      <hr/>
		</td>
</tr>
      <tr>
        <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="64%">Ref.No.&nbsp;:<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
            <td width="36%">Date:&nbsp;<b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b></td>
          </tr>
          <tr>
            <td colspan="2" align="center">
              <strong>LETTER OF SANCTION</strong><br /></td>
            </tr>
          <tr>
            <td>To<br />
             <b><%=Helper.correctNull((String)hshValues.get("Title"))%> 
      <%=Helper.correctNull((String)hshValues.get("appname"))%>,<br>
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
      </b><b><%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>,</b><br>
      <b><%=Helper.correctNull((String)hshValues.get("perapp_address2"))%> ,</b><br>
      <b><%=Helper.correctNull((String)hshValues.get("perapp_city"))%> -<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>. 
      </b> <br>
      <b> <%=Helper.correctNull((String)hshValues.get("perapp_state"))%>.</b></td>
            <td>&nbsp;</td>
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
          <%
					String installment_year="";
          			installment_year = Integer.toString(curyear);
          			if(installment_year.equalsIgnoreCase("0"))
          			{
          				installment_year="";
          			}
          			
          	%>
            <td colspan="2"><p>Dear Sir/Madam,</p>
              <p align="center"><strong>                Your request for sanction of loan under
                                                          
                  <br />
				  <%if(producttype.equalsIgnoreCase("pO")){%>
				  UNION SMILE SCHEME
				  <%} else if(producttype.equalsIgnoreCase("pP")){%>
				  UNION CASH SCHEME
				<%   }%> 
                   </strong></p>
              <p>With reference to your loan application dated &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%></b>&nbsp;,requesting for sanction   
                 of a loan of Rs. &nbsp; <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b>&nbsp;[ Rupees &nbsp;<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b>] 
                 under <strong><%if(producttype.equalsIgnoreCase("pO")){%>
				 union smile scheme
				  <%} else if(producttype.equalsIgnoreCase("pP")){%>
				  union cash scheme
				<%   }%> </strong>  of bank.we are please to inform that term loan loan of Rs.&nbsp; <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b>&nbsp;[ Rupees &nbsp;<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b>]has been sanctioned on the following terms and conditions</p>
                    <ul>
               <li>The loan is repayable in &nbsp;<b><%=val%></b> 
                        monthly EMI of Rs.  <b><%=installment%></b> &nbsp;<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("loan_emi"))))%></b>
                        commencing from <b>(<%=installment_year%>)<%=Months[a]%></b>  month. A letter of authority to deducts EMIs from your pension account to be given as per prescribed format of the bank.</li>     
                      <li> The Loan carries a fixed interest of&nbsp;<b><%=Helper.correctNull((String) hshValues.get("mintrate"))%></b>&nbsp;% 
                     chargeable at monthly rests.</li>
              <!--        <li>The following security documents are to be executed 
                        at the time of disbursement of loan:<br />--> 
                    <!--   <li>(i) DP Note<br />
                  (ii)
                  Consumer goods (Vehicle Agreement) SD-10<br />
                  (iii) Form 'E'duly signed by the borrower instructing the supplier / dealer 
                  to register Bank's lien with RTA.<br />
                  (iv)Letter of gurantee from the gurantor ( SD-01) <br />
                  (v) Blank Forms 28, 29, 30.</li>
                      <li>The loan amount with margin money will be released directly 
                        in the name of the Dealer / Seller of the vehicle by way 
                        of a Demand Draft / Pay Order.</li> -->
       <% 
                 /*    if(arrydocRow!=null)
                     {
                       for(int i=0;i<arrydocRow.size();i++)
                       {				
                    	  arrydocCol=(ArrayList)arrydocRow.get(i);
							if(arrydocCol!=null)
							{*/
							%>
                       <br> 	<b><%//=i+1%>&nbsp;<%//=Helper.correctNull((String)arrydocCol.get(0))%></b>
                      <%
					/*		}
                      }
                     	}*/
                       %>
        			<li>The loan to be secured by pledge of NSCs/ KVPs/ Deposit receipts,the face value/present value of which should not be less than the loan amount.</li> 
        				
                      <p align="center"><b>OR</b></p>
                      <!--  <li>The vehicle financed by us is to be insured comprehensively 
                        covering all risks with Bank Clause.</li>
                      <li> Bank's lien on the vehicle financed is to be registered 
                        with RTA and a copy of the same to be submitted for our 
                        records.</li>--> 
                        <%		
        	if(vecRow!=null  && vecRow.size()>0)
        	{
        		for(int i=0;i<vecRow.size();i++)
        		{	
        			vecCol=(ArrayList)vecRow.get(i);
        			if(vecCol!=null)
        			{	
        				String title=Helper.correctNull((String) vecCol.get(0));
        				String GuarantorName=Helper.correctNull((String) vecCol.get(1));
        				String GuarantorMeans=Helper.correctNull((String) vecCol.get(9));%>
        				
      					<p> Personal guarantee of  <%=title %>. &nbsp;<b> <%=GuarantorName%></b>
                       whose means are reported as <b>Rs. <%=GuarantorMeans%> Lacs</b>
                        to be provided.</p>
                  <%}
        		}
        	}else{
        %>
                 <p> Personal guarantee of  Shri &nbsp;
                       whose means are reported as Rs. 
                        to be provided.</p>       
             <%} %>           
                        
                        
                      
                <!--        <li> Processing charges of Rs. &nbsp;<b><%//=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b> 
                        is to be paid before availment of loan</li>-->
                          <li>Personal guarantee of pension nominee of sri/smt.&nbsp;<b><%=Helper.correctNull((String) hshValues.get("pre_pensionnominee"))%></b></li>
                        <li>An undertaking from nominee as per prescribed format to be submitted.</li>
                        <li>Transfer of pension account is not permitted during currency of loan.</li>
                        <li>Delay in remitting EMI attracts penal interst @ 2%.</li>
                      <li>Bank reserves right to modify/ amend any of the terms and conditions.</li>
                      <li> All other terms and conditions governing the scheme</li>
                       
                     <% 
                     if(arryRow!=null)
                     {
                       for(int i=0;i<arryRow.size();i++)
                       {				
                    	  arryCol=(ArrayList)arryRow.get(i);
							if(arryCol!=null)
							
							%>
                      <br> 	<b><%=i+1%>)&nbsp;<%=Helper.correctNull((String)arryCol.get(1))%></b>
                      <%
							
                       }
                       	}
                       %>
                  </ul>
                  
                 <br> <br> <br> <br> <br> <br> 
                  
                              
              <p>We request you to convey your acceptance (or) otherwise to the above terms 
                and conditions of sanction on duplicate of this letter.</p>
              <p align="right"><strong>Yours faithfully,</strong></p>
              <p align="right">&nbsp;</p>
              <p align="right"><br />
                <strong>BRANCH/CHIEF MANAGER</strong></p>
              <table width="100%" border="1" cellspacing="0" cellpadding="3">
                <tr>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
                    <tr>
                      <td><strong>Accepted the above Terms &amp; Conditions</strong></td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="100">&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><strong> Signature of the Applicant [s]</strong></td>
                      <td><strong>Signature of the Guarantor [s]</strong></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                     <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                     <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><strong>Date : <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></strong></td>
                      <td><strong>Date : <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></strong></td>
                      <td>&nbsp;</td>
                    </tr>
                  </table></td>
                </tr>
              </table>              </td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  
</table>

</form>
</body>
</html>
