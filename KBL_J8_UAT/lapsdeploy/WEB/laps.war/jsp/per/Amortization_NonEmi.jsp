<%@include file="../share/directives.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
java.text.NumberFormat nf = java.text.NumberFormat
.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
  if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   } 
	int vecsize= 0;   
		
	String strPageFrom = Helper.correctNull((String)hshValues.get("pageFrom"));
	String strFacAmt = Helper.correctNull((String)hshValues.get("strDiff"));
	String strAppno = Helper.correctNull((String) hshValues.get("strAppno"));
	if(strAppno.equalsIgnoreCase(""))
		strAppno = Helper.correctNull((String) hshValues.get("appno"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	ArrayList arryRow=new ArrayList();
	ArrayList arryCol=new ArrayList();
	ArrayList arrtlrec=new ArrayList();
	ArrayList arrCol = new ArrayList();
	DecimalFormat dc=new DecimalFormat();
	dc.setGroupingUsed(false);
	dc.setMaximumFractionDigits(2);
	dc.setMinimumFractionDigits(2);
	String loanrepaydate = "0";
	
if(hshValues!=null)
{	
	 arryRow=(ArrayList)hshValues.get("arryRow");
}
if (hshValues != null) {
	//arrtlfac =(ArrayList)hshValues.get("arrtlfac");
	arrtlrec = (ArrayList) hshValues.get("arrtlrec");
}
double dblTotalInstAmt = 0.000;
double dblTotalInstPeriod = 0.000;
String strCatName = "";
String strstrfacamt = Helper.correctNull((String) hshValues.get("strfacamt"));
if(strCategoryType.equals("CORPORATE")||strCategoryType.equals("CORP") )
{
	strCategoryType ="CORP";
	strCatName="Corporate";
	
}
else if(strCategoryType.equals("OPS"))
{
	strCatName="Tertiary";
}else if(strCategoryType.equals("SME") || strCategoryType.equals("SSI"))
{
	strCatName="Corporate";
}
%>
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
  <td align="right" width="20%"><b>&nbsp;Proposal Number:&nbsp;</b></td>
  <td align="left" width="30%">&nbsp;<%=strAppno%>
  </td>
  <%if(strSessionModuleType.equals("CORP")){%>
  <td align="right" width="20%"><b>&nbsp;Facility :</b>&nbsp;</td>
  <td align="left" width="30%">&nbsp;<%=Helper.correctNull((String)hshValues.get("selfacility"))%>-<%= Helper.correctNull((String)hshValues.get("FacilityDesc")) %>
  </td>
  <%}else if(strSessionModuleType.equals("AGR")){%>
   <td align="right" width="20%"><b>&nbsp;Facility :</b>&nbsp;</td>
  <td align="left" width="30%">&nbsp;<%=Helper.correctNull((String)hshValues.get("selfacility"))%>-<%=Helper.correctNull((String)hshValues.get("FacilityDesc")) %>
  </td>
  <%}else{ %> 
  <td align="right" width="20%"><b>&nbsp;Product :</b>&nbsp;</td>
  <td align="left" width="30%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strprd_desc"))%>
  </td>
  <%} %>
  </tr>
</table>
     
  
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td> 
      <%if(strPageFrom.equalsIgnoreCase("emi")){%>
	<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
          <tr class="dataheader"> 
            <td width="9%" align="center"> 
              <b>Month</b>
            </td>
            <td width="16%" align="center"> 
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
             <td width="22%" align="center" nowrap="nowrap"> 
              <b>Due Date of Installment</b>
            </td>
            
          </tr>
          <% 
        if(arryRow!=null && arryRow.size()>0)
		  {
			  String Datevalue="";
              String installment=Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
              String strInterestcharged=Helper.correctNull((String)hshValues.get("sel_interestcharge"));
              int x=0;
               x=Integer.parseInt(installment)+1;
             
			  String pdate = Helper.correctNull((String)hshValues.get("txt_date"));
			
	  		  String duedate = "";
	  		  int  pdays =  Integer.parseInt(pdate.substring(0,2));
	  		  int pdays1=pdays;
	  		  int leaps = 0;
			  int  pmonths= Integer.parseInt(pdate.substring(3,5));
			 
	  		 int  pyears = Integer.parseInt(pdate.substring(6,10));
	  		if(!strInterestcharged.equalsIgnoreCase("2"))
	  			pmonths=pmonths+x;
	  		else
	  			pmonths=pmonths+1;
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
            <td width="16%" align="right"><%=dc.format((Double)arryCol.get(1))%></td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(2))%></td>
            <td width="15%" align="right"><%=dc.format((Double)arryCol.get(3))%></td>
            <td width="10%" align="right"><%=dc.format((Double)arryCol.get(4))%></td>
            <td width="10%" align="right"><%=dc.format((Double)arryCol.get(5))%></td>
            <td width="22%" align="center"><%=duedate%></td>
            
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
        <%} %>
        <%if(strPageFrom.equalsIgnoreCase("Nonemi")){ %>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <TR>
				<TD>
				<TABLE WIDTH="90%" BORDER="1" align="center" CELLSPACING="0"
					CELLPADDING="1" CLASS="outertable">
					<TR>
						<TD>

						<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="2"
							CLASS="outertable">
							<TR CLASS="dataheader">
							 <%if(strSessionModuleType.equals("CORP")||strSessionModuleType.equals("AGR")){%>
								<TD WIDTH="30%" ALIGN="center">Facility</TD>
								<%} %>
								<TD WIDTH="20%" ALIGN="center">Frequency</TD>
								<TD WIDTH="15%" ALIGN="center">No of Installment</TD>
								<TD WIDTH="15%" ALIGN="center">Amount of Installment</TD>
								<TD ALIGN="center" colspan="2" WIDTH="15%">Total</TD>
							</TR>
							<%
								if (arrtlrec != null) {
									for (int i = 0; i < arrtlrec.size(); i++) {
										arrCol = new ArrayList();
										arrCol = (ArrayList) arrtlrec.get(i);
										//out.println("arrCol"+arrCol);
							%>
							<TR CLASS="datagrid">
							 <%if(strSessionModuleType.equals("CORP")||strSessionModuleType.equals("AGR")){%>
								<TD ALIGN="left"><%=Helper.correctNull((String) arrCol.get(6))%></TD>
								<%} %>
								<%
									String frq = Helper.correctNull((String) arrCol.get(2));
											if (frq.equalsIgnoreCase("M"))
												frq = "Monthly";
											else if (frq.equalsIgnoreCase("Y"))
												frq = "Yearly";
											else if (frq.equalsIgnoreCase("Q"))
												frq = "Quarterly";
											else if (frq.equalsIgnoreCase("H"))
												frq = "Half Yearly";
											else
												frq = "";
								%>
								<TD align="center"><%=frq%></TD>
								<TD align="center"><%=Helper.correctNull((String) arrCol.get(3))%></TD>
								<TD align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%></TD>
								<TD align="right" colspan="2"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(5))))%></TD>
							</TR>
							<%
								dblTotalInstAmt += Double.parseDouble(Helper.correctDouble((String) arrCol.get(5)));
								dblTotalInstPeriod += Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
									}
								}
							%>
							<TR>
							 <%if(strSessionModuleType.equals("CORP")||strSessionModuleType.equals("AGR")){%>
								<TD COLSPAN="4" ALIGN="right"></TD>
								<%}else{ %>
								<TD COLSPAN="3" ALIGN="right"></TD>
								<%} %>
								<TD ALIGN="right" width="15%"><b>Total</b></TD>
								<TD ALIGN="right" width="15%"><INPUT TYPE="hidden" name="hidTotalsancamt" value="<%=dblTotalInstAmt%>">
								<b><%=nf.format(dblTotalInstAmt)%></b></TD>

							</TR>
						</TABLE>
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
			</table>
			<%} %>
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