<%@include file="../share/directives.jsp"%>
<%
	String keywordname=request.getParameter("keywordname");
%>
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>

	<%if(keywordname.equalsIgnoreCase("ParticularsofSecurityPledged")) { %>
			  <Table border='1' width='100%' align='center' class="outertable"  cellspacing='0' cellpadding='3'>
			  <tr align="center">
			  <td> Sl. No. </td> <td> Quantity (in number of units) </td> <td>DESCRIPTION OF GOODS </td> <td>Invoice or Market Value (Rs.) </td> <td>Amount (Rs.) </td> <td> Amount Advanced (Rs.) </td>
			  </tr>
			  <tr>
			  <td>&nbsp; <br><br><br></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
			  </tr>
			  </table>
	<% } else if(keywordname.equalsIgnoreCase("ParticularsofInstallments")) { %>
					 <Table border='1' width='95%' align='center' class="outertable"  cellspacing='0' cellpadding='3'>
    				 <tr>
    				 <td align='center'> SCHEDULE 'A' <br> (Particulars of Installments) 
    				 </tr>
    				 <tr>
    				 <td> &nbsp;<br><br><br><br><br><br> </td>
    				 </tr>
    				 </table>
	<% } else if(keywordname.equalsIgnoreCase("DescriptionofSecurity")) { %>
	
					  <Table border='1' width='95%' align='center' class="outertable"  cellspacing='0' cellpadding='3'>
    				  <tr align="center">
    				  <td align='center'> SCHEDULE 'B' <br> (Description of Security & Nature of charge created such as mortgage of immovable property or hypothecation of movables etc.) 
    				  </tr>
    				  <tr>
    				  <td> &nbsp;<br><br><br><br><br> </td>
    				  </tr>
    				  </table>

	<% } else if(keywordname.equalsIgnoreCase("scheduleTAB")) { %>
		
		 			 <Table border='1' width='95%' align='center' class="outertable"  cellspacing='0' cellpadding='3'>
    				 <tr align="center">
    				 <td>Name of the Company</td><td>Regd Folio</td><td>Policy/Share Certificate No.</td><td>Date</td><td>No. Of Shares </td><td>Face Value </td><td>Name of the Assured</td><td>Amount Assured</td> 
    				 </tr>
    				 <tr>
    				 <td>&nbsp; </td><td>&nbsp; </td><td>&nbsp; </td><td>&nbsp; </td><td>&nbsp; </td><td>&nbsp; </td><td>&nbsp; </td><td>&nbsp; </td> 
    				 </tr>
    				 </table>
			
	<% } else if(keywordname.equalsIgnoreCase("Descriptionofgoldornaments")) { %>
	
			  	  <Table border='1' width='100%' cellspacing='0' cellpadding='3' align='center' class="outertable">
  				  <tr align='center'>
  				  <td rowspan='2'>Sl. No. </td><td rowspan='2'>Description of gold ornaments</td><td colspan='2'>Weight in grams </td> <td rowspan='2'> Estimated value of the article (Rs.) </td>
  				  </tr>
  				  <tr>
  				  <td> Gross </td> <td>Net</td> 
  				  </tr>
  				  <tr>
  				  <td>&nbsp; <br><br><br></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
  				  </tr>
  				  <tr align='center'>
  				  <td> &nbsp;</td><td>TOTAL</td><td>&nbsp;</td><td>&nbsp;</td> <td align='right'> &nbsp;</td>
  				  </tr>
  				  </table>
			
	<% } else if(keywordname.equalsIgnoreCase("Activity")) { %>
	
	 				 <Table border='1' width='100%' cellspacing='0' cellpadding='3' class='outertable' align='center'>
    				 <tr align='center'>
    				 <td width='10%'>Sl. No. </td><td width='50%'>Activity</td><td width='20%'>No./Area</td><td width='20%'>Loan required</td>
    				 </tr>
    				 <tr>
    				 <td> &nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    				 </tr>
    				 <tr align='center'>
    				 <td colspan='2' align='center'> Total loan required</td><td>&nbsp;</td><td>&nbsp;</td>
    				 </tr>
    				 </table>
    <% } else if(keywordname.equalsIgnoreCase("Areaundercultivation")) { %>	
    
    		        <Table border='1' width='100%' cellspacing='0' cellpadding='3' class='outertable' align='center'>
    				<tr align='center'>
    				<td width='10%' > Sl. No. <br> <center>(1) </center> </td><td>Area under cultivation (Acres)<br><center>(2)#</center></td><td>Nature of crop grown<br><center>(3)</center> </td><td>Scale of Finance<br><center>(4)</center> </td> <td>Eligible loan amount(2)x (4)<br> <center> (5) </center> </td>
    				</tr>
    				<tr>
    				<td> &nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    				</tr>
    				<tr>
    				<td> &nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    				</tr>
    				<tr>
    				<td> &nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    				</tr>
    				<tr align='center'>
    				<td colspan='4'> <b> Total (a) </b> </td> <td> &nbsp;</td>
    				</tr>
    				<tr align='center'>
    				<td colspan='4'> <b> Add: </b>  loan for post harvest  activities (b) </td> <td> &nbsp;</td>
    				</tr>
    				<tr align='center'>
    				<td colspan='4'> <b> Total loan eligible (a) + (b) </b> </td> <td> &nbsp;</td>
    				</tr>
    				</table> 
    <% } else if(keywordname.equalsIgnoreCase("Agridev")) { %>	
    
    			 <Table border='1' width='100%' cellspacing='0' cellpadding='3' class='outertable' align='center'>
  				  <tr align='center'>
  				  <td width='10%'> Sl. No. <br> <center>(1) </center> </td><td width='20%'>Activity <br> <center> (2)# </center> </td><td width='20%'>Unit cost/Cost <br> <center> (3) </center> </td><td width='20%'>No. of units/Area <br> <center> (4) </center> </td>	<td width='20%'>Total cost (3) X (4)  <br> <center> (5) </center> </td>
  				  </tr>
  				  <tr>
  				  <td> &nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
  				  </tr>
  				  <tr>
  				  <td> &nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
  				  </tr>
  				  <tr>
  				  <td>Total (a)</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td> <td>&nbsp;</td>
  				  </tr>
  				  <tr align='center'>
  				  <td colspan='5'> <b>75% of the total investment Rs. </b> 
  				  </tr>
  				  </table>
  			
  	<% } else if(keywordname.equalsIgnoreCase("CreditFacilities")) { %>		
  		
  				    <Table border='1' width='95%' align='center' class="outertable" cellspacing='0' cellpadding='3'>
					<tr align="center">
					    <td>Sl.No.</td>
					    <td>Name of the Bank/ Financiers/others</b>>
					    <td>Nature of facility</td>
					    <td>Limit (Rs.)</td>
					    <td>Balance Due (Rs.)</td>
	                    <td colspan='2'>Securities & Value (Rs.)</td>
                    </tr>
                    <tr align='center'>
					<td>&nbsp;</td>
					<td align='left'>&nbsp;</td>
					<td>&nbsp;</td>
					<td align='right'>&nbsp;</td>
					<td align='right'>&nbsp;</td>
					<td colspan='2'>&nbsp;</td>
					</tr>
                    </table>
                    
                    
    <% } else if(keywordname.equalsIgnoreCase("Litigations")) { %>	
   	
					<Table border='1' width='95%' align='center' class="outertable" cellspacing='0' cellpadding='3'>
					<tr align="center">
				    <td>Sl.No.</td>
				    <td>Name of the Bank/ Financiers/others With whom facing</b>>
				    <td>Nature of Litigation</td>
				    <td>Date of Litigation</td>
				    <td>Claim amount (Rs.)</td>
                    <td>Other Claims</td>
                    <td>Present Position</td>
                    </tr>
                    <tr>
                    <td>&nbsp; <br><br> <br></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    </tr>
                    </table>
                    
   	 <% } else if(keywordname.equalsIgnoreCase("ParticularsofDoc")) { %>	
    
    				 <Table border='1' width='100%' cellspacing='1' cellpadding='3' class='outertable' align='center'>
    				 <tr align='center'>
    				 <td>Sl. No</td> <td>Date of Document </td><td>Particulars of Document </td>
    				 </tr>
    				 <tr>
    				 <td>&nbsp;<br><br><br><br></td><td>&nbsp;</td><td>&nbsp;</td>
    				 </tr>
    				 </table>
  
    <% } else if(keywordname.equalsIgnoreCase("guadetails")) { %>	
   		
  			<table>
  			<tr>
  			<td> <b>Guarantor Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Guarantor Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>		
  
   <% } else if(keywordname.equalsIgnoreCase("guaAddress")) { %>	
   
   			<table>
  			<tr>
  			<td> Guarantor Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Guarantor Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>		
  
   	
	
	 <% } else if(keywordname.equalsIgnoreCase("coappDetails")) { %>	
   		
  			<table>
  			<tr>
  			<td> <b>Co-Applicant Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Co-Applicant Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>		
  
   <% } else if(keywordname.equalsIgnoreCase("coappAddress")) { %>	
   
   			<table>
  			<tr>
  			<td> Co-Applicant Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Co-Applicant Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>		
   
	
	 <% } else if(keywordname.equalsIgnoreCase("appDetails")) { %>	
   		
  			<table>
  			<tr>
  			<td> <b>Applicant Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Applicant Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>		
  
   <% } else if(keywordname.equalsIgnoreCase("appAddress")) { %>	
   
   			<table>
  			<tr>
  			<td> Applicant Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Applicant Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>		
  
   	
	<% }else if(keywordname.equalsIgnoreCase("InstallmentsDetails")) { %>	
		   
			 <table border='0' width='95%' align='center' class="outertable"  cellspacing='0' cellpadding='3'>
    				 <tr>
    				 <td align='center'> SCHEDULE 'A' <br> (Particulars of Installments) 
    				 </tr>
    				 <tr>
    				 <td> &nbsp;<br><br><br><br><br><br> </td>
    				 </tr>
    				 </table>
	<% } else if(keywordname.equalsIgnoreCase("DescriptionofSecurity")) { %>
	
					  <Table border='1' width='95%' align='center' class="outertable"  cellspacing='0' cellpadding='3'>
    				  <tr align="center">
    				  <td align='center'> SCHEDULE 'B' <br> (Description of Security & Nature of charge created such as mortgage of immovable property or hypothecation of movables etc.) 
    				  </tr>
    				  <tr>
    				  <td> &nbsp;<br><br><br><br><br> </td>
    				  </tr>
    				  </table>	

	
<% } else if(keywordname.equalsIgnoreCase("CoobligantDetails")) { %>	
	
	<table>
	<tr>
	<td> <b>Co-Obligant Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
	</tr> 
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td> <b>Co-Obligant Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
	</tr> 			
	</table>		

<% }else if(keywordname.equalsIgnoreCase("ProprietorDetails")) { %>	
	
	<table>
	<tr>
	<td> <b>Proprietor Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
	</tr> 
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td> <b>Proprietor Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
	</tr> 			
	</table>		

<% }else if(keywordname.equalsIgnoreCase("CoobligantAddress")) { %>	

	<table>
	<tr>
	<td> Co-Obligant Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td> Co-Obligant Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
	</tr> 			
	</table>		


<% }else if(keywordname.equalsIgnoreCase("ProprietorAddress")) { %>	

	<table>
	<tr>
	<td> Proprietor Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td> Proprietor Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
	</tr> 			
	</table>
			
<% } else if(keywordname.equalsIgnoreCase("TitleDeedDepositDetails")) { %>	
   		
  			<table>
  			<tr>
  			<td> on this ____ day of ________ (month) of 20___ has deposited at _______________ branch</td>
  			</tr> 
  			</table>		
<% }else if(keywordname.equalsIgnoreCase("HypothecationDescription")) { %>
	<table>
  	<tr>
  	<td>1) security description for Hypothecation</td>
  	</tr>
  	<tr><td>&nbsp;</td></tr>
  	<tr>
  	<td>2) security description for Hypothecation</td>
  	</tr>
  	<tr><td>
  			</tr> 
  			</table>
	<% }else if(keywordname.equalsIgnoreCase("EquitablemortgageDescription")) {%>
	<table>
  	<tr>
  	<td>1) security description for  Equitable mortgage</td>
  	</tr>
  	<tr><td>&nbsp;</td></tr>
  	<tr>
  	<td>2) security description for  Equitable mortgage</td>
  	</tr>
  	<tr><td>
  			</tr> 
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("AssignmentDescription")) {%>
  			<table>
  	<tr>
  	<td>1) security description for  Assignment</td>
  	</tr>
  	<tr><td>&nbsp;</td></tr>
  	<tr>
  	<td>2) security description for  Assignment</td>
  	</tr>
  	<tr><td>
  			</tr> 
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("PledgeDescription")) {%>
  			<table>
  	<tr>
  	<td>1) security description for  Pledge</td>
  	</tr>
  	<tr><td>&nbsp;</td></tr>
  	<tr>
  	<td>2) security description for  Pledge</td>
  	</tr>
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("RegisteredMortgageDescription")) {%>
  			<table>
  	<tr>
  	<td>1) security description for  Registered Mortgage</td>
  	</tr>
  	<tr><td>&nbsp;</td></tr>
  	<tr>
  	<td>2) security description for  Registered Mortgage</td>
  	</tr>
  	<tr><td>
  			</tr> 
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("TransferableDescription")){%>
  			<table>
  	<tr>
  	<td>1) security description for  Transferable</td>
  	</tr>
  	<tr><td>&nbsp;</td></tr>
  	<tr>
  	<td>2) security description for  Transferable</td>
  	</tr>
  	<tr><td>
  			</tr> 
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("HypothecationAddress")){%>
  			<table>
  			<tr>
  			<td> Premises Owner Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Premises Owner Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("EquitableMortgageAddresss")){%>
  			<table>
  			<tr>
  			<td> Premises Owner Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Premises Owner Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("AssignmentAddress")){%>
  			<table>
  			<tr>
  			<td> Premises Owner Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Premises Owner Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("PledgeAddress")){%>
  			<table>
  			<tr>
  			<td> Premises Owner Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Premises Owner Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("RegisteredMortgageAddress")){%>
  			<table>
  			<tr>
  			<td> Premises Owner Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Premises Owner Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("TransferableAddress")){%>
  			<table>
  			<tr>
  			<td> Premises Owner Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> Premises Owner Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("HypothecationDetails")){%>
  			<table>
  			<tr>
  			<td> <b>Premises Owner Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Premises Owner Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("EquitableMortgageDetails")){%>
  			<table>
  			<tr>
  			<td> <b>Premises Owner Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Premises Owner Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("AssignmentDetails")){%>
  			<table>
  			<tr>
  			<td> <b>Premises Owner Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Premises Owner Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("PledgeDetails")){%>
  			<table>
  			<tr>
  			<td> <b>Premises Owner Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Premises Owner Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("RegisteredMortgageDetails")){%>
  			<table>
  			<tr>
  			<td> <b>Premises Owner Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Premises Owner Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("TransferableDetails")){%>
  			<table>
  			<tr>
  			<td> <b>Premises Owner Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Premises Owner Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("StockHypothecation")){%>
  			<table>
  			<tr><td>
  			Hypothecation of <u><b>Type</b></u> <u><b>Machinery Type</b></u> (Model-<u><b>Year of Manufacture</b></u>) valued Rs.<u><b>Net security value/</b></u>- installed in the building bearing Door no._____ situated in address line 1, address line 2, City - Pincode, State belonging to ______________.
  			</td>
  			</tr>
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("BookDebtHypothecation")){%>
  			<table>
  			<tr>
  			<td>Hypothecation of Bills Receivables 
  			</td>
  			</tr>
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("FurnitureHypothecation")){%>
  			<table>
  			<tr><td>
           Hypothecation of Furniture and Fixtures valued at <u><b>Net security value/</b></u>- stored/installed in Door No _____, address line 1, address line 2, address line 3, City - Pincode, State belonging to __________.  </td>
  			</tr>
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("LiveStockHypothecation")){%>
  			<table>
  			<tr><td>
  			 Hypothecation of _____ <u><b>Security Classification</b></u> totally valued at <u><b>Net security value/</b></u>- stored in Door No_____, address line 1, address line 2, address line 3, City - Pincode, State belonging to ________.
            Details are as follows:
            </td>
            </tr>
            </table>
            <table><tr><th>Age</th><th>&nbsp;</th><th>Breed</th><th>&nbsp;</th><th>Identification Mark</th></tr>
            <tr><td>1</td><td>&nbsp;</td><td>Breed No1</td><td>&nbsp;</td><td>Tag No 1</td></tr>
            <tr><td>2</td><td>&nbsp;</td><td>Breed No2</td><td>&nbsp;</td><td>Tag No 2</td></tr></table>
  			<%}else if(keywordname.equalsIgnoreCase("StockPremisesOwneraddress")){%>
  			<table>
  			<tr>
  			<td>Stock Premises Owner Name 1 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr>
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td>Stock Premises Owner Name 2 <br> address line 1 <br> address line 2 <br> City - Pincode <br> State </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("StockPremisesOwnerdetails")){%>
  			<table>
  			<tr>
  			<td> <b>Stock Premises Owner Name 1 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 
  			<tr><td>&nbsp;</td></tr>
  			<tr>
  			<td> <b>Stock Premises Owner Name 2 </b> , S/o / D/o <b>father's/husband's name</b>, aged about <b> Age</b> years, residing at <b> Address </b>  </td>
  			</tr> 			
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("MachineryHypothecation")){%>
  			<table>
  			<tr><td>
  			Hypothecation of stock stored/stacked in Door No _________, address line 1, address line 2, address line 3, City - Pincode, State belonging to _________.
  			</td>
  			</tr>
  			</table>
  			<%}else if(keywordname.equalsIgnoreCase("CropHypothecation")){%>
  			<table>
  			<tr>
  			<td>
  			Hypothecation of  <u><b>Security Classification</b></u> valued at<u><b> Net security value/</b></u>-  in_______ ______ of land situated in Survey No _______,address line 1, address line 2, address line 3, City - Pincode,  State belonging to __________.</td>
  			</tr> 			
  			</table>
  			<%}%>
  			
  			
  			
  			
  			
  			
  			
  			
  			
</body>
</html>