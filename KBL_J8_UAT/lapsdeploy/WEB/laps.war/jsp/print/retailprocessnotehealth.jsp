<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
ArrayList arryCol=null;
ArrayList arryRow=(ArrayList)hshValues.get("arrAsset");

double total_amt=0.00;
double cost1=0.00,cost2=0.00;

String res=Helper.correctNull((String)hshValues.get("auto_category"));
ArrayList arrydocCol = null;
ArrayList arrydocRow = (ArrayList) hshValues.get("arrDocsId");

ArrayList vecCol = null;
ArrayList vecRow = (ArrayList) hshValues.get("vecGuarantor");
ArrayList vecCoApp_col = null;
ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");

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
%>
<%
double total = 0.00;
	 
	 ArrayList  arrCollateral=(ArrayList)hshValues.get("arrCollateral");
	 ArrayList  arrInvestment=(ArrayList)hshValues.get("arrInvestment");
	 ArrayList  arrInsurance=(ArrayList)hshValues.get("arrInsurance");
	 ArrayList  arrPerAuto=(ArrayList)hshValues.get("arrPerAuto");	
	 ArrayList  arrAsset=(ArrayList)hshValues.get("arrAsset");	
	 //ArrayList  arrProposed=(ArrayList)hshValues.get("arrProposed");	   
	 //ArrayList  arrAsset=(ArrayList)hshValues.get("arrAsset");	   
	
	
	
int calMonth=0;
String date="";
String Month="0";
String year="0";
String calYear="";
//String loan_noofinstallment = "0";	
String dates=Helper.correctNull((String) hshValues.get("app_processdate"));
String installments=Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
String strloanterms=Helper.correctNull((String)hshValues.get("lreqterms")); 

int x=0,y=0;
 x=Integer.parseInt(installments)+1;
 y=Integer.parseInt(strloanterms);



if(!dates.equals(""))
{

	StringTokenizer tokenizer1 = new StringTokenizer(dates, "/");

	while (tokenizer1.hasMoreTokens()) 
	{
		date=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		Month=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		year=Helper.correctNull((String)tokenizer1.nextToken()).trim();
		calYear=year;
		
	}

}
else
{
	 Month="0";
}

int month=0;
month=Integer.parseInt(Month);
int TOTMonths=0;
TOTMonths=month+x;
int valMonth1=0;
int valMonth2=0;
int valMonth=TOTMonths;
int a=0;
int temp=0;
int curyear=0;

if(valMonth<12 || valMonth==12)
{
	if(!calYear.equalsIgnoreCase(""))
	{
		curyear=0+Integer.parseInt(calYear);
	}
	else
	{
		curyear=0;
	}
}
if(valMonth>12)
{
	 valMonth1=valMonth/12;
	 valMonth2=valMonth%12;
	 if(valMonth2==0)
	 {
		 calMonth=12;
		 
	 }
	 else
	 {	 
		temp=valMonth1*12;
		
		if(!calYear.equals(""))
		{				
			curyear=(valMonth1)+Integer.parseInt(calYear);
		}
		
		 valMonth2=valMonth-temp;
		 calMonth=valMonth2;	 
	}
}
else
{
	 calMonth=valMonth;
}
	
	 String Months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
	 if(!dates.equals(""))
	 {
	 	a=calMonth;
	 }
	 else
	 {
		 a=0;
	 }
	 
	 
	 int a1=0;
	 int endMonth=0;
	 endMonth=month+y;
	 int curyear1=0;
	 //for computing end date 
	 if(endMonth<12 || endMonth==12)
	 {
	 	if(!calYear.equalsIgnoreCase(""))
	 	{
	 		curyear1=0+Integer.parseInt(calYear);
	 	}
	 	else
	 	{
	 		curyear1=0;
	 	}
	 }
	 if(endMonth>12)
	 {
	 	 valMonth1=endMonth/12;
	 	 valMonth2=endMonth%12;
	 	 if(valMonth2==0)
	 	 {
	 		 calMonth=12;
	 		 
	 	 }
	 	 else
	 	 {	 
	 		temp=valMonth1*12;
	 		
	 		if(!calYear.equals(""))
	 		{				
	 			curyear1=(valMonth1)+Integer.parseInt(calYear);
	 		}
	 		
	 		 valMonth2=endMonth-temp;
	 		 calMonth=valMonth2;	 
	 	}
	 }
	 else
	 {
	 	 calMonth=endMonth;
	 }
	 String Months1[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
	 if(!dates.equals(""))
	 {
	 	a1=calMonth;
	 }
	 else
	 {
		 a1=0;
	 }
	 ArrayList arrRow=(ArrayList)hshValues.get("mailcomments");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>

<body>
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
      <table width="100%" border="0" cellspacing="0" cellpadding="5" bordercolor="#999999">
        <tr> 
          <td colspan="3" class="td_bg"><strong >PROCESS CUM SANCTION - UNION 
            HEALTH </strong></td>
        </tr>
      <%  String perapp_title=Helper.correctNull((String) hshValues.get("Title"));
      %>
        <tr> 
          <td width="44%" valign="top">1(a)  Name of the Applicant/s</td>
          <td width="1%">:</td>
          <td width="55%"><b><%=perapp_title%>&nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%></b><br>
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
          <td>1(b) Branch Name</td>
          <td>:</td>
          <td>&nbsp;<b><%=Helper.correctNull((String) hshValues.get("cus_org_name"))%></b></td>
        </tr>
        <tr> 
          <td>2.Constitution</td>
          <td>:</td>
          <td><b><%=Helper.correctNull((String) hshValues.get("Constitution"))%></b>
           <% if(vecCoApp_Row!=null)
        	{
        		for(int i=0;i<vecCoApp_Row.size();i++)
        		{
        			vecCoApp_col=(ArrayList)vecCoApp_Row.get(i);
        			if(vecCoApp_col!=null)
        			{	
        				String Constitution=Helper.correctNull((String) vecCoApp_col.get(11));
        %>
        				<br><b><%out.println(Constitution); %></b>
        <%			}
        		}
        	}%>
          </td>
        </tr>
        <tr> 
          <td>3.Date of establishment</td>
          <td>:</td>
          <td><b><%=Helper.correctNull((String) hshValues.get("perapp_dob"))%></b></td>
        </tr>
        <tr> 
          <td>4. Occupation </td>
          <td>:</td>
          <td>
            <% String Occpation="";
		String perapp_eduothers=Helper.correctNull((String) hshValues.get("perapp_eduothers"));
			String appOccupation=getOccupation(perapp_eduothers);%>
			<b><% out.println(appOccupation);
		if(vecCoApp_Row!=null  && vecCoApp_Row.size()>0)
        	{
        		for(int i=0;i<vecCoApp_Row.size();i++)
        		{
        			vecCoApp_col=(ArrayList)vecCoApp_Row.get(i);
        			if(vecCoApp_col!=null)
        			{	
        				Occpation=Helper.correctNull((String) vecCoApp_col.get(12));
        				
        				String s=getOccupation(Occpation);%><br>
        				<b><%out.println(s); %></b>
        <%			}
        		}
        	}%>
		<%!String occuval="";
		String getOccupation(String Occpation)
		{			
					if(Occpation.equalsIgnoreCase("1_S")) 
					{
						occuval= "Employee - ";
					}
					else if(Occpation.equalsIgnoreCase("1_1")) 
					{
						occuval= "Employee - Educational Institutions";
					}
					else if(Occpation.equalsIgnoreCase("1_2")) 
					{
						occuval= "Employee - Govt. Local Bodies";
					}
					else if(Occpation.equalsIgnoreCase("1_3")) 
					{
						occuval= "Employee - State Govt.";
					}
					else if(Occpation.equalsIgnoreCase("1_4")) 
					{
						occuval= "Employee - Central Govt";
					}
					else if(Occpation.equalsIgnoreCase("1_5")) 
					{
						occuval= "Employee - Pvt Company";
					}
					else if(Occpation.equalsIgnoreCase("1_6")) 
					{
						occuval= "Employee - Others";
					}
					else if(Occpation.equalsIgnoreCase("2_S")) 
					{
						occuval= "Business Man - ";
					}
					/*else if(Occpation.equalsIgnoreCase("2_1")) 
					{
						occuval= "Business Man-Traders - Retail";
					}
					else if(Occpation.equalsIgnoreCase("2_2")) 
					{
						occuval= "Business Man-Govt. Traders - Whole Sales";
					}
					else if(Occpation.equalsIgnoreCase("2_3")) 
					{
						occuval= "Business Man-Self Employed.";
					}
					else if(Occpation.equalsIgnoreCase("2_4")) 
					{
						occuval= "Business Man-Transport Operator";
					}*/
					else if(Occpation.equalsIgnoreCase("3_S")) 
					{
						occuval= "Professionals - ";
					}
					else if(Occpation.equalsIgnoreCase("3_1")) 
					{
						occuval= "Professionals - Advocate";
					}
					else if(Occpation.equalsIgnoreCase("3_2")) 
					{
						occuval= "Professionals - Doctor";
					}
					else if(Occpation.equalsIgnoreCase("3_3")) 
					{
						occuval= "Professionals - Architect";
					}
					else if(Occpation.equalsIgnoreCase("3_4")) 
					{
						occuval= "Professionals - C.A.";
					}
					else if(Occpation.equalsIgnoreCase("3_5")) 
					{
						occuval= "Professionals - Others";
					}
					else if(Occpation.equalsIgnoreCase("4_S")) 
					{
						occuval= "Agriculture and allied activities -";
					}
					else if(Occpation.equalsIgnoreCase("4_1")) 
					{
						occuval= "Agriculture and allied activities - Marginal Farmer";
					}
					else if(Occpation.equalsIgnoreCase("4_2")) 
					{
						occuval= "Agriculture and allied activities - Small Farmer";
					}
					else if(Occpation.equalsIgnoreCase("4_3")) 
					{
						occuval= "Agriculture and allied activities - Other Farmer.";
					}
					else if(Occpation.equalsIgnoreCase("4_4")) 
					{
						occuval= "Agriculture and allied activities - Tenant Farmer";
					}
					else if(Occpation.equalsIgnoreCase("4_5")) 
					{
						occuval= "Agriculture and allied activities - Share Cropper";
					}
					else if(Occpation.equalsIgnoreCase("4_6")) 
					{
						occuval= "Agriculture and allied activities - Agriculture Labor";
					}
					else if(Occpation.equalsIgnoreCase("4_7")) 
					{
						occuval= "Agriculture and allied activities - Other Labor";
					}
					else if(Occpation.equalsIgnoreCase("4_8")) 
					{
						occuval= "Agriculture and allied activities - Landless Farmer";
					}
					else if(Occpation.equalsIgnoreCase("4_9")) 
					{
						occuval= "Agriculture and allied activities - Fisher man";
					}
					else if(Occpation.equalsIgnoreCase("4_10")) 
					{
						occuval= "Agriculture and allied activities - veteran";
					}
					
					else if(Occpation.equalsIgnoreCase("5_S")) 
					{
						occuval="Retail Trade - ";	
						//occuval= "Non Govt. Organization-";
					}
					else if(Occpation.equalsIgnoreCase("6_S")) 
					{
						occuval= "SME (Services) - ";
					}
					else if(Occpation.equalsIgnoreCase("6_1")) 
					{
						occuval= "SME (Services) - Traders - Retail";
					}
					else if(Occpation.equalsIgnoreCase("6_2")) 
					{
						occuval= "SME (Services) - Traders - Whole Sales";
					}
					else if(Occpation.equalsIgnoreCase("7_S")) 
					{
						occuval= "SME (Manufacturing) - ";
					}
					else if(Occpation.equalsIgnoreCase("7_1")) 
					{
						occuval= "SME (Manufacturing) - Small Business";
					}
					else if(Occpation.equalsIgnoreCase("7_2")) 
					{
						occuval= "SME (Manufacturing) - Professional and Selfemployed";
					}
					else if(Occpation.equalsIgnoreCase("7_3")) 
					{
						occuval= "SME (Manufacturing) - SWRTO";
					}
					else if(Occpation.equalsIgnoreCase("7_4")) 
					{
						occuval= "SME (Manufacturing) - Others";
					}
					else if(Occpation.equalsIgnoreCase("8_S")) 
					{
						occuval= "Pensioner - ";
					}
					/*else if(Occpation.equalsIgnoreCase("8_1")) 
					{
						occuval= "Industry Small - Handicraftsman";
					}
					else if(Occpation.equalsIgnoreCase("8_2")) 
					{
						occuval= "Industry Small - Village & Cottage industries";
					}
					else if(Occpation.equalsIgnoreCase("8_3")) 
					{
						occuval= "Industry Small-Tiny Sectors.";
					}
					else if(Occpation.equalsIgnoreCase("8_4")) 
					{
						occuval= "Industry Small-Rural Artisans";
					}*/
					
					else if(Occpation.equalsIgnoreCase("9_S")) 
					{
						occuval= "Student - ";
					}
					/*else if(Occpation.equalsIgnoreCase("9_1")) 
					{
						occuval= "Pensioner-Small Trader";
					}
					else if(Occpation.equalsIgnoreCase("9_2")) 
					{
						occuval= "Pensioner - Self Employed";
					}
					else if(Occpation.equalsIgnoreCase("9_3")) 
					{
						occuval= "Pensioner-Small Business.";
					}
					else if(Occpation.equalsIgnoreCase("9_4")) 
					{
						occuval= "Pensioner-Transport Operator";
					}
					else if(Occpation.equalsIgnoreCase("9_5")) 
					{
						occuval= "Pensioner-Architect";
					}
					else if(Occpation.equalsIgnoreCase("9_6")) 
					{
						occuval= "Pensioner-Consultancy";
					}
					else if(Occpation.equalsIgnoreCase("9_7")) 
					{
						occuval= "Pensioner-Agriculturist";
					}
					else if(Occpation.equalsIgnoreCase("9_8")) 
					{
						occuval= "Pensioner-Handi Crafts Man";
					}
					else if(Occpation.equalsIgnoreCase("9_9")) 
					{
						occuval= "Pensioner-Contractor";
					}
					else if(Occpation.equalsIgnoreCase("9_10")) 
					{
						occuval= "Pensioner-Retainer";
					}
					else if(Occpation.equalsIgnoreCase("9_11")) 
					{
						occuval= "Pensioner-Others";
					}*/
					else if(Occpation.equalsIgnoreCase("10_S")) 
					{
						occuval= "Others - ";
					}
					/*else if(Occpation.equalsIgnoreCase("11_S")) 
					{
						occuval= "Other-";
					}*/
					/*else if(Occpation.equalsIgnoreCase("12_S")) 
					{
						occuval= "Other-";
					}*/
			return occuval;
		}
        	%>
        	
            </td>
        </tr>
        <tr> 
          <td>5. Means of the applicant/s <b>(Rs. in Lacs)</b></td>
          <td>:</td>
          <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("CR_Total_MEANS"))%><br>
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
        <tr> 
          <td>6. Present monthly / annual income of the applicants </td>
          <td>:</td>
          <td><b>Monthly :Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("permonsalary"))))%><br>
            	 Yearly :Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("peryearsalary"))))%>,<br></b>
  		
  		
  		<% if(vecCoApp_Row!=null)
    	{
    		for(int i=0;i<vecCoApp_Row.size();i++)
    		{
    			vecCoApp_col=(ArrayList)vecCoApp_Row.get(i);
    			if(vecCoApp_col!=null)
    			{	
    				String monsal=Helper.correctNull((String) vecCoApp_col.get(13));
    				String yrsal=Helper.correctNull((String) vecCoApp_col.get(14));
    %>
    				<b>Monthly: Rs.<%=monsal%>&nbsp;<br>Yearly : Rs.<%=yrsal%>,</b><br>
    <%			}
    		}
    	}%>
      </td>
        </tr>
        <tr> 
          <td>7. Purpose of Loan </td>
          <td>:</td>
          <td>&nbsp;<b><%=Helper.correctNull((String) hshValues.get("loan_purposeofloan"))%></b></td>
        </tr>
        
        <%
					  for(int i=1;i<11;i++)
					  {
					  	if(arryRow!=null && arryRow.size()>=i)
						{
							arryCol=(ArrayList)arryRow.get(i-1);
					  %>
                      <% 
					  double temp1  = Double.parseDouble(Helper.correctDouble((String)arryCol.get(2)));
					  total = temp1 + total;
						}
					  }
					  %>
        
        <tr> 
          <td align="justify">8.I. &nbsp;Cost of Equipment </td>
          <td>:</td>
          <td>Rs.<b><%=Helper.formatDoubleValue(total)%></b></td>
        </tr>
        <tr> 
          <td align="justify">&nbsp;II.&nbsp; Estimated cost of construction 
            / Cost of building as per quotations / estimates submitted </td>
          <td>:</td>
          <td>Rs.<b><%=Helper.correctNull((String) hshValues.get("prop_estimatecost"))%></b></td>
        </tr>
        
        <%
        	
        if(res.equalsIgnoreCase(""))
        {
        	
        	%><tr> 
            <td align="justify">&nbsp;III.&nbsp; Cost of Vehicles </td>
            <td>:</td>
            <td>Rs.<b></b></td>
          </tr>
        <% }%>  
        	<% 
        	 if(res.equalsIgnoreCase("1"))
        	{
        		                 
        %>
        
        <tr> 
          <td align="justify">&nbsp;III.&nbsp; Cost of Vehicles </td>
          <td>:</td>
          <td>Rs.<b><%=Helper.correctNull((String) hshValues.get("total_newvehicle"))%></b></td>
        </tr>
        <%
        	}
        	 if(res.equalsIgnoreCase("2"))
        		{
        		
        %>
        <tr> 
          <td align="justify">&nbsp;III.&nbsp; Cost of Vehicles </td>
          <td>:</td>
          <td>Rs.<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("auto_leastvalue"))))%></b></td>
        </tr>
        <%		
        	}
      	
        	
        	%>
        	
        	
        	<%
        	
        	String totcost1=Helper.correctNull((String) hshValues.get("prop_estimatedprice"));
        	
        	if((totcost1.equalsIgnoreCase("")||totcost1.equalsIgnoreCase("null")))
        	{
        		totcost1="0.00";
        	}
        	
        	cost1=Double.parseDouble(totcost1);
        	
        	String total_newvehicle=Helper.correctNull((String)hshValues.get("total_newvehicle"));
        	
        	if((total_newvehicle.equalsIgnoreCase("")||total_newvehicle.equalsIgnoreCase("null")))
        	{
        		total_newvehicle="0.00";
        	}
        	
        	String auto_leastvalue=Helper.correctNull((String)hshValues.get("auto_leastvalue"));
        	
        	if((auto_leastvalue.equalsIgnoreCase("")||auto_leastvalue.equalsIgnoreCase("null")))
        	{
        		auto_leastvalue="0.00";
        	}
        	
        	if(res.equalsIgnoreCase("1"))
        	cost2=Double.parseDouble(total_newvehicle);
        	else
        	cost2=Double.parseDouble(auto_leastvalue);	
        	total_amt=cost1+cost2+total;
        	%>
        	
        	
        <tr> 
          <td align="justify">Total Amount </td>
          <td>:</td>
          <td>Rs.<b><%=Helper.formatDoubleValue(total_amt)%></b></td>
        </tr>
        <tr> 
          <td>9. Margin </td>
          <td>:</td>
          <td>Rs.<b><%=Helper.formatDoubleValue(display_margin)%></b></td>
        </tr>
        <tr> 
          <td>10. Eligible quantum of loan </td>
          <td>:</td>
          <td> Rs. <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("loan_margin_amt"))))%></b></td>
        </tr>
        <tr> 
          <td>11. Date of pre-sanction Inspection</td>
          <td>:</td>
          <td><b><%=Helper.correctNull((String)hshValues.get("pre_visitdate"))%></b></td>
        </tr>
        <tr> 
          <td>12. Rate of Interest </td>
          <td>:</td>
          <td><b><%=Helper.correctNull((String) hshValues.get("mintrate"))%> &nbsp; 
            % &nbsp;<%=Helper.correctNull((String) hshValues.get("loan_inttype"))%></b></td>
        </tr>
        <tr> 
          <td valign="top">13. Amount of loan requested </td>
          <td>:</td>
          <td> 
            <p><b>Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("amtreqd"))))%></b></p>
          </td>
        </tr>
        <tr> 
          <td valign="top">14. Amount of Loan recommended </td>
          <td>:</td>
          <td><b>Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sancamount"))))%></b></td>
        </tr>
       <!--  <tr> 
          <td valign="top">15. Average DSCR ( to be worked in the case the 
            loan amount is Rs. 25 lacs and above ) </td>
          <td>:</td>
          <td>&nbsp;</td>
        </tr>--> 
        <tr> 
          <td valign="top">16. Investment grade points scored </td>
          <td>:</td>
          <td><b><%=Helper.correctNull((String) hshValues.get("scoreobtained"))%></b></td>
        </tr>
        <tr> 
          <td valign="top">17. Details of securities offered (specify) 
          </td>
          <td valign="top">:</td>
          
          <%
      String auto_category=Helper.correctNull((String)hshValues.get("auto_category"));
      String auto_make=Helper.correctNull((String)hshValues.get("auto_make"));
      String auto_model=Helper.correctNull((String)hshValues.get("auto_model"));
      String auto_articlename=Helper.correctNull((String)hshValues.get("auto_articlename"));
      
            
      %>
           
        
             <td width="60%" height="100" valign="top">
             
           <% 
           if(!Helper.correctNull((String)hshValues.get("prop_houseno")).equalsIgnoreCase("") || !Helper.correctNull((String)hshValues.get("prop_area")).equalsIgnoreCase("") || !Helper.correctNull((String)hshValues.get("prop_housingaddress")).equalsIgnoreCase("") || !Helper.correctNull((String)hshValues.get("prop_city")).equalsIgnoreCase("")) 
           {
      	        //out.println(" - Equitable / Simple Mortgage of the property situated at "+Helper.correctNull((String)hshValues.get("prop_houseno"))+" , "+Helper.correctNull((String)hshValues.get("prop_area"))+" , "+Helper.correctNull((String)hshValues.get("prop_housingaddress"))+" , "+Helper.correctNull((String)hshValues.get("prop_city"))+" , "+Helper.correctNull((String)hshValues.get("prop_pin")));
      	      	//out.println("<br>");
           }        	
      	     	String InterimSecurity=Helper.correctNull((String)hshValues.get("prop_intermsecurity"));
             	if(!InterimSecurity.equalsIgnoreCase(""))
             	{
             		out.println(" - Interim Security "+Helper.correctNull((String)hshValues.get("prop_intermsecurity")));
             		out.println("<br>");
             	}
             	
             	ArrayList arrAss=new ArrayList();
                
                if(arrAsset!=null && arrAsset.size()>0)
                {
    	            for(int i=0;i<arrAsset.size();i++)
    	            {
    	            	arrAss=new ArrayList();
    	            	arrAss=(ArrayList)arrAsset.get(i);            	
    	            	out.println(" - Hypothecation of asset <b>"+Helper.correctNull((String)arrAss.get(0)) +"</b>"); 
    	            	out.println("<br>");
    	            }	            
                }    
                 ArrayList arrColl=new ArrayList();
                 
                 if(arrCollateral!=null && arrCollateral.size()>0)
                 {
     	            for(int i=0;i<arrCollateral.size();i++)
     	            {
     	            	arrColl=new ArrayList();
     	            	arrColl=(ArrayList)arrCollateral.get(i);            	
     	            	out.println(" - Equitable / Simple Mortgage of the property situated at "+Helper.correctNull((String)arrColl.get(1))+" , "+Helper.correctNull((String)arrColl.get(2))+" , "+Helper.correctNull((String)arrColl.get(3))+" , "+Helper.correctNull((String)arrColl.get(4))+" , "+Helper.correctNull((String)arrColl.get(5)));
     	            	out.println("<br>");
     	            }	            
                 }
                 ArrayList arrInv=new ArrayList();
                 if(arrInvestment!=null && arrInvestment.size()>0)
                 {
                 	 for(int i=0;i<arrInvestment.size();i++)
      	            {
                 		 arrInv=new ArrayList();
                 		 arrInv=(ArrayList)arrInvestment.get(i);            	
      	            	
      	            	out.println(" - Pledge of deposit with "+Helper.correctNull((String)arrInv.get(0))+" for Rs. "+Helper.correctNull((String)arrInv.get(1)));	            	
      	            	out.println("<br>");
      	            }
                 }
                 
                 ArrayList arrIns=new ArrayList();
                 if(arrInsurance!=null && arrInsurance.size()>0)
                 {
                 	 for(int i=0;i<arrInsurance.size();i++)
      	            {
                 		 arrIns=new ArrayList();
                 		 arrIns=(ArrayList)arrInsurance.get(i);            	
      	            	 
      	            	 out.println(" - Assignment of Insurance No. "+Helper.correctNull((String)arrIns.get(0))+" , "+Helper.correctNull((String)arrIns.get(1))+" , "+Helper.correctNull((String)arrIns.get(2)));	            	
      	            	out.println("<br>");
      	            }
                 }
                 ArrayList arrAuto=new ArrayList();
                 if(arrPerAuto!=null && arrPerAuto.size()>0)
                 {
                 	 for(int i=0;i<arrPerAuto.size();i++)
      	            {
                 		 arrAuto=new ArrayList();
                 		 arrAuto=(ArrayList)arrPerAuto.get(i);            	
      	            	 
      	            	out.println(" - Hypothecation of vehicle "+Helper.correctNull((String)arrAuto.get(1))+" , "+Helper.correctNull((String)arrAuto.get(0))+" with "+Helper.correctNull((String)arrAuto.get(2)));
      	            	out.println("<br>");
      	            }
                 }
            if((!auto_articlename.equalsIgnoreCase("") || !auto_make.equalsIgnoreCase("")))
            {    
            	
            	out.println(" - Hypothecation of Vehicle "+auto_articlename+", "+ auto_make +" & "+auto_model);  
            	out.println("<br>");
            }
          %>
          </td>
        </tr>
        <tr> 
          <td valign="top">18. Details of guarantee, if any</td>
          <td>:</td>
          <td>
            <table width="98%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                 <%
        	if(vecRow!=null)
        	{
        		for(int i=0;i<vecRow.size();i++)
        		{
        			vecCol=(ArrayList)vecRow.get(i);
        			if(vecCol!=null)
        			{	
        				String title=Helper.correctNull((String) vecCol.get(0));
        				String GuarantorName=Helper.correctNull((String) vecCol.get(1));
        				String GuarantorMeans=Helper.correctNull((String) vecCol.get(9));%>
                <td>Name of the Guarantor <b><%=title%>.&nbsp;<%=GuarantorName%></td>
                <td>Means [Rs.] <b><%=Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(GuarantorMeans)))%></b></td>
              </tr>
              <%       			}
        		}
        	}
        %>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
         <%
					String installment_year="";
          			installment_year = Integer.toString(curyear);
          			if(installment_year.equalsIgnoreCase("0"))
          			{
          				installment_year="";
          			}
          			
          	%>
          	<%
					String installment_year1="";
          			installment_year1 = Integer.toString(curyear1);
          			if(installment_year1.equalsIgnoreCase("0"))
          			{
          				installment_year1="";
          			}
          			
          	%>
        <tr> 
          <td valign="top">19. Repayment Schedule</td>
          <td>:</td>
          <td>1. No. of EMls: <b><%=Helper.correctNull((String) hshValues.get("lreqterms"))%></b><br />
            2. Amount of EMI: <b><%=Helper.correctNull((String) hshValues.get("loan_emi"))%></b><br />
            3. Repayment to commence from: <b><%=Months[a]%> <%=installment_year%></b><br />
            4. Date by which the loan to be adjusted in full:<b><%=Months1[a1]%> <%=installment_year1%></b></td>
        </tr>
        <tr> 
          <td valign="top">20. Moratorium </td>
          <td>:</td>
          <td><b><%=Helper.correctNull((String) hshValues.get("loan_noofinstallment"))%> (months)</b></td>
        </tr>
        <tr> 
          <td valign="top">21. Processing charges </td>
          <td>:</td>
          <td><b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%></b>  </td>
        </tr>
        <tr> 
          <td valign="top">22. Security documents to be obtained [give Code Nos. 
            of documents]</td>
          <td>:</td>
          <td valign="top">
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
            <b><%=i+1%>)&nbsp;<%=Helper.correctNull((String)arrydocCol.get(1))%></b>
            <%
							}
                       }
                       	}
                       %>
          </td>
        </tr>
		<tr >
		<td colspan="3"> 
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
            <br /></td>
      
		</tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
