<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%request.setAttribute("_cache_refresh", "true");
  ArrayList Workingcapitalrow = new ArrayList();
	ArrayList Workingcapitalcol = new ArrayList();
	Workingcapitalrow = (ArrayList) hshValues.get("workingcapitalrow");

   ArrayList veccoapp=new ArrayList();
  veccoapp=(ArrayList)hshValues.get("vecReport11");
  
  ArrayList vecgua=new ArrayList();
  vecgua=(ArrayList)hshValues.get("vecReport12");
  
 %>
 <!-- Liability Details -->
 

		
<laps:handleerror />
<%
java.text.NumberFormat nf = java.text.NumberFormat
.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
String totappmov = nf.format(Double.parseDouble(Helper
		.correctDouble((String) hshValues.get("totmova2")))
		+ Double.parseDouble(Helper
				.correctDouble((String) hshValues.get("mov3a")))
		+ Double.parseDouble(Helper
				.correctDouble((String) hshValues.get("permova"))));
String liaapp = nf.format(Double.parseDouble(Helper
		.correctDouble((String) hshValues.get("totliaa"))));
String totappimov = nf.format(Double.parseDouble(Helper
		.correctDouble((String) hshValues.get("perimova"))));
String totassapp = nf.format(Double.parseDouble(totappmov)
		+ Double.parseDouble(totappimov));
String netapp = nf.format(Double.parseDouble(totassapp)-Double.parseDouble(liaapp));

  
if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}

HashMap hshRecord1 = (HashMap) hshValues.get("hshRecord1");
String sugar= Helper.correctNull((String)hshRecord1.get("txt_fact"));
if(sugar.equalsIgnoreCase(""))
{
	sugar="Nil";
}
String barns=Helper.correctNull((String)hshRecord1.get("txt_barns"));

String dimensions=Helper.correctNull((String)hshRecord1.get("txt_dimensions"));
String loc=Helper.correctNull((String)hshRecord1.get("txt_loc"));
String branch=Helper.correctNull((String)hshRecord1.get("txt_bran"));


if(barns.equalsIgnoreCase(""))
{
	barns="Nil";
}
if(dimensions.equalsIgnoreCase(""))
{
	dimensions="Nil";	
}
if(loc.equalsIgnoreCase(""))
{
	loc="Nil";
}
if(branch.equalsIgnoreCase(""))
{
	branch="Nil";	
}
		
		



 ArrayList vecintercrop=(ArrayList)hshValues.get("vecDataintercrop");

ArrayList vec2 = new ArrayList();
ArrayList v2=(ArrayList)hshValues.get("vecData2");
int vecsize6 = 0;
if (hshValues != null) 
{
	vec2 = (ArrayList) hshValues.get("vecData2");
	
	
}
if (vec2 != null) 
{
	vecsize6 = vec2.size();
}
%>
<%
 hshRecord1 = (HashMap) hshValues.get("hshRecord1");


int repaymentperiod=0;
int holidayperiod=0;

holidayperiod=Integer.parseInt(Helper.correctDouble((String)hshValues.get("loan_noofinstallment")));
repaymentperiod=Integer.parseInt(Helper.correctDouble((String)hshRecord1.get("terms")));



repaymentperiod=repaymentperiod-holidayperiod;











java.text.NumberFormat nf1 = java.text.NumberFormat.getNumberInstance();
nf1.setGroupingUsed(false);
nf1.setMaximumFractionDigits(0);
nf1.setMinimumFractionDigits(0);

java.text.NumberFormat nf2 = java.text.NumberFormat.getNumberInstance();
nf2.setGroupingUsed(false);
nf2.setMaximumFractionDigits(2);
nf2.setMinimumFractionDigits(0);
int i=0;
String interesttype =(String)hshRecord1.get("interesttype");
ArrayList arrinterestval =new ArrayList();
ArrayList arrsteptoamt = new ArrayList();
String strstepintrate ="";
String strsteptoamt ="";
if(interesttype.equals("stepup"))
{
	arrinterestval = (ArrayList)hshRecord1.get("prd_interest");
	arrsteptoamt =   (ArrayList)hshRecord1.get("toamt");
	for( i=0;i<arrinterestval.size();i++)
	{
		strstepintrate = strstepintrate +arrinterestval.get(i)+"^";
		strsteptoamt =strsteptoamt +arrsteptoamt.get(i)+"^";
	}	
}





String monthly1 = Helper.correctNull((String)hshRecord1.get("loan_reqterms"));
String monthly2 = Helper.correctNull((String)hshValues.get("loan_noofinstallment"));
String monthly3 = Helper.correctNull((String)hshValues.get("loan_periodicity"));


if (!monthly1.trim().equals("") && (!monthly2.trim().equals("")))
{
	
	if (monthly3.trim().equals("m"))
	{
		
		
	}
	else if (monthly3.trim().equals("q"))
	{
		
		
	}
	else if (monthly3.trim().equals("h"))
	{
		
		
	}
	else if (monthly3.trim().equals("y"))
	{
		
		
	}

}

double emi_totalcost=0.00;
double sanctionamount = 0.00;

double totalpercenvalue = 0.00;
emi_totalcost = Double.parseDouble(Helper.correctDouble((String)hshValues.get("emi_totalcost")));
sanctionamount = Double.parseDouble(Helper.correctDouble((String)hshValues.get("emi_sancamount")));
emi_totalcost = Double.parseDouble(Helper.formatDoubleValue(emi_totalcost));
sanctionamount = Double.parseDouble(Helper.formatDoubleValue(sanctionamount));
totalpercenvalue = (emi_totalcost - sanctionamount);
totalpercenvalue = Double.parseDouble(Helper.formatDoubleValue(totalpercenvalue));

 String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
                              	String measurementval="";
              
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<style>
td{
font-family:Ms Sans serif;
font-size:80%;

}
</style>
</head>
<body>
<form>
  <table width="100%" border="0" cellpadding="3" cellspacing="0"
	dwcopytype="CopyTableRow">
    <tr> 
      <td width="10%" rowspan="6"><img
			src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.gif"></td>
      <td width="70%" align='center'> <b><font face="MS Sans Serif" size="3">UNION 
        BANK OF INDIA</b></td>
      <td width="20%" nowrap><b></b></td>
    </tr>
    <tr> 
      <td align="center"> <b><font
			face="MS Sans Serif" size="3"><%=Helper.correctNull((String)hshRecord1.get("orgcity"))%></b></td>
      <td><b></b></td>
    </tr>
    <tr> 
      <td align="center">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td align='center'>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;<b>Date:<b><%=Helper.correctNull((String)hshValues.get("appraisal_date"))%></b></b></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr> 
            <td width="75%"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td><font face="MS Sans Serif"
									size="2"><b>REF.NO.&nbsp;<%=Helper.correctNull((String)hshRecord1.get("loan_bank_refno"))%></b></td>
                  <td align="right">&nbsp;</td>
                  <td align="right">&nbsp;</td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif"
									size="2"><b>BRANCH / OFFICE &nbsp;</b><%=Helper.correctNull((String)hshValues.get("organisationname"))%></td>
                  <td></td>
                  <td>&nbsp;</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td><b>District</b>&nbsp; 
              <%=Helper.correctNull((String)hshRecord1.get("orgcity"))%></td>
          </tr>
          
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td width="45%" bgcolor="#F3F3F3"><font
							face="MS Sans Serif" size="2"><b>Present Proposal</b></td>
                  <td width="55%"><%=Helper.correctNull((String) hshRecord1.get("prddescription"))%></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td width="45%" bgcolor="#F3F3F3"><font
							face="MS Sans Serif" size="2"><b>Purpose of Loan</b></td>
                  <td width="55%"><%=Helper.correctNull((String) hshRecord1
							.get("loan_purposeofloan"))%></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif"
									size="2"><b>1. Applicant</b></td>
          </tr>
          <tr> 
            <td> 
              <table width="95%" height="316" border="1" cellpadding="3" cellspacing="0" 
					bordercolor="#000000">
                <tr> 
                  <td width="50%" colspan="2">
                    <table width="95%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="45%"  bgcolor="#F3F3F3" nowrap><font face="MS Sans Serif"
									size="2"><b>Name of the Applicant </b></td>
                        <td width="55%"> <%=Helper.correctNull((String)hshRecord1.get("applname"))%> 
                           </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2"> 
                    <table width="95%" cellpadding="3" cellspacing="0" border="0">
                      <tr> 
                        <td bgcolor="#F3F3F3"><font face="MS Sans Serif"
									size="2"><b>Constitution</b></td>
                        <td><%=Helper.correctNull((String) hshRecord1
							.get("perapp_constitution1"))%></td>
                      </tr>
                      <%-- <tr> 
                        <td width="45%" bgcolor="#F3F3F3"><font face="MS Sans Serif"
									size="2"><b>Line of Activity</b>&nbsp;&nbsp;</td>
                        <td width="55%"><font face="MS Sans Serif"
									size="2"><%=LineofActivity %></td>
                      </tr>--%>
                      <tr> 
                        <td bgcolor="#F3F3F3"><font face="MS Sans Serif"
									size="2"><b>Address</b></td>
                        <td><%=Helper.correctNull((String)hshRecord1.get("perapp_address1"))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3">&nbsp;</td>
                        <td><%=Helper.correctNull((String)hshRecord1.get("perapp_address2"))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3">&nbsp;</td>
                        <td><%=Helper.correctNull((String)hshRecord1.get("perapp_city"))%>,<%=Helper.correctNull((String)hshRecord1.get("perapp_state"))%> 
                          ,<%=Helper.correctNull((String)hshRecord1.get("perapp_zip"))%></td>
                      </tr>
                     <%--  <tr> 
                        <td bgcolor="#F3F3F3"><b>Dealing 
                          with our Bank Since</b></td>
                        <td><%=Helper.correctNull((String)hshRecord1.get("perapp_banksince"))%></td>
                      </tr>--%>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Net 
                          worth as per the branch</b></td>
                        <td>Rs.<%=netapp%></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td><br>
              <table width="95%" border="1" cellspacing="0" cellpadding="0" bordercolor="#000000">
                <tr> 
                  <td width="50%"><font face="MS Sans Serif"
									size="2"><b>Name of the Co-Applicant </b></td>
                  <td width="50%">&nbsp;<b>Net 
                    worth as per the branch</b></td>
                </tr>
                <%
		     if(veccoapp!=null)
			 {
		      ArrayList veccoapp11=new ArrayList();
              veccoapp=(ArrayList)hshValues.get("vecReport11");
              for(int r=0;r<veccoapp.size();r++)
			  {
			   veccoapp11=(ArrayList)veccoapp.get(r);
			   
		  %>
                <tr> 
                  <td width="50%"> <%=Helper.correctNull((String)veccoapp11.get(1))%>&nbsp;</td>
                  <td width="50%"> <%=Helper.correctNull((String)veccoapp11.get(10))%></td>
                </tr>
                <%}}%>
              </table>
              <br>
              <table width="95%" border="1" cellspacing="0" cellpadding="0" bordercolor="#000000">
                <tr> 
                  <td width="50%"><font face="MS Sans Serif"
									size="2"><b>Name of the Guarantor</b></td>
                  <td width="50%"><b>Net worth 
                    as per the branch</b></td>
                </tr>
                <%
			  if(vecgua!=null)
			  {
			 ArrayList vecgua10=new ArrayList();
 	 		 vecgua=(ArrayList)hshValues.get("vecReport12");
    		 //out.println("vecgua"+vecgua);
			 for(int q=0;q<vecgua.size();q++)
			  {
			    vecgua10=(ArrayList)vecgua.get(q);
			   //out.println("vecgua10"+vecgua10);
			%>
                <tr> 
                  <td width="50%"> <%=Helper.correctNull((String)vecgua10.get(1))%>&nbsp;</td>
                  <td width="50%"> <%=Helper.correctNull((String)vecgua10.get(10))%></td>
                </tr>
                <%}}%>
              </table>
            </td>
          </tr>
          <%--- <tr> 
            <td> 
              <table width="95%" border="1" cellspacing="0" cellpadding="3"
					bordercolor="#000000">
              <tr> 
				
                  <td width="25%" height="65" bgcolor="#F3F3F3"><font face="MS Sans Serif"
							size="2"><b>Present Proposal</b></td>
                  <td width="75%"><font face="MS Sans Serif"
									size="2"><%=Helper.correctNull((String)hshRecord1.get("prddescription"))%> 
                    &nbsp; RS <font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_operativelimit"))%>/-</b><font face="MS Sans Serif"
									size="2">&nbsp;</td>
                </tr>
              </table>
            </td>
          </tr>--%>
          <tr> 
            <td> 
              <% 
				ArrayList a2 = new ArrayList();
				v2=(ArrayList)hshValues.get("vecData2");
				
			%>
              <% 
             
              if (vecsize6 != 0) {
              
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3"
					bordercolor="#000000">
                <tr> 
                  <td colspan="6" align=""><b>Eligible 
                    Crop Loan Limit as per our norms:</b>(<b>DIST)</b></td>
                </tr>
                <tr> 
                  <td align="center" width="22%"><b>SEASON--CROPS</b></td>
                  <td align="center" width="11%" ><b>ACREAGE</b></td>
                  <td align="center" width="12%" > 
                    <b>SCALE OF FINANCE</b>
                    <b>(PER ACRE)</b>
                  </td>
                  <td align="center" width="12%" ><b>ELIGIBILITY</b></td>
                  <td align="center" width="21%"><b>LOAN 
                    AMOUNT Requested(AMT.IN RS)</b></td>
                  <td align="center" width="22%"><b>LEAST 
                    LOAN AMOUNT (AMT.IN RS)</b></td>
                </tr>
                <%

			String str="";
				if(v2!=null)
				{				
					for(int m=0;m<vecsize6;m++)
					{							
						a2 = (ArrayList)v2.get(m);
						
						%>
                <tr> 
                  <td align="center"> 
                    <%str=Helper.correctNull((String)a2.get(1));
                if(str.equalsIgnoreCase("k1"))
                {
                	str="Khariff";
                }
                if(str.equalsIgnoreCase("r1"))
                {
                	str="Rabi";
                }
                if(str.equalsIgnoreCase("s1"))
                {
                	str="Summer";
                }
                if(str.equalsIgnoreCase("a1"))
                {
                	str="Annual";
                }
                if(str.equalsIgnoreCase("p1"))
                {
                	str="Perrenial";
                }
                 %>
                    <%=str%> -<%=Helper.correctNull((String)a2.get(0))%></td>
                  <td align="right"><%=Helper.correctNull((String)a2.get(2))%></td>
                  <td align="right"><%=Helper.correctNull((String)a2.get(3))%></td>
                  <td align="right"><%=Helper.correctNull((String)a2.get(6))%></td>
                  <td align="right"><%=Helper.correctNull((String)a2.get(4))%></td>
                  <td align="right"><%=Helper.correctNull((String)a2.get(5))%></td>
                </tr>
                <%}}%>
              </table>
              <%}  
			%>
            </td>
          </tr>
          <tr> </tr>
          <tr> 
            <td> 
              <% 
				 Workingcapitalcol=new ArrayList();
				Workingcapitalrow = (ArrayList) hshValues.get("workingcapitalrow");
	
			%>
              <% if (Workingcapitalrow.size()!= 0) {
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="2" bordercolor="#000000">
                <tr> 
                  <td colspan="5"  align = "left"><strong> Working 
                    Capital</strong></td>
                </tr>
                <tr> 
                  <td  align = "left" width="5%"><b>S.No</b></td>
                  <td align = "center"width="33%"><b>Activity</b></td>
                  <td align = "center"width="20%"><b>Physical 
                    Units</b></td>
                  <td align="center"width="20%"><b>Particulars</b></td>
                  <td align="center"width="20%"><b>Requirements</b></td>
                </tr>
                <%
	
	if(Workingcapitalrow.size()!= 0)
	{	
		for(int b=0;b<Workingcapitalrow.size();b++)
		{
			Workingcapitalcol=(ArrayList)Workingcapitalrow.get(b);		
			%>
                <tr> 
                  <td>&nbsp;<%=b+1%></td>
                  <td>&nbsp;<%=Helper.correctNull((String)Workingcapitalcol.get(1))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String)Workingcapitalcol.get(2))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String)Workingcapitalcol.get(3))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String)Workingcapitalcol.get(4))%></td>
                </tr>
                <%	}	
	                 }	
                            %>
              </table>
              <%  } 
			%>
             <%--  <table width="95%" height="168" border="1" cellpadding="3" cellspacing="0"
					bordercolor="#000000">
                <tr> </tr>
                <tr> 
                  <td width="94%"> 
                    <%
                    double c2= Double.parseDouble(Helper.correctDouble((String)hshRecord1.get("crop_total_loan")));
                    if (c2>0.0) {
			         %>
                    <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                      <tr> 
                        <td width="69%" bgcolor="#F3F3F3"><strong> Crop 
                          Loan Eligible for different Perennial Crops  
                          <b>(A)</b> </strong></td>
                        <td width="31%">Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("loan_amount_pe"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong> Crop Loan 
                          Eligible for different Annual Crops  
                          <b>(B)</b> </strong></td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("loan_amount_an"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Crop 
                          Loan Eligible for different Khariff Crops</strong><b>(C1)</b> 
                          </td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("loan_amount_kh"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Crop 
                          Loan Eligible for different Rabi Crops  
                          <b>(C2)</b> </strong></td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("loan_amount_rb"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Crop 
                          Loan Eligible for different Summer Crops  
                          <b>(C3)</b></strong></td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("loan_amount_su"))%></B></td>
                      </tr>
                    <tr> 
                        <td bgcolor="#F3F3F3"><strong>First 
                          Highest Loan Amount Among Seasonal Crops  
                          <b>(D1)</b> </strong></td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_firsthighest"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Second 
                          Highest Loan Amount Among Seasonal Crops</strong><b>(D2)</b> 
                          </td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_secondhighest"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Loan 
                          Amount for Seasonal Crops</strong><b>(C1+C2+C3=C)</b> 
                          </td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_loan"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Total 
                          Crop Loan</strong><b>(A+B+C)</b> 
                          </td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_total_loan"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Working 
                          Capital (Allied/Activity/Activities per Cycle)</strong><b>(D)</b></td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("totworkcap"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Term 
                          Loan <b>(E) </b></strong></td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("totloanamt"))%></B></td>
                      </tr>
                    </table>
                    <%  } 
			           %>
                    <br>
                    <% double c1= Double.parseDouble(Helper.correctDouble((String)hshRecord1.get("crop_total_coffeeloan")));
				   if (c1> 0) {
			         %>
                    <table width="95%" border="1" cellspacing="0" cellpadding="3"  bordercolor="#000000">
                      <tr> 
                        <td width="69%" bgcolor="#F3F3F3"><strong>Coffee 
                          Loan (A)</strong></td>
                        <td width="31%">Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("coffee_leastamt"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Inter 
                          Crop Loan(Details as furnished below)(B)</strong></td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_leastamt"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><strong>Total 
                          Coffee Loan(A+B=C)</strong></td>
                        <td>Rs.<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_total_coffeeloan"))%></B></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Adhoc 
                          limit [50% of C as coffee loan]as recommended by the 
                          br[G]</b></td>
                        <td>Rs<font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_adhoclimit"))%></b></td>
                      </tr>
                    </table>
                    <%  } 
			         %>
                    <br>
                     <table width="95%" border="1" cellspacing="0" cellpadding="3"  bordercolor="#000000">
                      <tr> 
                        <td width="70%"><font face="MS Sans Serif"
									size="2"><b>Production Credit 
                          <b>I(A+B+C+D+E)</b></b></td>
                        <td width="30%">Rs. 
                          <font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_prdcredit"))%></B></td>
                      </tr>
                     <tr> 
                        <td><font face="MS Sans Serif"
									size="2"><b>Consumption limit[G]</b></td>
                        <td>Rs. <font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_consumption"))%></b></td>
                      </tr>
                     <tr> 
                        <td><b>Operative limit 
                          for the season 2007-2008[I+G=II]</b></td>
                        <td>Rs. <font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_operativelimit"))%></b></td>
                      </tr>
                      <tr> 
                        <td><b>Contingency 
                          limit [30% of I]-as recommended by the br.[H]</b></td>
                        <td>Rs. <font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_contingency"))%></b></td>
                      </tr>
                      <tr> 
                        <td><b>Overall limit 
                          for documentation[II+H]</b></td>
                        <td>Rs. <font size="2" face="MS Sans Serif" ><b><%=Helper.correctNull((String)hshRecord1.get("crop_documentation"))%></B></td>
                      </tr>
                    </table>--%>
                    <br>
                    <% 
				ArrayList vecintercropval=new ArrayList();
				 vecintercrop=(ArrayList)hshValues.get("vecDataintercrop");
			
			%>
                    <% if (vecintercrop.size()!= 0) {
			%>
                    <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                      <% 	String measurementtype3 = Helper.correctNull((String)hshValues.get("land_measurement"));
                              measurementval="";
                            	if(measurementtype3.equalsIgnoreCase("c"))
                      	  		{
                      	 
                      	  			 measurementval = "Cents";
                      	 		 }
                      	 		 else
                      	  			{
                      					measurementval = "Guntas";
                      	 			}
                                %>
                      <tr> 
                        <td colspan="6"><strong> Details of Inter 
                          Crops </strong></td>
                      </tr>
                      <tr> 
                        <td width="14%"><strong> Crop Name</strong></td>
                        <td width="14%"> <strong>Extent[ac-<%=measurementval%>]</strong></td>
                        <td width="11%"><b>Scale 
                          of Finance</b></td>
                        <td width="18%"><b><font
											size="2" face="MS Sans Serif" >Eligibile 
                          Limit As Per DCC Scale(A)</b></td>
                        <td width="18%"><b><font
											size="2" face="MS Sans Serif" >Loan 
                          <br>
                          Amount Requested(B)</b></td>
                        <td width="25%"><b><font
											size="2" face="MS Sans Serif" >Least 
                          Amount (Rs.)<br>
                          (of A and B)</b></td>
                      </tr>
                  <%
				if(vecintercrop!=null)
				{				
					for(int m=0;m<vecintercrop.size();m++)
					{							
						 vecintercropval= (ArrayList)vecintercrop.get(m);
						
						%>
                      <tr> 
                        <td><%=Helper.correctNull((String)vecintercropval.get(3))%></td>
                        <td><%=Helper.correctNull((String)vecintercropval.get(4))%></td>
                        <td><%=Helper.correctNull((String)vecintercropval.get(5))%></td>
                        <td><%=Helper.correctNull((String)vecintercropval.get(6))%></td>
                        <td><%=Helper.correctNull((String)vecintercropval.get(7))%></td>
                        <td><%=Helper.correctNull((String)vecintercropval.get(8))%></td>
                      </tr>
                      <%}}%>
                    </table>
                    <%  } 
			%>
                    <br>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
      <%-- <tr> 
            <td>
              <% 
				ArrayList a2_liab = new ArrayList();
				arryCol_liab=(ArrayList)hshValues.get("arryRow_liab");
			%>
              <% if (vecsize_liab != 0) {
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td colspan="8" align="center"><b>Liabilities 
                    </b></td>
                </tr>
                <tr> 
                  <td><b>Institution</b></td>
                  <td><b>Liability type</b></td>
                  <td><b>Account No / Purpose</b></td>
                  <td><b>Loan Amount</b></td>
                  <td><b>Balance</b></td>
                  <td><b>Securities offered</b></td>
                  <td><b>Installment Amount</b></td>
                  <td><b>Applicant Type</b></td>
                </tr>
                <tr> 
                  <%
				if(arryCol_liab!=null)
				{				
					for(int m=0;m<vecsize_liab;m++)
					{							
						a2_liab = (ArrayList)arryCol_liab.get(m);
						
						%>
                  <td><%=Helper.correctNull((String)a2_liab.get(3))%></td>
                  <% String tr=Helper.correctNull((String)a2_liab.get(4));
			     if(tr.equalsIgnoreCase("LC"))
				 {
				 tr="Credit Card";
				 }
				  else if(tr.equalsIgnoreCase("LD"))
				 {
				 tr="Housing Loan";
				 }
				 else if(tr.equalsIgnoreCase("LP"))
				 { 
				 tr="Personal Loan";
				 }
				 else if(tr.equalsIgnoreCase("LO"))
				 { 
				 tr="Others";
				 }
				 else if(tr.equalsIgnoreCase("LL"))
				 { 
				 tr="Vehicle Loan";
				 }
				 
				 			 %>
                  <td><%=tr%></td>
                  <td><%=Helper.correctNull((String)a2_liab.get(8))%></td>
                  <td><%=Helper.correctNull((String)a2_liab.get(5))%></td>
                  <td><%=Helper.correctNull((String)a2_liab.get(6))%></td>
                  <td><%=Helper.correctNull((String)a2_liab.get(10))%></td>
                  <td><%=Helper.correctNull((String)a2_liab.get(7))%></td>
                  <td> 
                    <% String liab2 = Helper.correctNull((String)a2_liab.get(1));
				
				                String liab="";
								liab=liab2.substring(0,1);
								if (liab.equalsIgnoreCase("a")) {
									liab1 = "Applicant";
								} else if (liab.equalsIgnoreCase("c")) {
									liab1 = "Co-Applicant";
								} else if (liab.equalsIgnoreCase("g")) {
									liab1 = "Guarantor";
								} else {
									liab1= "-";
								}

								%>
                    <%=liab1%> </td>
                </tr>
                <%}
			  }%>
              </table>
              <%
			  }%>
            </td>
          </tr>
        
        <tr> 
            <td>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td width="24%"><b>Background</b></td>
                  <td width="76%"><%=Helper.correctNull((String) hshValues.get("BgComments"))%></td>
                </tr>
                <tr> 
                  <td><b>Recommendations:</b></td>
                  <td><%=Helper.correctNull((String)hshRecord1.get("Comments"))%></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
   
   <%--  <tr> 
      <td> 
        <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
          <tr> 
            <td  bgcolor="#F3F3F3" width="17%"><strong>Rate 
              of Interest </strong></td>
            <td width="83%"><strong> <%=Helper.correctNull((String)hshRecord1.get("mintrate"))%>&nbsp;%p.a.[subject 
              to changes from time to time]</strong> &nbsp;</td>
          </tr>
          <tr> 
            <td  bgcolor="#F3F3F3"><strong>Disbursement</strong></td>
            <td><b>Disbursement for crop cultivation 
              and working capital requirement for allied and nonfarm activities 
              should be made as per genuine requirement.The bills/vouchers of 
              the inputs purchased may be obtained,scrutinized and held with documents 
              so as to make them available for verification by the auditors .In 
              case of difficulty,a letter of undertaking may be obtained by the 
              farmer in leiu of bills/receipts indicating purchase of inputs/assets,as 
              per the format.<br>
              The Branches should not limit release contingency limit along with 
              the regular limit.Contingency limit should be released only in case 
              of increase in operational cost during the subsequent years based 
              on annual review.</b></td>
          </tr>
          <tr> 
            <td height="61"  bgcolor="#F3F3F3"><strong>&nbsp;Repayment</strong></td>
            <td>
              <% double n1= Double.parseDouble(Helper.correctDouble((String)hshRecord1.get("crop_total_loan")));
				   if (n1> 0) {
			         %>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td><b>A.The seasonal sub-limits 
                    granted for cultivation of crops will be repaid as soon as 
                    harvesting and marketing of crops is completed but not later 
                    than the due date of repayment i.e </b> 
                    <%
			String strm="";
			ArrayList a4 = new ArrayList();
				if(v_2!=null)
				{				
					for(int m=0;m<vecsize_repay;m++)
					{							
						a4 = (ArrayList)v_2.get(m);
						
						%>
                    <%  strm=Helper.correctNull((String)a4.get(1));
                if(strm.equalsIgnoreCase("k1"))
                {
                	strm="Khariff";
                }
                if(strm.equalsIgnoreCase("r1"))
                {
                	strm="Rabi";
                }
                if(strm.equalsIgnoreCase("s1"))
                {
                	strm="Summer";
                }
                %>
                    <strong> <%=strm%> -<%=Helper.correctNull((String)a4.get(0))%>-<%=Helper.correctNull((String)a4.get(7))%>(months), 
                    </strong><strong> 
                    <%}}%>
                    <br>
                    <strong> B.The Crop Loan Limit is sanctioned 
                    for five years subject to renewal every year.The renewal will 
                    be made on submission of the cropping plan for the next year.</strong><br>
                     <strong>C.The Limits granted for annual/perennial 
                    crops i.e 
                    <%
			String strm1="";
			ArrayList a5 = new ArrayList();
				if(v_3!=null)
				{				
					for(int m=0;m<vecsize_repayan;m++)
					{							
						a5 = (ArrayList)v_3.get(m);
						
						%>
                    <%  strm1=Helper.correctNull((String)a5.get(1));
                if(strm1.equalsIgnoreCase("a1"))
                {
                	strm1="Annual";
                }
                if(strm1.equalsIgnoreCase("p1"))
                {
                	strm1="Perennial";
                }
                
                %>
                    <strong> <%=strm1%> -<%=Helper.correctNull((String)a5.get(0))%>-<%=Helper.correctNull((String)a5.get(7))%>(months), 
                    </strong></strong><strong><strong> 
                    <%}}%>
                    <br>
                     <strong> D.The Term Loan will be repaid in 
                    <b><%=Helper.correctNull((String)hshRecord1.get("txt_repayTL"))%> 
                    <%  String strmon=Helper.correctNull((String)hshRecord1.get("txt_payment"));
                if(strmon.equalsIgnoreCase("1"))
                {
                	strmon="Monthly";
                }
                if(strmon.equalsIgnoreCase("2"))
                {
                	strmon="Quarterly";
                }
                if(strmon.equalsIgnoreCase("3"))
                {
                	strmon="half yearly";
                }
				if(strmon.equalsIgnoreCase("4"))
                {
                	strmon="yearly";
                }
                %>
                    <strong> <%=strmon%> installment of Rs. <b><%=Helper.correctNull((String)hshRecord1.get("txt_installment"))%></b>/-each 
                    along with interest accrued,starting from <b><%=Helper.correctNull((String)hshRecord1.get("agr_date"))%></b> 
                    with an initial repayment holiday of <b><%=Helper.correctNull((String)hshRecord1.get("txt_holiday"))%></b></strong><strong> 
                    (Months) </strong></b></strong></strong></strong></strong></td>
                </tr>
              </table>
              <%  } 
			           %>
              <br>
              <% double n2= Double.parseDouble(Helper.correctDouble((String)hshRecord1.get("crop_total_coffeeloan")));
				   if (n2> 0) {
			         %>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td><b>The loan amount along 
                    with interest accured shall be recovered within 12 months 
                    from the date of disbursement or 1 month after sale of coffee 
                    or June 20 _____ ,whichever is applicable.</b></td>
                </tr>
              </table>
              <%  } 
			           %>
            </td>
          </tr>
          <tr> 
            <td  bgcolor="#F3F3F3"><strong>Guarantor</strong></td>
            <td>&nbsp; 
              <% 
 				ArrayList	vecname1 = (ArrayList) hshValues.get("vecRows");
			
			ArrayList g51 =  new ArrayList();
				if((vecname1!=null)&&(v.size()!=0))
				{					
					int vecappsize1 =vecname1.size();
					
					for(int l2=0;l2<vecappsize1;l2++)
					{							
						g51= (ArrayList)vecname1.get(l2);
						
						%>
              <br>
              <br>
              <%=l2+1%>) &nbsp; <%=Helper.correctNull((String)g51.get(1))%><%=Helper.correctNull((String)g51.get(0))%>,<br>
              <%=Helper.correctNull((String)g51.get(2))%>,<br>
              <%=Helper.correctNull((String)g51.get(3))%>,<br>
              <%=Helper.correctNull((String)g51.get(4))%>, <br>
              <%=Helper.correctNull((String)g51.get(5))%> -<%=Helper.correctNull((String)g51.get(7))%>, 
              <br>
              <%=Helper.correctNull((String)g51.get(6))%> </td>
            <%
				          	}
					
						}
					%>
          </tr>
        </table>
      </td>
    </tr>
  <tr> 
      <td>
        <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
          <tr bgcolor="#F3F3F3"> 
            <td><b>Security/ies</b>:</td>
          </tr>
          <tr> 
            <td> 
              <% 
				 ArrayList a3 = new ArrayList();
				v2=(ArrayList)hshValues.get("vecData2");
			
			%>
              <% if (v2.size()!= 0) {
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td colspan="3"><strong> Hypothecation of- 
                    <%
			
			 a3 = new ArrayList();
			String str6="";
				if(v2!=null)
				{				
					for(int m=0;m<vecsize6;m++)
					{							
						a3 = (ArrayList)v2.get(m);
						
						%>
                    <%=Helper.correctNull((String)a3.get(0))%>, 
                    <%}}%>
                    Crops on the landed Property described below</strong></td>
                </tr>
                <tr> 
                  <% 
			  measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
                              	 measurementval="";
                            	if(measurementtype.equalsIgnoreCase("c"))
                      	  		{
                      	 
                      	  			 measurementval = "Cents";
                      	 		 }
                      	 		 else
                      	  			{
                      					measurementval = "Guntas";
                      	 			}
				ArrayList a1 = new ArrayList();
			
				v1=(ArrayList)hshValues.get("vecData1");
			
			%>
                  <% if (v1.size()!= 0) {
			%>
                  <td width="23%"><strong> Location</strong></td>
                  <td width="62%"> <strong>Sy.No</strong></td>
                  <td width="15%"> <strong>Extent[ac-<%=measurementval%>]</strong></td>
                </tr>
                <%
			
			 a1 = new ArrayList();
				if(v1!=null)
				{				
					for(int l=0;l<vecsize5;l++)
					{							
						a1 = (ArrayList)v1.get(l);
					  acreval = Double.parseDouble(Helper.correctDouble((String) a1.get(4)));
					centguntval = Double.parseDouble(Helper.correctDouble((String)a1.get(22)));
					totalacreval = totalacreval + acreval;
					totalcentgunt = totalcentgunt + centguntval;
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
                  <td><%=Helper.correctNull((String)a1.get(5))%>,<%=Helper.correctNull((String)a1.get(6))%>,<%=Helper.correctNull((String)a1.get(7))%></td>
                  <td><%=Helper.correctNull((String)a1.get(8))%></td>
                  <td><%=Helper.correctNull((String)a1.get(4))%>.<%=Helper.correctNull((String)a1.get(22))%></td>
                </tr>
                <%}}%>
              </table>
              <%  } 
			%>
              <% if (v2.size()> 0) {
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td width="85%"> <strong>Total</strong></td>
                  <td width="15%"> <%=totalacreval%>Acres<%=guntasrealq%>&nbsp;&nbsp; 
                     <%=measurementval%> </td>
                </tr>
                <%  } 
			%>
              </table>
              <%  } 
			%>
              <br>
              <% 
				 vecestate=new ArrayList();
				 vecrowestate=(ArrayList)hshValues.get("vecdataestate");
			
			%>
              <% if (vecrowestate.size()!= 0) {
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td><strong> Hypothecation of Coffee /Inter Crops 
                    on the landed Property 
                    <%
			
			    
				if( vecrowestate!=null)
				{				
					for(int s=0;s<vecrowestate.size();s++)
					{
					    					
						 vecestate = (ArrayList)vecrowestate.get(s);
				
					  acrevalestate = Double.parseDouble(Helper.correctDouble((String)  vecestate.get(10)));
					centguntvalestate = Double.parseDouble(Helper.correctDouble((String) vecestate.get(11)));
					totalacrevalestate = totalacrevalestate + acrevalestate;
					totalcentguntestate = totalcentguntestate + centguntvalestate;
						%>
                    <%
				  
                                if(measurementtype.equalsIgnoreCase("g"))
                      	  		{
                      	 
                      	  		                    	 		        
					guntasrealqestate  = totalcentguntestate % 40;
					guntasrealrestate   = totalcentguntestate / 40 ;
					if(guntasrealrestate >= 1)
					{
						totalacrevalestate = 	totalacrevalestate + guntasrealrestate;
						
					}
					totalacrevalestate = Math.floor(totalacrevalestate);
							}
                   else 
                   {
                   	guntasrealqestate  = totalcentguntestate % 100;
   					guntasrealrestate   = totalcentguntestate / 100 ;
   					if(guntasrealrestate >= 1)
   					{
   						totalacrevalestate = 	totalacrevalestate + guntasrealrestate;
   					}
   					totalacrevalestate = Math.floor(totalacrevalestate);
                   }					
					%>
                    <%}}%>
                    <%=totalacrevalestate%>Acres<%=guntasrealqestate%>&nbsp;&nbsp; 
                     <%=measurementval%> </strong></td>
                </tr>
              </table>
              <%  } 
			%>
              <% 
				ArrayList vec11=new ArrayList();
				 vec5=(ArrayList)hshValues.get("vecData10");
			
			%>
              <% if (vec5.size()!= 0) {
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td colspan="3"><strong> Registered mortgage of 
                    landed Property described below:</strong></td>
                </tr>
                <tr> 
                  <td width="33%"><strong> Location</strong></td>
                  <td width="49%"> <strong>Sy.No</strong></td>
                  <td width="18%"> <strong>Extent[ac-<%=measurementval%>]</strong></td>
                </tr>
                <%if(vec5!=null)
               { 
            	   
               vec11=new ArrayList();
              		 
					  for(int m=0;m<vec5.size();m++)
					  {
					    vec11=(ArrayList)vec5.get(m);
					 acreval_r = Double.parseDouble(Helper.correctDouble((String) vec11.get(9)));
					centguntval_r = Double.parseDouble(Helper.correctDouble((String)vec11.get(10)));
					totalacreval_r = totalacreval_r + acreval_r;
					totalcentgunt_r = totalcentgunt_r + centguntval_r;
						 
					%>
                <%
                                if(measurementtype.equalsIgnoreCase("g"))
                      	  		{
                      	 
                      	  		                    	 		        
					guntasrealq_r  = totalcentgunt_r % 40;
					guntasrealr_r   = totalcentgunt_r / 40 ;
					if(guntasrealr_r >= 1)
					{
						totalacreval_r = 	totalacreval_r + guntasrealr_r;
					}
					totalacreval_r = Math.floor(totalacreval_r);
					
         	  		}
                   else 
                   {
                   	guntasrealq_r  = totalcentgunt_r % 100;
   					guntasrealr_r   = totalcentgunt_r / 100 ;
   					if(guntasrealr_r >= 1)
   					{
   						totalacreval_r = 	totalacreval_r + guntasrealr_r;
   					}
   					totalacreval_r = Math.floor(totalacreval_r);
                   }					
					%>
                <tr> 
                  <td><%=Helper.correctNull((String)vec11.get(5))%>, <%=Helper.correctNull((String)vec11.get(6))%>,<%=Helper.correctNull((String)vec11.get(7))%></td>
                  <td> <%=Helper.correctNull((String)vec11.get(8))%></td>
                  <td><%=Helper.correctNull((String)vec11.get(9))%>.<%=Helper.correctNull((String)vec11.get(10))%></td>
                </tr>
                <%}}%>
              </table>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td width="82%"><strong> Total</strong></td>
                  <td width="18%"><%=totalacreval_r%>Acres<%=guntasrealq_r%>&nbsp;&nbsp; 
                     <%=measurementval%> </td>
                </tr>
              </table>
              <%  } 
			%>
              <br>
              <% 
				   		 vec12=new ArrayList();
  					vec_1=(ArrayList)hshValues.get("vecdata11");
				
			%>
              <% if (vec_1.size()!= 0) {
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td colspan="3"><strong> Equitable mortgage of 
                    landed Property described below:</strong></td>
                </tr>
                <tr> 
                  <td width="33%"><strong> Location</strong></td>
                  <td width="50%"> <strong>Sy.No</strong></td>
                  <td width="17%"> <strong>Extent[ac-<%=measurementval%>]</strong></td>
                </tr>
                <% if(vec_1!=null)
             {
            
           		 vec12=new ArrayList();
  	 
					  for(int l=0;l<vec_1.size();l++)
					  {
						  vec12=(ArrayList)vec_1.get(l);
					acreval_e = Double.parseDouble(Helper.correctDouble((String) vec12.get(9)));
					centguntval_e = Double.parseDouble(Helper.correctDouble((String)vec12.get(10)));
					totalacreval_e = totalacreval_e + acreval_e;
					totalcentgunt_e = totalcentgunt_e + centguntval_e; 
					%>
                <%
                                if(measurementtype.equalsIgnoreCase("g"))
                      	  		{
                      	 
                      	  		                    	 		        
					guntasrealq_e  = totalcentgunt_e % 40;
					guntasrealr_e   = totalcentgunt_e / 40 ;
					if(guntasrealr_e >= 1)
					{
						totalacreval_e = 	totalacreval_e + guntasrealr_e;
					}
					totalacreval_e = Math.floor(totalacreval_e);
					
         	  		}
                   else 
                   {
                   	guntasrealq_e  = totalcentgunt_e % 100;
   					guntasrealr_e   = totalcentgunt_e/ 100 ;
   					if(guntasrealr_e >= 1)
   					{
   						totalacreval_e = 	totalacreval_e + guntasrealr_e;
   					}
   					totalacreval_e = Math.floor(totalacreval_e);
                   }					
					%>
                <tr> 
                  <td><%=Helper.correctNull((String)vec12.get(5))%>, <%=Helper.correctNull((String)vec12.get(6))%>, 
                    <%=Helper.correctNull((String)vec12.get(7))%> </td>
                  <td> <%=Helper.correctNull((String)vec12.get(8))%></td>
                  <td><%=Helper.correctNull((String)vec12.get(9))%>.<%=Helper.correctNull((String)vec12.get(10))%></td>
                </tr>
                <%}}%>
              </table>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td width="83%" height="31"><strong> Total</strong></td>
                  <td width="17%"><%=totalacreval_e%>Acres<%=guntasrealq_e%>&nbsp;&nbsp; 
                      <%=measurementval%> </td>
                </tr>
              </table>
              <%  } 
			%>
              <br>
              <% 
				    vec13=new ArrayList();
  					vec_2=(ArrayList)hshValues.get("vecData12");
				
			%>
              <% if (vec_2.size()!= 0) {
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td colspan="3"><strong> Creation of Charge mortgage 
                    of landed Property described below:</strong></td>
                </tr>
                <tr> 
                  <td width="32%"><strong> Location</strong></td>
                  <td width="50%"> <strong>Sy.No</strong></td>
                  <td width="18%"> <strong>Extent[ac-<%=measurementval%>]</strong></td>
                </tr>
                <% if(vec_2!=null)
                   {
            
             		vec13=new ArrayList();
   
					  for(int h=0;h<vec_2.size();h++)
					  {
					    vec13=(ArrayList)vec_2.get(h);
					acreval_c = Double.parseDouble(Helper.correctDouble((String) vec13.get(9)));
					centguntval_c = Double.parseDouble(Helper.correctDouble((String)vec13.get(10)));
					totalacreval_c = totalacreval_c + acreval_c;
					totalcentgunt_c = totalcentgunt_c + centguntval_c;  
					%>
                <%
                      if(measurementtype.equalsIgnoreCase("g"))
                     {
                    guntasrealq_c  = totalcentgunt_e % 40;
					guntasrealr_c  = totalcentgunt_e / 40 ;
					if(guntasrealr_c >= 1)
					{
						totalacreval_c = 	totalacreval_c + guntasrealr_c;
					}
					totalacreval_c = Math.floor(totalacreval_c);
					
         	  		}
                   else 
                   {
                   	guntasrealq_c  = totalcentgunt_c % 100;
   					guntasrealr_c  = totalcentgunt_c/ 100 ;
   					if(guntasrealr_c >= 1)
   					{
   						totalacreval_c = 	totalacreval_c + guntasrealr_c;
   					}
   					totalacreval_c = Math.floor(totalacreval_c);
                   }					
					%>
                <tr> 
                  <td><%=Helper.correctNull((String)vec13.get(5))%>, <%=Helper.correctNull((String)vec13.get(6))%>,<%=Helper.correctNull((String)vec13.get(7))%></td>
                  <td> <%=Helper.correctNull((String)vec13.get(8))%></td>
                  <td><%=Helper.correctNull((String)vec13.get(9))%>.<%=Helper.correctNull((String)vec13.get(10))%></td>
                </tr>
                <%}}%>
              </table>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td width="82%"><strong> Total</strong></td>
                  <td width="18%"><%=totalacreval_c%>Acres<%=guntasrealq_c%>&nbsp;&nbsp; 
                      <%=measurementval%></td>
                </tr>
              </table>
              <%  } 
			%>
              <br>
              <table width="95%" border="1" cellspacing="0" cellpadding="3" bordercolor="#000000">
                <tr> 
                  <td width="50%"> <b>Tie up with Sugar Factory</b></td>
                  <td width="50%"><%=sugar%></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> <b>
              <%ArrayList vecRowcolt = (ArrayList) hshValues.get("vecRowcolt");
              if(vecRowcolt!=null)
              {
			if (vecRowcolt.size() != 0) {

				%>
              Immovable Property </b> 
              <!-- out.println("vecRowcolt==="+vecRowcolt); -->
              <%for (int f = 0; f < vecRowcolt.size(); f++) {
					ArrayList vecColcolt = (ArrayList) vecRowcolt.get(f);

					%>
              <br>
              <table width="95%" border="1" cellspacing="0" cellpadding="3"
			bordercolor="#000000">
                <tr> 
                  <td><b> 
                    <%String atype = Helper.correctNull((String) vecColcolt
							.get(1));
					if (atype.equalsIgnoreCase("a")) {
						out.println("Applicant");
					} else if (atype.equalsIgnoreCase("c")) {
						out.println("Co-Applicant");
					} else {
						out.println("Guarantor");
					}

					%>
                    </b></td>
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td width="46%"><b>Location 
                    of Asset</b></td>
                  <td width="54%"><b>Other 
                    Details</b></td>
                </tr>
                <tr> 
                  <td > 
                    <table width="95%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Contact 
                          Person</b></td>
                        <td>&nbsp;<%=Helper.correctNull((String) vecColcolt
									.get(8))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Address</b></td>
                        <td>&nbsp;<%=Helper.correctNull((String) vecColcolt
									.get(3))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3">&nbsp;</td>
                        <td>&nbsp;<%=Helper.correctNull((String) vecColcolt
									.get(4))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>City</b></td>
                        <td>&nbsp;<%=Helper.correctNull((String) vecColcolt
									.get(5))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Pin 
                          Code</b></td>
                        <td>&nbsp;<%=Helper.correctNull((String) vecColcolt
									.get(7))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>State</b></td>
                        <td>&nbsp;<%=Helper.correctNull((String) vecColcolt
									.get(6))%></td>
                      </tr>
                    </table>
                  </td>
                  <td> 
                    <table width="95%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Year 
                          Built</b></td>
                        <td>&nbsp;<%=Helper.correctNull((String) vecColcolt
									.get(9))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3" ><b>Immovable 
                          Property Extent[Sq.ft]</b></td>
                        <td><%=Helper.correctNull((String) vecColcolt
									.get(14))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Survey 
                          No</b></td>
                        <td>&nbsp;<%=Helper.correctNull((String) vecColcolt
									.get(15))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Purchase 
                          Price</b></td>
                        <td><%=Helper.correctNull((String) vecColcolt
									.get(10))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Mortgage 
                          Bal </b></td>
                        <td><%=Helper.correctNull((String) vecColcolt
									.get(13))%></td>
                      </tr>
                      <tr> 
                        <td bgcolor="#F3F3F3"><b>Appraised 
                          Value</b></td>
                        <td><%=Helper.correctNull((String) vecColcolt
									.get(12))%></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <%}
			}
              }
			%>
              <br>
              <%ArrayList arryRowAsset = (ArrayList) hshValues.get("otherassetRow");
			ArrayList Asset = new ArrayList();
			String checkAssetOpen1 = "";
			String checkAssetOpen = "";
			%>
              <% 
              if(arryRowAsset!=null)
              {
              if (arryRowAsset.size() != 0) {
			//out.println("arryRowAsset==sssssssss="+arryRowAsset);
			%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3"
					bordercolor="#000000">
                <tr> 
                  <td colspan="5" align="center"><b>Other 
                    Assets </b></td>
                </tr>
                <tr> 
                  <td align="center" width="31%"><b>Security 
                    Details </b></td>
                  <td align="center" width="18%" ><b>Particulars</b></td>
                  <td align="center" width="15%" ><b>Purchase 
                    Price </b></td>
                  <td align="center" width="15%" ><b>Market 
                    Value </b></td>
                  <td align="center" width="21%"><b>Applicant 
                    Type</b></td>
                </tr>
                <%  String checkAsset = "";
					String checkAsset1 = "";
					String checkAsset2 = "";
					String checkAsset4 = "";
					for (int d = 0; d < arryRowAsset.size(); d++) {
						Asset = (ArrayList) arryRowAsset.get(d);
							if (Asset.size() != 0) {
			 %>
                <tr> 
                  <td align="left">&nbsp;<%=Asset.get(1)%></td>
                  <td align="left">&nbsp;<%=Asset.get(2)%></td>
                  <td align="right">&nbsp;<%=Asset.get(3)%></td>
                  <td align="right">&nbsp;<%=Asset.get(4)%></td>
                  <%  checkAsset = (String) Asset.get(0);
								checkAsset1 = checkAsset.substring(0, 1);
								if (checkAsset1.equalsIgnoreCase("a")) {
									checkAsset2 = "Applicant";
								} else if (checkAsset1.equalsIgnoreCase("c")) {
									checkAsset2 = "Co-Applicant";
								} else if (checkAsset1.equalsIgnoreCase("g")) {
									checkAsset2 = "Guarantor";
								} else {
									checkAsset2 = "-";
								}

								%>
                  <td align="left">&nbsp;<%=checkAsset2%></td>
                </tr>
                <%	}
				} 
	  		 %>
              </table>
              <%  } 
              }
			%>
            </td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <%ArrayList arryRowAcc = (ArrayList) hshValues.get("arryRow2");
			ArrayList Acc = new ArrayList();
			String checkAccOpen1 = "";
			String checkAccOpen = "";
			%>
              <%
              if(arryRowAcc!=null)
              {
              if (arryRowAcc.size() != 0) {
				for (int t = 0; t < arryRowAcc.size(); t++) {
				
					Acc = (ArrayList) arryRowAcc.get(t);
					
					checkAccOpen1 = (String) Acc.get(7);
					if (checkAccOpen1.equalsIgnoreCase("Y")) {
						checkAccOpen = "true";
					}
				}
				if (checkAccOpen.equalsIgnoreCase("true")) {
				
					%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3"
					bordercolor="#000000">
                <tr> 
                  <td colspan="5" align="center"><b>Bank 
                    Accounts </b></td>
                </tr>
                <tr> 
                  <td align="center" width="31%"><b>Bank 
                    / <strong>Branch Name</strong></b></td>
                  <td align="center" width="18%" ><b>Type 
                    of Account</b></td>
                  <td align="center" width="15%" ><b>Account 
                    No </b></td>
                  <td align="center" width="15%" ><b>Account 
                    Balance </b></td>
                  <td align="center" width="21%"><b>Applicant 
                    Type</b></td>
                </tr>
                <%String checkAcc = "";
					String checkAcc1 = "";
					String checkAcc2 = "";
					String checkAcc4 = "";
					//out.println("acconts==="+Acc);
					for (int m = 0; m < arryRowAcc.size(); m++) {
						Acc = (ArrayList) arryRowAcc.get(m);
							if (Acc.size() != 0) {
							checkAcc4 = (String) Acc.get(7);
							if (checkAcc4.equalsIgnoreCase("Y")) {

								%>
                <tr> 
                  <td align="left">&nbsp;<%=Acc.get(3)%></td>
                  <td align="left">&nbsp; 
                    <%
				String acctype=(String)Acc.get(5);
				if(acctype.equalsIgnoreCase("AI"))
				{
					out.println("Current Deposit");
				}
				else if(acctype.equalsIgnoreCase("AD"))
				{
						out.println("Fixed Deposit");
				}
				else if(acctype.equalsIgnoreCase("AC"))
				{
						out.println("Cumulative Deposit");
				}
				else if(acctype.equalsIgnoreCase("AS"))
				{
						out.println("Savings Deposit");
				}
				else if(acctype.equalsIgnoreCase("AM"))
				{
						out.println("Recurring Deposit");
				}
				%>
                  </td>
                  <td align="right">&nbsp;<%=Acc.get(4)%></td>
                  <td align="right">&nbsp;<%=Acc.get(6)%></td>
                  <%checkAcc = (String) Acc.get(1);
								checkAcc1 = checkAcc.substring(0, 1);
								if (checkAcc1.equalsIgnoreCase("a")) {
									checkAcc2 = "Applicant";
								} else if (checkAcc1.equalsIgnoreCase("c")) {
									checkAcc2 = "Co-Applicant";
								} else if (checkAcc1.equalsIgnoreCase("g")) {
									checkAcc2 = "Guarantor";
								} else {
									checkAcc2 = "-";
								}

								%>
                  <td align="left">&nbsp;<%=checkAcc2%></td>
                </tr>
                <%}
						}

					}

				%>
              </table>
              <%}
			}
              }
			%>
            </td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <%ArrayList arryRowInv = (ArrayList) hshValues.get("arryRow1");
			ArrayList inv = new ArrayList();
			String checkinvOpen1 = "";
			String checkinvOpen = "";

			//out.println(arryRowInv); %>
              <%
              if(arryRowInv!=null){
              if (arryRowInv.size() != 0) {
				for (int n = 0; n < arryRowInv.size();n++) {
					inv = (ArrayList) arryRowInv.get(n);
					checkinvOpen1 = (String) inv.get(6);
					if (checkinvOpen1.equalsIgnoreCase("Y")) {
						checkinvOpen = "true";
					}
				}
				if (checkinvOpen.equalsIgnoreCase("true")) {

					%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3"
					bordercolor="#000000">
                <tr> 
                  <td colspan="5" align="center"><b>Investments</b></td>
                </tr>
                <tr> 
                  <td align="center" width="31%"><b>Description</b></td>
                  <td align="center" width="18%" ><b>Market/Present 
                    Value </b></td>
                  <td align="center" width="15%" ><b>Number 
                    of Units</b></td>
                  <td align="center" width="15%" ><b>Total 
                    Value</b></td>
                  <td align="center" width="21%"><b>Applicant 
                    Type</b></td>
                </tr>
                <%String checkinv = "";
					String checkinv1 = "";
					String checkinv2 = "";
					String checkinv4 = "";
					for (int q = 0; q < arryRowInv.size(); q++) {
						inv = (ArrayList) arryRowInv.get(q);
						if (inv.size() != 0) {
							checkinv4 = (String) inv.get(6);
							if (checkinv4.equalsIgnoreCase("Y")) {

								%>
                <tr> 
                  <td align="left">&nbsp;<%=inv.get(3)%></td>
                  <td align="right">&nbsp;<%=inv.get(4)%></td>
                  <td align="right">&nbsp;<%=inv.get(5)%></td>
                  <td align="right">&nbsp;<%=inv.get(7)%></td>
                  <%checkinv = (String) inv.get(1);
								checkinv1 = checkinv.substring(0, 1);
								if (checkinv1.equalsIgnoreCase("a")) {
									checkinv2 = "Applicant";
								} else if (checkinv1.equalsIgnoreCase("c")) {
									checkinv2 = "Co-Applicant";
								} else if (checkinv1.equalsIgnoreCase("g")) {
									checkinv2 = "Guarantor";
								} else {
									checkinv2 = "-";
								}

								%>
                  <td align="left">&nbsp;<%=checkinv2%></td>
                </tr>
                <%}
						}

					}

				%>
              </table>
              <%}
			}
              }
			%>
            </td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <%ArrayList arryRowIns = (ArrayList) hshValues.get("arryRow3");
			String checkinsOpen = "false";
			String checkinsOpen1 = "";
			ArrayList ins = new ArrayList();
			//out.println(arryRowIns); %>
              <%if(arryRowIns!=null){
              if (arryRowIns.size() != 0) {
				for (int c = 0; c < arryRowIns.size(); c++) {
					ins = (ArrayList) arryRowIns.get(c);
					checkinsOpen1 = (String) ins.get(7);
					if (checkinsOpen1.equalsIgnoreCase("Y")) {
						checkinsOpen = "true";
					}
				}
				if (checkinsOpen.equalsIgnoreCase("true")) {

					%>
              <table width="95%" border="1" cellspacing="0" cellpadding="3"
					bordercolor="#000000">
                <tr> 
                  <td colspan="6" align="center"><b>Insurance 
                    Policies </b></td>
                </tr>
                <tr> 
                  <td width="12%" align="center" ><font face="MS Sans Serif"
							size="2"><b>Policy No</b></td>
                  <td width="11%" align="center" ><font face="MS Sans Serif"
							size="2"><b>Maturity Date </b></td>
                  <td width="19%" align="center" ><font face="MS Sans Serif"
							size="2"><b>Last Premium Paid Upto </b></td>
                  <td width="29%" align="center" ><b><font size="2"
							face="MS Sans Serif">Insurance Company Name</b></td>
                  <td width="11%" align="center" ><b><font size="2"
							face="MS Sans Serif">Sum Assured </b></td>
                  <td width="18%" align="center" ><font face="MS Sans Serif"
							size="2"><b>Applicant Type</b></td>
                </tr>
                <%String checkins = "";
					String checkins1 = "";
					String checkins2 = "";
					String checkins4 = "";
					for (int r= 0; r < arryRowIns.size(); r++) {
						ins = (ArrayList) arryRowIns.get(r);
						if (ins.size() != 0) {
							checkins4 = (String) ins.get(7);
							if (checkins4.equalsIgnoreCase("Y")) {

								%>
                <tr> 
                  <td align="center">&nbsp;<%=ins.get(3)%></td>
                  <td align="center"><%=ins.get(8)%></td>
                  <td align="center"><%=ins.get(9)%></td>
                  <td align="center"><%=ins.get(5)%></td>
                  <td align="center"><%=ins.get(6)%></td>
                  <%checkins = (String) ins.get(1);
								checkins1 = checkins.substring(0, 1);
								if (checkins1.equalsIgnoreCase("a")) {
									checkins2 = "Applicant";
								} else if (checkins1.equalsIgnoreCase("c")) {
									checkins2 = "Co-Applicant";
								} else if (checkins1.equalsIgnoreCase("g")) {
									checkins2 = "Guarantor";
								} else {
									checkins2 = "-";
								}

								%>
                  <td >&nbsp;<%=checkins2%></td>
                </tr>
                <%}
						}

					%>
                <br>
                <%}

				%>
              </table>
              <%}
			}
              }
			%>
            </td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <%ArrayList arryRowLnd = (ArrayList) hshValues.get("arryRow4");
			ArrayList lnd = new ArrayList();
			//out.println(arryRowLnd);
			String checklndOpen1 = "";
			String checklndOpen = "false";

			%>
              <%
              if(arryRowLnd!=null)
              {
              if (arryRowLnd.size() != 0) {
				for (int w= 0; w < arryRowLnd.size(); w++) {
					lnd = (ArrayList) arryRowLnd.get(w);
					checklndOpen1 = (String) lnd.get(5);
					if (checklndOpen1.equalsIgnoreCase("Y")) {
						checklndOpen = "true";
					}

				}
				if (checklndOpen.equalsIgnoreCase("true")) {

					%>
              <table width="95%" border="1" cellpadding="3" cellspacing="0"
					bordercolor="#000000">
                <tr> 
                  <td colspan="6"> 
                    <div align="center"><B>Land/ Building/ Other Assets</B></div>
                  </td>
                </tr>
                <tr> 
                  <td align="center" width="30%"><b>Description </b></td>
                  <td align="center" width="14%"><B>Purchase Price</B></td>
                  <td align="center" width="14%"><B>Market Value</B></td>
                  <td align="center" width="14%"><B>Whether lease holder or ownership</B></td>
                  <td align="center" width="14%"><B>Applicant Type</B></td>
                  <td align="center" width="14%"><B>Asset Type</B></td>
                </tr>
                <%String checklnd = "";
					String checklnd1 = "";
					String checklnd2 = "";
					String checklnd4 = "";
					String checklnd5 = "";
					String checklnd6 = "";
					for (int a = 0; a< arryRowLnd.size(); a++) {
						lnd = (ArrayList) arryRowLnd.get(a);
						if (lnd.size() != 0) {
							checklnd4 = (String) lnd.get(5);
							if (checklnd4.equalsIgnoreCase("Y")) {

								%>
                <tr> 
                  <td align="left">&nbsp;<%=lnd.get(3)%></td>
                  <td align="right">&nbsp;<%=lnd.get(11)%></td>
                  <td align="right">&nbsp;<%=lnd.get(4)%></td>
                  <td align="left">&nbsp;<%=lnd.get(10)%></td>
                  <%checklnd = (String) lnd.get(1);

								if (!checklnd.equalsIgnoreCase("")) {
									checklnd1 = (String) checklnd.substring(0,
											1);
								} else {
									checklnd1 = "-";
								}
								if (checklnd1.equalsIgnoreCase("a")) {
									checklnd2 = "Applicant";
								} else if (checklnd1.equalsIgnoreCase("c")) {
									checklnd2 = "Co-Applicant";
								} else if (checklnd1.equalsIgnoreCase("g")) {
									checklnd2 = "Guarantor";
								} else {
									checklnd2 = "-";
								}

								%>
                  <td align="left">&nbsp;<%=checklnd2%></td>
                  <%checklnd5 = (String) lnd.get(9);
								if (checklnd5.equalsIgnoreCase("M")) {
									checklnd6 = "Movable";
								} else if (checklnd5.equalsIgnoreCase("I")) {
									checklnd6 = "Immovable";
								}

								%>
                  <td align="left">&nbsp;<%=checklnd6%></td>
                </tr>
                <%}
						}
					}

				%>
              </table>
              <%}
			}}
			%>
            </td>
          </tr>
        </table>
    </tr>
  </table>
  
  <tr> 
    <td>&nbsp; 
      <table width="100%" border="1" cellspacing="0" cellpadding="3"
			bordercolor="#000000">
        <tr> 
          <td bgcolor="#F3F3F3"><font face="MS Sans Serif"
					size="2"><b>Other Special Terms</b><font
					face="MS Sans Serif" size="2">&nbsp;</td>
        </tr>
        <%ArrayList g4 = new ArrayList();
			ArrayList v3 = (ArrayList) hshValues.get("vecterms");
			int a = v3.size();
			
			if (v3 != null && a!=0) {
				int vecsize3 = v3.size();
				for (int l = 0; l < vecsize3; l++) {
					g4 = (ArrayList) v3.get(l);

					%>
        <tr> 
          <td height="47"><br>
            <table width="95%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="4%"><%=l + 1%>.</td>
                <td width="96%"><%=Helper.correctNull((String) g4
											.get(0))%></td>
              </tr>
            </table>
          </td>
        </tr>
        <%}
			}

			%>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp; 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
       <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><strong>&nbsp;MIS CODE: </strong><b><%=Helper.correctNull((String) hshValues.get("Code_No"))%></b><strong> 
            </strong></td>
        </tr>
        <tr> 
          <td><strong>SUBMITTED FOR ORDERS:</strong></td>
        </tr>
        <tr> 
          <td> 
            <table width="95%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="50%">&nbsp; </td>
                <td width="50%">&nbsp;</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td align="right"><strong>Manager/Sr. 
                  Manager</strong>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
      <tr> 
          <td >&nbsp; 
            <table width="95%" height="94" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td><strong>REMARKS OF THE SANCTIONING AUTHORITY:</strong></td>
              </tr>
              <tr> 
                <td height="54">&nbsp;</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td> 
            <table width="95%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="50%">Date:</td>
                <td width="50%" align="right"><strong> Sanctioning 
                  Authority </strong></td>
              </tr>
            </table>
          </td>
        </tr>--%>
        <tr>
		  <td width="25%"><b>Margin</b></td>
		  <td width="75%"><b>Nil. However, wherever scale of finance is not followed, applicable marins has to be obtained.</b></td>
		  </tr>
		  <tr>
		  <td width="25%"><b>Interest Rate:</b></td>
		  <td width="75%"><b>&nbsp;</b></td>
		  </tr>
		  <tr>
		  <td colspan="2"><b>Documents to be obtained:</b></td>
		  <td><b>&nbsp;</b></td>
		  </tr>
		  <tr>
		  <td colspan="2" align="center">
		  <table width="90%" border="0" cellspacing="0" cellpadding="0" bordercolor="#000000" >
		  <tr><td>a.DPN</td></tr>
		  <tr><td>b.SD07</td></tr>
		  <tr><td>c.E.M/SD12</td></tr>
		  <tr><td>d.SD08</td></tr>
		  </table>
		  </td>
		  </tr>
		  <tr>
		  <td colspan="2"><b>Security</b></td>
		  <td><b>&nbsp;</b></td>
		  </tr>
		  <tr>
		  <td colspan="2" align="center">
		  <table width="90%" border="0" cellspacing="0" cellpadding="0" bordercolor="#000000" >
		  <tr><td>a.Hypothecation of standing crops</td></tr>
		  <tr><td>b.Equitable mortgage/Simple mortgage of agricultural lands or other immovable properties</td></tr>
		  <tr><td>c.Letter of guarantee from sureties acceptable to the bank, wherever applicable</td></tr>
		  </table>
		  </td>
		  </tr>
          <tr> 
            <td colspan="2"><strong>Disbursement of Loan</strong></td>
		</tr>
		<tr>
           <td colspan="2" align="center">
		  <table width="90%" border="0" cellspacing="0" cellpadding="0" bordercolor="#000000" >
		  <tr><td>
		  Loan amount for seasonal crop operations should be disdursed in cash and kind as mentioned above as per requirement for farm operations. Loan amount for kind component like fertilizers, insecticides etc should be paid directly to the suppliers by a pay order or demand draft. payment to the suppliers to made on receipt of bills/invoices in case supply order is issued to supplier. The relative bills/receipts should be held on record. End use to be verified by regular inspections and reports held on record.
		  </td></tr>
		  </table>
         </tr>
		  <tr> 
            <td colspan="2"><strong>Repayment of Loan</strong></td>
		</tr>
		 <tr>
           <td colspan="2" align="center">
		  <table width="90%" border="0" cellspacing="0" cellpadding="0" bordercolor="#000000" >
		  <tr><td>
		  Entire loan amount accrued interest should be repaid after harvest of the crops/ marketing of the produce within 12 months in case of short duration crop or within 18 months in case of adsali sugarcane crop.
		  </td></tr>
		  </table>
         </tr>
		 <tr> 
            <td colspan="2"><strong>Special Instruction</strong></td>
		</tr>
		 <tr>
           <td colspan="2" align="center">
		  <table width="90%" border="0" cellspacing="0" cellpadding="0" bordercolor="#000000" >
		  <tr><td>
		  a. Valid and enforceable documents are to be obtained before the release of the loan.
		  </td></tr>
		  <tr><td>
		  b. Legal opinion along with the search report for the last thirty years should be obtained for agriculture land about its clear title from the empanelled advocate of our Bank. Land should be easily marketable and can be mortgaged to the bank. Valuation report of the land to be mortgaged is to be obtained.
		    </td></tr>
		  </table>
         </tr>
		 <tr>
		    <td width="25%"> <b>Sanctioned by </b> </td>
		 <td width="75%">&nbsp;
		 </td>
		 </tr>
		 <tr>
		 <td>&nbsp;</td>
		 <td>&nbsp;</td>
		 </tr>
		  <tr>
		 <td>&nbsp;</td>
		 <td>&nbsp;</td>
		 </tr>
		  <tr>
		 <td>&nbsp;</td>
		 <td>&nbsp;</td>
		 </tr>
		  <tr>
		 <td>&nbsp;</td>
		 <td>&nbsp;</td>
		 </tr>
		 <tr>
		    <td width="25%"> <b>Manager/Senior Manager </b> </td>
		    <td width="75%" align="right"> <b>Chief Manager/Asst.Gen.Manager</b> 
            </td>
		 </tr>
		 
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>


  <input type="hidden" name="comappid"
	value="<%=Helper.correctNull((String)request.getParameter("comappid"))%>">
  <input type="hidden" name="appno"
	value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
</form>
</body>
</html>


