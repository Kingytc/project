<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%


 ArrayList vecGuarantor=new ArrayList();
 vecGuarantor=(ArrayList)hshValues.get("vecGuarantor"); 
 ArrayList vecCoApp_col = null;
 ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
 ArrayList arrCol1 = null;
 ArrayList arrRow1 = (ArrayList) hshValues.get("arrDocsId");
 
 
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
 String installments=Helper.correctInt((String)hshValues.get("loan_noofinstallment"));

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
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="98%" border="0" cellspacing="0" cellpadding="3" height="346">
  <tr> 
    <tr> 
          <td colspan="3" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
         </tr>
    <tr>
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
      <p><b>Ref. </b> <b><%=Helper.correctNull((String)hshValues.get("appno"))%></b>
      <p><b>To </b>
	  <br><br>
        <b><%=Helper.correctNull((String)hshValues.get("Title"))%> <%=Helper.correctNull((String)hshValues.get("appname"))%><br>
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
      <div align="center"><b>SUB: UNION HEALTH SCHEME </b><br>
      </div>
    </td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td colspan="2"> 
      <p align="justify">With reference to your loan application dated &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%>&nbsp;</b>, 
        we are pleased to inform that a Term Loan of Rs.<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%>&nbsp;</b> 
        [RS <b><%=Helper.figtoWords(Helper.correctNull((String)hshValues.get("sancamount")))%> ]</b>&nbsp; 
        is sanctioned in your favour for the purpose of <b><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%>&nbsp;</b> 
        under <b>Union health</b> Loan scheme, on the following terms and conditions.</p>
      </td>
  </tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3" height="968">
  <tr> 
    <td height="820"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="4%" valign="top"></td>
          <td width="96%">A <b><%=Helper.correctNull((String) hshValues.get("loan_inttype"))%></b> interest of <b><%=Helper.correctNull((String) hshValues.get("mintrate"))%>%</b> 
            per annum at monthly rests will be charged to your Term loan account.<br>
            <br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> Loan amount will be disbursed directly to the 
              supplier of equipment / dealer of materials directly by way of demand 
              draft/pay order in the case of purchase of equipment etc. In the 
              case of construction, loan amount will be disbursed in a phased 
              manner depending on progress of construction and the loan will be 
              relased by way of pay order/demand draft in favour supplier of materials. 
              In the case of construction, cash disbursement shall be considered 
              only in such cases where payment cannot be made by payorder/demand 
              draft. <br>
              <br>
            </p>
          </td>
        </tr>
        <%int val1=0,val2=0;
        String str1= Helper.correctInt((String)hshValues.get("lreqterms"));
        String str2= Helper.correctInt((String)hshValues.get("loan_noofinstallment"));
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
              </b>&nbsp;<b>Equated &nbsp;<%=installment%>&nbsp;Installments</b> 
              of <b>Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_emi"))))%></b> 
              &nbsp;commencing from <b><%=Months[a]%> <%=installment_year%></b> 
              month including moratorium period of <font face="MS Sans Serif" size="2"><b><%=Helper.correctNull((String)hshValues.get("loan_noofinstallment"))%></b></font> 
              &nbsp; months.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <%
		ArrayList  arrCollateral=(ArrayList)hshValues.get("arrCollateral");
	 ArrayList  arrInvestment=(ArrayList)hshValues.get("arrInvestment");
	 ArrayList  arrShare=(ArrayList)hshValues.get("arrShare");
	 ArrayList  arrInsurance=(ArrayList)hshValues.get("arrInsurance");
	 ArrayList  arrPerAuto=(ArrayList)hshValues.get("arrPerAuto");	   
	 
		%>
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> The advance will be collaterally secured by pledge 
              of securities or EM of property situated at 
             <% ArrayList arrInv=new ArrayList();
            if(arrInvestment!=null && arrInvestment.size()!=0)
            {
            	 for(int i=0;i<arrInvestment.size();i++)
 	            {
            		 arrInv=new ArrayList();
            		 arrInv=(ArrayList)arrInvestment.get(i);            	
 	            	out.println("<br>");
 	            	out.println(" - Pledge of deposit with "+Helper.correctNull((String)arrInv.get(0))+" with Rs. "+Helper.correctNull((String)arrInv.get(1)));	            	
 	            }
            }
            
            ArrayList arrSh=new ArrayList();
            if(arrShare!=null && arrShare.size()!=0)
            {
            	 for(int i=0;i<arrShare.size();i++)
 	            {
            		arrSh=new ArrayList();
            		arrSh=(ArrayList)arrShare.get(i);            	
 	            	out.println("<br>");
 	            	out.println(" - Pledge of Shares with "+Helper.correctNull((String)arrSh.get(0))+" with Rs. "+Helper.correctNull((String)arrSh.get(1)));	            	
 	            }
            }
            
            ArrayList arrIns=new ArrayList();
            if(arrInsurance!=null && arrInsurance.size()!=0)
            {
            	 for(int i=0;i<arrInsurance.size();i++)
 	            {
            		 arrIns=new ArrayList();
            		 arrIns=(ArrayList)arrInsurance.get(i);            	
 	            	 out.println("<br>");
 	            	 out.println(" - Assignment of Insurance No. "+Helper.correctNull((String)arrIns.get(0))+" , "+Helper.correctNull((String)arrIns.get(1))+" , "+Helper.correctNull((String)arrIns.get(2)));	            	
 	            }
            }
            ArrayList arrAuto=new ArrayList();
            if(arrPerAuto!=null && arrPerAuto.size()!=0)
            {
            	 for(int i=0;i<arrPerAuto.size();i++)
 	            {
            		 arrAuto=new ArrayList();
            		 arrAuto=(ArrayList)arrPerAuto.get(i);            	
 	            	 out.println("<br>");
 	            	 out.println(" - Hypothecation of "+Helper.correctNull((String)arrAuto.get(0))+" , "+Helper.correctNull((String)arrAuto.get(1)));	            	
 	            }
            }
        
        
        %>
              [ the value of collateral security should not be less than 50% of 
              loan amount] </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> The loan will be secured by equitable mortgage 
              of land/land and buildings/commercial property situated at <b><%=Helper.correctNull((String)hshValues.get("prop_houseno"))%>,<%=Helper.correctNull((String)hshValues.get("prop_area"))%>-
			  <%=Helper.correctNull((String)hshValues.get("prop_city"))%>-<%=Helper.correctNull((String)hshValues.get("prop_state"))%>-<%=Helper.correctNull((String)hshValues.get("prop_pin"))%> 
             </b> held by <b>&nbsp;<%=Helper.correctNull((String)hshValues.get("Title"))%>
              <%=Helper.correctNull((String)hshValues.get("appname"))%>,</b> 
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
        	}%> &nbsp;valued 
              &nbsp; Rs <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("prop_mar_build"))))%></b> 
              &nbsp; [ in case the advanced is sanctioned primarily for purchase/construction 
              of building] <br>
              <br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify">Assets created out of bank's finance will be insured 
              at borrowers' cost covering all types of risk.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> Borrower to furnish the relevant bills/receipts 
              towards purchase of equipment/construction of building etc.</p>
            for full value [ i.e total cost of the equipment/asset/construction 
            ]<br>
            <br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="justify">&nbsp; 
            <li></li>
          </td>
          <td width="96%">&nbsp; 
            <%
	ArrayList vecGua=new ArrayList();
	vecGuarantor=(ArrayList)hshValues.get("vecGuarantor");
	
	if(vecGuarantor!=null)
	{ 
         
           
   for(int i=0;i<vecGuarantor.size();i++)
   {
	   vecGua=(ArrayList)vecGuarantor.get(i);  
  
%>
            <b><%=Helper.correctNull((String)vecGua.get(1))%></b> stand 
            as guarantor [s] <br>
            <br>
            <%}}%>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> Borrower to furnish his/her' no objection' to 
              carrying out inspection of the assets created out of bank's finance, 
              as and when required.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" align="justify"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify">Processing charges Rs. <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b> 
              shall be levied on the loan amount. <br>
            </p>
          </td>
        </tr>
        <br>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%">Penal interest <b>@ 2%</b> will be charged if payment 
            of EMls is not regular. <br>
            <br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> Take-over penalty of <b>2%</b>shall be levied 
              on the average outstanding forthe last preceding 12 months in case 
              the loan is taken over by other banks or financial Institutions 
              or adjusted out of funds borrowed from third party. However, no 
              penalty will be levied if the account is adjusted out own verifiable 
              legitimate sources and onus of proof for the same rests with the 
              borrower.<br>
              <br>
            </p>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%">Term loan is subject to review every year. <br>
            <br>
          </td>
        </tr>
        <tr> 
          <td width="4%" valign="top"> 
            <li></li>
          </td>
          <td width="96%"> 
            <p align="justify"> Bank has every right to modify/add /delete any 
              of the terms and conditions during the currency of loan at its discretion.</p>
			  
			  <br><br><br><br><br>
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
            <p align="justify">&nbsp &nbsp&nbsp&nbsp &nbsp Thanking you and assuring 
              our best services at all times. </p>
          </td>
        </tr>
      </table>
      
	</td>
  </tr>
  <tr> 
    <td> 
      <p div align="right"><b>For Karnataka Bank Ltd.</b></p>
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
            <p><b>The above Terms and Conditions are acceptable us</b></p>
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
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

