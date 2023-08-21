<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%
String strSaral=Helper.correctNull((String)hshValues.get("saral"));
String[] MOV_DESCRIPTION=new String[10];
String[] IMMOV_DESCRIPTION=new String[10];
String[] MOV_VALUE=new String[10];
String[] IMMOV_VALUE=new String[10];

String MOV_TOTAL=Helper.correctDouble((String)hshValues.get("CR_MOV_TOTAL"));
double mov_total=Double.parseDouble(MOV_TOTAL);
String IMMOV_TOTAL=Helper.correctDouble((String)hshValues.get("CR_IMMOV_TOTAL"));
double immov_total=Double.parseDouble(IMMOV_TOTAL);
String TOTAL_MEANS=Helper.correctDouble((String) hshValues.get("CR_Total_MEANS"));
double total_means=Double.parseDouble(TOTAL_MEANS);

MOV_DESCRIPTION=(String[])hshValues.get("CR_MOV_DESCRIPTION");
MOV_VALUE=(String[])hshValues.get("CR_MOV_VALUE");
IMMOV_DESCRIPTION=(String[])hshValues.get("CR_IMMOV_DESCRIPTION");
IMMOV_VALUE=(String[])hshValues.get("CR_IMMOV_VALUE");

String Busability=Helper.correctNull((String)hshValues.get("CR_Business_ability"));
String BusConducted=Helper.correctNull((String)hshValues.get("CR_Business_Conducted"));
String BusReputation=Helper.correctNull((String)hshValues.get("CR_Business_Reputation"));
String BusCondition=Helper.correctNull((String)hshValues.get("CR_Business_Condition"));

if(Busability.equalsIgnoreCase("1"))
{
	Busability="CAPABLE";
}
else if(Busability.equalsIgnoreCase("2"))
{
	Busability="INCAPABLE";
}
else if(Busability.equalsIgnoreCase("3"))
{
	Busability="EXPERIENCED";
}
else if(Busability.equalsIgnoreCase("4"))
{
	Busability="INEXPERIENCED";
}
else if(Busability.equalsIgnoreCase("5"))
{
	Busability="NOT APPLICABLE";
}
else
{
	Busability="";
}

if(BusConducted.equalsIgnoreCase("1"))
{
	BusConducted="SPECULATIVE";
}
else if(BusConducted.equalsIgnoreCase("2"))
{
	BusConducted="OVERTRADE";
}
else if(BusConducted.equalsIgnoreCase("3"))
{
	BusConducted="CONSERVATIVE";
}
else if(BusConducted.equalsIgnoreCase("4"))
{
	BusConducted="PRUDENT";
}
else if(BusConducted.equalsIgnoreCase("5"))
{
	BusConducted="CAUTIOUS";
}
else if(BusConducted.equalsIgnoreCase("6"))
{
	BusConducted="STEADY";
}
else if(BusConducted.equalsIgnoreCase("7"))
{
	BusConducted="NOT APPLICABLE";
}
else
{
	BusConducted="";
}

if(BusReputation.equalsIgnoreCase("1"))
{
	BusReputation="HONEST";
}
else if(BusReputation.equalsIgnoreCase("2"))
{
	BusReputation="DISHONEST";
}
else if(BusReputation.equalsIgnoreCase("3"))
{
	BusReputation="STRAIGHT-FORWARD";
}
else if(BusReputation.equalsIgnoreCase("4"))
{
	BusReputation="TRICKY";
}
else if(BusReputation.equalsIgnoreCase("5"))
{
	BusReputation="SHARP";
}
else if(BusReputation.equalsIgnoreCase("6"))
{
	BusReputation="SHREWD";
}
else if(BusReputation.equalsIgnoreCase("7"))
{
	BusReputation="NOT APPLICABLE";
}
else
{
	BusReputation="";
}

if(BusCondition.equalsIgnoreCase("1"))
{
	BusCondition="PROGRESSIVE";
}
else if(BusCondition.equalsIgnoreCase("2"))
{
	BusCondition="DECLINING";
}
else if(BusCondition.equalsIgnoreCase("3"))
{
	BusCondition="STAGNANT";
}
else if(BusCondition.equalsIgnoreCase("4"))
{
	BusCondition="THRIVING";
}
else if(BusCondition.equalsIgnoreCase("5"))
{
	BusCondition="HEALTHY";
}
else if(BusCondition.equalsIgnoreCase("6"))
{
	BusCondition="SOUND";
}
else if(BusCondition.equalsIgnoreCase("7"))
{
	BusCondition="LIQUID";
}
else if(BusCondition.equalsIgnoreCase("8"))
{
	BusCondition="NOT APPLICABLE";
}
else
{
	BusCondition="";
}

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Credit Report</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css"/>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td align="center" colspan="3"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
  </tr>
  <tr> 
    <td align="center" colspan="3"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
  </tr>
  <tr>
    <td align="center" colspan="3"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp;<hr/></td>
  </tr>
  <tr> 
    <td align="center" colspan="3"><b>Credit Report</b></td>
  </tr>
  <%if(strSaral.equalsIgnoreCase("saral"))
		{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"><laps:inward/></td>
  </tr>
  <%}else
	{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"> <laps:application/></td>
  </tr>
  <%}%>
  <%if(!(strSaral.equalsIgnoreCase("saral")))
	{%>
  <tr> 
    <td colspan="2"><b>Name:</b></td>
    <td align="left">&nbsp; <%=Helper.correctNull((String) hshValues.get("perapp_fname"))%> 
    </td>
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><b>ADDRESS WITH TELEPHONE NUMBER</b></td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3"> &nbsp;<%=Helper.correctNull((String) hshValues.get("address"))%>,<br/>
      &nbsp;<%=Helper.correctNull((String) hshValues.get("city_name"))%>,<br/>
      &nbsp;<%=Helper.correctNull((String) hshValues.get("state_name"))%>,<br/>
      &nbsp;Pincode:&nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_zip"))%>.<br/>
      &nbsp;Tel No :&nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_phone"))%> 
    </td>
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <%} %>
  <tr> 
    <td width="35%"><b>NATURE OF MAIN BUSINESS</b></td>
    <td width="5%"><b>:</b></td>
    <td><%=Helper.correctNull((String) hshValues.get("cr_mainbussiness"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td width="35%"><b>SIDE LINES IF ANY</b></td>
    <td width="5%"><b>:</b></td>
    <td><%=Helper.correctNull((String) hshValues.get("cr_sideline"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td><b>CONSTITUTION </b></td>
    <td><b>:</b></td>
    <td><%=Helper.correctNull((String) hshValues.get("cr_constitution"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td><b>CATEGORY</b></td>
    <td><b>:</b></td>
    <td> 
      <%if(Helper.correctNull((String)hshValues.get("CR_Agri")).equalsIgnoreCase("2"))
   			{
	   			out.println("Non-Agriculturist");
   			}else
	   		if(Helper.correctNull((String)hshValues.get("CR_Agri")).equalsIgnoreCase("1"))
	   		{
		   		out.println("Agriculturist");
	   		}%>
      &nbsp;&nbsp;&nbsp;&nbsp; 
      <%if(Helper.correctNull((String)hshValues.get("CR_Minor")).equalsIgnoreCase("1")){
    		out.println("Minority");
    	}else if(Helper.correctNull((String)hshValues.get("CR_Minor")).equalsIgnoreCase("2")){
    		out.println("SC/ST");
    	}%>
    </td>
  </tr>
  <tr> 
    <td colspan="3"><p><b>Full name of identical, connected or associated firms giving 
      the nature and place of business name(s) of their bankers with address/es 
      and details of credit facilities allowed by them. <br/>
      Full names &amp; address of the individual, proprietor, partners, karta 
      and co-parceners, directors, etc. and their relationship with each other. 
      If any (brief report on the business means/assets of partners/directors 
      to be given on the reverse)</b></p>
    </td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr > 
            <td rowspan="2" width="20%"> 
              <div align="center"><b>Name &amp; Father s Name</b></div>
            </td>
            <td colspan="6"> 
              <div align="center"><b>Address with Telephone Number</b></div>
            </td>
          </tr>
          <tr> 
            <td align="center" width="13%"><b>Office</b></td>
            <td align="center" width="11%"><b>Tel.No.</b></td>
            <td align="center" width="12%"><b>Residence</b></td>
            <td align="center" width="13%"><b>Tel.No.</b></td>
            <td align="center" width="17%"><b>Permanent Address</b></td>
            <td align="center" width="14%"><b>Tel. No.</b></td>
          </tr>
          <%--
		          	if(arrAppDetails.size()>0)
		          	{
			          		for(int i=0;i<arrAppDetails.size();i++)
			          		{
			          			arrRow=new ArrayList();
					          			arrRow=(ArrayList)arrAppDetails.get(i);
					          %>
          <tr valign="top"> 
            <td width="20%"><%=arrRow.get(0)%><b> &amp; </b><%=arrRow.get(1)%> 
            </td>
            <td width="15%">&nbsp;<%=arrRow.get(2)%> </td>
            <td width="11%">&nbsp;<%=arrRow.get(3)%> </td>
            <td width="15%">&nbsp;<%=arrRow.get(4)%> </td>
            <td width="11%">&nbsp;<%=arrRow.get(5)%> </td>
            <td width="17%">&nbsp;<%=arrRow.get(6)%> </td>
            <td width="11%">&nbsp;<%=arrRow.get(7)%> </td>
          </tr>
          <%
			          		}
		        	 }
		          	else
		          	{
		         %>
          <tr> 
            <td width="20%" height="18">&nbsp; </td>
            <td width="13%" height="18">&nbsp; </td>
            <td width="11%" height="18">&nbsp; </td>
            <td width="12%" height="18">&nbsp; </td>
            <td width="13%" height="18">&nbsp; </td>
            <td width="17%" height="18">&nbsp; </td>
            <td width="14%" height="18">&nbsp; </td>
          </tr>
          <%
		          	}
		   --%>
		   <tr valign="top"> 
            <td width="20%"><%=Helper.correctNull((String)hshValues.get("strAppName"))%><b> 
              &amp; </b><%=Helper.correctNull((String)hshValues.get("cr_fatname"))%>&nbsp;</td>
            <td width="13%"><%=Helper.correctNull((String)hshValues.get("cr_offadd"))%>&nbsp;</td>
            <td width="11%"><%=Helper.correctNull((String)hshValues.get("cr_offtelno"))%>&nbsp;</td>
            <td width="12%"><%=Helper.correctNull((String)hshValues.get("cr_resadd"))%>&nbsp;</td>
            <td width="13%"><%=Helper.correctNull((String)hshValues.get("cr_restelno"))%>&nbsp;</td>
            <td width="17%"><%=Helper.correctNull((String)hshValues.get("cr_permadd"))%>&nbsp;</td>
            <td width="14%"><%=Helper.correctNull((String)hshValues.get("cr_permtelno"))%>&nbsp;</td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        
        <tr> 
          <td width="37%" valign="top"><b>TOTAL MEANS (Rs in Lacs). </b></td>
          <td width="63%" valign="top"><%=Helper.formatDoubleValue(total_means)%> as on <%=Helper.correctNull((String) hshValues.get("CR_meansason"))%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
 
  <tr> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top"><b>GUARANTEES GIVEN IN DETAIL </b></td>
          <td width="63%" valign="top"> 
            <p><%=Helper.correctNull((String) hshValues.get("CR_Gurantee"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td width="37%"><b>PARTICULARS OF LIABILITIES OF INDIVIDUAL / PARTNERS / DIRECTORS 
      /OTHERS (Rs. in Lacs)</b></td>
    <td colspan="2"><%=Helper.correctNull((String) hshValues.get("CR_LIAB_Partner"))%></td>
  </tr>
  <tr valign="top"> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td width="37%" valign="top">&nbsp;</td>
          <td width="63%" valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td width="37%" valign="top"><b>BUSINESS ABILITY</b></td>
          <td width="63%" valign="top"> <%=Busability%>&nbsp; </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr valign="top"> 
    <td width="37%"><b>BUSINESS CONDUCTED</b></td>
    <td colspan="2"><%=BusConducted%>&nbsp;</td>
  </tr>
  <tr valign="top"> 
    <td width="37%"><b>BUSINESS REPUTATION</b></td>
    <td colspan="2"><%=BusReputation%>&nbsp;</td>
  </tr>
  <tr valign="top"> 
    <td width="37%"><b>CONDITION OF BUSINESS</b></td>
    <td colspan="2"><%=BusCondition%>&nbsp;</td>
  </tr>
  <tr valign="top"> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top"><b>&nbsp;NATURE AND EXTENT OF DEALINGS 
            WITH BANK&#146;S BRANCHES (WHAT LIMIT ENJOYED AT OTHER BRANCHES) </b></td>
          <td width="63%" valign="top"> 
            <p><%=Helper.correctNull((String) hshValues.get("CR_DEALINGS_BANK"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr valign="top"> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr valign="top"> 
    <td width="37%"><b>NAMES OF BANKERS / FINANCIAL INSTITUTIONS AND CREDIT FACILITIES 
      AT OTHER BANKS / <br/>
      FINANCIAL INSTITUTIONS AND SECURITIES CHARGED TO THEM</b></td>
    <td colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues.get("CR_SECURITIES_CHARGED"))%></td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%"><b>BRIEF REPORT ON THE MEANS OF INDIVIDUAL PROPRIETOR 
            OR PARTNER OR DIRECTOR</b></td>
          <td width="63%" valign="top"> 
            <p><%=Helper.correctNull((String) hshValues.get("CR_REPORT_ON_MEANS"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  
  <tr> 
    <td colspan="3"><b> DETAILS OF FIXED ASSETS ( GIVE NATURE AND 
      LOCATION OF EACH ASSETS AND INCASE OF IMMOVABLE PROPERTY THE NAMES IN WHICH 
      IT IS HELD) :</b> </td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">
        <tr align="center"> 
          <td colspan="2"> 
		  <div id="top">
              <table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">
                <tr align="right"> 
                  <td colspan="2"><b>Rs. in lacs</b></td>
                </tr>
                <tr align="center"> 
                  <td colspan="2"><b>MOVABLE ASSETS</b></td>
                </tr>
                <tr align="center"> 
                  <td width="28%"><b>DESCRIPTION</b></td>
                  <td width="22%"><b>VALUE</b></td>
                </tr>
                <%
			    for(int i=0;i<MOV_DESCRIPTION.length;i++)
		         { 	
			    	  String strMovValue=Helper.correctNull(MOV_VALUE[i]);
		        	  if(strMovValue.equalsIgnoreCase(""))
		        	  {
		        		  strMovValue="0.00";
		        	  }
		        	  double MovValue=Double.parseDouble(strMovValue);
			    %>
                <tr align="center"> 
                  <td width="28%" align="left">&nbsp;<%=Helper.correctNull(MOV_DESCRIPTION[i])%></td>
                  <td width="22%" align="right"><%=Helper.formatDoubleValue(MovValue)%></td>
                </tr>
                <%} %>
                <tr align="center"> 
                  <td width="28%"><b>TOTAL</b></td>
                  <td width="22%" align="right"><%=Helper.formatDoubleValue(mov_total)%></td>
                </tr>
              </table>
		</div>
          </td>
          <td colspan="2"> 
		  <div id="top">
            <table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">
              <tr align="right"> 
                <td colspan="2"><b>Rs. in lacs</b></td>
              </tr>
              <tr align="center"> 
                  <td colspan="2"><b>IMMOVABLE ASSETS</b></td>
              </tr>
              <tr align="center"> 
                  <td width="28%" ><b>DESCRIPTION</b></td>
                  <td width="22%" ><b>VALUE</b></td>
              </tr>
              <%
			    for(int i=0;i<IMMOV_DESCRIPTION.length;i++)
		         { 	
			    	  String strImMovValue=Helper.correctNull(IMMOV_VALUE[i]);
		        	  if(strImMovValue.equalsIgnoreCase(""))
		        	  {
		        		  strImMovValue="0.00";
		        	  }		        	  
		        	  double ImMovValue=Double.parseDouble(strImMovValue);
			    %>
              <tr align="center"> 
                <td width="28%" align="left">&nbsp;<%=Helper.correctNull(IMMOV_DESCRIPTION[i])%></td>
                <td width="22%" align="right"><%=Helper.formatDoubleValue(ImMovValue)%></td>
              </tr>
              <%} %>
              <tr align="center"> 
                  <td width="28%"><b>TOTAL</b></td>
                <td width="22%" align="right"><%=Helper.formatDoubleValue(immov_total)%></td>
              </tr>
            </table>
		</div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="3" height="32"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="7">
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="8%" valign="bottom"><b>DATE :</b></td>
          <td width="20%" valign="bottom"><b>&nbsp;<%=Helper.correctNull((String) hshValues.get("CR_DATE"))%></b></td>
          <td align="center"><b>(<%=Helper.correctNull((String) hshValues.get("CR_Investigator"))%>)<br/>
            CREDIT INVESTIGATOR &nbsp;</b></td>
          <td align="center"><b>(<%=Helper.correctNull((String) hshValues.get("CR_Brmanager"))%>)<br/>
            BRANCH MANAGER&nbsp;</b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html> 
  