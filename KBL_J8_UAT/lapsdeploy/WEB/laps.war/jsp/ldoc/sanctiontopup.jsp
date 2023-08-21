<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
 //ArrayList vecGuarantor=new ArrayList();
 //vecGuarantor=(ArrayList)hshValues.get("vecGuarantor"); 
 
 ArrayList vecCol = null;
 ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");
 ArrayList vecCoApp_col = null;
 ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
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
<title>UBI</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="98%" border="0" cellspacing="0" cellpadding="3" height="346">
   
   <tr> 
          <td colspan="3" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" width="75" height="75"></td>          		
    </tr>
    <TR>
    <td colspan="3"> 
      <div align="center"><b><font size="+1">KARNATAKA BANK LTD.</font></b><br>
   <b> <%=Helper.correctNull((String)hshValues.get("orgname"))%> </b> Branch<br>
      </div>
    </td>
  </tr>
  <tr> 
  			
    <td align="center" colspan="3"><strong ><b> <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      .<br> Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></b></strong>
      <hr/>
		</td>
</tr>
  <tr> 
    <td colspan="2"> 
      <div align="right"></div>
    </td>
    <td width="36%">Date: <b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b></td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <div align="center"><b><br>
        LETTER OF SANCTION</b></div>
    </td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <p><b>Ref.&nbsp;:<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("appno"))%></b>
      <p><b>To </b>
	  <br><br>
        <b><%=Helper.correctNull((String)hshValues.get("Title"))%> <%=Helper.correctNull((String)hshValues.get("appname"))%>,<br>
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
        <b> <%=Helper.correctNull((String)hshValues.get("perapp_state"))%>.</b> 
    </td>
  </tr>
  <tr> 
    <td colspan="3" height="41"> 
      <p>Dear Sir / Madam,</p>
      </td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <div align="center"><b>SUB: UNION Top-up Loan Scheme</b><br>
      </div>
    </td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td colspan="2"> 
      <p align="justify">With reference to your loan application dated <b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%></b>, 
        we are pleased to inform that a Term Loan/SOD of Rs.<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%></b> 
        [RS <b><%=Helper.figtoWords((String)hshValues.get("sancamount"))%></b>] 
        is sanctioned in your favour for the purpose of <b><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%></b> 
        under Union Top-up Loan scheme, on the following terms and conditions.</p>
      </td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3" height="968">
  <tr> 
    <td > 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"><p align="justify">A <b><%=Helper.correctNull((String) hshValues.get("loan_inttype"))%></b> interest of <b><%=Helper.correctNull((String) hshValues.get("mintrate"))%>%</b> 
            per annum at monthly rests will be charged to your Loan account.</p><br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> The loan amount will be credited to your SB/Current 
              Account </p><br>
           
          </td>
        </tr>
        <tr> 
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
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify">The loan shall be repayable in <b> <font face="MS Sans Serif" size="2"><b><%=val%></b></font> 
              </b><b>Equated <%=installment%> Installments</b> of <b>Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_emi"))))%></b> 
              commencing from <b>(<%=installment_year%>)<%=Months[a]%></b> 
              month .<br><br>
             <!--  SOD Limit shall be adjusted by reducing the limit by 1/5th every 
              year commencing from 5 years prior to the date of retirement (in 
              case of salaried persons] or 5 years prior to attaining the age 
              of 60 whichever is earlier. The limit can be adjusted by remitting 
              amount monthly/quarterly/half-yearly as per your convenience so 
              as to adjust 1/5th of I SOD limit by the end of 12 months.<br> -->
              
            </p><br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> A penal interest@2% will be levied on the overdue 
              Installments, if any
            </p><br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> In the case of take over of existing Home Loan, 
              the outstanding Top-up Loan also to be adjusted immediately
              </p><br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> No moratorium period will be allowed. Repayment 
              to commence immediately from the succeeding month of advance.<br>
              <br>
            </p>
          </td>
        </tr>
        
         <tr> 
                <td width="4%" valign="top">  </td>
                <td width="96%">&nbsp;</td>
              </tr>              
                    
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
      					<tr> 
                			<td width="4%"><li></li></td>
               			    <td width="96%"> Personal guarantee of
            				<b><%=title%>.&nbsp;<%=GuarantorName%></b>        
      
		                  with means of Rs.<b><%=Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(GuarantorMeans)))%></b>&nbsp;is to be provided in lieu 
		                  of the interim security (wherever stipulated)</td>
                  	   </tr><br>
                  <%}
        		}
        	}
        	else
        	{%> <td width="4%"><li></li></td>
        		<td width="96%">Personal guarantee of  with means of Rs.  is to be provided in lieu of the interim security (wherever stipulated)</td>
        	<% }
        %>
        
        <tr> 
                <td width="4%" valign="top">  </td>
                <td width="96%">&nbsp;</td>
              </tr>  
           <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> An irrevocable undertaking from your employer 
              is to be submitted to recover the EMls directly from your salary 
              every month and to remit the proceeds regularly to the bank.<br>
            </p><br>
          </td>
        </tr>
        <tr> 
          
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> An irrevocable undertaking from your employer 
              to adjust the loan dues if any, directly from the terminal benefits 
              payable to you in case of any eventuality/cessation in service by 
              you.
            </p><br>
          </td>
        </tr>
        <tr> 
          <!-- <td width="4%" valign="top">
            
          </td>-->
          <!--<td width="96%"> 
            <p align="justify"><br>
              The loan will be secured by extension of existing mortgage created 
              in the Home Loan account bearing Number----------------------- .You 
              are required to submit a letter extending the existing mortgage 
              in the prescribed format. </p>
          </td>-->
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"><p align="justify">In case the existing housing loan is adjusted and the 
            Top-up Loan still continues, mortgage shall not be released until 
            the Top-up Loan is also fully adjusted.</p><br>
          </td><br>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> Processing charges &nbsp;<b><%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b>	 
              shall be levied on the loan amount.
            </p><br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top">
            <li></li>
          </td>
          <td width="96%"><p align="justify"> Term loan is subject to review every year.
           </p><br>
          </td>
        </tr>
       <!--  <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"><p align="justify"> Interest on SOD is to be serviced every month in case 
            the limit is fully utilized.</p><br>
          </td>
        </tr> -->
        <tr>
          <td width="4%" valign="top"><li></li></td>
          <td width="96%">Bank has every right to modify/add /delete any of the 
            terms and conditions during the currency of loan at its discretion.</td>
        </tr>
        <tr> 
          <td width="4%" valign="top">
           
          </td>
          <td width="96%"> 
            <p align="justify">&nbsp; </p>
            <p>&nbsp &nbsp&nbsp&nbsp &nbsp We request you to convey your acceptance 
              or otherwise of the above terms and conditions by signing the copy 
              of this letter. <br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%">&nbsp;</td>
          <td width="96%"> 
            <p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Thanking you and assuring 
              our best services at all times. </p>
          </td>
        </tr>
      </table>
      
	</td>
  </tr>
  <tr> 
    <td> 
      <p div align="right">&nbsp &nbsp&nbsp&nbsp &nbsp Yours faithfully,</p>
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
            <p>Accepted the above Terms and Condition</p>
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="58%">&nbsp;</td>
                <td width="42%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="58%">&nbsp;</td>
                <td width="42%">&nbsp;</td>
              </tr>
              
              <tr> 
                <td width="58%"><b>Signature of the Borrower[s]</b></td>
                <td width="42%"><b>Signature of Guarantor[s]</b></td>
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
                <td width="58%">Date: <b> <%//=Helper.correctNull((String)hshValues.get("Curdate"))%> </b></td>
                <td width="42%">Date: <b> <%//=Helper.correctNull((String)hshValues.get("Curdate"))%> </b></td>
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


