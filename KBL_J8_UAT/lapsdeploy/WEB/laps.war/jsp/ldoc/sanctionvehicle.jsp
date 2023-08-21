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
ArrayList vecCol = null;
ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");
ArrayList vecCoApp_col = null;
ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
ArrayList arrCol1 = null;
ArrayList arrRow1 = (ArrayList) hshValues.get("arrDocsId");
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
          <td colspan="2" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
         </tr>
        <tr> 
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5" bordercolor="#999999">
      <tr>
            <td width="100%" align="center">Karnataka Bank Ltd.<br>
		
			&nbsp;<strong ><b><%=Helper.correctNull((String)hshValues.get("orgname"))%>&nbsp;Branch</b></strong></td>
      </tr>
      <tr> 
  			
    <td align="center"><strong ><b> <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      .<br> Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></b></strong>
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
              <p align="center"><strong>                Sub: UNION MILES SCHEME
                  <br />
                  Conveying of sanction Terms and Conditions</strong></p>
              <p>With reference to your loan application dated &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%></b>&nbsp;we are pleased to inform you that  
                a Term Loan of Rs. &nbsp; <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b>&nbsp;[ Rupees &nbsp;<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b>] is 
                sanctioned to you for the purpose of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%>&nbsp;</b>under <strong>Union Miles Scheme</strong>, on the following terms and conditions.</p>
                    <ul>
                      <li> A fixed interest of&nbsp;<b><%=Helper.correctNull((String) hshValues.get("mintrate"))%></b>&nbsp;% 
                        per annum at monthly rests will be charged on your Loan 
                        a/c.</li>
                      <li>The following security documents are to be executed 
                        at the time of disbursement of loan:<br />
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
           <%   if(arrRow1!=null)
        			{
        			for(int i=0;i<arrRow1.size();i++)
        			{	
        			arrCol1=(ArrayList)arrRow1.get(i);
	        			if(arrCol1!=null)
	        				{	
	        				//String code=Helper.correctNull((String) arrCol1.get(0));
	        				String document=Helper.correctNull((String) arrCol1.get(1));%>
	        				 <%=i+1%>)&nbsp;<b> <%=document%></b><br>
	        				<%}
        			}
        			}%>
        			<li>The loan amount with margin money will be released directly in the name of 
        				the Dealer/Seller of the vehicle by way of a Demand Draft/Pay Order</li> 	
                      <li>The loan is repayable in &nbsp;<b><%=val%></b> 
                        Equated  <b><%=installment%></b> installments of Rs. &nbsp;<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("loan_emi"))))%></b>
                        commencing from <b><%=Months[a]%> <%=installment_year%></b>  month.</li>
                      <li>A penal interest @2% will be levied on the overdue installment 
                        if any?</li>
                      <li>The vehicle financed by us is to be insured comprehensively 
                        covering all risks with Bank Clause.</li>
                      <li> Bank's lien on the vehicle financed is to be registered 
                        with RTA and a copy of the same to be submitted for our 
                        records.</li><br>
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
        				
      					<li> <%=title %> &nbsp;<b> <%=GuarantorName%></b>
                        with means of <b>Rs. <%=GuarantorMeans%> Lacs</b> is acceptable to Bank to stand as guarantor 
                        to your loan.</li>
                  <%}
        		}
        	}
        	else
        	{%>
        		<li>with means of <b>Rs.  </b> is acceptable to Bank to stand as guarantor 
                to your loan.
       <% 	}
        %>
                        
                        
                        
                        
                      
                      <li> Processing charges of Rs. &nbsp;<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b> 
                        is to be paid before availment of loan</li>
                      <li> An irrevocable undertaking from your employer is to 
                        be submitted to recover the EMls directly from your salary 
                        every month and to remit the proceeds regularly to Bank.</li>
                      <li> An irrevocable undertaking from your Employer to adjust 
                        the loan dues if any, directly from the Terminal benefits 
                        payable to you in case of any eventuality / cessation 
                        in service by you or not to release terminal benefits 
                        until a no due certificate is produced from the Bank.</li>
                       
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
                  
                              
              <p>We now request you to convey your acceptance (or) otherwise of the above terms 
                and conditions and call on us any working day to enable us to disburse the loan after 
                proper documentation.</p>
              <p align="right"><strong>For Karnataka Bank Ltd.</strong></p>
              <p align="right">&nbsp;</p>
              <p align="right"><br />
                <strong>CHIEF/BRANCH MANAGER</strong></p>
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
                      <td><strong> &nbsp;</strong></td>
                      <td><strong>&nbsp;</strong></td>
                    </tr>
                    <tr>
                      <td><strong> &nbsp;</strong></td>
                      <td><strong>&nbsp;</strong></td>
                    </tr>
                     <tr>
                      <td><strong> &nbsp;</strong></td>
                      <td><strong>&nbsp;</strong></td>
                    </tr>
                     <tr>
                      <td><strong> &nbsp;</strong></td>
                      <td><strong>&nbsp;</strong></td>
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
  </tr>
</table>

</form>
</body>
</html>
