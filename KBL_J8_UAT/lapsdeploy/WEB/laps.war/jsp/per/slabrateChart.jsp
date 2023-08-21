<%@include file="../share/directives.jsp" %>
<%
	ArrayList arrRow = (ArrayList) hshValues.get("arrRow");
	String str[] = { "", "January", "February", "March", "April",
					"May", "June", "July", "August", "September", "October",
					"November", "December" };
					
					String loan_noofinstallment = "0";
					String loanrepaydate = "0";	
					loan_noofinstallment = Helper.correctNull((String) hshValues.get("loan_noofinstallment"));		
%>

<html>
<head>
<title>Slab Rate Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JAVASCRIPT">
	function doClose()
	{
			window.close();
	}
</script>
</head>

<body onblur="self.focus()">
<br>
<form name=amtfrm class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
</table>
     <br> <div align="center"><b>Slab Rate</b></div>
  
<br>
  <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataHeader"> 
            <td width="9%" > 
              <div align="center"><b>Month</b></div>
            </td>
            <td width="18%" > 
              <div align="center"><b>Loan 
                Amount OS</b></div>
            </td>
            <td width="15%" > 
              <div align="center"><b>Interest 
                Amt</b></div>
            </td>
            <td width="10%" > 
              <div align="center"><b>Premium</b></div>
            </td>
            <td width="15%" > 
              <div align="center"><b>Actual 
                Amt Due</b></div>
            </td>
            <td width="18%" > 
              <div align="center"><b>
                Due Date of Installment</b></div>
            </td>
          </tr>
          <% 
		
		 if(arrRow!=null && arrRow.size()>0)
		 {
		 
		   String Datevalue="";
              String installment=Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
            //installment = "0";
              int x=0;
               x=Integer.parseInt(installment)+1;
             
			  String pdate = Helper.correctNull((String)hshValues.get("txt_date"));
	  		  String duedate = "";
	  		  int  pdays =  Integer.parseInt(pdate.substring(0,2));
	  		  int pdays1=pdays;
	  		  int leaps = 0;
			  int  pmonths= Integer.parseInt(pdate.substring(3,5));
			 
	  		 int  pyears = Integer.parseInt(pdate.substring(6,10));
	  		
	  		pmonths=pmonths+x;
	  		
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
		 
		  ArrayList arrCol = new ArrayList(); 	 	
			 for(int i=0; i<arrRow.size(); i++)
			 {
			 arrCol = (ArrayList)arrRow.get(i); 
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
          <tr class="datGrid"> 
            <td width="9%" align="center">&nbsp;<%=i+1%></td>
            <td width="17%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))%></td>
            <td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
            <td width="10%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td>
            <td width="10%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
            <td width="18%" align="right">&nbsp;<%=duedate%></td>
          </tr>
          <% 
		  }
		  }
		   %>
          <tr class="datGrid"> 
            <td width="9%" align="center">&nbsp;</td>
            <td width="17%"><font color="#CC0000"></font></td>
            <td width="15%" align="right">&nbsp;</td>
            <td width="10%" align="center">&nbsp;</td>
            <td width="10%"><font color="#CC0000">&nbsp;</font></td>
            <td width="18%"><font color="#CC0000">&nbsp;</font></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
</form>
</body>
</html>
