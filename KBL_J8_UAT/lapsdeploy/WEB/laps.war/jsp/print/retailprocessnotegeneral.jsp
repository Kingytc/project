<%@include file="../share/directives.jsp"%>
<%String producttype=Helper.correctNull((String)hshValues.get("prd_type"));
String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
	
	 ArrayList vecCoApp_col = null;
	 ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
	 ArrayList vecCol = null;
	 ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");	 
	 ArrayList  arrCollateral=(ArrayList)hshValues.get("arrCollateral");
	 ArrayList  arrInvestment=(ArrayList)hshValues.get("arrInvestment");
	 ArrayList  arrInsurance=(ArrayList)hshValues.get("arrInsurance");
	 ArrayList  arrPerAuto=(ArrayList)hshValues.get("arrPerAuto");	   
	 ArrayList  arrProposed=(ArrayList)hshValues.get("arrProposed");	   
	 ArrayList  arrAsset=(ArrayList)hshValues.get("arrAsset");	
	 ArrayList  arrInterest=(ArrayList)hshValues.get("arrInterest");	   
	 ArrayList  arrUpto=(ArrayList)hshValues.get("arrToTenor");	  
	 ArrayList  arrEMI=(ArrayList)hshValues.get("arrEmi");	  
	 ArrayList arrUptomonths=(ArrayList)hshValues.get("arrUptomonths");	  
	 ArrayList arrRow=(ArrayList)hshValues.get("mailcomments");%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">	
<script>
var score="<%=Helper.correctNull((String)hshValues.get("scoreobtained"))%>";
var product="<%=producttype%>";
function callOnload()
{	
	if(score=="")
	{
		alert("Scoring Chart is not Prepared");
	}
}
</script>	
</head>
<body onLoad="callOnload()">
<table width="98%" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
    <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr align="center">
    <td ><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg">
    </td>
    </tr>
      <tr align="center" > 
                <td align="center"> <b>KARNATAKA BANK LTD.</b><br>
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
			
  <tr>
    <td><table width="100%" border="0" cellpadding="5" cellspacing="0">
      <tr>
        <td><strong>Process note cum Sanction </strong><br></td>
      </tr>
	  <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
         <tr>
                <td width="50%" > Application Inward No.: <b><%=Helper.correctNull((String) hshValues.get("appno"))%></b>
                </td>
		        <td width="50%" align="right"> Date of Acknowledgement <b><%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%></b></td>
		   </tr>
		 
		   </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%" valign="top">1(a) Name of the Applicant/s</td>
            <td width="1%" valign="top">:</td>
                <td width="60%" >&nbsp;<b><%=Helper.correctNull((String)hshValues.get("Title"))%>&nbsp;<%=Helper.correctNull((String)hshValues.get("appname"))%></b><br>
                <% if(vecCoApp_Row!=null){
        		for(int i=0;i<vecCoApp_Row.size();i++)
        		{
        			vecCoApp_col=(ArrayList)vecCoApp_Row.get(i);
        			if(vecCoApp_col!=null)
        			{	
        				String title=Helper.correctNull((String) vecCoApp_col.get(0));
        				String CoApplicantName=Helper.correctNull((String) vecCoApp_col.get(1));%>
        				<b>&nbsp;<%=title%>.&nbsp;<%=CoApplicantName%></b><br>
        <%}}}%>
                </td>
          </tr>
        </table>          </td>
      </tr>
      <tr>
      	 <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%" valign="top">1(b) Branch Name</td>
            <td width="1%" valign="top">:</td>
                <td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("cus_org_name"))%> </b></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%" valign="top">2. Purpose of Loan</td>
            <td width="1%" valign="top">:</td>
                <td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%> </b></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%" valign="top">3. Investment Grade Points Scored(Minimum 40%)</td>
            <td width="1%" valign="top">:</td>
                <td width="60%" valign="top"><b><%=Helper.correctNull((String)hshValues.get("scoreobtained"))%>% </b></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%" valign="top">4. Whether relevant documents furnished</td>
            <td width="1%" valign="top">:</td>
            <td width="60%" valign="top"><b>YES / NO </b></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%">5. Eligible Loan Amount</td>
            <td width="1%">:</td>
                <td width="60%"><b>Rs.<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b>
                  </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%" valign="top">6. Rate of Interest</td>
            <td width="1%" valign="top">:</td>
                <td width="60%" valign="top">
                <%if(Helper.correctNull((String) hshValues.get("loan_inttype")).equalsIgnoreCase("Combo")){%>
                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                	<tr>
                	<td>
                	<%
                    if(arrInterest!=null && arrInterest.size()!=0)
                    {
        	            for(int i=0;i<arrInterest.size();i++)
        	            {
        	            	if(i==0){
        	            	out.println("<b>"+arrInterest.get(i)+ "%</b> for <b>"+ arrUpto.get(i) + " Months </b>"); 	            	
        	            	}
        	            	else
        	            	{
        	            		out.println("<br><b>"+arrInterest.get(i)+ "%</b> Beyond&nbsp;<b>"+arrUpto.get(i-1)+"&nbsp;Months</b> Upto <b>");
        	            		if(arrInterest.size()==(i+1))
        	            		{
        	            			out.println(Helper.correctNull((String) hshValues.get("lreqterms")) + " Months </b>"); 	
        	            		}
        	            		else
        	            		{
        	            			out.println(arrUpto.get(i) + " Months </b>"); 	
        	            		}
        	            	}
        	            	
        	            }	            
                    }
                	%>
                	</td>
                	</tr>
                </table>
                <%}else{ %>
                <b><%=Helper.correctNull((String) hshValues.get("mintrate"))%>% &nbsp;<%=Helper.correctNull((String) hshValues.get("loan_inttype"))%>
                  </b>
                  <%} %></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%" valign="top">7. Repayment Schedule</td>
            <td width="1%" valign="top">:</td>
                <td width="60%">In <b><%=Helper.correctNull((String) hshValues.get("lreqterms"))%></b> 
                  Months (Incl. Moratorium period)<br>
                  <%if(Helper.correctNull((String) hshValues.get("loan_inttype")).equalsIgnoreCase("Combo")){
                	
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
                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                	 <tr>
        	            <td>
                	
                	<%
                    if(arrEMI!=null && arrEMI.size()!=0)
                    {
        	            for(int i=0;i<arrEMI.size();i++)
        	            {%>
        	           
        	            	<%
        	            	if(i==0)
        	            	{
        	            		out.print("@ Rs. "+arrEMI.get(i)+"&nbsp;per installment commencing");
        	            		out.print("<br> from "+Helper.correctNull((String)hshValues.get("emidate"))+"&nbsp;for&nbsp;"+arrUptomonths.get(i)+" Months");
        	            	}
        	            	else
        	            	{
        	            		out.print(" and thereafter <br><b>*</b>@ Rs. "+arrEMI.get(i)+"&nbsp;per installment commencing <br> from ");
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
        	            		out.print("&nbsp;for&nbsp;");
        	            		out.print(Integer.parseInt(arrUptomonths.get(i).toString())-Integer.parseInt(arrUptomonths.get(i-1).toString())+" Months");
        	            	}
        	            	
        	            	%>
        	           	            	
        	           <%}
        	            out.println("<b>*</b> Based on present interest rate. However EMI will be based on the then interest prevailing after 36 months.");
                    }
                	%>
                	 </td> 
        	            </tr>
                	
                </table>
                <%}else{ %>
                  @ Rs. <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("loan_emi"))))%></b> 
                  per installment commencing<br>
              from <b><%=Helper.correctNull((String)hshValues.get("emidate"))%><%//=Months[a]%> <%//=installment_year%></b>&nbsp;  Month.
              <%} %>
              </td>
          </tr>
        </table></td>
      </tr>
      <tr>
      <%
      String auto_category=Helper.correctNull((String)hshValues.get("auto_category"));
      String auto_make=Helper.correctNull((String)hshValues.get("auto_make"));
      String auto_model=Helper.correctNull((String)hshValues.get("auto_model"));
      String auto_registration=Helper.correctNull((String)hshValues.get("auto_registration"));
      String auto_articlename=Helper.correctNull((String)hshValues.get("auto_articlename"));
      
            
      %>
      
      
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td width="39%" valign="top">8. Security Details</td>
            <td width="1%" valign="top">:</td>
            <td width="60%" height="100" valign="top">
            <%
            if(producttype.equalsIgnoreCase("pA") && auto_category.equalsIgnoreCase("1") )
            {   
            	
            	out.println(" - Hypothecation of Vehicle "+auto_articlename+", "+ auto_make +" & "+auto_model);           	
            }
            else if(producttype.equalsIgnoreCase("pA") && auto_category.equalsIgnoreCase("2") )
            {
            	
            	out.println(" - Hypothecation of Vehicle "+auto_articlename+" & "+auto_registration);
            }
            
            if(producttype.equalsIgnoreCase("pD") && Helper.correctNull((String)hshValues.get("loan_secure")).equalsIgnoreCase("S"))
            {  
 				ArrayList arrAss=new ArrayList();
                 
                 if(arrAsset!=null && arrAsset.size()!=0)
                 {
     	            for(int i=0;i<arrAsset.size();i++)
     	            {
     	            	arrAss=new ArrayList();
     	            	arrAss=(ArrayList)arrAsset.get(i);            	
     	            	out.println("<br>");
     	            	out.println(" - Hypothecation of asset <b>"+Helper.correctNull((String)arrAss.get(0)) +"</b>"); 	            	
     	            	out.println("<br>");
     	            	
     	            }	            
                 }            	          	
            }
            
           if(producttype.equalsIgnoreCase("pH"))
            {            	
            	String InterimSecurity="";
     	        out.println("<br>");
     	        out.println(" - Equitable / Simple Mortgage of the property situated at "+Helper.correctNull((String)hshValues.get("prop_houseno"))+" , "+Helper.correctNull((String)hshValues.get("prop_area"))+" , "+Helper.correctNull((String)hshValues.get("prop_housingaddress"))+" , "+Helper.correctNull((String)hshValues.get("prop_city"))+" , "+Helper.correctNull((String)hshValues.get("prop_pin")));
     	            	
            	InterimSecurity=Helper.correctNull((String)hshValues.get("prop_intermsecurity"));
            	if(!InterimSecurity.equalsIgnoreCase(""))
            	{
            		out.println("<br>");
   	            	out.println(" - Interim Security "+Helper.correctNull((String)hshValues.get("prop_intermsecurity")));
            	}
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
           
          </tr>
        </table></td>
      </tr>
      <tr>
      	<td>
      		<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
      			
       			<%if(arrRow!=null && arrRow.size()>0)
          				{%>
          			<tr>
            		<td colspan="3" align="center" class="td_bg"><strong>Recommended for Sanction</strong></td>
       			</tr>	
       				<%
          				for(int i=0; i<arrRow.size();i++)
          					{
          					ArrayList arrCol=new ArrayList();
          					arrCol=(ArrayList)arrRow.get(i);
       					%>
   					 <tr>
			            <td valign="top"><%=arrCol.get(0)%>&nbsp;</td>
            			<td valign="top">:&nbsp;</td>
			            <td valign="top"><P><%=arrCol.get(1)%>&nbsp;</P></td>
			         </tr>
			          <% 
            			}%>
			            <%}
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
          			</table>
          		</td>
          	</tr>
          	<tr>
			     	<td colspan="3" align="center" class="td_bg"><strong>Sanctioned / Declined</strong></td>
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
            				<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("sancauth"))%></td>
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
			</td>
		</tr>
	</table>
</td>
</tr>
</table></td>
</tr>
</table>
</body>
</html>
