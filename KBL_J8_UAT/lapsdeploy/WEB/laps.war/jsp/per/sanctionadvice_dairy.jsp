<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<laps:handleerror />
<%
ArrayList arrRow=new ArrayList(); 
HashMap hshValues1=new HashMap();
String prd_type=Helper.correctNull((String)hshValues.get("prdtype"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="80%" border="0" cellspacing="0" cellpadding="3" align="center">
  <tr> 
    <td colspan="7"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
        </tr>
        <tr> 
          <td align="center"><b><%=Helper.correctNull((String) hshValues.get("org_name"))%><br>
            <%=Helper.correctNull((String) hshValues.get("orgadd1"))%>, <%=Helper.correctNull((String) hshValues.get("orgadd2"))%>, 
            <%=Helper.correctNull((String) hshValues
									.get("orgcity"))%>, <%=Helper.correctNull((String) hshValues
							.get("orgstate"))%>, <%=Helper.correctNull((String) hshValues.get("orgzip"))%>. 
            <br>
            Tel No :<%=Helper.correctNull((String) hshValues.get("orgphone"))%> 
            </B> 
            <hr/>
          </td>
        </tr>
        <tr> 
          <td align="center"><u><b>Sanction Advice</b></u></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="5"><b>Sanction Advice No :&nbsp;</b>&nbsp;<%=Helper.correctNull((String)hshValues.get("appno"))%></td>
    <td align="right" width="12%"><b>&nbsp;Date :</b></td>
    <td width="15%"><b><%=Helper.correctNull((String) hshValues.get("app_processdate"))%></b></td>
  </tr>
  <tr> 
    <td width="2%" valign="top" rowspan="1"><b>1)</b></td>
    <td width="14%" valign="top"><b>Borrower's Name and Address </b></td>
    <td width="2%" valign="top">:</td>
    <td colspan="4"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr> 
          <td width="85%"><%=Helper.correctNull((String)hshValues.get("perapp_title")) %><b>. 
            </b><%=Helper.correctNull((String)hshValues.get("perapp_fname")) %> 
            &amp; 
            <%		
          	ArrayList vecReport1 = new ArrayList();
			vecReport1 = (ArrayList) hshValues.get("vecReport");
			if (vecReport1 != null && vecReport1.size()>0) 
			{
			%>
            <%for (int l = 0; l < vecReport1.size(); l++) 
			{
				ArrayList b1 = null;
				b1 = (ArrayList) vecReport1.get(l);
			%>
            <%=Helper.correctNull((String) b1.get(0))%><b>. </b><%=Helper.correctNull((String) b1.get(1))%> 
            <%if(l < vecReport1.size()-1){%>
            &amp; 
            <%} %>
            <% }}%>
          </td>
        </tr>
        <%if(!Helper.correctNull((String)hshValues.get("perapp_address1")).equalsIgnoreCase("")){ %>
        <tr> 
          <td width="85%"> <%=Helper.correctNull((String)hshValues.get("perapp_address1")) %><b>,</b> 
          </td>
        </tr>
        <%}%>
        <%if(!Helper.correctNull((String)hshValues.get("perapp_address2")).equalsIgnoreCase("") && !Helper.correctNull((String)hshValues.get("perapp_address3")).equalsIgnoreCase("")){ %>
        <tr> 
          <td width="85%"><%=Helper.correctNull((String)hshValues.get("perapp_address2")) %><%=Helper.correctNull((String)hshValues.get("perapp_address3"))%>, 
          </td>
        </tr>
        <%} %>
        <%if(!Helper.correctNull((String)hshValues.get("perapp_city")).equalsIgnoreCase("")){ %>
        <tr> 
          <td width="85%"><%=Helper.correctNull((String)hshValues.get("perapp_city")) %>, 
          </td>
        </tr>
        <%}%>
        <%if(!(Helper.correctNull((String)hshValues.get("perapp_phone")).trim()).equalsIgnoreCase("")){ %>
        <tr> 
          <td width="85%"><%=Helper.correctNull((String)hshValues.get("perapp_phone")) %>, 
          </td>
        </tr>
        <%} %>
        <%if(!Helper.correctNull((String)hshValues.get("perapp_zip")).equalsIgnoreCase("")){ %>
        <tr> 
          <td width="85%"><b>pincode :</b> <%=Helper.correctNull((String)hshValues.get("perapp_zip")) %>. 
          </td>
        </tr>
        <%} %>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="2%" valign="top"><b>2)</b></td>
    <td width="14%" valign="top"><b>Means of the Borrower(s)</b></td>
    <td width="2%" valign="top">:</td>
    <td colspan="4"> 
      <div id="top"> 
        <table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr class="tblhead"> 
            <td>Name</td>
            <td>Means</td>
            <td>As on</td>
          </tr>
          <tr> 
            <td><%=Helper.correctNull((String)hshValues.get("perapp_title"))%>.<%=Helper.correctNull((String)hshValues.get("perapp_fname"))%></td>
            <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("applntmeans"))))%></td>
            <td><%=Helper.correctNull((String)hshValues.get("applntmeansason"))%></td>
          </tr>
          <%
  			if (vecReport1 != null && vecReport1.size()>0) 
  			{
  				for (int l = 0; l < vecReport1.size(); l++) 
  				{
  					ArrayList b1 = null;
  					b1 = (ArrayList) vecReport1.get(l);
  			%>
          <tr> 
            <td><%=Helper.correctNull((String) b1.get(0))%>.<%=Helper.correctNull((String) b1.get(1))%></td>
            <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(2))))%></td>
            <td><%=Helper.correctNull((String) b1.get(3))%></td>
          </tr>
          <%}} %>
        </table>
      </div>
    </td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%"><b>Established</b></td>
    <td width="2%">:</td>
    <td width="20%"><%=Helper.correctNull((String)hshValues.get("peremp_establish"))  %></td>
    <td width="12%">&nbsp;</td>
    <td width="12%">Constitution:</td>
    <td width="15%"><b><%=Helper.correctNull((String)hshValues.get("constitutiondesc"))  %></b></td>
  </tr>
  <tr> 
    <td width="2%" valign="top"><b>3)</b></td>
    <td width="14%" valign="top"><b>Name &amp; Means of the Guarantor(s)</b></td>
    <td width="2%" valign="top">:</td>
    <td colspan="4" valign="top"> 
    <% 
    vecReport1=new ArrayList();
    vecReport1=(ArrayList)hshValues.get("vecVal");
		if (vecReport1 != null && vecReport1.size()>0) 
		{
    %>
      <div id="top"> 
        <table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr class="tblhead"> 
            <td>Name</td>
            <td>Means</td>
            <td>As on</td>
          </tr>
          <%
         
  				for (int l = 0; l < vecReport1.size(); l++) 
  				{
  					ArrayList b1 = null;
  					b1 = (ArrayList) vecReport1.get(l);
  			%>
          <tr> 
            <td><%=Helper.correctNull((String) b1.get(0))%>.<%=Helper.correctNull((String) b1.get(1))%></td>
            <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) b1.get(2))))%></td>
            <td><%=Helper.correctNull((String) b1.get(3))%></td>
          </tr>
          <%} %>
        </table>
      </div>
      <%}else{ %>
      No Guarantor
      <%} %>
    </td>
  </tr>
  <tr> 
    <td width="2%" valign="top"><b>4)</b></td>
    <td width="14%" valign="top"><b>New/Renewal</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <td width="20%"><b>New / Renewal</b></td>
    <td width="12%">&nbsp;</td>
    <td colspan="2" nowrap><b>Month of Review:</b>&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("review_month"))%></td>
  </tr>
  <tr> 
    <td width="2%" valign="top"><b>5)</b></td>
    <td width="14%" valign="top"><b>Nature of Facility</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <%
    String loanfacility=Helper.correctNull((String)hshValues.get("loan_facility"));

    if(loanfacility.equalsIgnoreCase("0"))loanfacility="";
    if(loanfacility.equalsIgnoreCase("1"))loanfacility="Short Term Loan";
   	if(loanfacility.equalsIgnoreCase("2"))loanfacility="Term-Loan Medium";	
   	if(loanfacility.equalsIgnoreCase("3"))loanfacility="Term-Loan Long";
   	if(loanfacility.equalsIgnoreCase("4"))loanfacility="Secured-Over Draft";
   	if(loanfacility.equalsIgnoreCase("5"))loanfacility="Clean-Over Draft";
   	if(loanfacility.equalsIgnoreCase("6"))loanfacility="Cash Credit-Pledge";
	if(loanfacility.equalsIgnoreCase("7"))loanfacility="Cash Credit-Hypo of stock";
	if(loanfacility.equalsIgnoreCase("8"))loanfacility="Cash Credit-Hypo of Book/Debt";
	if(loanfacility.equalsIgnoreCase("9"))loanfacility="OD - Reducing";
	if(loanfacility.equalsIgnoreCase("10"))loanfacility="DLRI";
	if(loanfacility.equalsIgnoreCase("11"))loanfacility="ILROD-Inland loan Repayable on Demand";
   	

   
    %>
    <td colspan="4" nowrap><b><%=loanfacility%></b></td>
  </tr>
  <tr> 
    <td width="2%" valign="top">&nbsp;</td>
    <td width="14%" valign="top">&nbsp;</td>
    <td width="2%" valign="top">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <%
            
            if(prd_type.equalsIgnoreCase("aL"))
            {
            	arrRow=(ArrayList)hshValues.get("arrwarehouse");
            	  if(arrRow!=null && arrRow.size()>0){
            		
            	  
            %>
            
    <tr>
    	<td width="2%" valign="top">&nbsp;</td>
    	<td colspan="6"> 
    	<div id="top"> 
    	<table width="100%" border="0" cellspacing="0" cellpadding="3">
    		<tr class="tblhead">
    			<td>Name &amp; Description of the goods to be pledged</td>
    			<td>Document of title to goods &amp; or warehouse Receipts</td>
    			<td>No. of units to be Pledged</td>
    			<td>Weight / Measurement units in Quintals</td>
    			<td>Market rate per unit</td>
    			<td>Total Market Value</td>
    			<td>Loan Amount requested</td>
    			<td>Value as per warehouse receipt</td>
    			<td>Date of Invoice</td>
    		</tr>
    		<%
    		 for(int i=0;i<arrRow.size();i++){ 
    			 ArrayList arrCol=new ArrayList();
    			 arrCol=(ArrayList)arrRow.get(i);
    		%>
    		
    		<tr>
    			<td><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>
    			<td><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
    			<td><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
    			<td><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td>
    			<td align="right"><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</td>
    			<td align="right"><%=Helper.correctNull((String)arrCol.get(5))%>&nbsp;</td>
    			<td align="right"><%=Helper.correctNull((String)arrCol.get(6))%>&nbsp;</td>
    			<td align="right"><%=Helper.correctNull((String)arrCol.get(7))%>&nbsp;</td>
    			<td><%=Helper.correctNull((String)arrCol.get(8))%>&nbsp;</td>
    		</tr>
    		<%} %>
    		<tr>
    			<td>Total</td>
    			<td>&nbsp;</td>
    			<td>&nbsp;</td>
    			<td>&nbsp;</td>
    			<td align="right">&nbsp;</td>
    			<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totMarketValue"))))%>&nbsp;</td>
    			<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totLoanAmt"))))%>&nbsp;</td>
    			<td align="right">&nbsp;</td>
    			<td>&nbsp;</td>
    		</tr>
    	</table>
    	</div>
    	</td>
    </tr>       
            
            
  <%
            		  } }
  %>
  
  
  
  <tr> 
    <td width="2%" valign="top">&nbsp;</td>
    <td colspan="6"> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <%
              String loan_recmdamt=Helper.correctNull((String)hshValues.get("loan_recmdamt")); 
              double recamt=0.00;
			  String margin=Helper.correctNull((String)hshValues.get("offeredmargin"));
			  double mar=0.00;
				if(!margin.equals(""))
				{
					mar=Double.parseDouble(margin); 
				}
				else
				{
					mar=0.00;
				}
				
				
              
              if(!loan_recmdamt.equals(""))
              {
            	  recamt=Double.parseDouble(loan_recmdamt);
              }
              else
              {
            	  recamt=0.00;
              }
			  
			  String strvalsub="3";
			  double sub=0.00;
			  String subsidy="";
			  if(strvalsub.equalsIgnoreCase("3"))
			  {	
					 subsidy=Helper.correctNull((String)hshValues.get("loan_sub"));
					 sub=0.00;
					if(!subsidy.equals(""))
					{
						sub=Double.parseDouble(subsidy); 
					}
					else
					{
						sub=0.00;
					}
				}
      
        %>
          <tr class="tblhead"> 
            <td width="25%">Purpose</td>
            <td width="13%">Total Project Cost Rs.</td>
            <td width="12%">Loan sanctioned Rs.</td>
            <td width="9%">Margin Rs.</td>
            <%if(strvalsub.equalsIgnoreCase("3"))
		  {%>
            <td width="14%">Subsidy(Rs.)</td>
            <%}%>
            <td width="13%">RATE OF INTEREST % <b>p.a.</b></td>
            <td width="14%">Repayment Schedule in Months</td>
          </tr>
          <tr> 
            <td width="25%" ><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%></td>
            <td width="13%" align="right" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_costloanprd"))))  %></td>
            <td width="12%" align="right" ><%=Helper.formatDoubleValue(recamt)%></td>
            <td width="9%" align="right" ><%=Helper.formatDoubleValue(mar)%></td>
            <%if(strvalsub.equalsIgnoreCase("3"))
		  	{%>
            <td width="14%" align="right"><%=Helper.formatDoubleValue(sub)%></td>
            <%}%>
            <td width="13%"><%=Helper.correctNull((String)hshValues.get("loan_modintrate"))%></td>
            <td width="14%"><%=Helper.correctNull((String)hshValues.get("lreqterms"))%><b> 
              &nbsp; </b></td>
          </tr>
          <tr> 
            <td width="25%">Total</td>
            <td width="13%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_costloanprd"))))  %></td>
            <td width="12%" align="right"><%=Helper.formatDoubleValue(recamt)%></td>
            <td width="9%" align="right"><%=Helper.formatDoubleValue(mar)%></td>
            <td width="14%" align="right"><%=Helper.formatDoubleValue(sub)%></td>
            <td width="13%">&nbsp;</td>
            <td width="14%" >&nbsp; </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
  <tr> 
    <td width="2%" rowspan="1" valign="top"><b>6)</b></td>
    <td width="14%" rowspan="1" valign="top"><b>Security</b></td>
    <td width="2%" rowspan="1" valign="top"><b>:</b></td>
    <td colspan="4"> 
      <%
    if(Helper.correctNull((String)hshValues.get("agr_security1")).equalsIgnoreCase("h"))
    {
    	out.println("Hypothecation of");
  		out.println(Helper.correctNull((String)hshValues.get("agr_securityval1")));  
  	}
  	if(Helper.correctNull((String)hshValues.get("agr_security1")).equalsIgnoreCase("m"))
    {
    	out.println("Mortgage of");
  		out.println(Helper.correctNull((String)hshValues.get("agr_securityval1")));  
  	}
  	if(Helper.correctNull((String)hshValues.get("agr_security1")).equalsIgnoreCase("l"))
	{
		out.println("Lien of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval1")));  
	}
  	if(Helper.correctNull((String)hshValues.get("agr_security1")).equalsIgnoreCase("a"))
	{
		out.println("Assignment of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval1")));  
	}
  	if(Helper.correctNull((String)hshValues.get("agr_security1")).equalsIgnoreCase("p"))
	{
		out.println("Pledge of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval1")));  
	}
  	
  	if(Helper.correctNull((String)hshValues.get("agr_security2")).equalsIgnoreCase("h"))
    {
    	out.println("<br>Hypothecation of");
  		out.println(Helper.correctNull((String)hshValues.get("agr_securityval2")));  
  	}
  	if(Helper.correctNull((String)hshValues.get("agr_security2")).equalsIgnoreCase("m"))
    {
    	out.println("<br>Mortgage of");
  		out.println(Helper.correctNull((String)hshValues.get("agr_securityval2")));  
  	}
  	if(Helper.correctNull((String)hshValues.get("agr_security2")).equalsIgnoreCase("l"))
	{
		out.println("<br>Lien of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval2")));  
	}
  	if(Helper.correctNull((String)hshValues.get("agr_security2")).equalsIgnoreCase("a"))
	{
		out.println("<br>Assignment of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval2")));  
	}
  	if(Helper.correctNull((String)hshValues.get("agr_security2")).equalsIgnoreCase("p"))
	{
		out.println("<br>Pledge of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval2")));  
	}
  	
  	if(Helper.correctNull((String)hshValues.get("agr_security3")).equalsIgnoreCase("h"))
    {
    	out.println("<br>Hypothecation of");
  		out.println(Helper.correctNull((String)hshValues.get("agr_securityval3")));  
  	}
  	if(Helper.correctNull((String)hshValues.get("agr_security3")).equalsIgnoreCase("m"))
    {
    	out.println("<br>Mortgage of");
  		out.println(Helper.correctNull((String)hshValues.get("agr_securityval3")));  
  	}
  	if(Helper.correctNull((String)hshValues.get("agr_security3")).equalsIgnoreCase("l"))
	{
		out.println("<br>Lien of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval3")));  
	}
  	if(Helper.correctNull((String)hshValues.get("agr_security3")).equalsIgnoreCase("a"))
	{
		out.println("<br>Assignment of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval3")));  
	}
  	if(Helper.correctNull((String)hshValues.get("agr_security3")).equalsIgnoreCase("p"))
	{
		out.println("<br>Pledge of");
		out.println(Helper.correctNull((String)hshValues.get("agr_securityval3")));  
	}
  	out.println("<br>Letter of Guarantee from sureties wherever applicable");
  	%>
    </td>
  </tr>
  <tr> 
    <td width="2%" valign="top"><b>7)</b></td>
    <td width="14%" valign="top"><b>Documents to be Obtained</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <td colspan="4"> 
      <table width="100%" cellpadding="3" cellspacing="0" border="0">
        <%
        ArrayList vecdata =new ArrayList();
        ArrayList vecval =new ArrayList();
        vecdata=(ArrayList)hshValues.get("vecVal_doc");
        int vsize=0;
        if(vecdata!=null)
        {
        	vsize=vecdata.size();
        }
        for(int i=0;i<vsize;i++)
        {
        	vecval=(ArrayList)vecdata.get(i);
        %>
        <tr valign="top"> 
          <td><%=i+1%>.</td>
          <td align="left"><%=(vecval.get(0)).toString().trim()%></td>
        </tr>
        <%
        }
         %>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="2%" rowspan="2" valign="top"><b>8)</b></td>
    <td width="14%" rowspan="2" valign="top"><b>Disbursement of Loan</b></td>
    <td width="2%" rowspan="2" valign="top"><b>:</b></td>
    <td colspan="4"> 
      <p>1.&nbsp;Loan amount along with margin money, deposited with us, should 
        be paid directly to the supplier of the same. Receipt / Invoice evidencing 
        the supply should be kept on record.</p>
    </td>
  </tr>
  <tr> 
    <td colspan="4">2.&nbsp;Loan will be disbursed in _________installments based 
      on the requirement / progress of the work.</td>
  </tr>
  <tr> 
    <td width="2%" valign="top"><b>9)</b></td>
    <td width="14%" valign="top"><b>Repayment of Loan</b></td>
    <td width="2%" valign="top"><b>: </b></td>
    <%
   if("aC".equals(Helper.correctNull((String)hshValues.get("prdtype"))))
    	{
 %>
    <td colspan="4" valign="top"> 
      <%if(Helper.correctNull((String)hshValues.get("tech_ugc")).equalsIgnoreCase("3")){ %>
      Entire loan amount along with accrued interest should be repaid after harvest 
      of the crops / marketing of the produce within 12 months in case of short 
      duration crops or with within 18 months in case of adsali sugarcane crop. 
      <%}else{ %>
      Entire loan amount along with accrued interest should be repaid after harvest 
      / marketing of the crops 
      <%} %>
    </td>
    <%}
    	else
    	{%>
    <td colspan="4" valign="top" width="23%">Entire loan amount along with accrued 
      interest thereon should be repaid in __________ equal monthly / quarterly 
      / half yearly / yearly instalments commencing from ____________________ 
    </td>
    <% }%>
  </tr>
  <tr> 
    <td width="2%" valign="top"><b>10)</b></td>
    <td width="14%" valign="top"><b>Special Instructions</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <td colspan="4"> 
      <%
                  arrRow=(ArrayList)hshValues.get("arrTerms");
    			if(arrRow!=null && arrRow.size()>0)
                	{	
    				 for(int i=0;i<arrRow.size();i++)
                		{
                			%>
		<table width="98%" cellpadding="3" cellspacing="0" border="0">
		<tr><td width="4%" valign="top"><b><%=i+1%>)</b><td>
		<td width="96%">					
      <%=Helper.correctNull((String)arrRow.get(i))%><br>
	  </td>
	  </tr>
      <%}
              			 }%>
  </table>
  </td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <%
  arrRow=(ArrayList)hshValues.get("mailcomments");
  if(arrRow!=null && arrRow.size()>0)
          				{%>
          			<tr>
            		<td colspan="7" align="center" class="td_bg"><strong>Recommended for Sanction</strong></td>
       			</tr>	
       				<%
          				for(int i=0; i<arrRow.size();i++)
          					{
          					ArrayList arrCol=new ArrayList();
          					arrCol=(ArrayList)arrRow.get(i);
       					%>
   					 <tr>
   					 	<td width="2%">&nbsp;</td>
			            <td valign="top"><%=arrCol.get(0)%>&nbsp;</td>
            			<td valign="top">:&nbsp;</td>
			            <td valign="top" colspan="4"><P><%=arrCol.get(1)%>&nbsp;</P></td>
			         </tr>
			          <% 
            			}%>
            			 <tr>
   					 	<td width="2%">&nbsp;</td>
			            <td valign="top">&nbsp;</td>
            			<td valign="top">&nbsp;</td>
			            <td valign="top" colspan="4" align="right">Signature&nbsp;</td>
			         </tr>
			            <%}
          				%>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <%
  if(!Helper.correctNull((String)hshValues.get("sancauth")).equalsIgnoreCase("")||!Helper.correctNull((String)hshValues.get("sancofficercomments")).equalsIgnoreCase(""))
  {
  %>
  <tr>
  	<td width="2%">&nbsp;</td>
			 	<td valign="top"><%=Helper.correctNull((String)hshValues.get("sancauth"))%>&nbsp;</td>
				<td valign="top">:&nbsp;</td>
			  	<td valign="top" colspan="4"><p><%=Helper.correctNull((String)hshValues.get("sancofficercomments"))%>&nbsp;</p></td>
   </tr>	
   <%} %>
   <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td width="14%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
    <td colspan="4">&nbsp;</td>
  </tr>
   <tr>
   					 	<td width="2%">&nbsp;</td>
			            <td valign="top">&nbsp;</td>
            			<td valign="top">&nbsp;</td>
			            <td valign="top" colspan="4" align="right">Signature&nbsp;</td>
			         </tr>
</table>

</body>
</html>
