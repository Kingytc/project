<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%!
   double AmtReq,margin=0.00;
%>

<%
	ArrayList arrydocCol = null;
	ArrayList arrydocRow = (ArrayList) hshValues.get("arrDocsId");
	String producttype=Helper.correctNull((String)hshValues.get("prd_type"));	
 
    double land1=0.00;
    double build1 =0.00;
    double tot_land_build=0.00;
    
    String loc_prop=Helper.correctNull((String)hshValues.get("prop_type"));
    if(loc_prop.equalsIgnoreCase("1"))
    {
    	loc_prop="Metro";
    }
    if(loc_prop.equalsIgnoreCase("2"))
    {
    	loc_prop="Urban";
    }
    if(loc_prop.equalsIgnoreCase("3"))
    {
    	loc_prop="Semi Urban";
    }
    if(loc_prop.equalsIgnoreCase("4"))
    {
    	loc_prop="Rural";
    }
    
    
    String prd_loantype=Helper.correctNull((String)hshValues.get("prd_loantype"));
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
		
		String prop_nature=Helper.correctNull((String)hshValues.get("prop_nature"));
		if(prop_nature.equalsIgnoreCase("C"))
		{
			prop_nature="Commercial";
		}
		else if(prop_nature.equalsIgnoreCase("R"))
		{
			prop_nature="Residential";
		}
		else if(prop_nature.equalsIgnoreCase("s"))
		{
			prop_nature="";
		}
		
		
		String land=Helper.correctNull((String)hshValues.get("prop_mar_land"));
		if((land.equalsIgnoreCase("")||land.equalsIgnoreCase("null")))
    	{
			land="0.00";
    	}
    	land1=Double.parseDouble(land);
    	
		String build=Helper.correctNull((String)hshValues.get("prop_mar_build"));
    	if((build.equalsIgnoreCase("")||build.equalsIgnoreCase("null")))
    	{
    		build="0.00";
    	}
    	build1=Double.parseDouble(build);
		
    	tot_land_build=land1+build1;
    	
    	// Nature of Facility 
    	String facility_type=Helper.correctNull((String)hshValues.get("loan_facility"));	
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

//Margin Calculation
double mar_borrowed1=0.00,mar_offered1=0.00,display_margin=0.00;
String mar_borrowed=Helper.correctNull((String)hshValues.get("offeredmargin"));	
String mar_offered=Helper.correctNull((String)hshValues.get("downpay"));	    	

  if((mar_borrowed.equalsIgnoreCase("")||mar_borrowed.equalsIgnoreCase("null")))
	{
	  mar_borrowed="0.00";
	}
  if((mar_offered.equalsIgnoreCase("")||mar_offered.equalsIgnoreCase("null")))
	{
	  mar_offered="0.00";
	} 
  mar_borrowed1=Double.parseDouble(mar_borrowed);
  mar_offered1=Double.parseDouble(mar_offered);
  if(mar_borrowed1 >= mar_offered1)
  {
	  display_margin=mar_borrowed1;
  }
  else
  {
	  display_margin=mar_offered1;
  }  
  
    	
		 ArrayList vecCoApp_col = null;
		 ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
		 
		 ArrayList  arrCollateral=(ArrayList)hshValues.get("arrCollateral");
		 ArrayList arrRow=(ArrayList)hshValues.get("mailcomments");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>UBI</title>
	
<script>

function onloading()
{
	var score="<%=Helper.correctNull((String) hshValues.get("scoreobtained"))%>";
	if(score=="")
	{
		alert("Scoring Chart is not Prepared");	
	}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>

<body onload="onloading()">
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
    <br>
      <table width="100%" border="0" cellspacing="0" cellpadding="5"  bordercolor="#999999">
        <tr> 
          <td colspan="2" class="td_bg"><strong>PROCESS CUM SANCTION</strong></td>
        </tr>
        <tr> 
          <td width="40%">1(a)  Name of the Applicant/s</td>
          <td width="60%">&nbsp;<b> <%=Helper.correctNull((String)hshValues.get("Title"))%><%=Helper.correctNull((String)hshValues.get("appname"))%></b><br>
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
          <td>1(b) Branch Name </td>
          <td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("cus_org_name"))%></b></td>
        </tr>
        <tr> 
          <td>2. Means of the Applicant/s &nbsp;<b>(Rs. in Lacs)</b></td>
          <td>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CR_Total_MEANS"))))%><br>
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
          <td>3. Purpose of Loan </td>
          <td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%></b></td>
        </tr>
        <tr> 
          <td>4. <strong>Details of property offered as prime security: </strong></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <p>&nbsp;&nbsp;&nbsp;a. Nature of Property 
          </td>
          <td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("prop_housetype"))%></b></td>
        </tr>
        <tr> 
          <td>&nbsp;&nbsp;&nbsp;b. Area / Location / Address </td>
          <td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("prop_areaofplot"))%> 
            / <%=loc_prop%> / <%=Helper.correctNull((String)hshValues.get("prop_area"))%></b></td>
        </tr>
        <tr> 
          <td>&nbsp;&nbsp;&nbsp;c. Whether residential / Commercial </td>
          <td>&nbsp;<b><%=prop_nature%></b></td>
        </tr>
        <tr> 
          <td>&nbsp;&nbsp;&nbsp;d. Present market value of the property </td>
          <td>&nbsp;<b><%=Helper.formatDoubleValue(tot_land_build)%></b></td>
        </tr>
        <tr> 
          <td>4. Date of inspection of the property</td>
          <td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("pre_visitdate"))%></b></td>
        </tr>
        <tr> 
          <td>5. Whether the value of the property as per valuation report is 
            reasonable</td>
          <td>&nbsp;Yes/No</td>
        </tr>
        <tr> 
          <td>6. Nature &amp; Amount of Loan requested </td>
          <td>&nbsp;<b><%=facility_type%></b>&nbsp;&amp;&nbsp;<b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("amtreqd"))))%></b></td>
        </tr>
        <tr> 
          <td>7. Margin </td>
          <td><b>Rs.&nbsp;<%=Helper.formatDoubleValue(display_margin)%></b></td>
        </tr>
        <tr> 
          <td>8. Eligible amount of loan </td>
          <td><b>Rs.&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%> 
            </b></td>
        </tr>
        <tr> 
          <td>9. Amount of Loan recommended </td>
          <td> <b>Rs.&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%></b> 
          </td>
        </tr>
        <tr> 
          <td>10. Investment grade points scored(Minimum 40%) </td>
          <td><b>&nbsp;<%=Helper.correctNull((String) hshValues.get("scoreobtained"))%>&nbsp;</b></td>
        </tr>
        <tr> 
          <td>11. Rate of Interest [as per option exercised by the applicant/s 
            ] </td>
          <td><b>&nbsp;<%=Helper.correctNull((String) hshValues.get("mintrate"))%>&nbsp;% 
            - &nbsp;<%=Helper.correctNull((String) hshValues.get("loan_inttype"))%><b> 
          </td>
        <tr> 
          <%
      String auto_category=Helper.correctNull((String)hshValues.get("auto_category"));
      String auto_make=Helper.correctNull((String)hshValues.get("auto_make"));
      String auto_model=Helper.correctNull((String)hshValues.get("auto_model"));
      String auto_registration=Helper.correctNull((String)hshValues.get("auto_registration"));
      String auto_articlename=Helper.correctNull((String)hshValues.get("auto_articlename"));
      
            
      %>
          <!--  <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>-->
          <td width="39%" valign="top">12. Collateral Security </td>
          <td width="60%" height="100" valign="top">&nbsp; 
            <%if(producttype.equalsIgnoreCase("pA") && auto_category.equalsIgnoreCase("1") )
            {            	
            	out.println("  Hypothecation of Vehicle "+auto_articlename+" & "+auto_model);           	
            }
            else if(producttype.equalsIgnoreCase("pA") && auto_category.equalsIgnoreCase("2") )
            {
            	out.println("  Hypothecation of Vehicle "+auto_articlename+" & "+auto_registration);
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
			            	out.println(" - Owned by "+Helper.correctNull((String)arrColl.get(6))+" "+"valued");
			            	out.println(" Rs. "+Helper.correctNull((String)arrColl.get(9))+"[as per value given by approved valuer of the bank]");
			            }	            
		            }
            
		            
          /*  ArrayList arrInv=new ArrayList();
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
        	}*/
        %>
          </td>
          <!--   </tr>
        </table></td>-->
        </tr>
        <tr> 
          <td valign="top">13. Documents to be obtained</td>
          <td><b> 
            <% 
                     if(arrydocRow!=null)
                     {
                       for(int i=0;i<arrydocRow.size();i++)
                       {				
                    	  arrydocCol=(ArrayList)arrydocRow.get(i);
							if(arrydocCol!=null)
							{
							%>
            <br>
            <b><%=i+1%>)&nbsp;<%=Helper.correctNull((String)arrydocCol.get(0))%></b> 
            <%
							}
                       }
                       	}
                       %>
          </td>
        </tr>
        <tr> 
          <td valign="top">14. Processing Charges</td>
          <td><b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b> 
            of the loan amount excluding Service Tax</td>
        </tr>
        <tr> 
          <td valign="top" colspan="2">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="2" valign="top"><br />
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <%if(arrRow!=null && arrRow.size()>0)
          				{
          				for(int i=0; i<arrRow.size();i++)
          					{
          					ArrayList arrCol=new ArrayList();
          					arrCol=(ArrayList)arrRow.get(i);
       					%>
              <% 
            			}
			            }
          				%>
              <tr> 
                <td align="center" colspan="2">
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
                </td>
              </tr>
            </table>
            <br />
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
