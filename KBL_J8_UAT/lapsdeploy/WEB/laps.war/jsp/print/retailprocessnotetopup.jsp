<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />

<%!
   double AmtReq,margin=0.00,emi_amt=0.00;
	int terms=0,mor_period=0,no_emi=0;
%>

<%  
String dat=Helper.correctNull((String)hshValues.get("emidate"));

terms=Integer.parseInt(Helper.correctInt((String)hshValues.get("lreqterms")));
mor_period=Integer.parseInt(Helper.correctInt((String)hshValues.get("loan_noofinstallment")));
no_emi=terms-mor_period;

	emi_amt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_emi")));
	String producttype=Helper.correctNull((String)hshValues.get("prd_type"));
    AmtReq=Double.parseDouble(Helper.correctDouble((String)hshValues.get("amtreqd")));
    margin=((AmtReq*20)/100);
 
 String prd_loantype=Helper.correctNull((String)hshValues.get("prd_loantype"));
  //out.print(prd_loantype);
	if(prd_loantype.equalsIgnoreCase("TL"))
		{
		 prd_loantype="Term Loan";  
		
		}
	   else if(prd_loantype.equalsIgnoreCase("OD"))
		{
	 	 prd_loantype="Over Draft";  
	 	
		}
		
		String prop_type=Helper.correctNull((String)hshValues.get("prop_housetype"));
		if(prop_type.equalsIgnoreCase("Land"))
		{
	     prop_type="Land";  
		}else if(prop_type.equalsIgnoreCase("Flat"))
	 	 {
		  prop_type="Flat";  
	  	}
		else if(prop_type.equalsIgnoreCase("Apartment"))
		{
			  prop_type="Apartment";  
		}
		else if(prop_type.equalsIgnoreCase("House/Building"))
		{
			  prop_type="House/ Building";  
		}
		
String facility_type=Helper.correctNull((String)hshValues.get("loan_facility"));	
// out.print(facility);
if(facility_type.equalsIgnoreCase("0"))
{
	facility_type="";
}
if(facility_type.equalsIgnoreCase("1"))
{
	facility_type="Short Term Loan";
}
if(facility_type.equalsIgnoreCase("2"))
{
	facility_type="Term Loan-Medium";
}
if(facility_type.equalsIgnoreCase("3"))
{
	facility_type="Long Term Loan";
}
if(facility_type.equalsIgnoreCase("4"))
{
	facility_type="Secured-Over Draft";
}
if(facility_type.equalsIgnoreCase("5"))
{
	facility_type="Clean-Over Draft";
}
if(facility_type.equalsIgnoreCase("6"))
{
	facility_type="Cash Credit-Pledge";
}
if(facility_type.equalsIgnoreCase("7"))
{
	facility_type="Cash Credit-Hypo of stock";
}
if(facility_type.equalsIgnoreCase("8"))
{
	facility_type="Cash Credit-Hypo of Book/Debt";
}
if(facility_type.equalsIgnoreCase("9"))
{
	facility_type="OD - Reducing<";
}
if(facility_type.equalsIgnoreCase("10"))
{
	facility_type="DLRI";
}
if(facility_type.equalsIgnoreCase("11"))
{
	facility_type="ILROD-Inland loan Repayable on Demand";
}


		
		
		 ArrayList arrydocCol = null;
		 ArrayList arrydocRow = (ArrayList) hshValues.get("arrDocsId");
		 ArrayList vecCol = null;
		 ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");
		 
		 ArrayList vecCoApp_col = null;
		 ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");

%>
	<%
	   
	 
	// ArrayList vecCoApplVal=new ArrayList();
	 ArrayList  arrCollateral=(ArrayList)hshValues.get("arrCollateral");
	
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
	 
	 ArrayList arrRow=(ArrayList)hshValues.get("mailcomments");
	 ArrayList  arrInsurance=(ArrayList)hshValues.get("arrInsurance");
	 ArrayList  arrPerAuto=(ArrayList)hshValues.get("arrPerAuto");
	 ArrayList  arrInvestment=(ArrayList)hshValues.get("arrInvestment");
	 %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css" />
</head>


<body>
<table width="98%" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
    <td>&nbsp;</td>
    </tr>
    <tr align="center">
    <td ><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"
							width="350" height="70">
    </td>
    </tr>
      <tr align="center" > 
                    <td colspan="4"> <b>KARNATAKA BANK LTD.</b><br>
                  <b><%=Helper.correctNull((String) hshValues.get("orgname"))%> 
                 <%strOrgLevel.equalsIgnoreCase("B");
                  {%>
                  </b><b><%=Helper.correctNull((String)hshValues.get("branchname"))%></b><br>
                  <%}%>
                </td>
              </tr>
              <tr> 
                <td align="center" ><b> <%=Helper.correctNull((String) hshValues.get("orgadd1"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgadd2"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgcity"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgstate"))%>-&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgzip"))%>&nbsp; 
                  .<br>
                  Tel No : <%=Helper.correctNull((String) hshValues.get("orgphone"))%></b> 
                  <hr />
                </td>
              </tr>
    </table>
    <br>
      <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" bordercolor="#999999">
        <tr> 
          <td colspan="2" class="td_bg"><strong>PROCESS CUM SANCTION</strong></td>
        </tr>
        <tr> 
          <td width="40%">1(a) Name of the Applicant/s</td>
          <td width="60%">
          <b><%=Helper.correctNull((String)hshValues.get("Title"))%>&nbsp;<%=Helper.correctNull((String)hshValues.get("appname"))%></b><br>
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
          </td>
        </tr>
        <tr>
            <td width="40%" >1(b) Branch Name</td>
           <td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("cus_org_name"))%> </b></td>
      </tr>
       
                
        <tr>
         <td width="40%">2. Means of the Applicant/s  <b>(Rs. in Lacs)</b></td>  
  		 <td width="60%">
  		 &nbsp;<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CR_Total_MEANS"))))%><br>
  		  <% if(vecCoApp_Row!=null)
        	{
        		for(int i=0;i<vecCoApp_Row.size();i++)
        		{
        			vecCoApp_col=(ArrayList)vecCoApp_Row.get(i);
        			if(vecCoApp_col!=null)
        			{
        				String CoApplicantMeans=Helper.correctNull((String) vecCoApp_col.get(9));
        	%>
        	&nbsp;<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(CoApplicantMeans)))%><br>
        	<%
        			}
        		}
        	}
  		  %>
  		 
  		 </td>
  		</tr>
  		
  		<tr> 
          <td>3. Present monthly / annual income of the applicants </td>
          <td><b>Monthly :Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("permonsalary"))))%><br>
            	 Yearly :Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("peryearsalary"))))%>,<br></b>
  		
  		
  		<% if(vecCoApp_Row!=null)
    	{
    		for(int i=0;i<vecCoApp_Row.size();i++)
    		{
    			vecCoApp_col=(ArrayList)vecCoApp_Row.get(i);
    			if(vecCoApp_col!=null)
    			{	
    				String monsal=Helper.correctNull((String) vecCoApp_col.get(13));
    				String yrsal=Helper.correctNull((String) vecCoApp_col.get(14));
    %>
    				<b>Monthly: Rs.<%=monsal%>&nbsp;<br>Yearly : Rs.<%=yrsal%>,</b><br>
    <%			}
    		}
    	}%>
      </td>
        </tr>
        <tr> 
          <td>4. Whether the Installments are paid regularly as per stipulated 
            repayment schedule</td>
          <td>YES / NO</td>
        </tr>
        <tr> 
          <td>5. Whether the account figured in EAS/SMA at any point of time ? </td>
          <td><b>Yes/No</b></td>
        </tr>
        <tr> 
          <td>6. Details of installment already paid in original Home Loan</td>
          <td><b>No. of installments: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     Total amount(Rs.)</b></td>
          
        </tr>
        <tr> 
        <tr> 
          <td>7. Computation of Eligible quantum of loan Total Amount repaid Less:Margin- 50% Eligible Quantum of Loan </td>
          <td><b> </b></td>
        </tr>
        <tr> 
          <td>8. Amount of Top-up Loan sought</td>
          <td><b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("amtreqd"))))%></b></td>
        </tr>
        <tr> 
          <td>9. Amount of Top up loan recommended</td>
          <td><b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b></td>
        </tr>
        <tr> 
          <td>10. Nature of facility sought / Recommended</td>
          <td><b><%=facility_type%></b></td>
        </tr>
        	<%
					String installment_year="";
          			installment_year = Integer.toString(curyear);
          			if(installment_year.equalsIgnoreCase("0"))
          			{
          				installment_year="";
          			}
          			
          	%>
          <tr>
        <td valign="top">11. Repayment Schedule [in the case of Term Loan]</td>
        <td>a. Number of EMls :<b> <%=no_emi %>(months)</b><br/>
          b. Amount of EMI :<b> Rs. <%=Helper.formatDoubleValue(emi_amt) %></b><br />
          c. Repayment to commence from: <b><%=Months[a]%> <%=installment_year%></b> </td>
      </tr>
        <tr> 
          <td>12. Rate of Interest</td>
          <td><b><%=Helper.correctNull((String) hshValues.get("mintrate"))%> %,</b> &nbsp;<%=Helper.correctNull((String) hshValues.get("loan_inttype"))%>
          </td>
        </tr>
        <tr> 
          <td valign="top">13. Margin </td>
          <td> 
            <b> <%=Helper.correctNull((String) hshValues.get("margin_perct"))%> %</b>
          </td>
        </tr>
        
        <tr>
      <%
      String auto_category=Helper.correctNull((String)hshValues.get("auto_category"));
      String auto_model=Helper.correctNull((String)hshValues.get("auto_model"));
      String auto_registration=Helper.correctNull((String)hshValues.get("auto_registration"));
      String auto_articlename=Helper.correctNull((String)hshValues.get("auto_articlename"));
      String auto_make=Helper.correctNull((String)hshValues.get("auto_make"));
      
            
      %>
      
      
            <td width="39%" valign="top">14. Security Details</td>
            
            <td width="60%" height="100" valign="top">
            <%if(producttype.equalsIgnoreCase("pA") && auto_category.equalsIgnoreCase("1") )
            {            	
            	out.println(" - Hypothecation of Vehicle "+auto_articlename+", "+ auto_make +" & "+auto_model);             	
            }
            else if(producttype.equalsIgnoreCase("pA") && auto_category.equalsIgnoreCase("2") )
            {
            	out.println(" - Hypothecation of Vehicle "+auto_articlename+", "+ auto_make +" & "+auto_model);  
            }
            
    ArrayList arrColl=new ArrayList();
            
            if(arrCollateral!=null && arrCollateral.size()!=0)
            {
	            for(int i=0;i<arrCollateral.size();i++)
	            {
	            	arrColl=new ArrayList();
	            	arrColl=(ArrayList)arrCollateral.get(i);            	
	            	out.println("<br>");
	            	out.println(" - Equitable / Simple Mortgage of the property situated at "+Helper.correctNull((String)arrColl.get(1))+" , "+Helper.correctNull((String)arrColl.get(2))+" , "+Helper.correctNull((String)arrColl.get(3))+" , "+Helper.correctNull((String)arrColl.get(4))+" , "+Helper.correctNull((String)arrColl.get(5)));	            	
	            }	            
            }
            
            String InterimSecurity="";
 	        out.println("<br>");
 	        out.println(" - Equitable / Simple Mortgage of the property situated at "+Helper.correctNull((String)hshValues.get("prop_houseno"))+" , "+Helper.correctNull((String)hshValues.get("prop_area"))+" , "+Helper.correctNull((String)hshValues.get("prop_housingaddress"))+" , "+Helper.correctNull((String)hshValues.get("prop_city"))+" , "+Helper.correctNull((String)hshValues.get("prop_pin")));
 	            	
        	InterimSecurity=Helper.correctNull((String)hshValues.get("prop_intermsecurity"));
        	if(!InterimSecurity.equalsIgnoreCase(""))
        	{
        		out.println("<br>");
	            	out.println(" - Interim Security "+Helper.correctNull((String)hshValues.get("prop_intermsecurity")));
        	}
        	
        	ArrayList arrInv=new ArrayList();
            if(arrInvestment!=null && arrInvestment.size()!=0)
            {
            	 for(int i=0;i<arrInvestment.size();i++)
 	            {
            		 arrInv=new ArrayList();
            		 arrInv=(ArrayList)arrInvestment.get(i);            	
 	            	out.println("<br>");
 	            	out.println(" - Pledge of deposit with <b>"+Helper.correctNull((String)arrInv.get(0))+"</b> for Rs. "+Helper.correctNull((String)arrInv.get(1)));	            	
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
 	            	 out.println(" - Hypothecation of vehicle "+Helper.correctNull((String)arrAuto.get(1))+" , "+Helper.correctNull((String)arrAuto.get(0))+" with "+Helper.correctNull((String)arrAuto.get(2)));	            	
 	            }
            }
            
        %>
        
        <tr> 
        
          <td valign="top">15. Details of personal guarantee</td>
          <td> 
            <table width="70%" border="0" cellspacing="0" cellpadding="0">
                              
                  <%
        	if(vecRow!=null)
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
            <td>Name: <b><%=title%>.&nbsp;<%=GuarantorName%></b> 
       			</td>
                <td> Means : (Rs.)<b><%=Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(GuarantorMeans)))%></b></td>
              </tr>
              <%       			}
        		}
        	}
        %>
                
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td valign="top">16. Documents to be obtained</td>
          <td><% 
                     if(arrydocRow!=null)
                     {
                       for(int i=0;i<arrydocRow.size();i++)
                       {				
                    	  arrydocCol=(ArrayList)arrydocRow.get(i);
							if(arrydocCol!=null)
							{
							%>
            <br>
            <b><%=i+1%>)&nbsp;<%=Helper.correctNull((String)arrydocCol.get(1))%></b>
            <%
							}
                       }
                       	}
                       %></td>
        </tr>
        <tr> 
          <td valign="top">17. Processing Charges</td>
          <td><b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b> 
            of the loan amount (excluding service tax) </td>
        </tr>
      <tr>
	  <td colspan="3"> 
            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
              <tr> 
                <td colspan="3" align="center" class="td_bg"><strong>Recommended 
                  for Sanction</strong></td>
              </tr>
              <%if(arrRow!=null && arrRow.size()>0)
          				{
          				for(int i=0; i<arrRow.size();i++)
          					{
          					ArrayList arrCol=new ArrayList();
          					arrCol=(ArrayList)arrRow.get(i);
       					%>
              <tr> 
                <td valign="top"><%=arrCol.get(0)%>&nbsp;</td>
                <td valign="top">:&nbsp;</td>
                <td valign="top"> 
                  <p><%=arrCol.get(1)%>&nbsp;</p>
                </td>
              </tr>
              <% 
            			}
			            }
          				%>
              <tr> 
                <td colspan="3"> 
                  <table width="65%" border="0" align="center" cellpadding="5" cellspacing="0">
                    <tr> 
                      <td width="40%"><b>Signature</b></td>
                      <td width="1%">:</td>
                      <td width="59%">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><b>Name of the officer</b></td>
                      <td>:</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><b>Designation</b></td>
                      <td>:</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td colspan="3" align="center" class="td_bg"><strong>Sanctioned 
                  / Declined</strong></td>
              </tr>
              <tr>
			 	<td valign="top"><%=Helper.correctNull((String)hshValues.get("sancauth"))%>&nbsp;</td>
				<td valign="top">:&nbsp;</td>
			  	<td valign="top"><p><%=Helper.correctNull((String)hshValues.get("sancofficercomments"))%>&nbsp;</p></td>
       		</tr>	
              <tr> 
                <td colspan="3"> 
                  <table width="65%" border="0" align="center" cellpadding="5" cellspacing="0">
                    <tr> 
                      <td width="40%"><b>Signature</b></td>
                      <td width="1%">:</td>
                      <td width="59%">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><b>Name of the officer</b></td>
                      <td>:</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><b>Designation</b></td>
                      <td>:</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td>Name of the Br. with Seal</td>
                      <td>:</td>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <br /></td>
      
		
	  </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
