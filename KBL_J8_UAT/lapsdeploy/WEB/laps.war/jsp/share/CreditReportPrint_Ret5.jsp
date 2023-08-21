
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />

<%


ArrayList arrAppDetails=new ArrayList();
ArrayList arrRow=new ArrayList();

arrAppDetails=(ArrayList)hshValues.get("arrAppDetails");

ArrayList arrCol=null;
ArrayList arrCor=null;
ArrayList arrCorp=null;
if(hshValues.get("arrCorp")!=null)
	arrCorp=(ArrayList)hshValues.get("arrCorp");

ArrayList arrRow1 =(ArrayList) hshValues.get("arrCol");


String strAppType=Helper.correctNull((String)hshValues.get("strAppType"));
//out.print(strAppType);
%>

<%String[] MOV_DESCRIPTION = new String[10];
			String[] IMMOV_DESCRIPTION = new String[10];
			String[] MOV_VALUE = new String[10];
			String[] IMMOV_VALUE = new String[10];

			String MOV_TOTAL = Helper.correctNull((String) hshValues
					.get("CR_MOV_TOTAL"));
			double mov_total = Double.parseDouble(MOV_TOTAL);
			String IMMOV_TOTAL = Helper.correctNull((String) hshValues
					.get("CR_IMMOV_TOTAL"));
			double immov_total = Double.parseDouble(IMMOV_TOTAL);
			String TOTAL_MEANS = Helper.correctNull((String) hshValues
					.get("CR_Total_MEANS"));
			double total_means = Double.parseDouble(TOTAL_MEANS);

			MOV_DESCRIPTION = (String[]) hshValues.get("CR_MOV_DESCRIPTION");
			MOV_VALUE = (String[]) hshValues.get("CR_MOV_VALUE");
			IMMOV_DESCRIPTION = (String[]) hshValues
					.get("CR_IMMOV_DESCRIPTION");
			IMMOV_VALUE = (String[]) hshValues.get("CR_IMMOV_VALUE");

			String Busability = Helper.correctNull((String) hshValues
					.get("CR_Business_ability"));
			String BusConducted = Helper.correctNull((String) hshValues
					.get("CR_Business_Conducted"));
			String BusReputation = Helper.correctNull((String) hshValues
					.get("CR_Business_Reputation"));
			String BusCondition = Helper.correctNull((String) hshValues
					.get("CR_Business_Condition"));

			if (Busability.equalsIgnoreCase("1")) {
				Busability = "CAPABLE";
			} else if (Busability.equalsIgnoreCase("2")) {
				Busability = "INCAPABLE";
			} else if (Busability.equalsIgnoreCase("3")) {
				Busability = "EXPERIENCED";
			} else if (Busability.equalsIgnoreCase("4")) {
				Busability = "INEXPERIENCED";
			} else {
				Busability = "";
			}

			if (BusConducted.equalsIgnoreCase("1")) {
				BusConducted = "SPECULATIVE";
			} else if (BusConducted.equalsIgnoreCase("2")) {
				BusConducted = "OVERTRADE";
			} else if (BusConducted.equalsIgnoreCase("3")) {
				BusConducted = "CONSERVATIVE";
			} else if (BusConducted.equalsIgnoreCase("4")) {
				BusConducted = "PRUDENT";
			} else if (BusConducted.equalsIgnoreCase("5")) {
				BusConducted = "CAUTIOUS";
			} else if (BusConducted.equalsIgnoreCase("6")) {
				BusConducted = "STEADY";
			} else {
				BusConducted = "";
			}

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
			} else {
				BusReputation = "";
			}

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
			} else {
				BusCondition = "";
			}

			%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Credit Information Report</title>
<style type="text/css">
<!--
body,td,th {
	font-family: verdana;
	font-size: 11px;
	color: #000000;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css" />
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<TR>
		<TD ALIGN="center" COLSPAN="3"><B><FONT SIZE="2" FACE="MS Sans Serif">Union
		Bank of India</FONT></B></TD>
	</TR>
	<TR>
		<TD ALIGN="center" COLSPAN="3"><B><FONT SIZE="2" FACE="MS Sans Serif"></FONT><%=Helper.correctNull((String) hshValues.get("strOrgName"))%></B></TD>
	</TR>
	<TR>
		<TD ALIGN="center" COLSPAN="3">&nbsp;</TD>
	</TR>
	<TR BGCOLOR="#FFFFFF">
		<TD ALIGN="center" COLSPAN="3"><STRONG><FONT SIZE="2"
			FACE="MS Sans Serif"> Credit Report </FONT></STRONG></TD>
	</TR>
	<TR>
		<TD COLSPAN="3">&nbsp;</TD>
	</TR>
	<TR>
		<TD VALIGN="bottom" BGCOLOR="#FFFFFF" ALIGN="center" COLSPAN="3"><laps:application /></TD>
	</TR>
	<TR>
		<%if(strAppType.equalsIgnoreCase("0"))
			{%>
		<TD WIDTH="37%"><STRONG>Name</STRONG></TD>
		<TD COLSPAN="2" ALIGN="left">&nbsp; <%=Helper.correctNull((String) hshValues.get("comapp_companyname"))%>
		</TD>
		<%} 
		else
		{
			%>
			<TD WIDTH="37%"><STRONG>Name</STRONG></TD>
		<TD COLSPAN="2" ALIGN="left">&nbsp; <%=Helper.correctNull((String) hshValues.get("strAppName"))%>
		</TD>
		<%} %>
	</TR>
	<TR>
		<TD COLSPAN="3">&nbsp;</TD>
	</TR>
	<TR>
		<TD WIDTH="37%"><STRONG>ADDRESS WITH TELEPHONE NUMBER(HEAD OFFICE)</STRONG></TD>
		<TD COLSPAN="2">&nbsp;</TD>
	</TR>
	<TR>
		<TD COLSPAN="3" HEIGHT="25"><%=Helper.correctNull((String) hshValues.get("address"))%><BR>
		&nbsp;
		<%=Helper.correctNull((String) hshValues.get("city_name"))%><BR> &nbsp;
		<%=Helper.correctNull((String) hshValues.get("state_name"))%> <BR> &nbsp;Pincode:&nbsp;
		<%=Helper.correctNull((String) hshValues
							.get("comapp_crptpin"))%> <BR>
		&nbsp;Tel No :&nbsp;
		<%=Helper.correctNull((String) hshValues
							.get("comapp_crptphone"))%></TD>
	</TR>
	<TR>
		<TD COLSPAN="3"><STRONG>ADDRESS WITH TELEPHONE NUMBER(BRANCH OFFICE)</STRONG></TD>
	</TR>
	<TR>
		<TD COLSPAN="3" HEIGHT="94">
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="2">
			<%if (arrRow1 != null) {

				for (int j = 0; j < arrRow1.size(); j++) {

					arrCol = (ArrayList) arrRow1.get(j);

					%>
			<TR>
				<TD><%=j + 1%>)&nbsp;&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%>,</TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%>,</TD>
			</TR>
			<TR>
				<TD>&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></TD>
			</TR>
			<TR>
				<TD>&nbsp;Pincode:<%=Helper.correctNull((String) arrCol.get(4))%></TD>
			</TR>
			<TR>
				<TD HEIGHT="2">Tel No :<%=Helper.correctNull((String) arrCol.get(5))%></TD>
			</TR>
			<%}
			}

			%>
		</TABLE>
		<%String strOwner = Helper.correctNull((String) hshValues
					.get("comapp_ownership"));
			String strType = "";
			if (strOwner.trim().equals("OO")) {
				strType = "Others";
			} else if (strOwner.trim().equals("OLP")) {
				strType = "Private Limited Company";
			} else if (strOwner.trim().equals("OLC")) {
				strType = "Joint Borrowers";
			} else if (strOwner.trim().equals("OS")) {
				strType = "Sole Proprietor";
			} else if (strOwner.trim().equals("OCC")) {
				strType = "Corporate";
			} else if (strOwner.trim().equals("OP")) {
				strType = "Partnership";
			} else if (strOwner.trim().equals("IN")) {
				strType = "Individual";
			} else if (strOwner.trim().equals("Jo")) {
				strType = "Joint Venture";
			} else if (strOwner.trim().equals("sub")) {
				strType = "Wholly owned subsidiary";
			} else if (strOwner.trim().equals("nbfc")) {
				strType = "NBFC";
			} else {
				strType = "";
			}%>
			</TR>
			<%if(strAppType.equalsIgnoreCase("0"))
				{%>
			<TR>
				<TD COLSPAN="2"><STRONG>CONSTITUTION :</STRONG></TD>
				<TD><%=strType%></TD>
			</TR>
			<%}
			else
			{
				%>
				<TR>
				<TD COLSPAN="2"><STRONG>CONSTITUTION :</STRONG></TD>
				<TD>INDIVIDUAL</TD>
				</TR>
			<%} %>
	<TR>
		<TD COLSPAN="3"><STRONG>Full name of identical, connected or
		associated firms giving the nature and place of business name(s) of
		their bankers with address/es and details of credit facilities allowed
		by them. <BR> Full names &amp; address of the individual, proprietor,
		partners, karta and co-parceners, directors, etc. and their
		relationship with each other. If any (brief report on the business
		means/assets of partners/directors to be given on the reverse)
		</STRONG> <BR>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN="3">
		<TABLE WIDTH="100%" BORDER="0" class="outertable border1" CELLSPACING="0" CELLPADDING="2">
			<TR>
				<TD ROWSPAN="2" WIDTH="20%">
				<DIV ALIGN="center">Name &amp; Father's Name</DIV>
				</TD>
				<TD COLSPAN="6">
				<DIV ALIGN="center">Address with Telephone Number</DIV>
				</TD>
			</TR>
			<TR>
				<TD ALIGN="center" WIDTH="13%">Office</TD>
				<TD ALIGN="center" WIDTH="11%">Tel.No.</TD>
				<TD ALIGN="center" WIDTH="12%">Residence</TD>
				<TD ALIGN="center" WIDTH="13%">Tel.No.</TD>
				<TD ALIGN="center" WIDTH="17%">Permanent Address</TD>
				<TD ALIGN="center" WIDTH="14%">Tel. No.</TD>
			</TR>
			<%
			//out.print(strAppType);
			if(arrCorp!=null)
			{
				if (strAppType.equalsIgnoreCase("0")) {
					for (int i = 0; i < arrCorp.size(); i++) {
						arrCor = new ArrayList();
						arrCor = (ArrayList) arrCorp.get(i);
						
				%>
		   	<TR>
				<TD WIDTH="20%">&nbsp;<%=arrCor.get(7)%><B> & </B><%=arrCor.get(0)%></TD>
				<TD WIDTH="13%">&nbsp;<%=arrCor.get(1)%></TD>
				<TD WIDTH="11%">&nbsp;<%=arrCor.get(2)%></TD>
				<TD WIDTH="12%">&nbsp;<%=arrCor.get(3)%></TD>
				<TD WIDTH="13%">&nbsp;<%=arrCor.get(4)%></TD>
				<TD WIDTH="17%">&nbsp;<%=arrCor.get(5)%></TD>
				<TD WIDTH="14%">&nbsp;<%=arrCor.get(6)%></TD>
			</TR> 
			<% }  } }%>
			
			<%if (!strAppType.equalsIgnoreCase("0") && arrAppDetails.size() > 0) {
				for (int i = 0; i < arrAppDetails.size(); i++) {
					arrRow = new ArrayList();
					arrRow = (ArrayList) arrAppDetails.get(i);
					%>
			<TR>
				<TD WIDTH="20%">&nbsp;<%=arrRow.get(0)%><B> & </B><%=arrRow.get(1)%></TD>
				<TD WIDTH="13%">&nbsp;<%=arrRow.get(2)%></TD>
				<TD WIDTH="11%">&nbsp;<%=arrRow.get(3)%></TD>
				<TD WIDTH="12%">&nbsp;<%=arrRow.get(4)%></TD>
				<TD WIDTH="13%">&nbsp;<%=arrRow.get(5)%></TD>
				<TD WIDTH="17%">&nbsp;<%=arrRow.get(6)%></TD>
				<TD WIDTH="14%">&nbsp;<%=arrRow.get(7)%></TD>
			</TR>
			<%}
			} else {

			%>
			<TR>
				<TD WIDTH="20%">&nbsp;</TD>
				<TD WIDTH="13%">&nbsp;</TD>
				<TD WIDTH="11%">&nbsp;</TD>
				<TD WIDTH="12%">&nbsp;</TD>
				<TD WIDTH="13%">&nbsp;</TD>
				<TD WIDTH="17%">&nbsp;</TD>
				<TD WIDTH="14%">&nbsp;</TD>
			</TR>
			<%}

			%>
		</TABLE>
		</TD>
	</TR>
	<tr>
		<td width="37%">&nbsp;</td>
		<td colspan="2" align="left">&nbsp;</td>
	</tr>
	<tr>
		<td width="37%">&nbsp;</td>
		<td colspan="2" align="left">&nbsp;</td>
	</tr>
	<tr>
		<td width="37%">&nbsp;</td>
		<td colspan="2" align="left">&nbsp;</td>
	</tr>
	<!-- <tr>
		<td width="37%"><strong>Name</strong></td>
		<td colspan="2" align="left">&nbsp; <%=Helper.correctNull((String) hshValues.get("strAppName"))%>
		</td>
	</tr> -->
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="37%" valign="top">&nbsp;</td>
				<td width="63%" valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td width="37%" valign="top"><strong>TOTAL MEANS Rs. </strong></td>
				<td width="63%" valign="top"><%=Helper.formatDoubleValue(total_means)%>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="37%" valign="top"><strong>GURANTEES GIVEN IN DETAIL </strong></td>
				<td width="63%" valign="top">
				<p><%=Helper.correctNull((String) hshValues
									.get("CR_Gurantee"))%></p>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td width="37%"><strong>PARTICULARS OF LIABILITIES OF INDIVIDUAL / PARTNERS / DIRECTORS /OTHERS</strong></td>
		<td colspan="2"><%=Helper.correctNull((String) hshValues
							.get("CR_LIAB_Partner"))%></td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="37%" valign="top"><strong>BUSINESS ABILITY</strong></td>
				<td width="63%" valign="top">
				<p>&nbsp;<%=Busability%></p>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td width="37%"><strong>BUSINESS CONDUCTED</strong></td>
		<td colspan="2">&nbsp;<%=BusConducted%></td>
	</tr>
	<tr>
		<td width="37%"><strong>BUSINESS REPUTATION</strong></td>
		<td colspan="2">&nbsp;<%=BusReputation%></td>
	</tr>
	<tr>
		<td width="37%"><strong>CONDITION OF BUSINESS</strong></td>
		<td colspan="2">&nbsp;<%=BusCondition%></td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="37%" valign="top"><strong>&nbsp;NATURE AND EXTENT OF
				DEALINGS WITH BANK&#146;S BRANCHES (WHAT LIMIT ENJOYED AT OTHER
				BRANCHES) </strong></td>
				<td width="63%" valign="top">
				<p><%=Helper.correctNull((String) hshValues
							.get("CR_DEALINGS_BANK"))%></p>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td width="37%"><strong>NAMES OF BANKERS / FINANCIAL INSTITUTIONS AND
		CREDIT FACILITIES AT OTHER BANKS / <br> FINANCIAL INSTITUTIONS AND
		SECURITIES CHARGED TO THEM
		</strong></td>
		<td colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("CR_SECURITIES_CHARGED"))%></td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="37%"><strong>BRIEF REPORT ON THE MEANS OF INDIVIDUAL
				PROPRIETOR OR PARTNER OR DIRECTOR</strong></td>
				<td width="63%" valign="top">
				<p><%=Helper.correctNull((String) hshValues
							.get("CR_REPORT_ON_MEANS"))%></p>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3" height="35"><strong> DETAILS OF FIXED ASSETS ( GIVE
		NATURE AND LOCATION OF EACH ASSETS AND INCASE OF IMMOVABLE PROPERTY
		THE NAMES IN WHICH IT IS HELD) :</strong></td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="100%" border="0" cellspacing="1" cellpadding="2"
			align="center">
			<tr align="center">
				<td colspan="2">
				<table width="100%" border="0" class="outertable border1" cellspacing="1" cellpadding="2"
					align="center">
					<tr align="center">
						<td colspan="2">MOVABLE ASSETS</td>
					</tr>
					<tr align="center">
						<td width="26%" >DESCRIPTION</td>
						<td width="22%" >VALUE</td>
					</tr>
					<%for (int i = 0; i < MOV_DESCRIPTION.length; i++) {
				String strMovValue = Helper.correctNull(MOV_VALUE[i]);
				if (strMovValue.equalsIgnoreCase("")) {
					strMovValue = "0.00";
				}
				double MovValue = Double.parseDouble(strMovValue);

				%>
					<tr align="center">
						<td width="26%" align="left">&nbsp;<%=Helper.correctNull(MOV_DESCRIPTION[i])%></td>
						<td width="22%" align="right"><%=Helper.formatDoubleValue(MovValue)%></td>
					</tr>
					<%}

			%>
					<tr align="center">
						<td width="26%">TOTAL</td>
						<td width="22%" align="right"><%=Helper.formatDoubleValue(mov_total)%></td>
					</tr>
				</table>
				</td>
				<td colspan="2">
				<table width="100%" border="0" class="outertable border1" cellspacing="1" cellpadding="2"
					align="center">
					<tr align="center">
						<td colspan="2">IMMOVABLE ASSETS</td>
					</tr>
					<tr align="center">
						<td width="26%" >DESCRIPTION</td>
						<td width="22%" >VALUE</td>
					</tr>
					<%for (int i = 0; i < IMMOV_DESCRIPTION.length; i++) {
				String strImMovValue = Helper.correctNull(IMMOV_VALUE[i]);
				if (strImMovValue.equalsIgnoreCase("")) {
					strImMovValue = "0.00";
				}
				double ImMovValue = Double.parseDouble(strImMovValue);

				%>
					<tr align="center">
						<td width="26%" align="left">&nbsp;<%=Helper.correctNull(IMMOV_DESCRIPTION[i])%></td>
						<td width="22%" align="right"><%=Helper.formatDoubleValue(ImMovValue)%></td>
					</tr>
					<%}

			%>
					<tr align="center">
						<td width="26%">TOTAL</td>
						<td width="22%" align="right"><%=Helper.formatDoubleValue(immov_total)%></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3">
		<table width="90%" border="0" cellspacing="1" cellpadding="6">
			  <tr> 
         <td colspan="6">&nbsp;</td>
          </tr>
          <tr> 
         <td colspan="6">&nbsp;</td>
          </tr>
          <tr> 
         <td colspan="6">&nbsp;</td>
          </tr>
			<tr> 
         <td colspan="6">&nbsp;</td>
          </tr>
			<tr>
				<td width="10%">DATE :</td>
				<td width="20%">&nbsp;<%=Helper.correctNull((String) hshValues.get("CR_DATE"))%></td>
				<td width="25%">CREDIT INVESTIGATOR</td>
				<td width="10%">&nbsp;</td>
				<td width="25%" align="right">BRANCH MANAGER</td>
				<td width="10%">&nbsp;</td>
			</tr>
			<tr> 
         <td colspan="6">&nbsp;</td>
          </tr>
		</table>
		</td>
	</tr>
	
</table>
</body>
</html>
