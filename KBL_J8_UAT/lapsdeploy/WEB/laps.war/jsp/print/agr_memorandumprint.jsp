<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
			//out.println("hshValues----->"+hshValues);
			ArrayList vec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			int vecsize = 0;
			int vecrecsize = 0;
			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecData");
				vecrec = (ArrayList) hshValues.get("vecData2");
			}
			if (vecrec != null) {
				vecsize = vec.size();
			}
			if (vecrec != null) {
				vecrecsize = vecrec.size();
			}
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			ArrayList g3 = new ArrayList();
			
			String strAppname = Helper.correctNull((String)hshValues.get("appname"));
			String strAppno=(String)hshValues.get("strappno");
			String strsecurityval1=Helper.correctNull((String)hshValues.get("txt_securityval1"));
			String strsecurityval2=Helper.correctNull((String)hshValues.get("txt_securityval2"));
			String strsecurityval3=Helper.correctNull((String)hshValues.get("txt_securityval3"));
			String sel_sec1=Helper.correctNull((String)hshValues.get("sel_sec1"));
			String sel_sec2=Helper.correctNull((String)hshValues.get("sel_sec2"));
			String sel_sec3=Helper.correctNull((String)hshValues.get("sel_sec3"));

			String strProducttype=Helper.correctNull((String)request.getParameter("prdtype"));
			%>

<html>
<head>
<title>ubi</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	


  <tr> 
    <td align="center"><b>MEMORANDUM FOR SANCTION </b></td>
  </tr>
  
  <tr> 
   		<td>
   		<table width="95%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			
          <td width="25%">Name of the Applicant : </td>
			<td width="35%"><b><%=strAppname %></b></td>
			
          <td width="15%">Application No :</td>
			<td width="15%"><b><%=strAppno%></b></td>
			</tr>
		</table>
  	</tr>
  	
  <tr>
  <td>
  <%
 	if (vecrecsize != 0 && vecsize!=0)
	{
		if(vecrecsize==vecsize)
		{
		%>
	<table width="95%" border="0" cellspacing="0" cellpadding="3">
	<tr>
          <td colspan="4"><b><u>Observations of Appraising Officer:</u></b></td>
        </tr>
		<tr>
 
		<%	for (int l = 0; l < vecsize; l++) 
			{
				if (l < vecsize) 
				{
					g1 = (ArrayList) vec.get(l);
					g2 = (ArrayList) vecrec.get(l);
					//String strtype = Helper.correctNull((String) g1.get(0));
%>
<td width="3%" valign="top"><%=l + 1%>.</td>
<td width="67%" valign="top">
 <%=Helper.correctNull((String) g1.get(1))%>
</td> <td width="10%" valign="top">
<%String str11 = Helper.correctNull((String) g2.get(0));
	if (str11.equals("1")) 
	{
		out.println("Yes");
	} 
	else if (str11.equals("2")) 
	{
		out.println("No");
	}
	else if(str11.equals("3"))
	{
		out.println("Not Applicable");
	}
				}%>
				</td>
		<td width="20%" valign="top">&nbsp;
	<%=Helper.correctNull((String) g2.get(1))%></td>		
				</tr><tr>
			<%}
		}
	}
%>
	</tr>
	
</table>
</td>
</tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="90%" border="0" cellspacing="3" cellpadding="3">
        <tr> 
          <td><u><b>Recommendations of the Appraising Officer:</b></u></td>
        </tr>
        <tr> 
          <td>The relevant land record / documents have been obtained and verified 
            and found correct. The farm was visited by me on <b><%=Helper.correctNull((String)hshValues.get("txt_farmdate"))%></b> 
            .</td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="1" cellpadding="2">
              <tr> 
                <td width="2%"> a)</td>
                <td width="25%">Loan Recommended</td>
                <td colspan="2" >: Rs.<b><%=Helper.correctNull((String)hshValues.get("txt_loanamount"))%></b> 
                </td>
              </tr>
			   <%--
              <tr> 
			 
			  <%String strscheme = Helper.correctNull((String)hshValues.get("loan_govt"));
			 // String strschemetype = Helper.correctNull((String)hshValues.get("govt_scheme"));
			  String strschemetype1 = Helper.correctNull((String)hshValues.get("stat_data_desc")); 
	  
			  
	if (strscheme.equals("2")) 
	{
	    strscheme="General";
		
	} 
	else if (strscheme.equals("1")) 
	{
	      strscheme=strschemetype1;
		
	}
	
				%>
                <td width="2%">b)</td>
                <td width="25%">Scheme</td>
                <td colspan="2">:&nbsp;<%=strscheme%> </td>
              </tr>--%>
			 
                <tr> 
                <td width="2%" valign="top">b)</td>
                <td width="25%" valign="top">Security Proposed</td>
                <td colspan="2">
              <%
              	 
              
            	  if(sel_sec1.equalsIgnoreCase("h"))
            	  {
            		  sel_sec1="Hypothecation of";
            	  }
            	  else if(sel_sec1.equalsIgnoreCase("l"))
            	  {
            		  sel_sec1="Lien of";
            	  }
            	  else if(sel_sec1.equalsIgnoreCase("m"))
            	  {
            		  sel_sec1="Mortgage of";
            	  }
            	  else if(sel_sec1.equalsIgnoreCase("a"))
            	  {
            		  sel_sec1="Assignment of";
            	  }
            	  else if(sel_sec1.equalsIgnoreCase("p"))
            	  {
            		  sel_sec1="Pledge of";
            	  }%>
               
           <%   if(!sel_sec1.equalsIgnoreCase("s"))
              	{ %>
              		 <!-- <tr> 
                	<td width="2%"></td>
               		 <td width="25%"></td>
                	<td colspan="2">-->:&nbsp;<%=sel_sec1%>&nbsp;&nbsp;<b><%=strsecurityval1%></b><br/><!-- </td>
                	 </tr> -->
               <%}%>
           		  
              <%
            	  if(sel_sec2.equalsIgnoreCase("h"))
            	  {
            		  sel_sec2="Hypothecation of";
            	  }
            	  else if(sel_sec2.equalsIgnoreCase("l"))
            	  {
            		  sel_sec2="Lien of";
            	  }
            	  else if(sel_sec2.equalsIgnoreCase("m"))
            	  {
            		  sel_sec2="Mortgage of";
            	  }
            	  else if(sel_sec2.equalsIgnoreCase("a"))
            	  {
            		  sel_sec2="Assignment of";
            	  }
            	  else if(sel_sec2.equalsIgnoreCase("p"))
            	  {
            		  sel_sec2="Pledge of";
            	  }%>
            	  
            	  
           		  <%   if(!sel_sec2.equalsIgnoreCase("s"))
              			{ %>
              				<!--  <tr> 
			                <td width="2%">&nbsp;</td>
			                <td width="25%">&nbsp;</td>
                			<td colspan="2"> -->:&nbsp;<%=sel_sec2%>&nbsp;&nbsp;<b><%=strsecurityval2%></b><br><!-- </td>
                			   </tr> -->
              			 <%}
	           		  else 
	           		  {
	           			 %>
	           		  <!--  <tr> 
			                <td width="2%">&nbsp;</td>
			                <td width="25%">&nbsp;</td>
	           		 		 <td colspan="2">
	           		 	  </tr> -->
	           		  <%} %>  
                   <%
                  
            	  if(sel_sec3.equalsIgnoreCase("h"))
            	  {
            		  sel_sec3="Hypothecation of";
            	  }
            	  else if(sel_sec3.equalsIgnoreCase("l"))
            	  {
            		  sel_sec3="Lien of";
            	  }
            	  else if(sel_sec3.equalsIgnoreCase("m"))
            	  {
            		  sel_sec3="Mortgage of";
            	  }
            	  else if(sel_sec3.equalsIgnoreCase("a"))
            	  {
            		  sel_sec3="Assignment of";
            	  }
            	  else if(sel_sec3.equalsIgnoreCase("p"))
            	  {
            		  sel_sec3="Pledge of";
            	  }%>
            	  
            	  
           		  <%   if(!sel_sec3.equalsIgnoreCase("s"))
              			{ %>
              				<!--  <tr> 
			                <td width="2%">&nbsp;</td>
			                <td width="25%">&nbsp;</td>
                			<td colspan="2"> -->:&nbsp;<%=sel_sec3%>&nbsp;&nbsp;<b><%=strsecurityval3%></b><br><!-- </td>
                			   </tr> -->
              			 <%}
	           		  else 
	           		  {	%>
	           		   <!-- <tr> 
			                <td width="2%">&nbsp;</td>
			                <td width="25%">&nbsp;</td>
	           		 		 <td colspan="2">
	           		 	  </tr> -->
	           		  <%} %>  
              </td>
              </tr>
              
              <%
              ArrayList vecgua=new ArrayList();
              ArrayList vecgua10=new ArrayList();
              String gua1="";int size=1;
              //size=vecgua.size();
     		  
              
              vecgua=(ArrayList)hshValues.get("vecReport12");
              if(vecgua.size()!=0)
            	  if(vecgua!=null)
    			  {%>
            		  <tr> 
                      <td width="2%">&nbsp;</td>
                      <td width="25%">&nbsp;</td>
                      <td colspan="2">iii) Guarantee of </td>
                    </tr>
    			<% vecgua10=new ArrayList();
     	 		 vecgua=(ArrayList)hshValues.get("vecReport12");
        		 for(int q=0;q<vecgua.size();q++)
    			  {
        			 
    			    vecgua10=(ArrayList)vecgua.get(q);
    			    gua1=Helper.correctNull((String)vecgua10.get(1));
    			    
    			    String gua2=Helper.correctNull((String)vecgua10.get(2));
              %>
              <tr> 
                <td width="2%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td colspan="2"> 
                  <%
                 out.print(size++);
                 
                %>
                  )<b><%=gua1%></b> </td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="3%">&nbsp;</td>
                <td width="70%"> s/o, <b><%=gua2%></b> </td>
              </tr>
              <%}
        		 
              %>
              <!-- 
              <tr> 
                <td width="2%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td colspan="2">(b) Shri   </td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="3%">&nbsp;</td>
                <td width="70%">s/o ______________________________</td>
              </tr>-->
             <% 
               }%>
                
              <%		 
               			
               
               %>
              <%
              String payment=Helper.correctNull((String)hshValues.get("loan_periodicity"));
              if(payment.equalsIgnoreCase("m"))
              {
            	  payment="Monthly";
              }	
              else if(payment.equalsIgnoreCase("q"))
              {
            	  payment="Quarterly";
              }	
              else if(payment.equalsIgnoreCase("h"))
              {
            	  payment="Half Yearly";
              }	
              else if(payment.equalsIgnoreCase("y"))
              {
            	  payment="Yearly";
              }	
              
              %>
              <%double noofinstallment = 0;
			noofinstallment = Double
					.parseDouble(Helper.correctNull((String) hshValues
							.get("loan_noofinstallment")));
			String lreqterms = Helper.correctNull((String) hshValues
					.get("lreqterms"));
			 String sel_payment=Helper.correctNull((String)hshValues.get("loan_periodicity"));
			double repay = 0;
			repay = Double.parseDouble(lreqterms);
				
			if (sel_payment.equalsIgnoreCase("m")) {
				repay = (repay - noofinstallment) / 1;
			}
			if (sel_payment.equalsIgnoreCase("q")) {
				repay = (repay - noofinstallment) / 3;
			}
			if (sel_payment.equalsIgnoreCase("h")) {
				repay = (repay - noofinstallment) / 6;
			}
			if (sel_payment.equalsIgnoreCase("y")) {
				repay = (repay - noofinstallment) / 12;
			}%>

			<%if(!strProducttype.equals("aC")){%>
              <tr> 
                <td width="2%" valign="top">c)</td>
                <td width="25%">Repayment Schedule</td>
                <td colspan="2" valign="top">: <b><%=repay%></b> 
                  (Number of installments )&nbsp;&nbsp;<b><%=payment%></b> </td>
              </tr>
              <tr> 
                <td width="2%" valign="top">d)</td>
                <td width="25%" valign="top">Gestation period</td>
                <td colspan="2" valign="top">: <b><%=Helper.correctNull((String)hshValues.get("txt_installment"))%></b> 
                  (Number of Months)</td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td colspan="2">&nbsp;&nbsp;Therefore, the first instalment will become due 
                  on <b><%=Helper.correctNull((String)hshValues.get("txt_date"))%></b></td>
              </tr>
              <%
                String str=Helper.correctNull((String)hshValues.get("sel_insurance"));
                if(str.equalsIgnoreCase("1"))
                	str="Yes";
                else if(str.equalsIgnoreCase("2"))
                	str="No";
                             
                
                 %>
              <tr> 
                <td width="2%" valign="top">e)</td>
                <td width="25%" valign="top">Insurance wherever applicable</td>
                <td width="2%" valign="top">:</td>
                <td align="left" valign="top"> <b><%=str %></b></td>
              </tr>
			  <%}%>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="1" cellpadding="2">
        <tr> 
          <td width="33%">Place:</td>
          <td width="67%">Signature of Appraising Officer with name and designation 
          </td>
        </tr>
        <tr> 
          <td width="33%">Date:</td>
          <td width="67%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="33%">&nbsp;</td>
          <td width="67%" align="center">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="1" cellpadding="2">
	  	<tr> 
  		  <td width="35%"></td>
          <td width="65%">Sanctioned</td>
		</tr>
		<tr> 
          <td width="35%">&nbsp;</td>
          <td width="65%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="35%">&nbsp;</td>
          <td width="65%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="35%">Place:</td>
          <td width="65%">Signature of Sanctioning authority</td>
        </tr>
        <tr> 
          <td width="35%">Date:</td>
          <td width="65%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="35%">&nbsp;</td>
          <td width="65%" >Name of Sanctioning authority </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
