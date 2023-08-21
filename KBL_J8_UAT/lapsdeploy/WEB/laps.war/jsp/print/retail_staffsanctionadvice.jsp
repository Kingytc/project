<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
String producttype=Helper.correctNull((String)hshValues.get("prd_type"));
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
%>
<html>
<head>
<title>Staff Sanction Advice</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#999999">
<tr>
<td>
	<table width="100%" border="0" cellspacing="2" cellpadding="2" bordercolor="#999999">
	  <tr> 
	      <td colspan="4" align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" /><br>
            KARNATAKA BANK LTD.<br>
	    <%=Helper.correctNull((String)hshValues.get("approved_orgname"))%></td>
	  </tr>
	  <tr> 
	    
	  </tr>
	  <tr> 
	    <td colspan="4">
	    	<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#999999">
	    		<tr>
	    			<td width="50%">FROM:</td>
	    			<td width="50%">TO:</td>
	    		</tr>
	    		<tr>
	    			<td> <b>
	   				 <%=Helper.correctNull((String)hshValues.get("usr_fname"))%><br>
	    			<%=Helper.correctNull((String)hshValues.get("user_designation"))%> <br>
	    			<%=Helper.correctNull((String)hshValues.get("approved_orgname"))%> <br>
	     			 </b>&nbsp;</td>
	       			<td>&nbsp;</td>
    			</tr>
    		</table>
	   </td>
	   
	  </tr>
	  
	  <tr> 
	    <td colspan="2">&nbsp;</td>
	    <td width="22%">&nbsp;</td>
	    <td width="28%">DATE: <b><%=Helper.correctNull((String)hshValues.get("app_processdate"))%> 
	      </b></td>
	  </tr>
	  <tr> 
	    <td colspan="4" ALIGN="CENTER">SANCTION ADVICE</td>
	  </tr>
	  <tr> 
	    <td colspan="4" align="center">
	      
	      Sub:  <b><%=Helper.correctNull((String)hshValues.get("perapp_title"))%> 
	            </b>.<b><%=Helper.correctNull((String)hshValues.get("perapp_fname"))%> -
	            </b><b><%=Helper.correctNull((String)hshValues.get("perapp_staffusrid"))%> -
	            </b><b><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%> 
	      </b></td>
	        
	  </tr>
	  
	  <tr> 
	    <td colspan="4"> 
	      <p> We are pleased to inform you that loan for <b><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%> 
	        </b> has been sanctioned to <b><%=Helper.correctNull((String)hshValues.get("perapp_title"))%> 
	        </b>. <b><%=Helper.correctNull((String)hshValues.get("perapp_fname"))%> 
	        </b> on following terms and conditions. </p>
	    </td>
	  </tr>
	  <tr> 
	      <td colspan="2" valign="top">1. Purpose of Loan</td>
	      <td colspan="2" valign="top"><b><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%> 
            </b></td>
	  </tr>
	  <tr> 
	      <td colspan="2" valign="top">2.Amount Sanctioned</td>
	      <td colspan="2" valign="top"><b><%=ApplicationParams.getCurrency()%> 
            <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_recmdamt"))))%></b></td>
	  </tr>
	  <tr> 
	    <td colspan="2" valign="top">3. Rate of interest</td>
	      <td colspan="2" valign="top"><b> 
            <%arrRow=(ArrayList)hshValues.get("arrRowslab");
			if(arrRow!=null && arrRow.size()>0)
			{%>
            <table width="75%" border="1" cellspacing="0" cellpadding="0" valign="top">
				<tr valign="top">
				<td >Range From <b><%=ApplicationParams.getCurrency()%></b></td>
				<td>Range To <b><%=ApplicationParams.getCurrency() %></b></td>
				<td> Slab Interest (%)</td>
				</tr>
				<%for(int i=0;i<arrRow.size();i++)
				{%>
					
					<%arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null && arrCol.size()>0)
					{%>
						<tr valign="top">
						<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))%></td>
						
						<%if(i==(arrRow.size()-1))
						{%>
						<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
  						.correctDouble((String) hshValues.get("loan_recmdamt"))))%></td>
						<%}else {%>
						<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
						<%} %>
						<td><%=Helper.correctNull((String)arrCol.get(2))%></td>
						</tr>
				<%	}%>
					
			<%	}%>
				
				</table>
			<%}
			
         else {%>
            <%=Helper.correctNull((String)hshValues.get("loan_modintrate"))%>% 
            <%} %>
            </b></td>
	  </tr>
	  <tr> 
	      <td colspan="2" valign="top">4. Margin</td>
	      <td colspan="2" valign="top"><b><%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%> 
            %</b></td>
	  </tr>
	  <tr> 
	      <td colspan="2" valign="top">5. Repayment Period</td>
	      <td colspan="2" valign="top"><b><%=Helper.correctNull((String) hshValues.get("loan_reqterms"))%> 
            </b>&nbsp;Months</td>
	  </tr>
	  <tr> 
	      <td colspan="2" valign="top">6. Documents to be obtained</td>
		  <td colspan="2" valign="top"> 
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
	        	
	        out.print(Helper.correctNull((String)vecval.get(0)));
			out.print("<br>");	
	        }
			%>
            &nbsp;</td>
		
	  </tr>
	  <tr> 
	      <td colspan="2" valign="top">7. Special Terms and conditions</td>
	   
	      <td colspan="2" valign="top"> 
            <% 
		
		 ArrayList arryTerCondt =new ArrayList();
		 arryTerCondt = (ArrayList) hshValues.get("arrTerms");
	                     if(arryTerCondt!=null)
	                     {
	                       for(int i=0;i<arryTerCondt.size();i++)
	                       {	
	                    	   //arryTer = new ArrayList();
	                    	   //arryTer=(ArrayList)arryTerCondt.get(i);
								
									out.print(Helper.correctNull((String)arryTerCondt.get(i)));
									out.print("<br>");
	      
								
	                       }
	                       	}
	                       %>
            &nbsp;</td>
	  </tr>
	  <tr> 
	    <td colspan="2">&nbsp;</td>
	    <td colspan="2">
	        <table width="100%" border="0" cellspacing="1" cellpadding="3">
              <tr> 
                <td width="45%">&nbsp;</td>
                <td width="55%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="45%">&nbsp;</td>
                <td width="55%">Competant Authority </td>
              </tr>
              <tr>
                <td width="45%">&nbsp;</td>
                <td width="55%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="45%">&nbsp;</td>
                <td width="55%">Date:</td>
              </tr>
            </table>
	    </td>
	  </tr>
	</table>
</td>
</tr>
</table>
</body>
</html>
