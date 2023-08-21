<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
ArrayList arryRow=(ArrayList)hshValues.get("arryRow");
ArrayList arryCol=null;
DecimalFormat dc=new DecimalFormat();
			dc.setGroupingUsed(false);
			dc.setMaximumFractionDigits(2);
			dc.setMinimumFractionDigits(2);
					String lreqterms = "0";
			lreqterms = Helper.correctInt((String) hshValues.get("loan_terms"));
			String loanrepaydate = "0";
			int repaymentperiod = 0;
			repaymentperiod = Integer.parseInt(lreqterms);				
			int z = Integer.parseInt(lreqterms);%>
<html>
<head>
<title>Amortization</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script>
function doPrint()
{
	window.print();
}
</script>
</head>

<body onblur="self.focus()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<form name="amtfrm" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
  <tr class="dataheader">
  <td align="right" width="20%"><b>&nbsp;Applicant Name :&nbsp;</b></td>
  <td align="left" width="30%">&nbsp;<%=request.getParameter("varappname")%>
  </td>
  <td align="right" width="20%"><b>&nbsp;Interest :</b>&nbsp;</td>
  <td align="left" width="30%">&nbsp;<%=request.getParameter("inttype")%> rate @ <%=request.getParameter("modIntRate")%> p.a
  </td>
  </tr>
</table>
     
  
<br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
          <tr class="dataheader"> 
            <td width="9%" align="center"> 
              <b>Month</b>
            </td>
            <td width="18%" align="center"> 
              <b>Loan Amount OS</b>
            </td>
            <td width="15%" align="center"> 
              <b>Interest Amt</b>
            </td>
            <td width="15%" align="center"> 
              <b>Principal Amt</b>
            </td>
            <td width="10%" align="center"> 
              <b>EMI</b>
            </td>
            <td width="15%" align="center"> 
             <b>Actual Amt Due</b>
            </td>
             <td width="18%" align="center"> 
              <b>Due Date of Installment</b>
            </td>
            
          </tr>
          <% {String Datevalue="";
          String installment=Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
          
          int x=0,i=0;
           x=Integer.parseInt(installment);//+1;
         
		  String pdate = Helper.correctNull((String)hshValues.get("txt_date"));
		  if(pdate.equalsIgnoreCase(""))
			  pdate=Helper.getCurrentDateTime();
		
  		  String duedate = "";
  		  int  pdays =  Integer.parseInt(pdate.substring(0,2));
  		  int pdays1=pdays;
  		  int leaps = 0;
		  int  pmonths= Integer.parseInt(pdate.substring(3,5));
		 
  		 int  pyears = Integer.parseInt(pdate.substring(6,10));
  		
  		//pmonths=pmonths+x;
  		
  		if(pmonths>12)
		{
  			int tempyear=pmonths/12;
  			
  			
			pmonths =pmonths%12;
			if(pmonths==0)
			{
				pmonths=12;
				tempyear--;
			}
			pyears = pyears +tempyear;
		}     
  		

		if(pmonths==1 || pmonths==3 || pmonths==5 || pmonths==7 || pmonths==8 || pmonths==10 || pmonths==12)
		{
			
				if(pdays==31)
			{
 			pdays = pdays+0;
 			pdays1=31;
			}
			else
			{
				pdays1=pdays;
			}
			
		}
		else if(pmonths==4 || pmonths==6 || pmonths==9 || pmonths==11)
		{
			if( pdays==31 || pdays1==30 )
			{
 			pdays = pdays+0;
 			pdays1=30;
			}
			else
			{
				pdays1=pdays;
			}
			
		
		}	
			leaps = pyears%4;
			 if((pmonths==2)&& (leaps==0))
				
			{	if(pdays==31 || pdays==30 || pdays==29 )
				{
				pdays1=29;
				}
			else
				{
					pdays1=pdays;
				}
			}
			else if(pmonths==2)
			{
				if(pdays==31 || pdays==30 || pdays==29 || pdays==28)
				{
				pdays1=28;
				}
				else
				{
					pdays1=pdays;
				}
			}

		if (pmonths<10)
		{
				duedate = Integer.toString(pdays1)+"/0"+Integer.toString(pmonths)+"/"+Integer.toString(pyears);
		}
		else
		{
				duedate = Integer.toString(pdays1)+"/"+Integer.toString(pmonths)+"/"+Integer.toString(pyears);
		}
		
          
  		%>
         <tr  class="datagrid">
                     
                              <td width="9%"  align="center">0 </td>
                              <td width="19%"  align="right"><%=dc.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblrequested_amount"))))%></td>
                              <td width="19%"  align="right">0 </td>
                              <td width="15%"  align="right">0 </td>
                              <td width="16%"  align="right">0 </td>
                              <td width="22%"align="right"><%=dc.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblrequested_amount"))))%> </td>
                           <td width="16%"  align="right"><%=duedate %></td> </tr>
          
          
          <%}
		  if(arryRow!=null && arryRow.size()>0)
		  {
			  String Datevalue="";
              String installment=Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
              int x=0;
               x=Integer.parseInt(installment)+1;
             
			  String pdate = Helper.correctNull((String)hshValues.get("txt_date"));
			  if(pdate.equalsIgnoreCase(""))
				  pdate=Helper.getCurrentDateTime();
	  		  String duedate = "";
	  		  int  pdays =  Integer.parseInt(pdate.substring(0,2));
	  		  int pdays1=pdays;
	  		  int leaps = 0;
			  int  pmonths= Integer.parseInt(pdate.substring(3,5));
			 
	  		 int  pyears = Integer.parseInt(pdate.substring(6,10));
	  		
	  		pmonths=pmonths+x;
	  		//pmonths=pmonths+1;
	  		
	  		if(pmonths>12)
			{
	  			int tempyear=pmonths/12;
	  			
	  			
				pmonths =pmonths%12;
				if(pmonths==0)
				{
					pmonths=12;
					tempyear--;
				}
				pyears = pyears +tempyear;
			}          
			for(int i=0;i<arryRow.size()-1;i++)
			{
				arryCol=(ArrayList)arryRow.get(i);
				if(arryCol!=null)
				{
					
					if(pmonths==1 || pmonths==3 || pmonths==5 || pmonths==7 || pmonths==8 || pmonths==10 || pmonths==12)
					{
						
							if(pdays==31)
						{
			 			pdays = pdays+0;
			 			pdays1=31;
						}
						else
						{
							pdays1=pdays;
						}
						
					}
					else if(pmonths==4 || pmonths==6 || pmonths==9 || pmonths==11)
					{
						if( pdays==31 || pdays1==30 )
						{
			 			pdays = pdays+0;
			 			pdays1=30;
						}
						else
						{
							pdays1=pdays;
						}
						
					
					}	
						leaps = pyears%4;
						 if((pmonths==2)&& (leaps==0))
							
						{	if(pdays==31 || pdays==30 || pdays==29 )
							{
							pdays1=29;
							}
						else
							{
								pdays1=pdays;
							}
						}
						else if(pmonths==2)
						{
							if(pdays==31 || pdays==30 || pdays==29 || pdays==28)
							{
							pdays1=28;
							}
							else
							{
								pdays1=pdays;
							}
						}
		
					if (pmonths<10)
					{
							duedate = Integer.toString(pdays1)+"/0"+Integer.toString(pmonths)+"/"+Integer.toString(pyears);
					}
					else
					{
							duedate = Integer.toString(pdays1)+"/"+Integer.toString(pmonths)+"/"+Integer.toString(pyears);
					}
					
					pmonths = pmonths + 1;
					if (pmonths>12)
					{
						pmonths = 1;
						pyears = pyears + 1;
					}
					loanrepaydate=duedate;
					if(i==0)
		 			{
		 				Datevalue = duedate; 
		 			}
					
		  %>
          <tr class="datagrid"> 
            <td width="9%" align="center"><%=(Integer)arryCol.get(0)%></td>
            <td width="17%" align="right"><%=dc.format((Double)arryCol.get(1))%></td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(2))%></td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(3))%></td>
            <td width="10%" align="right"><%=dc.format((Double)arryCol.get(4))%></td>
            <td width="10%" align="right"><%=dc.format((Double)arryCol.get(5))%></td>
            <td width="18%" align="center"><%=duedate%></td>
            
          </tr>
          <%
				}
			}
			arryCol=(ArrayList)arryRow.get(arryRow.size()-1);
			if(arryCol!=null)
			{
			%>
          <tr class="dataheader"> 
            <td width="9%" align="center"><%=(String)arryCol.get(0)%></td>
            <td width="17%">&nbsp;</td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(1))%></td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(2))%></td>
            <td width="10%" align="right"><%=dc.format((Double)arryCol.get(3))%></td>
            <td width="10%">&nbsp;</td>
			<td width="18%">&nbsp;</td>
          </tr>
          <%
			}
	
		  }
		  %>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="1%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable linebor">
    <tr> 
      <td valign="top">
          <input type="button" name="print" value="Print" class="buttonOthers"  onClick="doPrint();">
      </td>
      <td valign="top">
          <input type="button" name="close" value="Close" class="buttonclose"  onClick="window.close();">
      </td>
    </tr>
  </table>
</form>
</body>
</html>
