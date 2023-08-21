<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<%
	ArrayList arrCol=null;
	ArrayList arrRow1=null;
	if(hshValues!=null)
	{
		arrRow1 =(ArrayList) hshValues.get("arrCol");
	}

	String strAppType=Helper.correctNull((String)hshValues.get("strAppType"));
	String strSaral=Helper.correctNull((String)hshValues.get("saral"));

	String[] MOV_DESCRIPTION = new String[10];
	String[] IMMOV_DESCRIPTION = new String[10];
	String[] MOV_VALUE = new String[10];
	String[] IMMOV_VALUE = new String[10];

	MOV_DESCRIPTION = (String[]) hshValues.get("CR_MOV_DESCRIPTION");
	MOV_VALUE = (String[]) hshValues.get("CR_MOV_VALUE");
	IMMOV_DESCRIPTION = (String[]) hshValues.get("CR_IMMOV_DESCRIPTION");
	IMMOV_VALUE = (String[]) hshValues.get("CR_IMMOV_VALUE");

	String BusReputation = Helper.correctNull((String) hshValues.get("CR_Business_Reputation"));
	if (BusReputation.equalsIgnoreCase("1")) {
		BusReputation = "HONEST";
	} else if (BusReputation.equalsIgnoreCase("2")) {
		BusReputation = "DISHONEST";
	} else if (BusReputation.equalsIgnoreCase("3")) {
		BusReputation = "STRAIGHT-FORWARD";
	} else if (BusReputation.equalsIgnoreCase("4")) {
		BusReputation = "TRICKY";
	} else if (BusReputation.equalsIgnoreCase("5")) {
		BusReputation = "SHARP";
	} else if (BusReputation.equalsIgnoreCase("6")) {
		BusReputation = "SHREWD";
	} else if (BusReputation.equalsIgnoreCase("7")) {
		BusReputation = "NOT APPLICABLE";
	} else {
		BusReputation = "";
	}
	String BusCondition = Helper.correctNull((String) hshValues.get("CR_Business_Condition"));
	if (BusCondition.equalsIgnoreCase("1")) {
		BusCondition = "PROGRESSIVE";
	} else if (BusCondition.equalsIgnoreCase("2")) {
		BusCondition = "DECLINING";
	} else if (BusCondition.equalsIgnoreCase("3")) {
		BusCondition = "STAGNANT";
	} else if (BusCondition.equalsIgnoreCase("4")) {
		BusCondition = "THRIVING";
	} else if (BusCondition.equalsIgnoreCase("5")) {
		BusCondition = "HEALTHY";
	} else if (BusCondition.equalsIgnoreCase("6")) {
		BusCondition = "SOUND";
	} else if (BusCondition.equalsIgnoreCase("7")) {
		BusCondition = "LIQUID";
	} else if (BusCondition.equalsIgnoreCase("8")) {
		BusCondition = "NOT APPLICABLE";
	} else {
		BusCondition = "";
	}
	
	String strProposalvalue = Helper.correctNull((String) request.getParameter("valuesin"));
	if (strProposalvalue.equalsIgnoreCase("C"))
		strProposalvalue = "Crores";
	else if (strProposalvalue.equalsIgnoreCase("L"))
		strProposalvalue = "Lacs";
	
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Credit Information Report</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css" />
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
  <tr> 
    <td align="center" colspan="4"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
  </tr>
  <tr> 
    <td align="center" colspan="4"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
  </tr>
  <tr> 
    <td align="center" colspan="4"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      <%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      <hr/>
    </td>
  </tr>
  <tr> 
    <td align="center" colspan="4"><b>Credit Report</b></td>
  </tr>
  <%if(strSaral.equalsIgnoreCase("saral"))
	{%>
  <tr> 
    <td valign="bottom" align="center" colspan="4"><lapschoice:inward /></td>
  </tr>
  <%}else
	{%>
  <tr> 
    <td valign="bottom"align="center" colspan="4"><lapschoice:application /></td>
  </tr>
  <%} %>
  <%if(!(strSaral.equalsIgnoreCase("saral")))
	{%>
  <tr> 
    <%if(strAppType.equalsIgnoreCase("0"))
			{%>
    <td width="37%" colspan="2"><b>Name</b></td>
    <td colspan="3" align="left">&nbsp; <%=Helper.correctNull((String) hshValues.get("comapp_companyname"))%> 
    </td>
    <%} 
		else
		{
			%>
    <td width="37%"><b>Name</b></td>
    <td colspan="3" align="left">&nbsp; <%=Helper.correctNull((String) hshValues.get("strAppName"))%> 
    </td>
    <%} %>
  </tr>
  <tr> 
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td width="37%" colspan="2"><b>ADDRESS WITH TELEPHONE NUMBER(HEAD OFFICE)</b></td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="4"><%=Helper.correctNull((String) hshValues.get("address"))%><br/>
    <%=Helper.correctNull((String) hshValues.get("city_name"))%><br/>
    <%=Helper.correctNull((String) hshValues.get("state_name"))%><br/>Pincode:&nbsp;
    <%=Helper.correctNull((String) hshValues.get("comapp_crptpin"))%><br/>Tel No :&nbsp;
    <%=Helper.correctNull((String) hshValues.get("comapp_crptphone"))%></td>
  </tr>
  <tr> 
    <td colspan="4"><b>ADDRESS WITH TELEPHONE NUMBER(BRANCH OFFICE)</b></td>
  </tr>
  <tr> 
    <td colspan="4"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="2">
        <%if (arrRow1 != null) {

				for (int j = 0; j < arrRow1.size(); j++) {

					arrCol = (ArrayList) arrRow1.get(j);

					%>
        <tr> 
          <td><%=j + 1%>)&nbsp;&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
        </tr>
        <tr> 
          <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%>,</td>
        </tr>
        <tr> 
          <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%>,</td>
        </tr>
        <tr> 
          <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
        </tr>
        <tr> 
          <td>&nbsp;Pincode:<%=Helper.correctNull((String) arrCol.get(4))%></td>
        </tr>
        <tr> 
          <td height="2">Tel No :<%=Helper.correctNull((String) arrCol.get(5))%></td>
        </tr>
        <%}
			}
	
			%>
      </table>
     
    </td>
  </tr>
  <%
	}else if(strSaral.equalsIgnoreCase("saral")){
	%>
  <tr> 
    <td colspan="3">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td width="37%" colspan="2"><b>Name</b></td>
    <td width="5%"><b>:</b></td>
    <td align="left"><%=Helper.correctNull((String) hshValues.get("strAppName"))%>&nbsp; 
    </td>
  </tr>
  <%} %>
  <tr> 
    <td width="35%" colspan="2"><b>NATURE OF MAIN BUSINESS</b></td>
    <td width="5%"><b>:</b></td>
    <td><%=Helper.correctNull((String) hshValues.get("cr_mainbussiness"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td width="35%" colspan="2"><b>SIDE LINES IF ANY</b></td>
    <td width="5%"><b>:</b></td>
    <td><%=Helper.correctNull((String) hshValues.get("cr_sideline"))%>&nbsp;</td>
  </tr>
  <%//if(strSaral.equalsIgnoreCase("saral")){ %>
  <tr> 
    <td colspan="2"><b>CONSTITUTION </b></td>
    <td><b>:</b></td>
    <td><%=Helper.correctNull((String) hshValues.get("cr_constitution"))%>&nbsp;</td>
  </tr>
  <%//} %>
  <tr> 
    <td colspan="2"><b>CATEGORY</b></td>
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
    <td colspan="4"> 
      <p><b>Full name of identical, connected or associated firms giving the nature 
        and place of business name(s) of their bankers with address/es and details 
        of credit facilities allowed by them. <br/>
        Full names &amp; address of the individual, proprietor, partners, karta 
        and co-parceners, directors, etc. and their relationship with each other. 
        If any (brief report on the business means/assets of partners/directors 
        to be given on the reverse) </b> </p>
    </td>
  </tr>
  <tr> 
    <td colspan="4"> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
            <td rowspan="2" width="20%" align="center"><b>Name &amp; Father's 
              Name </b></td>
            <td colspan="6" align="center"><b>Address with Telephone Number </b></td>
          </tr>
          <tr> 
            <td align="center" width="13%"><b>Office</b></td>
            <td align="center" width="11%"><b>Tel.No.</b></td>
            <td align="center" width="12%"><b>Residence</b></td>
            <td align="center" width="13%"><b>Tel.No.</b></td>
            <td align="center" width="17%"><b>Permanent Address</b></td>
            <td align="center" width="14%"><b>Tel. No.</b></td>
          </tr>
          <%
				if (strAppType.equalsIgnoreCase("0")) {
				%>
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
          <% } %>
          <%if (strAppType!="" && !strAppType.equalsIgnoreCase("0")){ %>
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
          <%} %>
        </table>
      </div>
    </td>
  </tr>
  <tr> 
    <td valign="top"><b>TOTAL MEANS (Rs. in <%=strProposalvalue%>)</b></td>
    <td valign="top"><b>:</b></td>
    <td colspan="2" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("CR_Total_MEANS"))))%> as on <%=Helper.correctNull((String) hshValues.get("CR_meansason"))%></td>
  </tr>
  <tr> 
    <td valign="top"><b>GURANTEES GIVEN IN DETAIL </b></td>
    <td valign="top"><b>:</b></td>
    <td colspan="2" valign="top"> 
      <p><%=Helper.correctNull((String) hshValues.get("CR_Gurantee"))%></p>
    </td>
  </tr>
  <tr> 
    <td width="35%" valign="top"><b>PARTICULARS OF LIABILITIES OF INDIVIDUAL / 
      PARTNERS / DIRECTORS /OTHERS (Rs. in <%=strProposalvalue%>)</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <td colspan="2" valign="top"><%=Helper.correctNull((String) hshValues.get("CR_LIAB_Partner"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td width="35%" valign="top"><b>BUSINESS ABILITY</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <td colspan="2" valign="top"> <%=ApplicantParams.getApplicantParams("BUSINESSABILITY",Helper.correctNull((String) hshValues.get("CR_Business_ability")))%>&nbsp; </td>
  </tr>
  <tr> 
    <td width="35%" valign="top"><b>BUSINESS CONDUCTED</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <td colspan="2" valign="top"><%=ApplicantParams.getApplicantParams("BUSINESSCONDUCTED",Helper.correctNull((String) hshValues.get("CR_Business_Conducted")))%>&nbsp;</td>
  </tr>
  <tr> 
    <td width="35%" valign="top"><b>BUSINESS REPUTATION</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <td colspan="2" valign="top"><%=BusReputation%>&nbsp;</td>
  </tr>
  <tr> 
    <td width="35%" valign="top"><b>CONDITION OF BUSINESS</b></td>
    <td width="2%" valign="top"><b>:</b></td>
    <td colspan="2" valign="top"><%=BusCondition%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="4" valign="top"><b>NATURE AND EXTENT OF DEALINGS WITH BANK&#146;S 
      BRANCHES (WHAT LIMIT ENJOYED AT OTHER BRANCHES)&nbsp;:</b> </td>
  </tr>
  <tr> 
    <td colspan="4" valign="top" align="just"> <%=Helper.correctNull((String) hshValues.get("CR_DEALINGS_BANK"))%> 
      &nbsp;</td>
  </tr>
  <tr> 
    <td colspan="4" valign="top"><b>NAMES OF BANKERS / FINANCIAL INSTITUTIONS 
      AND CREDIT FACILITIES AT OTHER BANKS / FINANCIAL INSTITUTIONS AND SECURITIES 
      CHARGED TO THEM&nbsp;:</b></td>
  </tr>
  <tr> 
    <td colspan="4" valign="top" align="just"> <%=Helper.correctNull((String) hshValues.get("CR_SECURITIES_CHARGED"))%> 
      &nbsp;</td>
  </tr>
  <tr> 
    <td colspan="4" valign="top"><b>BRIEF REPORT ON THE MEANS OF INDIVIDUAL PROPRIETOR 
      OR PARTNER OR DIRECTOR&nbsp;:</b> 
      
    </td>
  </tr>
  <tr> 
    <td colspan="4" valign="top"><%=Helper.correctNull((String) hshValues.get("CR_REPORT_ON_MEANS"))%>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="4" height="35"><b> DETAILS OF FIXED ASSETS ( GIVE NATURE AND 
      LOCATION OF EACH ASSETS AND INCASE OF IMMOVABLE PROPERTY THE NAMES IN WHICH 
      IT IS HELD) :</b></td>
  </tr>
  <tr> 
    <td colspan="4"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="2"
			align="center">
        <tr align="center"> 
          <td colspan="2"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="1" cellpadding="2"
					align="center">
                <tr align="right"> 
                  <td colspan="2"><b>(Rs. in <%=strProposalvalue%>)</b></td>
                </tr>
                <tr align="center"> 
                  <td colspan="2">MOVABLE ASSETS</td>
                </tr>
                <tr align="center"> 
                  <td width="26%" >DESCRIPTION</td>
                  <td width="22%" >VALUE</td>
                </tr>
                <%for (int i = 0; MOV_DESCRIPTION!=null && i < MOV_DESCRIPTION.length; i++) {
				%>
                <tr align="center"> 
                  <td width="26%"  align="left">&nbsp;<%=Helper.correctNull(MOV_DESCRIPTION[i])%></td>
                  <td width="22%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(MOV_VALUE[i])))%></td>
                </tr>
                <%}

			%>
                <tr align="center"> 
                  <td width="26%">TOTAL</td>
                  <td width="22%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("CR_MOV_TOTAL"))))%></td>
                </tr>
              </table>
            </div>
          </td>
          <td colspan="2"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="1" cellpadding="2"
					align="center">
                <tr align="right"> 
                  <td colspan="2"><b>(Rs. in <%=strProposalvalue%>)</b></td>
                </tr>
                <tr align="center"> 
                  <td colspan="2">IMMOVABLE ASSETS</td>
                </tr>
                <tr align="center"> 
                  <td width="26%" >DESCRIPTION</td>
                  <td width="22%">VALUE</td>
                </tr>
                <%for (int i = 0;IMMOV_DESCRIPTION!=null && i < IMMOV_DESCRIPTION.length; i++) {
				String strImMovValue = Helper.correctNull(IMMOV_VALUE[i]);
				if (strImMovValue.equalsIgnoreCase("")) {
					strImMovValue = "0.00";
				}
				double ImMovValue = Double.parseDouble(strImMovValue);

				%>
                <tr align="center"> 
                  <td width="26%"  align="left">&nbsp;<%=Helper.correctNull(IMMOV_DESCRIPTION[i])%></td>
                  <td width="22%" align="right"><%=Helper.formatDoubleValue(ImMovValue)%></td>
                </tr>
                <%}

			%>
                <tr align="center"> 
                  <td width="26%">TOTAL</td>
                  <td width="22%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("CR_IMMOV_TOTAL"))))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="4"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="7">
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="10%" valign="bottom"><b>DATE :</b></td>
          <td width="20%" valign="bottom"><b>&nbsp;<%=Helper.correctNull((String) hshValues.get("CR_DATE"))%></b></td>
          <td align="center"><b>(<%=Helper.correctNull((String) hshValues.get("CR_Investigator"))%>)<br/>
            CREDIT INVESTIGATOR</b></td>
          <td align="center"><b>&nbsp;(<%=Helper.correctNull((String) hshValues.get("CR_Brmanager"))%>)<br/>
            BRANCH MANAGER</b></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
