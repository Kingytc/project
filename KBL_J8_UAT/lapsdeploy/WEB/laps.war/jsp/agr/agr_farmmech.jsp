
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%

request.setAttribute("_cache_refresh", "true"); %>

<laps:handleerror />
<%String strAppno=request.getParameter("app_no");


ArrayList arryColLiqAsset2=null;
ArrayList crop=(ArrayList)hshValues.get("crop");

ArrayList vecData = new ArrayList();
ArrayList vecRow = new ArrayList();

ArrayList vecData1 = new ArrayList();
ArrayList vecRow1 = new ArrayList();

ArrayList vecData2 = new ArrayList();
ArrayList vecRow2 = new ArrayList();
int vecsize = 0;
int vecsize2 = 0;

int vecsize1 = 0;
int vecsize12 = 0;

int vecsize3 = 0;
int vecsize13 = 0;
if (hshValues != null) 
{
	vecData = (ArrayList) hshValues.get("vecData");
	vecData1 = (ArrayList) hshValues.get("vecData1");
	vecData2 = (ArrayList) hshValues.get("vecData2");
}
double acreval = 0.00;
double centguntval = 0.00;
double totalacreval = 0.00;
double totalcentgunt =0.00; 
double guntasrealq = 0.00; 
double guntasrealr = 0.00;

double acreval1 = 0.00;
double centguntval1= 0.00;
double totalacreval1 = 0.00;
double totalcentgunt1 =0.00; 
double guntasrealq1 = 0.00; 
double guntasrealr1 = 0.00;

double acreval2 = 0.00;
double centguntval2= 0.00;
double totalacreval2 = 0.00;
double totalcentgunt2 =0.00; 
double guntasrealq2 = 0.00; 
double guntasrealr2 = 0.00;

double totA1=0.00;
double totB1=0.00;
double AminusB=0.00;

%>

<%
	double TotalLandHolding=0.00,dbTotal=0.00,dbUnirrigated=0.00,
			doubleloanamount=0.00,doublerepayment=0.00,doubletotal=0.00,
			dblandrevenue=0.0,dbinterest=0.00,dbbullock=0.00,dbfuel=0.00,
			dbdriver=0.00,dbinsurance=0.00,dbrepair=0.00,dbtotal1=0.00,dbtotalbm=0.00,
			dbtotalab=0.00,dbincome=0.00,dbtotal3=0.00,doublenetincomepost=0.0,dbloters=0.00;
	
	TotalLandHolding=Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalacreval")));
	
	
	dbTotal=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbTotal")));
	dbUnirrigated=(TotalLandHolding-dbTotal);
	
	doubleloanamount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("totloanamt")));
	doublerepayment=Double.parseDouble(Helper.correctDouble((String)hshValues.get("payment")));
	doublenetincomepost=Double.parseDouble(Helper.correctDouble((String)hshValues.get("netincpost")));
	doubletotal=(doubleloanamount+doublerepayment);
	
	dblandrevenue=Double.parseDouble(Helper.correctDouble((String)hshValues.get("landrevenue")));
	
	
	//dbinterest=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_interest")));
	//dbbullock=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_bullock_cost")));
	
	dbinterest=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_interest_am")));
	dbbullock=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_bullock_cost_am")));
	
	dbfuel=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_fuel_cost")));
	
	dbdriver=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_salary")));
	
	dbinsurance=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_insurence")));
	
	dbrepair=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_repair_cost")));
	dbloters=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_other_cost"))); 
	dbtotal1=(dblandrevenue)+(dbinterest)+(dbbullock+dbfuel)+(dbdriver)+(dbinsurance+dbrepair)+(dbloters);	
	
	dbtotalab=(doublenetincomepost-dbtotal1);
	
	
	
	dbincome=Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_cmember")));
	dbtotal3=(dbtotalab+dbincome);
	totA1=Double.parseDouble(Helper.correctDouble((String)hshValues.get("netincpre")));
	dbtotalbm=Double.parseDouble(Helper.correctDouble((String)hshValues.get("landrevenue")))+
			Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_interest_bm")))+
			Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_bullock_cost_bm")));
	AminusB=totA1-dbtotalbm;
	java.text.NumberFormat nf = java.text.NumberFormat
	.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css" />
</head>

<body>
<table width="96%" border="0" cellspacing="0" cellpadding="3" align="center">
  <tr> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr> 
          <td align="center" colspan="2"><strong>ECONOMICS OF FARM MECHANISATION</strong></td>
        </tr>
        <tr> 
          <td align="right" colspan="2">&nbsp;</td>
        </tr>
        <%
        String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
      	String measurementval="";
    	if(measurementtype.equalsIgnoreCase("c"))
	  		{
	 
	  			 measurementval = "Cents";
	 		 }
	 		 else
	  			{
					measurementval = "Guntas";
	 			}
        
        vecsize2 = vecData.size();
			for (int j = 0; j < vecsize2; j++) {
				vecRow = (ArrayList) vecData.get(j);
				if (vecRow != null) {
			
				  	acreval = Double.parseDouble(Helper.correctDouble((String) vecRow.get(2)));
				  	centguntval = Double.parseDouble(Helper.correctDouble((String)vecRow.get(3)));
					totalacreval = totalacreval + acreval;
					totalcentgunt = totalcentgunt + centguntval;
						}
					}
			 %>
      <%
            if(measurementtype.equalsIgnoreCase("g"))
  	  		{
      	 		        
					guntasrealq  = totalcentgunt % 40;
					guntasrealr   = totalcentgunt / 40 ;
					if(guntasrealr >= 1)
						{
							totalacreval = 	totalacreval + guntasrealr;
						}
					totalacreval = Math.floor(totalacreval);

			}
			else 
			{
					guntasrealq  = totalcentgunt % 100;
					guntasrealr   = totalcentgunt / 100 ;
					if(guntasrealr >= 1)
					{
						totalacreval = 	totalacreval + guntasrealr;
					}
					totalacreval = Math.floor(totalacreval);
			}
 
        %>
        
        
        <tr> 
          <td>Name of the Applicant: &nbsp; <%=Helper.correctNull((String)hshValues.get("appname"))%></td>
          <td align="right">Total land Holding: <%=totalacreval%>&nbsp;&nbsp;Acres&nbsp;&nbsp;<%=guntasrealq%>&nbsp;&nbsp;<%=measurementval%></td>
        </tr>
        
        <% 
        	vecsize12 = vecData1.size();
			for (int j = 0; j < vecsize12; j++) {
				vecRow1 = (ArrayList) vecData1.get(j);
				if (vecRow1 != null) {			
				  	acreval1 = Double.parseDouble(Helper.correctDouble((String) vecRow1.get(0)));
				  	centguntval1 = Double.parseDouble(Helper.correctDouble((String)vecRow1.get(1)));
					totalacreval1 = totalacreval1 + acreval1;
					totalcentgunt1 = totalcentgunt1 + centguntval1;
							}
					}
			 %>
      <%
            if(measurementtype.equalsIgnoreCase("g"))
  	  		{                 	 		        
					guntasrealq1  = totalcentgunt1 % 40;
					guntasrealr1   = totalcentgunt1 / 40 ;
					if(guntasrealr1 >= 1)
						{
							totalacreval1 = 	totalacreval1 + guntasrealr1;
						}
					totalacreval1 = Math.floor(totalacreval1);

			}
			else 
			{
			guntasrealq1  = totalcentgunt1 % 100;
			guntasrealr1   = totalcentgunt1 / 100 ;
			if(guntasrealr1 >= 1)
			{
				totalacreval1 = 	totalacreval1 + guntasrealr1;
			}
			totalacreval1 = Math.floor(totalacreval1);
			}
  
        %>
  
        <tr> 
          <td >Branch: &nbsp; <%=Helper.correctNull((String)hshValues.get("branchName"))%></td>
          <td align="right">Total Irrigated Land:<%=totalacreval1%>&nbsp;&nbsp;Acres&nbsp;&nbsp;<%=guntasrealq1%>&nbsp;&nbsp;<%=measurementval%></td>
        </tr>
        
        <%
       	 	vecsize13 = vecData2.size();
			for (int j = 0; j < vecsize13; j++) {
				vecRow2 = (ArrayList) vecData2.get(j);
				if (vecRow2 != null) {
		
					acreval2 = Double.parseDouble(Helper.correctDouble((String) vecRow2.get(0)));
					centguntval2 = Double.parseDouble(Helper.correctDouble((String)vecRow2.get(1)));
					totalacreval2 = totalacreval2 + acreval2;
					totalcentgunt2 = totalcentgunt2 + centguntval2;
									}
						}
		 %>
  <%
       			 if(measurementtype.equalsIgnoreCase("g"))
	  				{
             	 		        
						guntasrealq2  = totalcentgunt2 % 40;
						guntasrealr2   = totalcentgunt2 / 40 ;
						if(guntasrealr2 >= 1)
							{
								totalacreval2 = 	totalacreval2 + guntasrealr2;
							}
						totalacreval2 = Math.floor(totalacreval2);
						}
				else 
					{
						guntasrealq2  = totalcentgunt2 % 100;
						guntasrealr2   = totalcentgunt2 / 100 ;
						if(guntasrealr2 >= 1)
							{
								totalacreval2 = 	totalacreval2 + guntasrealr2;
							}
						totalacreval2 = Math.floor(totalacreval2);
							}
				    %>
        <tr> 
          <td align="center">&nbsp;</td>
          <td align="right">Total Unirrigated Land:<%=totalacreval2%>&nbsp;&nbsp;Acres&nbsp;&nbsp;<%=guntasrealq2%>&nbsp;&nbsp;<%=measurementval%></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
        <tr> 
          <td rowspan="2" align="center"><strong>Crops </strong></td>
          <td colspan="2" align="center"><strong>Area in Acres</strong></td>
          <td colspan="2" align="center"><strong>Cost of cultivation per Acre</strong></td>
          <td align="center" colspan="2"><strong>Total cost of cultivation</strong></td>
          <td align="center" colspan="2"><strong>Yield per acre in units</strong></td>
          <td colspan="2" align="center" ><strong>Total Yield in units</strong></td>
          <td colspan="2" align="center" ><strong>Sale price per unit</strong></td>
          <td colspan="2" align="center" ><strong>Total income</strong></td>
          <td colspan="2" align="center" ><strong>Net Surplus</strong></td>
        </tr>
        <tr> 
          <td align="center"><strong>BM</strong></td>
          <td align="center"><strong>AM</strong></td>
          <td  align="center"><strong>BM <%=ApplicationParams.getCurrency()%></strong></td>
          <td align="center"><strong>AM <%=ApplicationParams.getCurrency()%></strong></td>
          <td align="center"><strong>BM <%=ApplicationParams.getCurrency()%></strong></td>
          <td align="center"><strong>AM <%=ApplicationParams.getCurrency()%></strong></td>
          <td align="center"><b>BM</b></td>
          <td align="center"><b>AM</b></td>
          <td align="center"><b>BM</b></td>
          <td align="center"><b>AM</b></td>
          <td><strong>BM <%=ApplicationParams.getCurrency()%></strong></td>
          <td><strong>AM <%=ApplicationParams.getCurrency()%></strong></td>
          <td align="center"><strong>BM <%=ApplicationParams.getCurrency()%></strong></td>
          <td align="center"><strong>AM <%=ApplicationParams.getCurrency()%></strong></td>
          <td align="center" nowrap><strong>BM <%=ApplicationParams.getCurrency()%></strong></td>
          <td align="center" nowrap><strong>AM <%=ApplicationParams.getCurrency()%></strong></td>
        </tr>
        <%
            if(crop!=null && crop.size()>0)
		{
   		   for(int j=1;j<crop.size()+1;j++)
		   {
			arryColLiqAsset2=(ArrayList)crop.get(j-1);
			
		        %>
        <tr> 
          <td>&nbsp;<%=arryColLiqAsset2.get(3)%></td>
          <td align="right">&nbsp;<%=arryColLiqAsset2.get(4)%></td>
          <td align="right">&nbsp;<%=arryColLiqAsset2.get(5)%></td>
          <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(20))))%></td>
          <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(7))))%></td>
          <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(8))))%></td>
          <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(9))))%></td>
          <td>&nbsp;<%=arryColLiqAsset2.get(10)%></td>
          <td>&nbsp;<%=arryColLiqAsset2.get(11)%></td>
          <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(12))))%></td>
          <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(13))))%></td>
          <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(14))))%></td>
          <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(15))))%></td>
          <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(16))))%></td>
          <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(17))))%></td>
          <td nowrap align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(18))))%></td>
          <td nowrap align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryColLiqAsset2.get(19))))%></td>
        </tr>
        <%
		 }
	      }
      	     %>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td colspan="2" align="right"><b>Total (A)</b></td>
          <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("netincpre"))))%></td>
          <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("netincpost"))))%></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="2">
        
        <tr> 
          <td width="24%">BM: Before Mechanization</td>
          <td width="9%">&nbsp;</td>
          <td width="41%">&nbsp;</td>
          <td width="3%">&nbsp;</td>
          <td align="right" width="9%"><b>BM </b></td>
          <td align="right" width="14%"><b>AM </b></td>
        </tr>
        <tr> 
          <td width="24%">AM: After Mechanization</td>
          <td width="9%">&nbsp;</td>
          <td width="41%"><strong>LESS OTHER EXPENSES</strong></td>
          <td width="3%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="14%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="41%">Land Revenue :</td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("landrevenue"))))%></td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("landrevenue"))))%></td>
        </tr>
        <tr> 
          <td width="24%">Loan Amount :</td>
          <td width="9%" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamount"))))%> 
          </td>
          <td width="41%">Interest on Crop Loan :</td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_interest_bm"))))%></td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_interest_am"))))%></td>
        </tr>
        <tr> 
          <td width="24%">Repayment Schedule :</td>
          <td width="9%">&nbsp;<%=Helper.correctNull((String)hshValues.get("bullock_holiday"))%> 
            &nbsp;<%=Helper.correctNull((String)hshValues.get("selperiod"))%> </td>
          <td width="41%">Cost of maintenance of bullocks :</td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_bullock_cost_bm"))))%></td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_bullock_cost_am"))))%></td>
        </tr>
		<%
			//String calc="";int yr;
			double loan_amt = Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamount")));
			double repay_schedule = Double.parseDouble(Helper.correctDouble((String)hshValues.get("bullock_holiday")));
			double dblperiod = Double.parseDouble(Helper.correctDouble((String)hshValues.get("period")));
			double amt=0.0;
			//int amt=Integer.parseInt(loan_amt);
			//double amt=loan_amt/12;
			if(dblperiod!=0.0)
			{
				amt=(loan_amt/(repay_schedule*dblperiod))*12;
			}
		%>
		
		
        <tr> 
          <td width="24%">Total yearly payment(for 12 months) : </td>
          <%if(dblperiod!=0.0){ %>
          <td width="9%" >&nbsp;<%=nf.format(amt)%> 
          <%}else{ %>
          <td width="9%" >&nbsp;
          <%} %>
          </td>
          <td width="41%">Fuel and Lubricants </td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right">0.00</td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_fuel_cost"))))%></td>
        </tr>
        <tr> 
          <td width="24%">Total</td>
          <td width="9%" >&nbsp;<%=Helper.formatDoubleValue(doubletotal)%> </td>
          <td width="41%">Driver's Salary:</td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right">0.00</td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_salary"))))%></td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="41%">Insurance and Taxes :</td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right">0.00</td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_insurence"))))%></td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="41%">Repairs &amp; Maintenance:</td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right">0.00</td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_repair_cost"))))%></td>
        </tr>
		<tr> 
          <td width="24%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="41%">Others</td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right">0.00</td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_other_cost"))))%></td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="41%"><b>Total (B)</b></td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%> </td>
          <td width="9%" align="right"><%=Helper.formatDoubleValue(dbtotalbm)%></td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(dbtotal1)%></td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="41%"><strong>A-B </strong></td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right"><%=Helper.formatDoubleValue(AminusB)%></td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(dbtotalab)%></td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="41%">Add:Income from custom service Hiring for &nbsp;<b><%=Helper.correctNull((String)hshValues.get("agr_cmachinery"))%></b> 
            &nbsp; hours @ <b><%=ApplicationParams.getCurrency()%></b> &nbsp; 
            <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_ratehour"))))%></b> 
            &nbsp; per hour&nbsp;&nbsp;<b>(C)</b></td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right">0.00</td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("agr_cmember"))))%></td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td width="9%">&nbsp;</td>
          <td width="41%"><b>Total (A-B+C)=D</b></td>
          <td width="3%" align="right"><%=ApplicationParams.getCurrency()%></td>
          <td width="9%" align="right"><%=Helper.formatDoubleValue(AminusB)%></td>
          <td align="right" width="14%"><%=Helper.formatDoubleValue(dbtotal3)%></td>
		  <%double dbnetincome=0.00;
		  dbnetincome=dbtotal3-AminusB;%>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td colspan="4" >Net Incremental Income:-(D1-D2) =<%=ApplicationParams.getCurrency()%> 
            <%=Helper.formatDoubleValue(dbnetincome)%></td>
          <td width="14%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td colspan="4" align="right">
            </td>
          <td width="14%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="24%">&nbsp;</td>
          <td colspan="4" align="right"><b>Signature</b>
            </td>
          <td width="14%">&nbsp;</td>
        </tr>
         <tr> 
          <td width="24%">&nbsp;</td>
          <td colspan="4" align="right">
            </td>
          <td width="14%">&nbsp;</td>
        </tr>
        
         <tr> 
          <td width="24%">&nbsp;</td>
          <td colspan="14" align="right"><b>Name of the processing officer</b>
            </td>
          <td width="14%">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
 
</table>
<input type=hidden name="app_no" value="<%=strAppno%>"> 
</body>
</html>
