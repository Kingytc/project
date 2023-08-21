<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
//out.print(hshValues.get("Curdate"));
double emi_amt=0.00;
int terms=0,mor_period=0,no_emi=0;


String dat=Helper.correctNull((String)hshValues.get("emidate"));

terms=Integer.parseInt(Helper.correctInt((String)hshValues.get("lreqterms")));
mor_period=Integer.parseInt(Helper.correctInt((String)hshValues.get("loan_noofinstallment")));
no_emi=terms-mor_period;

emi_amt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_emi")));

ArrayList arryCol = null;
ArrayList arryRow = (ArrayList) hshValues.get("arrTermsId");
//out.print(arryRow);
String producttype=Helper.correctNull((String)hshValues.get("prd_type"));



ArrayList vecCoApp_col = null;
ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
ArrayList vecCol = null;
ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");
ArrayList  arrCollateral=(ArrayList)hshValues.get("arrCollateral");
ArrayList  arrInvestment=(ArrayList)hshValues.get("arrInvestment");
ArrayList  arrShare=(ArrayList)hshValues.get("arrShare");
ArrayList  arrInsurance=(ArrayList)hshValues.get("arrInsurance");
ArrayList  arrPerAuto=(ArrayList)hshValues.get("arrPerAuto");	  
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
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">

</head>

<body >
<table width="98%" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="698"> 
    <!-- for displaying the application generated organisation name & address --> 
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
          <td align="center"> <b>KARNATAKA BANK LTD.</b><br>
                  <b><%=Helper.correctNull((String) hshValues.get("orgname"))%> 
                  </b> Branch<br>
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
    <!-- end -->
    <br>
      <table width="100%" border="0" cellspacing="0" cellpadding="5">
     <!--     <tr> 
          <td width="100%" align="center"><strong >KARNATAKA BANK LTD.<br>
           <%//=Helper.correctNull((String)hshValues.get("branchName"))%>  BRANCH</strong></td>
        </tr>-->
        <tr> <%if(producttype.equalsIgnoreCase("pO")){ %>
         
          <td>  <p><b>UNION SMILE PROCESS NOTE</b></p>
          </td>
          <%} else if(producttype.equalsIgnoreCase("pP")){%>
          	 <td><p><b>UNION CASH PROCESS NOTE</b></p></td>
        	  <%}%>
         
        </tr>
        <tr>
        	<td><p><b>Process note cum Sanction</b></p></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="39%" align="left">Application Inward No.</td>
                <td width="1%">:</td>
                <td align="left" width="33%"><b>&nbsp;<%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
                <td align="left" width="22%">Date of Acknowledgement:<b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
              </tr>
             <!--  <tr>  
                <td align="left" width="39%">2. Customer ID/Ref. SB/CD A/c No.</td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;</td>
              </tr>-->
              <tr> 
                <td valign="top" width="39%">1(a)  Name of the Applicant/s
                </td>
                <td valign="top" width="1%">:</td>
                <td align="left" colspan="3"> 
                  <p><b><%=Helper.correctNull((String)hshValues.get("Title"))%> 
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
                     </b> <!--<b><%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>,</b><br>
                    <b><%=Helper.correctNull((String)hshValues.get("perapp_address2"))%> 
                    ,</b><br>
                    <b><%=Helper.correctNull((String)hshValues.get("perapp_city"))%> 
                    -<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>. 
                    </b> <br>
                    <b> <%=Helper.correctNull((String)hshValues.get("perapp_state"))%></b> -->
                  </p>
                </td>
              </tr>
             <!--   <tr> 
                <td align="left" width="39%">Phone Number</td>
                <td width="1%">:</td>
                <td colspan="3"><b><%=Helper.correctNull((String)hshValues.get("perapp_phone"))%></b></td>
              </tr>
              <tr> 
                <td align="left" width="39%">Email Id</td>
                <td width="1%">:</td>
                <td colspan="3"><b><%=Helper.correctNull((String)hshValues.get("perapp_email"))%></b></td>
              </tr>-->
              <!-- 
              
              <tr> 
                <td align="left" width="39%">4. Monthly Pension amount or <br>
                  Monthly Drawing Fixed Amount<br>
                </td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr> 
                <td height="2" align="left" width="39%">5. Pension details/source 
                  of fixed Monthly Income<br>
                  a) Pension Disbursement Authority<br>
                </td>
                <td height="2" width="1%">:</td>
                <td height="2" colspan="3">&nbsp;</td>
              </tr>
              <tr> 
                <td align="left" width="39%">b) Pension SB A/c No./Branch</td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;</td>
              </tr>
              -->
              <tr>
        <td width="5%">1(b) Branch Name </td>
        <td width="1%">:</td>
          <td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("cus_org_name"))%></b></td>
      </tr>
              <tr>
        <td width="5%">2. Purpose of Loan </td>
        <td width="1%">:</td>
          <td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%></b></td>
      </tr>
      <tr>
            <td width="39%">3. Whether relevant documents furnished</td>
            <td width="1%">:</td>
            <td width="60%"><b>YES / NO
            <%--if(Helper.correctNull((String)hshValues.get("documentsfurnished")).equalsIgnoreCase("N"))
            	out.println("NO");
            else
            	out.println("YES");
            --%>
            </b></td>
          </tr>
             <tr> 
                <td align="left" width="39%">4. Eligible Loan Amount</td>
                <td width="1%">:</td>
                 <!--  <%if(Helper.correctNull((String) hshValues.get("prd_type"))=="pO"){%> 
                Smile <%}else if(Helper.correctNull((String) hshValues.get("prd_type"))=="pO")
                {%>
                	Cash
                <%} %>
                <br>
                </td>
                <td width="1%">:</td>
                <td width="5%">a)Eligible amount</td> 
                <td width="1%">:</td>
                <td width="42%">&nbsp;<b>Rs.&nbsp;<%=Helper.correctNull((String) hshValues.get("loan_margin_amt"))%></b></td>
              </tr>
              <tr> -->
                <!-- <td align="left" width="3%">&nbsp;</td>
                <td width="1%">:</td> 
                <td nowrap>b)Sanctioned amount</td>
                <td>:</td>-->
                <td>&nbsp;<b>Rs.&nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></b></td>
              </tr>
             <!--  <tr> 
                <td align="left" width="39%">5. Margin ( % and amount )</td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;<b><%//=Helper.correctNull((String) hshValues.get("loan_margin"))%>%</b></td>
              </tr> -->
              <tr> 
                <td align="left" width="39%">5. Rate of Interest</td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;<b>
                 <% if(producttype.equalsIgnoreCase("pR")) {%>
                 2% on Deposit / Commercial Rate for Third Party Deposit
                 <%}else { %>
                <%=Helper.correctNull((String) hshValues.get("mintrate"))%>
            % &nbsp;<%=Helper.correctNull((String) hshValues.get("loan_inttype"))%>
            <%} %>
            </b></td>
              </tr>
             <!--  <tr> 
                <td align="left" width="39%">7. Processing charges</td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;<b>Rs.&nbsp;<%=Helper.correctNull((String) hshValues.get("procfee"))%></b></td>
              </tr> -->
              <%
					String installment_year="";
          			installment_year = Integer.toString(curyear);
          			if(installment_year.equalsIgnoreCase("0"))
          			{
          				installment_year="";
          			}
          			
          	%>
              <tr> 
                <td align="left" width="39%">6. Repayment Schedule</td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;<b>In &nbsp;<%=no_emi%></b> months &nbsp; @ Rs.<b> <%=Helper.formatDoubleValue(emi_amt) %> </b>per installment commencing from <b><%=Months[a]%> <%=installment_year%></b></td>
              </tr>
              
              <tr>
               <%
      String auto_category=Helper.correctNull((String)hshValues.get("auto_category"));
      String auto_make=Helper.correctNull((String)hshValues.get("auto_make"));
      String auto_model=Helper.correctNull((String)hshValues.get("auto_model"));
      String auto_registration=Helper.correctNull((String)hshValues.get("auto_registration"));
      String auto_articlename=Helper.correctNull((String)hshValues.get("auto_articlename"));
      
            
      %>
      
    <!--   <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>--> 
           <% if(producttype.equalsIgnoreCase("pR")) {%>
           <tr><td colspan="4">7. Security Details</td></tr>
           <tr><td colspan="4">
           <table width="100%" border="1" cellspacing="1" cellpadding="2" bordercolorlight="#FFFFFF" bordercolordark="#DEDACF">
			<tr>
			
			<td width="6%" align="center"><font face="MS Sans Serif"
															size="1" ><b>Deposit Receipt No </b> </font>
														<td width="6%" align="center"><b><font
															face="MS Sans Serif" size="1">Amount</font></b></td>
														<td width="6%" align="center"><b><font
															face="MS Sans Serif" size="1">Date
														of Issue</font></b></td>

														<td width="6%" align="center"><b><font
															face="MS Sans Serif" size="1">Present Value </font></b></td>

														<td width="6%" align="center"><b><font
															face="MS Sans Serif" size="1">Date of Maturity </font></b></td>

														<td width="6%" align="center"><b><font
															face="MS Sans Serif" size="1">Maturity Value</font></b></td>
													</tr>
													<%
													ArrayList arrSecurity=new ArrayList();
													arrSecurity=(ArrayList)hshValues.get("arrRow");
			
			if (arrSecurity != null) {
				int vecsize = arrSecurity.size();
				for (int l = 0; l < vecsize; l++) {
					
					ArrayList arrSecCol = (ArrayList) arrSecurity.get(l);

					%>
													<%//if (Helper.correctNull((String) hshValues.get("strid")).equalsIgnoreCase(Helper.correctNull((String)g1.get(1))))%>
													<tr valign="top">
													<td width="6%" align="left">&nbsp;<%=Helper.correctNull((String) arrSecCol.get(1))%></td>

														<td width="6%" align="left">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrSecCol.get(6)))%></td>

														<td width="6%" align="left" valign="top">&nbsp; <%=Helper.correctNull((String)arrSecCol.get(5))%></td>

														<td width="6%" align="left" valign="top">&nbsp; <%=Helper.checkDecimal(Helper.correctDouble((String)arrSecCol.get(8)))%></td>

														<td width="6%" align="left">&nbsp;<%=Helper.correctNull((String) arrSecCol.get(11))%></td>

														<td width="6%" align="right">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String)arrSecCol.get(9)))%></td>
														</tr>
													<%}
			}

			%>
													
												</table>
												</td></tr>
												
           <%}else { %>
           <tr>
            <td width="39%" valign="top">7. Security Details</td>
            <td width="1%" valign="top">:</td>
            <td width="60%" height="100" valign="top">
      <%  
      if(producttype.equalsIgnoreCase("pA") && auto_category.equalsIgnoreCase("1") )
            {            	
            	out.println(" - Hypothecation of Vehicle "+auto_articlename+" & "+auto_model);           	
            }
            else if(producttype.equalsIgnoreCase("pA") && auto_category.equalsIgnoreCase("2") )
            {
            	out.println(" - Hypothecation of Vehicle "+auto_articlename+" & "+auto_registration);
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
      
      ArrayList arrInv=new ArrayList();
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
      if(vecRow!=null && vecRow.size()>0)
      {	
      	out.println("<br>");
  		out.println(" - Personal Guarantee of :-");	
  		for(int i=0;i<vecRow.size();i++)
  		{	
  			vecCol=(ArrayList)vecRow.get(i);
  			if(vecCol!=null)
  			{	
  				String title=Helper.correctNull((String) vecCol.get(0));
  				String GuarantorName=Helper.correctNull((String) vecCol.get(1));
  				String GuarantorMeans=Helper.correctNull((String) vecCol.get(9));%>
				
          			<br>
      				<b><%=title%>.&nbsp;<%=GuarantorName%></b>        
            <%}
  		}
  	}
  %>
              
            </td>
           
      <!--      </tr>
        </table>
        </td>-->
      </tr>  
              
              
              
              
         <!--      <tr> 
                <td align="left" width="39%">10. Security Details </td>
                <td width="1%">:</td>
                <td align="left" colspan="3">1.</td> 
              </tr>
              <tr> 
                <td align="left" width="39%">1. Prime </td>
                <td width="1%">&nbsp;</td>
                <td align="left" colspan="3">2.</td>
              </tr>
              <tr> 
                <td align="left" width="39%">2. Collateral/Guarantee </td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;</td>
              </tr>
              <td align="left" colspan="3">-->
              
              
            <!--   <tr> 
                <td align="left" width="39%">10.Repayment terms</td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;<b><%//=Helper.correctNull((String) hshValues.get("lreqterms"))%> (months)</b></td>
              </tr>
              <tr> 
                <td align="left" width="39%">&nbsp;</td>
                <td width="1%">&nbsp;</td>
                <td colspan="3">&nbsp;</td>
              </tr>
               <tr> 
                <td align="left" width="39%">Accepted the above terms and conditions</td>
                <td width="1%">:</td>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr> 
                <td align="left" width="39%">&nbsp;</td>
                <td width="1%">&nbsp;</td>
                <td colspan="3"> -->
             <% 
            /* ArrayList arrTerm=new ArrayList();
             if(arryRow!=null && arryRow.size()!=0)
            {
	            for(int i=0;i<arryRow.size();i++)
	            {
	            	arrTerm=new ArrayList();
	            	arrTerm=(ArrayList)arryRow.get(i);            	
	            	out.println("<br>");
	            	//out.println(arrTerm);
	            	//out.println(arrTerm.get(1));	            	
	      
         %>     
             
                <%= i+1+")"+arrTerm.get(1) %>
                
          <%            }	            
            }
             */    
            %>  
           
            
            </table>
          </td>
        </tr>
        
        <%} %>
       <!--  <tr> 
          <td height="150" valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="15">
              <tr> 
                <td width="50%"> 
                  <p>Signature of Applicant:</p>
                  <p>&nbsp;</p>
                  <p>Signature of Guarantor:</p>
                </td>
                <td width="50%"> 
                  <p>for Karnataka Bank Ltd. </p>
                  <p>&nbsp;</p>
                  <p>Chief/Branch Manager</p>
                </td>
              </tr>-->
              <tr>
          <td> 
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
