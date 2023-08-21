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
 ArrayList  arrEMI=(ArrayList)hshValues.get("arrEmi");	  
 ArrayList arrUptomonths=(ArrayList)hshValues.get("arrUptomonths");	
 String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
 	
 
%>
<html>
<head>
<title>Sanction Letter for Home scheme</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
      	<tr> 
          <td colspan="2" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
         </tr>
        <tr> 
          <td colspan="2" align="center"><b><font size="3" face="MS Sans Serif">
          		KARNATAKA BANK LTD.</font></b></td>
          		
         </tr>
         <tr>
          <td colspan="2" align="center"><b><strong>
           	<%=Helper.correctNull((String) hshValues.get("branchName"))%> &nbsp; Branch</strong></b>
          </td>
        </tr>
        <tr> 
    <td align="center" colspan="2"><strong> <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      . <br> Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></strong>
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
          <td align="center">
            <p>To:<br>
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
        				 &nbsp; &nbsp;<b><%=title%>.&nbsp;<%=CoApplicantName%></b><br>
        <%			}
        		}
        	}%>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_address1"))%></b><br>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_address2"))%></b><br>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_city"))%> -<b><%=Helper.correctNull((String) hshValues.get("perapp_zip"))%></b></b><br>
              &nbsp; <b><%=Helper.correctNull((String) hshValues.get("perapp_state"))%></b><br>
              
            </p>
            <p>Dear Sir / Madam,<br>
            </p>
            <span align="center"><b>SUB: HOME SCHEME </b><br>
              <u>Conveying of sanction Terms and conditions<br>
              <br>
              </u> </span>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="4%">&nbsp;</td>
                <td width="96%"><p>With reference to your loan application dated 
                  &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%></b> 
                  we are pleased to inform you that a Term Loan of Rs.&nbsp;<b><%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b> 
                  (Rupees &nbsp;<b><%=Helper.figtoWords(Helper.correctNull((String) hshValues.get("sancamount")))%></b>) 
                  is sanctioned to you for the purpose of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%></b> 
                  under  Home Scheme on the following terms and conditions: </p>
                </td>
              </tr>
              <tr> 
                <td width="4%" valign="top">1)</td>
                <td width="96%"> 
                <%if(Helper.correctNull((String) hshValues.get("loan_inttype")).equalsIgnoreCase("Combo")) {%>
                <p align="justify">ROI @ <b><%=Helper.correctNull((String) hshValues.get("mintrate"))%></b>% 
                    will be applicable for the first three years and from fourth year onwards floating rate 
                    linked to then prevailing BPLR will be applicable.
                  </p>
                 <%}else{ %>
                  <p align="justify">A <b><%=Helper.correctNull((String) hshValues.get("loan_inttype"))%></b> interest of &nbsp;<b><%=Helper.correctNull((String) hshValues.get("mintrate"))%></b>% 
                    per annum(i.e)------------------below/above Base Rate of the bank  at monthly rests will be charged  
                  </p>
                 <%} %>
                </td>
              </tr>
              <tr> 
                <td width="4%" valign="top">2)</td>
                <td width="96%"> 
                  <p align="justify"> The loan amount with margin money will be 
                    released directly in the name of the Builder Contractor / 
                    Supplier of material by way of a Demand Draft / Pay Order 
                    depending on the progress of work / construction. In case 
                    of Outright Purchase the amount will be paid directly to the 
                    seller by DO/PO after execution of the Sale Deed.<br>
                  </p>
                </td>
              </tr>
              <tr> 
                <td width="4%" vallign="top">3)</td>
                <td width="96%">
                  <p valign="justify">The following security documents are to be 
                    executed at the time of disbursement of loan:</p>
                  
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
        
        <%if(Helper.correctNull((String) hshValues.get("loan_inttype")).equalsIgnoreCase("Combo")) {
        	String dates=Helper.correctNull((String) hshValues.get("emidate1"));
        	int Month=0;
        	int year=0;
        	if(!dates.equals(""))
        	{
           	  	StringTokenizer tokenizer1 = new StringTokenizer(dates, "/");
        	  	while (tokenizer1.hasMoreTokens()) 
        	  	{
        	  		Month=Integer.parseInt(Helper.correctInt((String)tokenizer1.nextToken()).trim());
        	  		year=Integer.parseInt(Helper.correctInt((String)tokenizer1.nextToken()).trim());
        	  	}
			}
        
        
        %>
        <tr> 
                <td width="4%" valign="top">4)</td>
                <td width="96%"><p>The Loan is repayable in&nbsp;<b><%=val%></b>  &nbsp;
                  Equated <b><%=installment%> </b> &nbsp; installments of 
                  
                  <%
                    if(arrEMI!=null && arrEMI.size()!=0)
                    {
        	            for(int i=0;i<arrEMI.size();i++)
        	            {%>
        	           
        	            	<%
        	            	if(i==0)
        	            	{
        	            		out.print("@ Rs. <b>"+arrEMI.get(i)+"</b>&nbsp;per installment commencing");
        	            		out.print(" from <b>"+Helper.correctNull((String)hshValues.get("emidate"))+"</b>&nbsp;for&nbsp;<b>"+arrUptomonths.get(i)+"</b> Months");
        	            	}
        	            	else
        	            	{
        	            		out.print(" and thereafter @ Rs. <b>"+arrEMI.get(i)+"</b>&nbsp;per installment commencing  from <b>");
        	            		if(Month!=0 && year!=0)
        	            		{
        	            			int valMonth1=0;
        	            			int valMonth2=0;
        	            			Month=Month+Integer.parseInt(arrUptomonths.get(i-1).toString());
        	            			if(Month>12)
        	            			{
        	            				valMonth1=Month/12;
        	            			 	valMonth2=Month%12;
        	            			 	if(valMonth2==0)
        	            			 	{
        	            					Month=12;
        	            				}
        	            			 	else
        	            			 	{	 
        	            					int temp=valMonth1*12;
        	            					year=(valMonth1)+year;
        	            					Month=Month-temp;
        	            				}
        	            			}
        	            			out.print(Months[Month] +"   "+ year);
        	            		}
        	            		out.print("</b>&nbsp;for&nbsp;<b>");
        	            		out.print(Integer.parseInt(arrUptomonths.get(i).toString())-Integer.parseInt(arrUptomonths.get(i-1).toString())+"</b> Months");
        	            	}
        	            	
        	            	%>
        	           	            	
        	           <%}	            
                    }
                	%>
                  
                  (The total repayment period includes the period of moratorium)</p>
                   </td>
              </tr>
        
        
        
        <%}else{ %>
        
              <tr> 
                <td width="4%" valign="top">4)</td>
                <td width="96%"><p>The Loan is repayable in&nbsp;<b><%=val%></b>  &nbsp;
                  Equated <b><%=installment%> </b> &nbsp; installments of Rs.&nbsp;<b><%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("loan_emi"))))%></b> 
                 &nbsp; commencing from <b><%=Helper.correctNull((String) hshValues.get("emidate"))%> </b>  &nbsp;month (after moratorium period 
                  if any given) (The total repayment period includes the period 
                  of moratorium) </p></td>
              </tr>
          <%} %>    
              <tr> 
                <td width="4%">5)</td>
                <td width="96%"><p>A moratorium period of&nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_noofinstallment"))%></b> 
                  &nbsp;months is allowed. </p></td>
              </tr>
              <tr> 
                <td width="4%">6)</td>
                <td width="96%"><p>A penal interest @ 2% will be levied on the overdue 
                  installment if any.</p></td>
              </tr>
              <tr> 
                <td width="4%">7)</td>
                <td width="96%"><p>Insurance of the building/house/fiat besides covering 
                  personal accident benefit is to be provided .</p></td>
              </tr>
              <!-- Guarantor Name & Means -->
              <tr> 
                <td width="4%">8)</td>
                    
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
      
		                  with means of Rs.<b><%=Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(GuarantorMeans)))%> Lacs</b>&nbsp;is to be provided in lieu 
		                  of the interim security (wherever stipulated)</td>
                  	   </tr>
                  <%}
        		}
        	}
        	else
        	{%>
                <td width="96%">Personal guarantee of	with means of Rs. is to be provided in lieu of the interim security (wherever stipulated)</td>
        	<%}
        %>
              <tr> 
                <td width="4%" valign="top">9)</td>
                <td width="96%"><p>Processing charges of Rs. &nbsp;<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b>	
                  &nbsp;is to be paid before availment of loan.</p></td>
              </tr>
            
              <tr> 
                <td width="4%" valign="top">9)</td>
                <td width="96%">An irrevocable undertaking from your Employer 
                  is to be submitted to recover the EMIs directly from your salary 
                  every month and to remit the proceeds regularly to Bank.</td>
              </tr>
              <tr> 
                <td width="4%" valign="top">10)</td>
                <td width="96%">An irrevocable undertaking from your Employer 
                  to adjust the loan dues if any, directly from the Terminal benefits 
                  payable to you in case of any eventually / cessation in service 
                  by you or not to release terminal benefits until no dues certificates 
                  is produced from the bank</td>
              </tr>
              
              <tr> 
                <td width="4%" valign="top">11)</td>
                <td width="96%">Equitable / Simple Mortgage of the property purchased 
                  / constructed with Bank finance along with notarized declaration 
                  to be created</td>
              </tr>
              <tr> 
                <td width="4%"  valign="top">12)</td>
                <td width="96%">Interest charged during moratorium to be serviced 
                  every month. In case of failure to service the interest regularly 
                  every month, the interest accrued during the moratorium will 
                  be added to the principal amount and EMI will be re-fixed accordingly.</td>
              </tr>
              <tr> 
                <td width="4%" valign="top">13)</td>
                <td width="96%"> 
                  <p align="justify">All other terms and conditions as applicable 
                    to the scheme from time to time.</p>
                 
              
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
                       %><br><br>
             </td>
              
              </tr>
              <tr>
                <td width="4%" valign="top">14)</td>
                <td width="96%">We now request you to convey your acceptance (or) 
                  otherwise of the above terms and conditions and call on us any 
                  working day to enable us to disburse the loan after proper documentation. 
                </td>
              </tr>
            </table>
            <p align="center"><br>
            
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
                          
                        </table>
                        <table width="98%" border="0" cellspacing="0" cellpadding="5">
                      <br><br><br>
                          
                            
                          <tr> 
                            <td width="59%">Date: <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
                            <td width="41%">Date: <b><%//=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
                          </tr>
                        </table>
                        <p>&nbsp;</p>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp;</p>
                  <p>&nbsp; </p>
                  <p>&nbsp; </p>
                </td>
              </tr>
            </table>
            <p align="center"><br>
            </p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
