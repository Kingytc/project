<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%ArrayList arryCol_grpcon = null;
			ArrayList operinfo = (ArrayList) hshValues.get("oper_info");
			ArrayList arrSubFac = new ArrayList();
			ArrayList arrSubFacRecords = new ArrayList();
			ArrayList arrRow = new ArrayList();
			ArrayList arrData = new ArrayList();

			String strOwnership = Helper.correctNull((String) hshValues.get("comapp_ownership"));
			String strProposalvalue = Helper.correctNull((String) hshValues.get("proposalvaluesin"));
			String strOwner = Helper.correctNull((String) hshValues.get("comapp_ownership"));
			if (strProposalvalue.equalsIgnoreCase("C"))
				strProposalvalue = "Crores";
			else
				strProposalvalue = "Lacs";

			String strSanctauth = Helper.correctNull((String) hshValues.get("exec_sancauth"));
			double dbltotal=0.00;
			
			String chkCategory = "", chkCategory1 = "";
			ArrayList OurBank_WC_Funded = new ArrayList();
			ArrayList WC_Funded = new ArrayList();
			int arrWC_Funded_Size = 0;
			ArrayList OurBank_WC_NonFunded = new ArrayList();
			ArrayList WC_NonFunded = new ArrayList();
			int arrWC_NonFunded_Size = 0;
			ArrayList OurBank_TL = new ArrayList();
			ArrayList TL_Funded_NonFunded = new ArrayList();
			int arrTL_Funded_NonFunded_Size = 0;
			double existing =0;
			double total_proposed_sec=0;
			String chkCategory_subheadid="";
			String chkCategory_headid="";
			ArrayList arrtotRemark = new ArrayList();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Short Term Loan</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/executivereport.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="25px" topmargin="25px" marginwidth="25px" marginheight="25px">
<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
	<tr>
		<td>
		
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <%if (strSanctauth.equals("7")) {%>
        <tr align="right"> 
          <td colspan="4"> 
            <table border="0" cellspacing="0" cellpadding="3" width="">
              <tr> 
                <td align="left">Agenda Item No:<%=Helper.correctNull((String) hshValues
								.get("exec_agendano"))%> <br>
                  MCM of: <%=Helper.correctNull((String) hshValues
										.get("exec_mcm"))%> </td>
              </tr>
            </table>
          </td>
        </tr>
        <%}

			%>
        <tr> 
          <td align="center" colspan="4"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
        </tr>
        <tr> 
          <td align="center" colspan="4">Branch / Office, <%=Helper.correctNull((String) hshValues.get("strOrgName"))%> 
            <hr>
          </td>
        </tr>
        <tr> 
          <td width="10%"><b>Ref No:</b></td>
          <td width="60%"><%=Helper.correctNull((String) hshValues.get("exec_refno"))%>&nbsp;</td>
          <td width="17%" align="right"><b>Date :&nbsp;</b></td>
          <td width="13%" align="right"><%=Helper.correctNull((String) hshValues.get("exec_date"))%>&nbsp;</td>
        </tr>
        <tr align="right"> 
          <td colspan="4"> 
            <table border="0" cellspacing="0" cellpadding="6">
              <tr> 
                <%if (strSanctauth.equals("4") || strSanctauth.equals("5")) {
				%>
                <td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/GM.jpg"
							width="55" height="77"></td>
                <td>&nbsp;&nbsp;</td>
                <%}
						if (strSanctauth.equals("5") || strSanctauth.equals("6")|| strSanctauth.equals("7")) {
				%>
                <td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/ED.jpg"
							width="55" height="77"></td>
                <td>&nbsp;&nbsp;</td>
                <%}
					if (strSanctauth.equals("6") || strSanctauth.equals("7")) {
				%>
                <td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/CMD.jpg"
							width="55" height="77"></td>
                <%}
				%>
              </tr>
            </table>
          </td>
        </tr>
       
      </table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<div id="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        
        <tr> 
          <td valign="top"><b>PRESENT REQUEST</b></td>
        </tr>
        <tr> 
          <td valign="top"><%=Helper.formatTextAreaData((String) hshValues.get("exec_presentreq"))%></td>
        </tr>
      </table>
	  </div>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	
	<tr>
		<td>
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="20%">GROUP</td>
				<td width="1%"><b>:</b></td>
				<td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues.get("groupdesc"))%></td>
				<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
				
            <td width="20%">BANKING ARRANGEMENT</td>
				<td width="1%"><b>:</b></td>
				<td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues.get("status_banking"))%></td>
				<td width="23%">LEAD BANK</td>
				<td width="1%"><b>:</b></td>
				<%if (Helper.correctNull((String) hshValues.get("status_banking")).equals("Consortium")) 
				{
				%>
				<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues.get("com_propleadbank"))%></td>
				<%} else {
			%>
				<td width="19%">N.A. &nbsp;</td>
				<%}
			%>
			</tr>
			<tr>
				<td width="20%">MONTH OF REVIEW</td>
				<td width="1%"><b>:</b></td>
				<td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues.get("COM_PROPDEVREVDATE"))%></td>
				<td colspan="3"><b>OUR SHARE</b></td>
			</tr>
			<tr>
				<td width="20%" rowspan="2">ASSET CLASSIFICATION</td>
				<td width="1%" rowspan="2"><b>:</b></td>
				<td width="21%" rowspan="2"><%=Helper.correctNull((String) hshValues.get("com_propassettype"))%></td>
				<td width="23%">Fundbased</td>
				<td width="1%"><b>:</b></td>
				<td width="15%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("TOTAL_FUNDED"))))%>&nbsp;%</td>
			</tr>
			<tr>
				<td width="23%">NonFundbased</td>
				<td width="1%"><b>:</b></td>
				<td width="15%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("TOTAL_NONFUNDED"))))%>&nbsp;%</td>
			</tr>

			<%
			ArrayList arrRating = new ArrayList();
			ArrayList arrCol = new ArrayList();
			int arrsize = 0;

			if (hshValues != null) 
			{
				arrRating = (ArrayList) hshValues.get("arrVal");
			}

			if (arrRating != null) 
			{
				arrsize = arrRating.size();
			}

			String[] strprevious = new String[8];
			String[] strcurrent = new String[8];

			for (int i = 0; i < strprevious.length; i++) 
			{
				strprevious[i] = "";
				strcurrent[i] = "";
			}

			if (arrRating != null) 
			{
				for (int i = 0; i < arrRating.size(); i++) 
				{
					arrCol = (ArrayList) arrRating.get(i);

					strprevious[i] = Helper.correctNull((String) arrCol.get(0));
					strcurrent[i] = Helper.correctNull((String) arrCol.get(1));
				}
			}
			%>

			<tr>
				<td width="20%" valign="top">INTERNAL CREDIT RATING</td>
				<td width="1%" valign="top"><b>:</b></td>
				<td colspan="4">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr align="center">
						<td>&nbsp;</td>
						<td><b>Grade</b></td>
						<td><b>Score</b></td>
						<td><b>Risk definition</b></td>
					</tr>
					<tr align="left">
						<td><b>Previous Year</b></td>
						<td><%=strprevious[1]%></td>
						<td><%=strprevious[0]%></td>
						<td><%=strprevious[2]%></td>
					</tr>
					<tr align="left">
						<td><b>Current Year</b></td>
						<td><%=strcurrent[1]%></td>
						<td><%=strcurrent[0]%></td>
						<td><%=strcurrent[2]%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="20%">EXTERNAL CREDIT RATING</td>
				<td width="1%"><b>:</b></td>
				<td colspan="4">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td width="29%">RATING AGENCY</td>
						<td width="28%">PREVIOUS YEAR</td>
						<td width="43%">CURRENT YEAR</td>
					</tr>
					<tr>
						<td width="29%">&nbsp;<%=Helper.correctNull((String) hshValues.get("extagency"))%></td>
						<td width="28%">&nbsp;<%=Helper.correctNull((String) hshValues.get("extlastrate"))%></td>
						<td width="43%">&nbsp;<%=Helper.correctNull((String) hshValues.get("extcurrate"))%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="20%">STATUS OF ACCOUNT</td>
				<td width="1%"><b>:</b></td>
				<td colspan="4"><%=Helper.correctNull((String) hshValues.get("status_acc"))%>&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				
          <td width="2%"><b>1.&nbsp;</b></td>
				
          <td width="35%"><b>NAME OF THE ACCOUNT</b></td>
				
          <td width="1%"><b><b>:</b></b></td>
				
          <td width="62%"><%=Helper.correctNull((String) hshValues.get("comapp_companyname"))%></td>
			</tr>
			<tr>
				
          <td width="2%">&nbsp;</td>
			</tr>
			<tr>
				
          <td width="2%" align="right"><b>1.1</b></td>
				
          <td width="35%"><b>BRANCH / ZONE</b></td>
				
          <td width="1%"><b><b>:</b></b></td>
				
          <td width="62%"><%=Helper.correctNull((String) hshValues.get("appCreationBranch"))%></td>
			</tr>
		<tr>
          <td width="2%"><b>&nbsp;</b></td>
          <td width="35%">&nbsp;</td>
          <td width="1%">&nbsp;</td>
          <td width="62%">&nbsp;</td>
		</tr>
		<tr>
          <td width="2%">&nbsp;</td>
		</tr>
		<tr>
          <td width="2%"><b>2.&nbsp;</b></td>
          <td width="35%"><b>CONSTITUTION</b></td>
          <td width="1%"><b>:</b></td>
          <td width="62%"><%=Helper.correctNull((String) hshValues.get("strownership"))%> </td>
		</tr>
		<tr>
          <td width="2%">&nbsp;</td>
		</tr>
		<tr>
          <td width="2%" ><b>2.1</b></td>
          <td width="35%"><b>DATE OF INCORPORATION</b></td>
          <td width="1%"><b><b>:</b></b></td>
          <td width="62%"><%=Helper.correctNull((String) hshValues.get("comapp_yrsinbusiness"))%></td>
		</tr>
		<tr>
         <td width="2%">&nbsp;</td>
	    </tr>
		<tr>
          <td valign="top" width="2%"><b>3.&nbsp;</b></td>
          <td width="35%" valign="top"><b>LINE OF ACTIVITY</b></td>
          <td width="1%" valign="top"><b><b>:</b></b></td>
          <td width="62%"><%=Helper.formatTextAreaData((String) hshValues.get("comapp_businessnature"))%>&nbsp;</td>
		</tr>
		<tr>
          <td width="2%">&nbsp;</td>
		</tr>
		<tr>
          <td width="2%"><b>4.&nbsp;</b></td>
          <td width="35%"><b> ADDRESS</b></td>
          <td width="1%">&nbsp;</td>
          <td width="62%">&nbsp;</td>
		</tr>
		<tr>
          <td width="2%">&nbsp;</td>
		</tr>
		<tr>
          <td valign="top" width="2%"><b>&nbsp;</b></td>
          <td width="35%" valign="top"><b>Regd./Admn.Office</b></td>
          <td width="1%" valign="top"><b><b>:</b></b></td>
          <td width="62%"><%=Helper.correctNull((String) hshValues.get("comapp_regadd1"))%>-<%=Helper.correctNull((String) hshValues.get("comapp_regadd2"))%><br>
				<%=Helper.correctNull((String) hshValues.get("Regcity_name"))%> <br>
				<%=Helper.correctNull((String) hshValues.get("Regstate_name"))%> <br>
				Pin:<%=Helper.correctNull((String) hshValues.get("comapp_regpin"))%><br>
		  </td>
		</tr>
		<tr>
          <td width="2%">&nbsp;</td>
		</tr>
			<%
			arrData = new ArrayList();
			arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrUnitsworks");
			if (arrRow != null && arrRow.size() > 0) 
			{
			%>
		<tr>
          <td valign="top" width="2%">&nbsp;</td>
          <td width="35%" valign="top"><b>Units/Works</b></td>
          <td width="1%" valign="top"><b><b>:</b></b></td>
          <td width="62%"> 
            <table border="0" width="100%">
					<%for (int i = 0; i < arrRow.size(); i++) 
					{
					arrData = (ArrayList) arrRow.get(i);
					%>
					<tr>
						<td><%=arrData.get(0)%>,<br>
						<%=arrData.get(1)%>,<br>
						<%=arrData.get(2)%>,<br>
						<%=arrData.get(3)%>-<%=arrData.get(4)%>.<br>
						</td>
					</tr>
					<%}%>
			</table>
		 </td>
		</tr>
			<%}%>
	</table>
	</td>
</tr>
</table>

<!-- Start -->
<table width="90%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" colspan="5">&nbsp;</td>
			</tr>
			<tr>
				
          <td valign="top" width="3%"><b>5.&nbsp;</b></td>
				
          <td valign="top" colspan="4" width="97%"><b>Present Position of the Account :</b></td>
			</tr>
				
			<tr>
				<td valign="top" align="right" colspan="5"><b>(<%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>)</b></td>
			</tr>
			<tr>
				
          <td valign="top" rowspan="4" width="3%">&nbsp;</td>
				
          <td valign="top" colspan="4" width="97%"> 
            <div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
					<td width="20%" align="center"><b> Nature of Facility</b></td>
					<td width="10%" align="center"><b> Amount</b></td>
					<td width="10%" align="center"><b> O/S as On <%=Helper.correctNull((String)hshValues.get("detailsasondate"))%></b></td>
					<td width="12%" align="center"><b> Int/Comm</b></td>
					<td width="8%" align="center"><b> Margin (%)</b></td>
					<td width="10%" align="center"><b>Security </b></td>
					<td width="10%" align="center"><b>Value of Securities</b></td>
					<td width="18%" align="center"><b> Over dues, if any</b></td>
					</tr>
					<%--<tr class="tblhead">
						<td width="13%" align="center">Existing</td>
						<td width="13%" align="center">Proposed</td>
					</tr>
				</table>
				
				</td>
			</tr>--%>
			<%--<tr>
				
          <td valign="top" colspan="4" width="97%"> 
             <table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td>
						<div id="top">
						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">--%>
                    <tr> 
                  <td align="left" colspan="8"><b>A]NONFUND BASED LIMITS</b></td>
                </tr>
                      <% 
							OurBank_WC_NonFunded = new ArrayList();
								WC_NonFunded = new ArrayList();
								arrWC_NonFunded_Size = 0;
								OurBank_WC_NonFunded = (ArrayList) hshValues.get("OurBank_WC_NonFunded");
								
								if (OurBank_WC_NonFunded != null) 
								{
									arrWC_NonFunded_Size = OurBank_WC_NonFunded.size();
								}
	
								for (int i = 0; i < arrWC_NonFunded_Size; i++) 
								{
									WC_NonFunded = (ArrayList) OurBank_WC_NonFunded.get(i);
									chkCategory = Helper.correctNull((String) WC_NonFunded.get(12));
									
									if (chkCategory.equals("A")) 
									{
										chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) WC_NonFunded.get(13))+ " Month ) ";
									} 
									else
									{
										chkCategory1 = "";
									}
									int introwspan = Integer.parseInt(Helper.correctInt((String) WC_NonFunded.get(16)));
							%>
                      <tr valign="top"> 
                        <td  align="left" rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) WC_NonFunded.get(0))%> 
                          <%=chkCategory1%></b></td>
								
                      <%--  <td width="13%" align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(1))))%></td>--%>
								
                        <td  align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(2))))%></td>
                        <td  align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(6))))%></td>
                         <td align="right" rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_NonFunded.get(4))%>&nbsp;</td>
                        
								<%
								ArrayList arrSecurities = new ArrayList();
								arrSecurities = (ArrayList) WC_NonFunded.get(15);
								if (arrSecurities != null && arrSecurities.size() > 0) 
								{
									for (int j = 0; j < arrSecurities.size(); j++) 
									{
										arrCol = new ArrayList();
										String strBorder = "";
										arrCol = (ArrayList) arrSecurities.get(j);
										//if ((introwspan - 1) == j && j != 0) 
										//{
										//	strBorder = "style=\"border-top-width:0\";";
										//}
										//else if (j == 0) 
										//{
										//	strBorder = "style=\"border-bottom-width:0\";";
										//}
										//else 
										//{
										//	strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
										//}
										if (j == 0)
										{
								%>
								
                        <td  align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
						<td><%=Helper.formatTextAreaData((String) arrCol.get(0))%>&nbsp;</td>
						<td  align="right" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(7))))%>&nbsp;</td>
						 <td  align="right" rowspan="<%=introwspan%>" valign="top"><%=Helper.correctNull((String) WC_NonFunded.get(8))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td  align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
								
                        <td  align="left" valign="top"><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
								<%}
									}
										} else {%>
								
                        <td valign="top">&nbsp;</td>
						<td  align="left" valign="top">&nbsp;</td>
                        <td  align="right" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(7))))%>&nbsp;</td>
						 <td  align="right" rowspan="<%=introwspan%>" valign="top"><%=Helper.correctNull((String) WC_NonFunded.get(8))%>&nbsp;</td>
								<%}
								%>
							</tr>
							<%//For the Sub-limits, under each one
								arrSubFac = new ArrayList();
								arrSubFac = (ArrayList) WC_NonFunded.get(9);
								int subFacSize = arrSubFac.size();
								if (arrSubFac != null && subFacSize > 0)
								{
									for (int j = 0; j < subFacSize; j++) 
									{
										arrSubFacRecords = new ArrayList();
										arrSubFacRecords = (ArrayList) arrSubFac.get(j);
				
										chkCategory = Helper.correctNull((String) arrSubFacRecords.get(11));
										if (chkCategory.equals("A")) 
										{
											chkCategory1 = "<br>(Adhoc Limit for " + Helper.correctNull((String) arrSubFacRecords.get(12)) + " Month) ";
										} 
										else 
										{
											chkCategory1 = "";
										}
										int intsubrowspan = Integer.parseInt(Helper.correctInt((String) arrSubFacRecords.get(15)));

						%>
							<%if (j == 0) {%>
							<tr>
								<td colspan="8">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
							</tr>
							<%}%>
							
                      <tr valign="top"> 
                        <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(0))%> 
                          <%=chkCategory1%></td>
								
                       <%--  <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))%>)</td>--%>
								
                        <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))%>)</td>
                        <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(6))))%></td>
                        <td  align="right" rowspan="<%=intsubrowspan%>"><%=Helper.correctNull((String) arrSubFacRecords.get(4))%>&nbsp; 
                        </td>
								<%ArrayList arrsubSecurities = new ArrayList();
									arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
									if (arrSecurities != null && arrsubSecurities.size() > 0) 
									{
										for (int k = 0; k < arrsubSecurities.size(); k++)
										{
											arrCol = new ArrayList();
											//String strBorder = "";
											arrCol = (ArrayList) arrsubSecurities.get(k);
											//if ((intsubrowspan - 1) == k) 
											//{
											//	strBorder = "style=\"border-top-width:0\";";
											//}
											//else if (k == 0) 
											//{
											//	strBorder = "style=\"border-bottom-width:0\";";
											//}
											//else
											//{
											//	strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
											//}
											if (k == 0) 
											{

									%>
								
                        <td  align="right">&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
						<td><%=Helper
															.formatTextAreaData((String) arrCol
																	.get(0))%>&nbsp;</td>
					  <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))%></td>
				 	 <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(8))%></td>
								
                        
								<%} else {%>
							</tr>
							<tr>
								
                        <td  align="right" <%//=strBorder%> valign="top">&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td  align="left" <%//=strBorder%> valign="top"><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%}
							}
						} else {%>
								
                        <td valign="top">&nbsp;</td>
						
                        <td align="left" valign="top">&nbsp;</td>
                         <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))%></td>
				 	 <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(8))%></td>
								<%}

					%>
							</tr>
							<%}}
				}
				//End of 'Sub-Facilities' details               
			

			%>
							
                     <tr valign="top"> 
                        <td  align="left"><b> Sub- Total [A]</b></td>
						
                        <td  align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_proposed"))))%></td>
								
                        <td>&nbsp;</td>
								
                        <td> &nbsp;</td>
						<td >&nbsp;</td>		
                        <td >&nbsp;</td>
                        <td >&nbsp;</td>		
                        <td >&nbsp;</td>
							
						
			</tr>
			<%--<tr>
				
          <td valign="top" colspan="4" width="97%"> 
             <table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td>
						<div id="top">
						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">--%>
                      <tr> 
                  <td align="left" colspan="8"><b>B]FUND BASED LIMITS</b></td>
                </tr>
                      <%OurBank_WC_Funded = new ArrayList();
			WC_Funded = new ArrayList();

			arrWC_Funded_Size = 0;

			OurBank_WC_Funded = (ArrayList) hshValues.get("OurBank_WC_Funded");
			if (OurBank_WC_Funded != null) {
				arrWC_Funded_Size = OurBank_WC_Funded.size();
			}
			
			
			for (int i = 0; i < arrWC_Funded_Size; i++) {
				WC_Funded = (ArrayList) OurBank_WC_Funded.get(i);
				chkCategory = Helper.correctNull((String) WC_Funded.get(12));
				
				 
				if (chkCategory.equals("A")) {
					chkCategory1 = "<br>(Adhoc Limit for "
							+ Helper.correctNull((String) WC_Funded.get(13))
							+ " Month ) ";
				} else {
					chkCategory1 = "";
				}
				int introwspan = Integer.parseInt(Helper
						.correctInt((String) WC_Funded.get(16)));

				%>
                      <tr valign="top"> 
                        <td  align="left" 
									rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) WC_Funded.get(0))%> 
                          <%=chkCategory1%></b></td>
								
                       <%--  <td width="13%" align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(1))))%></td>--%>
								
                        <td  align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(2))))%></td>
						<td  align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(6))))%></td>
						<td  align="right" rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_Funded.get(4))%>&nbsp;</td>
						
								<%ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) WC_Funded.get(15);
				if (arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						arrCol = new ArrayList();
						//String strBorder = "";
						arrCol = (ArrayList) arrSecurities.get(j);
						//if ((introwspan - 1) == j && j != 0) {
						//	strBorder = "style=\"border-top-width:0\";";
						//} else if (j == 0) {
						//	strBorder = "style=\"border-bottom-width:0\";";
						//} else {
						//	strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						//}
						if (j == 0) {

							%>
								
                        <td  align="right" <%//=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
					
								
                        <td><%=Helper
													.formatTextAreaData((String) arrCol
															.get(0))%>&nbsp;</td>
						<td  align="right" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(7))))%>&nbsp;</td>
						 <td  align="right" rowspan="<%=introwspan%>" valign="top"><%=Helper.correctNull((String) WC_Funded.get(8))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td  align="right" <%//=strBorder%> valign="top">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
								
                        <td  align="left" <%//=strBorder%> valign="top"><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
								<%}
					}
				} else {%>
								
                        <td valign="top">&nbsp;</td>
						<td  align="left" valign="top">&nbsp;</td>
                        <td  align="right" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(7))))%>&nbsp;</td>
						 <td  align="right" rowspan="<%=introwspan%>" valign="top"><%=Helper.correctNull((String) WC_Funded.get(8))%>&nbsp;</td>
								<%}

				%>
							</tr>
							<%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_Funded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);

						chkCategory = Helper
								.correctNull((String) arrSubFacRecords.get(11));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month )";
						} else {
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper
								.correctInt((String) arrSubFacRecords.get(15)));

						%>
							<%if (j == 0) {%>
							<tr>
								<td colspan="8">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
							</tr>
							<%}%>
							
                      <tr valign="top"> 
                        <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%> <%=chkCategory1%></td>
								
                        <%--<td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td> --%>
								
                        <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
					  <td  align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(6))))%></td>
					<td  align="right" rowspan="<%=intsubrowspan%>"><%=Helper.correctNull((String) arrSubFacRecords.get(4))%>&nbsp; 
								<%arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
						if (arrSecurities != null
								&& arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								arrCol = new ArrayList();
								//String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								//if ((intsubrowspan - 1) == k) {
								//	strBorder = "style=\"border-top-width:0\";";
								//} else if (k == 0) {
								//	strBorder = "style=\"border-bottom-width:0\";";
								//} else {
								//	strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								//}
								if (k == 0) {

									%>
								
                        <td width="8%" align="right" <%//=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                       
								
                        <td width="31%"><%=Helper
															.formatTextAreaData((String) arrCol
																	.get(0))%>&nbsp;</td>
						 <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))%></td>
				 	 <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(8))%></td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td width="8%" align="right" <%//=strBorder%> valign="top">&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td width="31%" align="left" <%//=strBorder%> valign="top"><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%}
							}
						} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                       
								
                        <td  align="left" valign="top">&nbsp;</td>
                         <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))%></td>
				 	 <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(8))%></td>
								<%}

					%>
							</tr>
							<%}
				}}
				//End of 'Sub-Facilities' details               
			

			%>
							<tr>
								<td  align="left"><b>Sub- Total [B]</b></td>
								
								<td  align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_funded_proposed"))))%></td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>		
                        		<td >&nbsp;</td>
							</tr>
						
			
			<%--<tr>
				
          <td valign="top" colspan="4" width="97%"> 
             <table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td>
						<div id="top">
						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">--%>
                   <tr>
					<td align="left" colspan="8"><b>C] TERM LOAN</b></td>
				</tr>
                      <%OurBank_TL = new ArrayList();
			TL_Funded_NonFunded = new ArrayList();

			arrTL_Funded_NonFunded_Size = 0;

			OurBank_TL = (ArrayList) hshValues.get("OurBank_TL");

			if (OurBank_TL != null) {
				arrTL_Funded_NonFunded_Size = OurBank_TL.size();
			}
			
		

			for (int i = 0; i < arrTL_Funded_NonFunded_Size; i++) {
				TL_Funded_NonFunded = (ArrayList) OurBank_TL.get(i);
				chkCategory= Helper.correctNull((String) TL_Funded_NonFunded.get(12));
				
				if (chkCategory.equals("A")) {
					chkCategory1 = "<br>(Adhoc Limit for "
							+ Helper.correctNull((String) TL_Funded_NonFunded
									.get(13)) + " Month )";
				} else {
					chkCategory1 = "";
				}
				int introwspan = Integer.parseInt(Helper
						.correctInt((String) TL_Funded_NonFunded.get(16)));

				%>
                      <tr valign="top"> 
                        <td  align="left" 
									rowspan="<%=introwspan%>"><b><%=Helper.correctNull((String) TL_Funded_NonFunded
								.get(0))%> <%=chkCategory1%></b>&nbsp;</td>
								
                        <%--<td width="13%" align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(1))))%></td> --%>
								
                        <td  align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(2))))%></td>
						<td  align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(6))))%></td>
						<td  align="right" rowspan="<%=introwspan%>"><%=Helper.correctNull((String) TL_Funded_NonFunded.get(4))%>&nbsp;</td>
						
								<%ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) TL_Funded_NonFunded.get(15);
				if (arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						arrCol = new ArrayList();
						//String strBorder = "";
						arrCol = (ArrayList) arrSecurities.get(j);
						//if ((introwspan - 1) == j && j != 0) {
						//	strBorder = "style=\"border-top-width:0\";";
						//} else if (j == 0) {
						//	strBorder = "style=\"border-bottom-width:0\";";
						//} else {
						//	strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						//}
						if (j == 0) {

							%>
								
                        <td  align="right" <%//=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
								
                      
								
                        <td><%=Helper
													.formatTextAreaData((String) arrCol
															.get(0))%>&nbsp;</td>
						<td  align="right" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(7))))%>&nbsp;</td>
						 <td  align="right" rowspan="<%=introwspan%>" valign="top"><%=Helper.correctNull((String) TL_Funded_NonFunded.get(8))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td  align="right"  <%//=strBorder%> valign="top">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
								
                        <td  align="left" <%//=strBorder%> valign="top"><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
								<%}
					}
				} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                       
								
                        <td  align="left" valign="top">&nbsp;</td>
                        <td  align="right" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(7))))%>&nbsp;</td>
						 <td  align="right" rowspan="<%=introwspan%>" valign="top"><%=Helper.correctNull((String) TL_Funded_NonFunded.get(8))%>&nbsp;</td>
								<%}

				%>
							</tr>
							<%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						chkCategory = Helper
								.correctNull((String) arrSubFacRecords.get(11));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month )";
						} else {
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper
								.correctInt((String) arrSubFacRecords.get(15)));

						%>
							<%if (j == 0) {%>
							<tr>
								<td colspan="8">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
							</tr>
							<%}%>
							
                      <tr valign="top"> 
                        <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%> <%=chkCategory1%></td>
								
                      <%-- %>  <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>--%>
								
                        <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
					  <td  align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(6))))%></td>
					<td  align="right" rowspan="<%=intsubrowspan%>"><%=Helper.correctNull((String) arrSubFacRecords.get(4))%>&nbsp; 
								<%ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
						if (arrSecurities != null
								&& arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								arrCol = new ArrayList();
								//String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								/*if ((intsubrowspan - 1) == k) {
									strBorder = "style=\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "style=\"border-bottom-width:0\";";
								} else {
									strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								}*/
								if (k == 0) {

									%>
								
                        <td align="right" <%//=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                       
								
                        <td  <%//=strBorder%> class="just"><%=Helper
															.formatTextAreaData((String) arrCol
																	.get(0))%>&nbsp;</td>
																	
						 <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))%></td>
				 	 <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(8))%></td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td  align="right"  <%//=strBorder%> valign="top">&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td  align="left" <%//=strBorder%> valign="top"><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%}
							}
						} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                        
								
                        <td  align="left" valign="top">&nbsp;</td>
                        
                         <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(7))))%></td>
				 	 <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(8))%></td>
								<%}

					%>
							</tr>
							<%}
				}}
				//End of 'Sub-Facilities' details               
			

			%>
							<tr>
								<td align="left"><b>Sub- Total [C]</b></td>
								
								<td  align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues.get("tl_total_proposed"))))%></td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
							</tr>
							<tr>
								<td >
								<div align="center"><b>TOTAL</b></div>
								</td>
								<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
										.correctDouble((String) hshValues.get("total_proposed"))))%></td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								
							</tr>
						</table>
						
						<%--</td>
					</tr>
				</table>--%>
				</div>
				</td>
			</tr>
			
		</table>
			
		</td>
		
	</tr>
	
</table>

 <%
                    arrRow=new ArrayList();
                    arrData=new ArrayList();
                    arrRow=(ArrayList)hshValues.get("arrSecRemarks");
                    if(arrRow!=null && arrRow.size()!=0){
                
                    %>
<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
   <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      
      <%  for(int i=0;i<arrRow.size();i++)
      {
    	  arrData=(ArrayList)arrRow.get(i); 
    	  if(!Helper.formatTextAreaData((String)arrData.get(0)).equalsIgnoreCase("")){ %>
		  <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
		  <td width="3%">&nbsp;</td>			
          <td valign="top" class="just" width="97%"><%=Helper.formatTextAreaData((String)arrData.get(0))%>&nbsp;</td>
        </tr>
        
        <%}
	  } %>
        </table>
      </td>
   </tr>
</table>
		 <%   }
                    %>	
<!-- end -->

<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
	<tr>
		<td valign="top">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="2%"><b>6.1&nbsp;</b></td>
          <td valign="top" width="98%"><b>NATURE AND VALUE OF COLLATERAL SECURITY 
            :</b></td>
        </tr>
        <tr> 
          <td valign="top" align="right" colspan="2"><b>(<%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>)</b></td>
        </tr>
        <tr> 
		  <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="98%"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr align="center" class="tblhead"> 
                  <td><b> S.No.</b></td>
                  <td class="just"><b>Nature / Description of collateral security 
                    indicating area &amp; location of property</b></td>
                  <td><b> Value</b></td>
                  <td class="just"><b> Date of Valuation along with name of Valuer</b></td>
                  <td class="just"><b>Insurance Amount &amp; Date of Expiry</b></td>
                  <td><b> Remarks</b></td>
                </tr>
                <%
	                ArrayList arrColldetails = new ArrayList();
					ArrayList arrValues = new ArrayList();
					arrColldetails = (ArrayList) hshValues.get("arrColldetails");
					
					
					if (arrColldetails != null && arrColldetails.size() != 0) 
					{
						for (int i = 0; i < arrColldetails.size(); i++) 
						{
						arrValues = (ArrayList) arrColldetails.get(i);
						dbltotal = dbltotal+Double.parseDouble(Helper.correctDouble((String) arrValues.get(1)));
					%>
                <tr valign="top"> 
                  <td><%=i+1%>.&nbsp;</td>
                  <td class="just"><%=Helper.formatTextAreaData((String) arrValues.get(0))%> 
                    &nbsp;</td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrValues.get(1))))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String) arrValues.get(2))%> 
                    - <%=Helper.correctNull((String) arrValues.get(3))%></td>
                  <td align="center">&nbsp; 
                    <%if (Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrValues.get(4)))).equals("0.00")) 
                    {
						out.println("-");
					}
                    else
                    {%>
                    <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrValues.get(4))))%> 
                    - <%=Helper.correctNull((String) arrValues.get(5))%></td>
                  <%}%>
                  <td class="just">&nbsp;<%=Helper.formatTextAreaData((String) arrValues.get(6))%></td>
                </tr>
                <%}%>
                <tr> 
                  <td>&nbsp;</td>
                  <td><b>Total</b></td>
                  <td align="right"><%=Helper.formatDoubleValue(dbltotal)%></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <%} else {
			%>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <%}

			%>
              </table>
            </div>
          </td>
        </tr>
      </table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="2%"><b>6.2&nbsp;</b></td>
          <td valign="top" width="98%"><b> PERSONAL /CORPORATE GUARANTEE :</b></td>
        </tr>
        <tr> 
		  <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" colspan="2" width="98%"> 
            <div id="top"> 
              <table width="65%" border="0" cellspacing="0" cellpadding="3">
                <%boolean bolguarantee = false;
                boolean corpguarantee = false;

			arrRow = new ArrayList();
			arrData = new ArrayList();

			arrRow = (ArrayList) hshValues.get("arrGuarantors");

			if (arrRow != null && arrRow.size() != 0) 
			{
				bolguarantee = true;

				%>
                <tr align="center" class="tblhead "> 
                  <td align="center"><b>Name</b></td>
                  <td align="center"><b>Means (<%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>)</b></td>
                  <td align="center"><b>Means as On</b></td>
                </tr>
                <tr align="center"> 
                  <td align="left" colspan="3"><b>PERSONAL GUARANTEE</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++)
                {
					arrData = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td align="left"><%=arrData.get(0)%>&nbsp;<%=arrData.get(2)%>&nbsp;<%=arrData.get(1)%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrData.get(4))))%></td>
                  <td align="left"><%=arrData.get(5)%></td>
                </tr>
                <%}
			}

			%>
               <%
				if (Helper.correctNull(
						(String) hshValues.get("sel_applicantguarantee"))
						.equalsIgnoreCase("Y")) {
					if (!bolguarantee) {
						bolguarantee = true;%>

                <tr align="center" class="tblhead "> 
                  <td align="center"><b>Name</b></td>
                  <td align="center"><b>Means (<%=ApplicationParams.getCurrency()%>  In <%=strProposalvalue%>)</b></td>
                  <td align="center"><b>Means as On</b></td>
                </tr>
                <%}%>
                <%if(!corpguarantee){
                	corpguarantee=true;%>
                
                <tr align="center"> 
                  <td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
                </tr>
               	<%} %>
                
                <tr align="center"> 
                  <td align="left"><%=Helper.correctNull((String) hshValues.get("comapp_companyname"))%>&nbsp;</td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("means"))))%>&nbsp;</td>
                   <td align="left"><%=Helper.correctNull((String) hshValues.get("meansason"))%></td>
                </tr>
                <% } %>
				
                <%arrRow = new ArrayList();
					arrData = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrCorpguarantee");
					if (arrRow != null && arrRow.size() > 0)
					{
						if (!bolguarantee) 
						{
							bolguarantee = true;%>
                <tr align="center" class="tblhead "> 
                  <td align="center"><b>Name</b></td>
                  <td align="center"><b>Means (<%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>)</b></td>
                  <td align="center"><b>Means as On</b></td>
                </tr>
                <%}%>
                <%if(!corpguarantee){
                	corpguarantee=true;%>
                
                <tr align="center"> 
                  <td align="left" colspan="2"><b>CORPORATE GUARANTEE</b></td>
                </tr>
                <%} %>
                
                <%for (int i = 0; i < arrRow.size(); i++) 
                {
					arrData = (ArrayList) arrRow.get(i);
				%>
                <tr align="center"> 
                  <td align="left"><%=Helper.correctNull((String) arrData.get(0))%>&nbsp;</td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrData.get(4))))%>&nbsp;</td>
                  <td align="left"><%=arrData.get(5)%></td>
                </tr>
                <%}
					}
				
			%>
              </table>
            </div>
            <%if (!bolguarantee)
            {
				out.print("Nil");
			}%>
          </td>
        </tr>
      </table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td colspan="5">&nbsp;</td>
	</tr>
	<tr>
		
    <td width="3%"><b>7.&nbsp;</b></td>
    <td><b>BRIEF FINANCIALS :</b></td>
	</tr>
	<%
			ArrayList arr = null;
			arrsize = 0;

			if (hshValues != null) 
			{
				arr = (ArrayList) hshValues.get("arrValFin");
			}
			if (arr != null)
			{
				arrsize = arr.size();
			}

			ArrayList g1 = null;

			for (int l = 0; l < 25; l++)
			{
				int arrSize = 0;
				if (l < arrsize)
				{
					g1 = (ArrayList) arr.get(l);

					if (g1 != null)
					{
						arrSize = g1.size();
					}
				}

				if (arrSize > 0)
				{
					if (l == 0) 
					{ 
						%>
	
	<tr valign="top">
		<td align="right" colspan="5"><b>(Rs In <%=strProposalvalue%>)</b></td>
	</tr>
	<tr>
		<td width="3%">&nbsp;</td>
		<td>
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			
			
			<tr class="tblhead">
				<td>&nbsp;</td>
				<td align="center">Year ended</td>
				<td align="center">Year ended</td>
				<td align="center">Year ended</td>
				<td align="center">Year ended</td>
			</tr>			
						
			<tr>
				<td>&nbsp;</td>
				<td align="center"><%=Helper.correctNull((String) g1.get(0))%></td>
				<td align="center"><%=Helper.correctNull((String) g1.get(1))%></td>
				<td align="center"><%=Helper.correctNull((String) g1.get(2))%></td>
				<td align="center"><%=Helper.correctNull((String) g1.get(3))%></td>
			</tr>
			<%
			}
					else if (l == 1) 
					{

						%>
			<tr>
				<td>&nbsp;</td>
				<td align="center"><%=Helper.correctNull((String) g1.get(0))%></td>
				<td align="center"><%=Helper.correctNull((String) g1.get(1))%></td>
				<td align="center"><%=Helper.correctNull((String) g1.get(2))%></td>
				<td align="center"><%=Helper.correctNull((String) g1.get(3))%></td>
			</tr>
			<%
			}
					else 
					{
					%>
			<tr>
				<td><%=Helper.correctNull((String) g1.get(4))%></td>
				<td align="right"><%=Helper.correctNull((String) g1.get(0))%></td>
				<td align="right"><%=Helper.correctNull((String) g1.get(1))%></td>
				<td align="right"><%=Helper.correctNull((String) g1.get(2))%></td>
				<td align="right"><%=Helper.correctNull((String) g1.get(3))%></td>
			</tr>
			<%}
				}
			}
			%>
		</table>
		</div>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		
    <td width="3%" valign="top">&nbsp;</td>
		
    <td width="42%" valign="top"><b>COMMENTS ON FINANCIAL INDICATORS </b></td>
		
    <td width="1%" valign="top"><b>:</b></td>
		<%String financial = Helper.correctEditor((String) hshValues.get("comments"));
			if (financial.trim().equals("")|| financial.equalsIgnoreCase("<P>&nbsp;</P>")) 
			{%>
	    
    <td width="16%" valign="top">Nil &nbsp;</td>
		<%} else {%>
		
    <td valign="top" width="38%">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" width="3%"><b>&nbsp;</b></td>
		<td valign="top" colspan="3"><%=Helper.correctEditor((String) hshValues.get("comments"))%></td>
		<%}%>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top"><b>8.1</b>&nbsp;</td>
          <td width="41%" valign="top"><b>PRUDENTIAL EXPOSURE NORMS</b></td>
          <td width="1%" valign="top"><b><b>:</b></b></td>
          <td valign="top" width="55%">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4" valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top">&nbsp;</td>
          <td colspan="3"> 
            <div id="top"> 
              <table width="50%" border="0">
                <tr> 
                  <td>Constitution</td>
                  <td>Prudential Limit in <b>(<%=ApplicationParams.getCurrency()%> 
                    in <%=strProposalvalue%>)</b></td>
                </tr>
                <tr> 
                  <td><%=Helper.correctNull((String) hshValues.get("strownership"))%></td>
                  <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("maxlimit"))))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top">&nbsp;</td>
          <td colspan="3"> 
            <div id="top"> 
              <table width="75%" border="0">
                <tr> 
                  <td>Category</td>
                  <td>Ceiling as % to Bank's Capital Funds</td>
                  <td>Amount based on Capital Funds <b>(<%=ApplicationParams.getCurrency()%> 
                    in <%=strProposalvalue%>)</b></td>
                </tr>
                <tr> 
                  <td><%=Helper.correctNull((String) hshValues.get("label"))%></td>
                  <td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("capital_funds"))))%> 
                  </td>
                  <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("capital_amt"))))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td width="3%" valign="top">&nbsp;</td>
          <td colspan="4" valign="top" class="just"><%=Helper.formatTextAreaData((String) hshValues.get("exposure_norms"))%></td>
        </tr>
        <tr> 
          <td colspan="2" valign="top">&nbsp;</td>
        </tr>
      </table>
		</td>
	</tr>
</table>



<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>8.2&nbsp;</b></td>
          <td valign="top"><b>GROUP EXPOSURE DETAILS</b></td>
          <td valign="bottom" align="right"><b>(Rs In <%=strProposalvalue%>)</b></td>
        </tr>
        <tr> 
          <td valign="top" colspan="3">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%">&nbsp;</td>
          <td valign="top" colspan="2"> 
            <div id="top"> 
              <table border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="15%" rowspan="2" align="center">Name<br>
                    of the <br>
                    Concern</td>
                  <td rowspan="2" width="15%" align="center">Branch</td>
                  <td rowspan="2" width="10%" align="center">CoA</td>
                  <td colspan="2" align="center">Contin-gent</td>
                  <td colspan="3" align="center">FBWC</td>
                  <td colspan="2" align="center">Term Loan</td>
                  <td width="5%" rowspan="2" align="center">Investment</td>
                  <td width="5%" rowspan="2" align="center">MOR</td>
                  <td width="5%" rowspan="2" align="center">Irregularity,<br>
                    if any</td>
                </tr>
                <tr> 
                  <td width="5%">Limit</td>
                  <td width="5%">O/s</td>
                  <td width="5%">Limit</td>
                  <td width="5%">DP</td>
                  <td width="5%">O/s</td>
                  <td width="5%">Limit</td>
                  <td width="5%">O/s</td>
                </tr>
                <%if (operinfo != null && operinfo.size() > 0) 
						{
							for (int j = 0; j < operinfo.size(); j++) 
								{
								arryCol_grpcon = (ArrayList) operinfo.get(j);
					%>
                <tr> 
                  <td width="15%" align="left"><font size="1">&nbsp;<%=Helper.correctNull((String) arryCol_grpcon.get(13))%></font></td>
                  <td width="15%" align="left"><font size="1">&nbsp;<%=Helper.correctNull((String) arryCol_grpcon.get(1))%></font></td>
                  <td width="10%" align="left"><font size="1">&nbsp;<%=Helper.correctNull((String) arryCol_grpcon.get(2))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(3))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(4))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(5))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(6))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(7))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(8))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(9))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(10))))%></font></td>
                  <td width="10%" align="left"><font size="1">&nbsp;<%=Helper.correctNull((String) arryCol_grpcon.get(11))%></font></td>
                  <td width="10%" align="left"><font size="1">&nbsp;<%=Helper.correctNull((String) arryCol_grpcon.get(12))%></font></td>
                </tr>
                <%			}
						}
						else
						{
					%>
                <tr> 
                  <td width="15%">&nbsp;</td>
                  <td width="15%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                </tr>
                <%}

				if (operinfo != null && operinfo.size() != 0) 
				{
				%>
                <tr> 
                  <td width="15%"><b>Total Exposure</b></td>
                  <td width="15%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("EXEC_GCCOMLIMIT"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("EXEC_GCCOMOS"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("EXEC_GCFBWCLT"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("EXEC_GCFBWCDP"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("EXEC_GCFBWCOS"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("EXEC_GCTLLT"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("EXEC_GCTLOS"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("EXEC_GCINS"))))%></font></td>
                  <td width="10%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                </tr>
                <%}
			%>
              </table>
            </div>
          </td>
        </tr>
      </table>
		</td>
	</tr>
</table>



<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
		<tr>
				<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
				
          <td valign="top" width="3%"><b>8.3&nbsp;</b></td>
          <td valign="top" width="43%"><b>EXPOSURE NORMS FOR UNSECURED ADVANCES</b></td>
          <td valign="top" align="center" width="1%"><b><b>:</b></b></td>
				<%String Norms= Helper.correctEditor((String)hshValues.get("comstl_norms")).trim();
				if (Norms.trim().equals("")|| Norms.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
          <td valign="top" width="15%">Nil</td>
				<%} else {%>
          <td valign="top" width="38%">&nbsp;</td>
		</tr>
		<tr>
				
          <td valign="top" width="3%"><b>&nbsp;</b></td>
				<td colspan="3"><%=Helper.correctEditor((String)hshValues.get("comstl_norms"))%>
				</td>
				<%}%>
		</tr>
		</table>
		</td>
	</tr>
</table>


<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
	            
          <td valign="top" width="3%"><b>8.4</b></td>
	            
          <td valign="top" width="43%"><b>UMBRELLA LIMIT FOR SUB-BPLR LENDING</b></td>
				
          <td valign="top" align="center" width="1%"><b><b>:</b></b></td>
				<%String bplr= Helper.correctEditor((String)hshValues.get("comstl_bplr")).trim();
				if (bplr.trim().equals("")|| bplr.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
				
          <td valign="top" width="15%">Nil</td>
				<%} else {%>
				
          <td valign="top" width="38%">&nbsp;</td>
			</tr>
			<tr>
				
          <td valign="top" width="3%" >&nbsp;</td>
				<td colspan="3"><%=bplr%></td>
				<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>



<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				
          <td valign="top" width="3%"><b>9.&nbsp;</b></td>
				
          <td valign="top" width="43%"><b>PRESENT REQUEST</b></td>
				
          <td valign="top" align="center" width="1%"><b><b>:</b></b></td>

				<%String exec_presentreq= Helper.formatTextAreaData((String) hshValues.get("exec_presentreq")).trim();
					if (exec_presentreq.trim().equals("") || exec_presentreq.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
				
          <td valign="top" width="15%">Nil</td>
				<%} else {%>
				
          <td valign="top" width="38%">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>&nbsp;</b></td>
				<td class="just" colspan="3"><%=exec_presentreq%>
				</td>
				<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%"><b>10.&nbsp;</b></td>
          <td valign="top" colspan="3"><b>COMMENTS ON LIMIT SOUGHT</b><b></b></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%" align="right"><b>10.1&nbsp;</b></td>
          <td valign="top" width="42%"><b>ASSESSMENT OF THE PROPOSAL</B></td>
          <td valign="top" align="center" width="1%"><b><b>:</b></b></td>
          <%String termloan_comments= Helper.correctEditor((String) hshValues.get("com_termloan_comments")).trim();
		  		if (termloan_comments.trim().equals("")|| termloan_comments.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
          <td valign="top" width="15%">Nil</td>
          <%} else {%>
          <td valign="top" width="38%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%"><b>&nbsp;</b></td>
          <td colspan="3"><%=termloan_comments%> </td>
          <%}%>
        </tr>
      </table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				
	          
          <td valign="top" width="4%" align="right"><b>10.2&nbsp;</b></td>
	          
          <td valign="top" width="42%"><b>CASH FLOW STATEMENT</b></td>
	          
          <td valign="top" align="center" width="1%"><b><b>:</b></b></td>
					<%String exec_notes= Helper.correctEditor((String) hshValues.get("exec_notes")).trim();
					if (exec_notes.trim().equals("")|| exec_notes.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
	          
          <td valign="top" width="15%">Nil</td>
					<%} else {%>
	          <td valign="top" width="38%">&nbsp;</td>
			</tr>
			<tr>
          		<td valign="top" width="4%"><b>&nbsp;</b></td>
				<td colspan="3"><%=Helper.correctEditor((String) hshValues.get("exec_notes")).trim()%>
				</td>
				<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
	          <td valign="top" width="3%"><b>11.&nbsp;</b></td>
	          
          <td valign="top" width="43%"><b>DELEGATED AUTHORITY</b></td>
	          
          <td valign="top" align="center" width="1%"><b><b>:</b></b></td>
				<%String exec_delegated6= Helper.formatTextAreaData((String) hshValues.get("exec_delegated")).trim();
					if (exec_delegated6.trim().equals("")|| exec_delegated6.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
	          
          <td valign="top" width="15%">Nil</td>
				<%} else {%>
	          <td valign="top" width="38%">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>&nbsp;</b></td>
				<td class="just" colspan="3"><%=Helper.formatTextAreaData((String) hshValues.get("exec_delegated")).trim()%>
				</td>
				<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" colspan="5">&nbsp;</td>
			</tr>
			<tr>
				
          <td valign="top" width="3%"><b>12.&nbsp;</b></td>
				
          <td valign="top" colspan="4" width="97%"><b>RECOMMENDATIONS</b></td>
			</tr>
		<tr>
			
		    <td valign="top"  colspan="5">In view of the above, we recommend for sanction 
		      of secured/unsecured STL, in addition to the existing facilities, in favour of the company as under:</td>
  			
		</tr>			
			<tr>
				<td valign="top" align="right" colspan="5"><b>(<%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>)</b></td>
			</tr>
			<tr>
				
          <td valign="top" rowspan="4" width="3%">&nbsp;</td>
				
          <td valign="top" colspan="4" width="97%"> 
            <div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td  width="27%">
						<div align="center">Nature of Limit</div>
						</td>
						<td >
						<div align="center">Amount</div>
						</td>
						<td  width="8%">
						<div align="center">Tenor</div>
						</td> 
						<td  width="8%">
						<div align="center">Margin (%)</div>
						</td>
						<td  width="8%">
						<div align="center">Int./ Comm.</div>
						</td>
						<td  width="31%">
						<div align="center">Security</div>
						</td>
					</tr>
					<%--<tr class="tblhead">
						<td width="13%" align="center">Existing</td>
						<td width="13%" align="center">Proposed</td>
					</tr>
				</table>
				
				</td>
			</tr>--%>
			<%--<tr>
				
          <td valign="top" colspan="4" width="97%"> 
             <table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td>
						<div id="top">
						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">--%>
                      <% 
							OurBank_WC_NonFunded = new ArrayList();
								WC_NonFunded = new ArrayList();
								arrWC_NonFunded_Size = 0;
								OurBank_WC_NonFunded = (ArrayList) hshValues.get("OurBank_WC_NonFunded_STL");
								
								if (OurBank_WC_NonFunded != null) 
								{
									arrWC_NonFunded_Size = OurBank_WC_NonFunded.size();
								}
	
								for (int i = 0; i < arrWC_NonFunded_Size; i++) 
								{
									WC_NonFunded = (ArrayList) OurBank_WC_NonFunded.get(i);
									chkCategory = Helper.correctNull((String) WC_NonFunded.get(12));
									chkCategory_headid= Helper.correctNull((String) WC_NonFunded.get(14));
									existing = Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(1)));
									arrSubFac = new ArrayList();
									arrSubFac = (ArrayList) WC_NonFunded.get(9);
								
									if (arrSubFac != null && arrSubFac.size() > 0) 
									{
										for (int j = 0; j < arrSubFac.size(); j++) 
										{
											arrSubFacRecords = new ArrayList();
											arrSubFacRecords = (ArrayList) arrSubFac.get(j);
											chkCategory_subheadid = Helper.correctNull((String) arrSubFacRecords.get(13));
										}
									}
									 if ((chkCategory_headid.equals("1")&& existing==0.00)||(chkCategory_subheadid.equals("1")))
									{ 
									if (chkCategory.equals("A")) 
									{
										chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) WC_NonFunded.get(13))+ " Month ) ";
									} 
									else
									{
										chkCategory1 = "";
									}
									int introwspan = Integer.parseInt(Helper.correctInt((String) WC_NonFunded.get(16)));
							%>
                      <tr valign="top"> 
                        <td width="27%" align="left" rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) WC_NonFunded.get(0))%> 
                          <%=chkCategory1%></b></td>
								
                      <%--  <td width="13%" align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(1))))%></td>--%>
								
                        <td width="13%" align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(2))))%></td>
                        <td width="8%" align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.correctNull((String) WC_NonFunded.get(13))%></td>
                        <%total_proposed_sec =Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(2)));%>
								<%
								ArrayList arrSecurities = new ArrayList();
								ArrayList arrRemarkrow = new ArrayList();
								ArrayList arrRemarkcol;
								arrSecurities = (ArrayList) WC_NonFunded.get(15);
								arrRemarkrow = (ArrayList) WC_NonFunded.get(17);
								if (arrSecurities != null && arrSecurities.size() > 0) 
								{
									for (int j = 0; j < arrSecurities.size(); j++) 
									{
										arrCol = new ArrayList();
										//String strBorder = "";
										arrCol = (ArrayList) arrSecurities.get(j);
										arrRemarkcol= (ArrayList) arrRemarkrow.get(j);
										arrtotRemark.add(arrRemarkcol);
										/*if ((introwspan - 1) == j && j != 0) 
										{
											strBorder = "style=\"border-top-width:0\";";
										}
										else if (j == 0) 
										{
											strBorder = "style=\"border-bottom-width:0\";";
										}
										else 
										{
											strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
										}*/
										if (j == 0)
										{
								%>
								
                        <td width="8%" align="right" <%//=strBorder%>>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
								
                        <td width="8%" align="right" rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_NonFunded.get(4))%>&nbsp;</td>
								
                        <td width="31%" <%//=strBorder%> class="just"><%=Helper.formatTextAreaData((String) arrCol.get(0))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td width="8%" align="right"  <%//=strBorder%> valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
								
                        <td width="31%" align="left" <%//=strBorder%> valign="top"><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
								<%}
									}
										} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                        <td width="8%" align="right" rowspan="<%=introwspan%>" valign="top"><%=Helper.correctNull((String) WC_NonFunded.get(4))%>&nbsp;</td>
								
                        <td width="31%" align="left" valign="top">&nbsp;</td>
								<%}
								%>
							</tr>
							<%//For the Sub-limits, under each one
								arrSubFac = new ArrayList();
								arrSubFac = (ArrayList) WC_NonFunded.get(9);
								int subFacSize = arrSubFac.size();
								if (arrSubFac != null && subFacSize > 0)
								{
									for (int j = 0; j < subFacSize; j++) 
									{
										arrSubFacRecords = new ArrayList();
										arrSubFacRecords = (ArrayList) arrSubFac.get(j);
				
										chkCategory = Helper.correctNull((String) arrSubFacRecords.get(11));
										if (chkCategory.equals("A")) 
										{
											chkCategory1 = "<br>(Adhoc Limit for " + Helper.correctNull((String) arrSubFacRecords.get(12)) + " Month) ";
										} 
										else 
										{
											chkCategory1 = "";
										}
										int intsubrowspan = Integer.parseInt(Helper.correctInt((String) arrSubFacRecords.get(15)));

						%>
							<%if (j == 0) {%>
							<tr>
								<td colspan="6">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
							</tr>
							<%}%>
							
                      <tr valign="top"> 
                        <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(0))%> 
                          <%=chkCategory1%></td>
								
                       <%--  <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))%>)</td>--%>
								
                        <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))%>)</td>
                        <td width="8%" align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(12))%></td>
								<%ArrayList arrsubSecurities = new ArrayList();
									arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
									if (arrSecurities != null && arrsubSecurities.size() > 0) 
									{
										for (int k = 0; k < arrsubSecurities.size(); k++)
										{
											arrCol = new ArrayList();
											//String strBorder = "";
											arrCol = (ArrayList) arrsubSecurities.get(k);
											/*if ((intsubrowspan - 1) == k) 
											{
												strBorder = "style=\"border-top-width:0\";";
											}
											else if (k == 0) 
											{
												strBorder = "style=\"border-bottom-width:0\";";
											}
											else
											{
												strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
											}*/
											if (k == 0) 
											{

									%>
								
                        <td width="8%" align="right" <%//=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td width="8%" align="right"
									rowspan="<%=intsubrowspan%>"><%=Helper
															.correctNull((String) arrSubFacRecords
																	.get(4))%>&nbsp; 
                        </td>
								
                        <td width="31%" <%//=strBorder%> class="just"><%=Helper
															.formatTextAreaData((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td width="8%" align="right" <%//=strBorder%> valign="top">&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td width="31%" align="left" <%//=strBorder%> valign="top"><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%}
							}
						} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                        <td width="8%" align="right" valign="top"><%=Helper
													.correctNull((String) arrSubFacRecords
															.get(4))%>&nbsp; </td>
								
                        <td width="31%" align="left" valign="top">&nbsp;</td>
								<%}

					%>
							</tr>
							<%}}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
							
                    <%--  <tr valign="top"> 
                        <td width="27%" align="left"><b> Sub- Total [A]</b></td>
								
                        <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_existing"))))%></td>
								
                        <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_proposed"))))%></td>
								
                        <td width="8%">&nbsp;</td>
								
                        <td width="8%">&nbsp;</td>
								
                        <td width="31%">&nbsp;</td>
							</tr>
						</table>
						</div>
						</td>
					</tr> 
				</table>
				</td>
			</tr>--%>
			<%--<tr>
				
          <td valign="top" colspan="4" width="97%"> 
             <table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td>
						<div id="top">
						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">--%>
                      <%OurBank_WC_Funded = new ArrayList();
			WC_Funded = new ArrayList();

			arrWC_Funded_Size = 0;

			OurBank_WC_Funded = (ArrayList) hshValues.get("OurBank_WC_Funded_STL");
			if (OurBank_WC_Funded != null) {
				arrWC_Funded_Size = OurBank_WC_Funded.size();
			}
			
			
			for (int i = 0; i < arrWC_Funded_Size; i++) {
				WC_Funded = (ArrayList) OurBank_WC_Funded.get(i);
				chkCategory = Helper.correctNull((String) WC_Funded.get(12));
				chkCategory_headid= Helper.correctNull((String) WC_Funded.get(14));
				existing = Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(1)));
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_Funded.get(9);
				chkCategory_subheadid="";
				if (arrSubFac != null && arrSubFac.size() > 0) 
				{
					for (int j = 0; j < arrSubFac.size(); j++) 
					{
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);
						chkCategory_subheadid = Helper.correctNull((String) arrSubFacRecords.get(13));
					}
				}
				 if ((chkCategory_headid.equals("1")&& existing==0.00)||(chkCategory_subheadid.equals("1")))
				{
				if (chkCategory.equals("A")) {
					chkCategory1 = "<br>(Adhoc Limit for "
							+ Helper.correctNull((String) WC_Funded.get(13))
							+ " Month ) ";
				} else {
					chkCategory1 = "";
				}
				int introwspan = Integer.parseInt(Helper
						.correctInt((String) WC_Funded.get(16)));

				%>
                      <tr valign="top"> 
                        <td width="27%" align="left" 
									rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) WC_Funded.get(0))%> 
                          <%=chkCategory1%></b></td>
								
                       <%--  <td width="13%" align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(1))))%></td>--%>
								
                        <td width="13%" align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(2))))%></td>
						<td width="8%" align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.correctNull((String) WC_Funded.get(13))%></td>
						<%total_proposed_sec =total_proposed_sec+Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(2)));%>
								<%ArrayList arrSecurities = new ArrayList();
								ArrayList arrRemarkrow = new ArrayList();
								ArrayList arrRemarkcol;
				arrSecurities = (ArrayList) WC_Funded.get(15);
				arrRemarkrow = (ArrayList) WC_Funded.get(17);
				if (arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						arrCol = new ArrayList();
						//String strBorder = "";
						arrCol = (ArrayList) arrSecurities.get(j);
						arrRemarkcol= (ArrayList) arrRemarkrow.get(j);
						arrtotRemark.add(arrRemarkcol);
						/*if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}*/
						if (j == 0) {

							%>
								
                        <td width="8%" align="right" <%//=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
								
                        <td width="8%" align="right" 
									rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_Funded
											.get(4))%>&nbsp; </td>
								
                        <td width="31%" <%//=strBorder%> class="just"><%=Helper
													.formatTextAreaData((String) arrCol
															.get(0))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td width="8%" align="right" <%//=strBorder%> valign="top">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
								
                        <td width="31%" align="left" <%//=strBorder%> valign="top"><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
								<%}
					}
				} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                        <td width="8%" align="right" valign="top"><%=Helper.correctNull((String) WC_Funded.get(4))%>&nbsp; 
                        </td>
								
                        <td width="31%" align="left" valign="top">&nbsp;</td>
								<%}

				%>
							</tr>
							<%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_Funded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);

						chkCategory = Helper
								.correctNull((String) arrSubFacRecords.get(11));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month )";
						} else {
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper
								.correctInt((String) arrSubFacRecords.get(15)));

						%>
							<%if (j == 0) {%>
							<tr>
								<td colspan="6">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
							</tr>
							<%}%>
							
                      <tr valign="top"> 
                        <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%> <%=chkCategory1%></td>
								
                        <%--<td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td> --%>
								
                        <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
					  <td width="8%" align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(12))%></td>
								<%arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
						if (arrSecurities != null
								&& arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								arrCol = new ArrayList();
								//String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								/*if ((intsubrowspan - 1) == k) {
									strBorder = "style=\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "style=\"border-bottom-width:0\";";
								} else {
									strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								}*/
								if (k == 0) {

									%>
								
                        <td width="8%" align="right" <%//=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td width="8%" align="right" 
									rowspan="<%=intsubrowspan%>"><%=Helper
															.correctNull((String) arrSubFacRecords
																	.get(4))%>&nbsp; 
                        </td>
								
                        <td width="31%"  <%//=strBorder%> class="just"><%=Helper
															.formatTextAreaData((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td width="8%" align="right" <%//=strBorder%> valign="top">&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td width="31%" align="left" <%//=strBorder%> valign="top"><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%}
							}
						} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                        <td width="8%" align="right" valign="top"><%=Helper
													.correctNull((String) arrSubFacRecords
															.get(4))%>&nbsp; </td>
								
                        <td width="31%" align="left" valign="top">&nbsp;</td>
								<%}

					%>
							</tr>
							<%}
				}}
				//End of 'Sub-Facilities' details               
			}

			%>
						<%--	<tr>
								<td width="27%" align="left"><b>Sub- Total [B]</b></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_funded_existing"))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_funded_proposed"))))%></td>
								<td width="8%">&nbsp;</td>
								<td width="8%">&nbsp;</td>
								<td width="31%">&nbsp;</td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>--%>
			<%--<tr>
				
          <td valign="top" colspan="4" width="97%"> 
             <table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td>
						<div id="top">
						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">--%>
                      <%OurBank_TL = new ArrayList();
			TL_Funded_NonFunded = new ArrayList();

			arrTL_Funded_NonFunded_Size = 0;

			OurBank_TL = (ArrayList) hshValues.get("OurBank_STL");

			if (OurBank_TL != null) {
				arrTL_Funded_NonFunded_Size = OurBank_TL.size();
			}
			
		

			for (int i = 0; i < arrTL_Funded_NonFunded_Size; i++) {
				TL_Funded_NonFunded = (ArrayList) OurBank_TL.get(i);
				chkCategory_headid= Helper.correctNull((String) TL_Funded_NonFunded.get(14));
				chkCategory = Helper.correctNull((String) TL_Funded_NonFunded.get(12));
				existing = Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(1)));
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
				chkCategory_subheadid="";
				if (arrSubFac != null && arrSubFac.size() > 0) 
				{
					for (int j = 0; j < arrSubFac.size(); j++) 
					{
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);
						chkCategory_subheadid = Helper.correctNull((String) arrSubFacRecords.get(13));
					}
				}
				if ((chkCategory_headid.equals("1")&& existing==0.00)||(chkCategory_subheadid.equals("1")))
				{
				if (chkCategory.equals("A")) {
					chkCategory1 = "<br>(Adhoc Limit for "
							+ Helper.correctNull((String) TL_Funded_NonFunded
									.get(13)) + " Month )";
				} else {
					chkCategory1 = "";
				}
				int introwspan = Integer.parseInt(Helper
						.correctInt((String) TL_Funded_NonFunded.get(16)));

				%>
                      <tr valign="top"> 
                        <td width="27%" align="left" 
									rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) TL_Funded_NonFunded
								.get(0))%> <%=chkCategory1%><b></b></b></td>
								
                        <%--<td width="13%" align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(1))))%></td> --%>
								
                        <td width="13%" align="right"
									rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(2))))%></td>
						<td width="8%" align="right" rowspan="<%=introwspan%>">&nbsp;<%=Helper.correctNull((String) TL_Funded_NonFunded.get(13))%></td>
						<%total_proposed_sec =total_proposed_sec+Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(2)));%>
								<%ArrayList arrSecurities = new ArrayList();
								ArrayList arrRemarkrow = new ArrayList();
								ArrayList arrRemarkcol;
				arrSecurities = (ArrayList) TL_Funded_NonFunded.get(15);
				arrRemarkrow = (ArrayList) TL_Funded_NonFunded.get(17);
				if (arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						arrCol = new ArrayList();
						arrRemarkcol = new ArrayList();
						//String strBorder = "";
						arrCol = (ArrayList) arrSecurities.get(j);
						arrRemarkcol= (ArrayList) arrRemarkrow.get(j);
						arrtotRemark.add(arrRemarkcol);
						/*if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}*/
						if (j == 0) {

							%>
								
                        <td width="8%" align="right" <%//=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
								
                        <td width="8%" align="right" 
									rowspan="<%=introwspan%>"><%=Helper
													.correctNull((String) TL_Funded_NonFunded
															.get(4))%>&nbsp; </td>
								
                        <td width="31%" <%//=strBorder%> class="just"><%=Helper
													.formatTextAreaData((String) arrCol
															.get(0))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td width="8%" align="right"  <%//=strBorder%> valign="top">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
								
                        <td width="31%" align="left" <%//=strBorder%> valign="top"><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
								<%}
					}
				} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                        <td width="8%" align="right" valign="top" ><%=Helper.correctNull((String) TL_Funded_NonFunded
									.get(4))%>&nbsp; </td>
								
                        <td width="31%" align="left" valign="top">&nbsp;</td>
								<%}

				%>
							</tr>
							<%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						chkCategory = Helper
								.correctNull((String) arrSubFacRecords.get(11));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month )";
						} else {
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper
								.correctInt((String) arrSubFacRecords.get(15)));

						%>
							<%if (j == 0) {%>
							<tr>
								<td colspan="6">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
							</tr>
							<%}%>
							
                      <tr valign="top"> 
                        <td align="left" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%> <%=chkCategory1%></td>
								
                      <%-- %>  <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>--%>
								
                        <td align="right" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
					  <td width="8%" align="right" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords.get(12))%></td>
								<%ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
						if (arrSecurities != null
								&& arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								arrCol = new ArrayList();
								//String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								/*if ((intsubrowspan - 1) == k) {
									strBorder = "style=\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "style=\"border-bottom-width:0\";";
								} else {
									strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								}*/
								if (k == 0) {

									%>
								
                        <td width="8%" align="right" <%//=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td width="8%" align="right" 
									rowspan="<%=intsubrowspan%>"><%=Helper
															.correctNull((String) arrSubFacRecords
																	.get(4))%>&nbsp; 
                        </td>
								
                        <td width="31%" <%//=strBorder%> class="just"><%=Helper
															.formatTextAreaData((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%} else {%>
							</tr>
							<tr>
								
                        <td width="8%" align="right"  <%//=strBorder%> valign="top">&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
								
                        <td width="31%" align="left" <%//=strBorder%> valign="top"><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
								<%}
							}
						} else {%>
								
                        <td valign="top">&nbsp;</td>
								
                        <td width="8%" align="right" valign="top" ><%=Helper
													.correctNull((String) arrSubFacRecords
															.get(4))%>&nbsp; </td>
								
                        <td width="31%" align="left" valign="top">&nbsp;</td>
								<%}

					%>
							</tr>
							<%}
				}}
				//End of 'Sub-Facilities' details               
			}

			%>
							<%--<tr>
								<td width="27%" align="left"><b>Sub- Total [C]</b></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tl_total_existing"))))%></td>
								<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tl_total_proposed"))))%></td>
								<td width="8%">&nbsp;</td>
								<td width="8%">&nbsp;</td>
								<td width="31%">&nbsp;</td>
							</tr>--%>
							<tr>
								<td width="27%">
								<div align="center"><b>TOTAL</b></div>
								</td>
								<td width="8%" align="right">&nbsp;<%=Helper.formatDoubleValue(total_proposed_sec)%></td>
								<td width="8%">&nbsp;</td>
								<td width="8%">&nbsp;</td>
								<td width="8%">&nbsp;</td>
								<td width="31%">&nbsp;</td>
								
							</tr>
						</table>
						
						<%--</td>
					</tr>
				</table>--%>
				</div>
				</td>
			</tr>
			
		</table>
			
		</td>
		
	</tr>
	
</table>

			<%
                    //arrRow=new ArrayList();
                    arrData=new ArrayList();
                    arrRow=(ArrayList)hshValues.get("arrSecRemarks");
                    if(arrtotRemark!=null && arrtotRemark.size()!=0){
                
                    %>
<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
   <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      
      <%  for(int i=0;i<arrtotRemark.size();i++)
      {
    	  arrData=(ArrayList)arrtotRemark.get(i); 
    	  if(!Helper.formatTextAreaData((String)arrData.get(0)).equalsIgnoreCase("")){ %>
		  <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
		  <td width="3%">&nbsp;</td>		
          <td valign="top" class="just" width="97%"><%=Helper.formatTextAreaData((String)arrData.get(0))%>&nbsp;</td>
        </tr>
        
        <%}
	  } %>
        </table>
      </td>
   </tr>
</table>
		 <%   }
                    %>	


<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%">&nbsp;</td>
          <td valign="top" width="97%"><b>COLLATERAL SECURITY :</b></td>
        </tr>
        <tr> 
          <td valign="top" align="right" colspan="2"><b>(<%=ApplicationParams.getCurrency()%> 
            In <%=strProposalvalue%>)</b></td>
        </tr>
        <tr> 
		  <td valign="top" width="3%">&nbsp;</td>
          <td valign="top" colspan="2" width="97%"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr align="center" class="tblhead"> 
				<td><b> S.No.</b></td>
                  <td class="just"><b>Nature / Description of collateral security 
                    indicating area &amp; location of property</b></td>
                  <td><b> Value<BR>
                    </b></td>
                  <td class="just"><b> Date of Valuation along with name of Valuer</b></td>
                  <td class="just"><b>Insurance Amount &amp; Date of Expiry</b></td>
                  <td><b> Remarks</b></td>
                </tr>
                <%arrColldetails = new ArrayList();
			arrValues = new ArrayList();
			arrColldetails = (ArrayList) hshValues.get("arrColldetails");

			if (arrColldetails != null && arrColldetails.size() != 0) {
				for (int i = 0; i < arrColldetails.size(); i++) {
					arrValues = (ArrayList) arrColldetails.get(i);

					%>
                <tr valign="top">
				<td><%=i+1%>.&nbsp;</td> 
                  <td class="just"><%=Helper.formatTextAreaData((String) arrValues
									.get(0))%> &nbsp;</td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrValues
													.get(1))))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String) arrValues.get(2))%> 
                    - <%=Helper.correctNull((String) arrValues.get(3))%></td>
                  <td width="21%" align="center">&nbsp; 
                    <%if (Helper.formatDoubleValue(
							Double.parseDouble(Helper
									.correctDouble((String) arrValues.get(4))))
							.equals("0.00")) {
						out.println("-");
					} else {%>
                    <%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrValues
																		.get(4))))%> 
                    - <%=Helper.correctNull((String) arrValues
												.get(5))%></td>
                  <%}%>
                  <td class="just">&nbsp;<%=Helper.formatTextAreaData((String) arrValues
									.get(6))%></td>
                </tr>
                <%}%>
                <tr> 
                <td>&nbsp;</td>
               	<td><b>Total</b></td>
                <td align="right"><%=Helper.formatDoubleValue(dbltotal)%></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
				  <td>&nbsp;</td>
              </tr>
					<%} else {

			%>
                <tr> 
				  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <%}

			%>
              </table>
            </div>
          </td>
        </tr>
      </table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="3">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%">&nbsp;</td>
				<td valign="top" width="2%">ii)</td>
				
          <td valign="top" width="95%"><b> PERSONAL GUARANTEE / CORPORATE GUARANTEE 
            </b></td>
			</tr>
			<tr>
			<td valign="top" width="3%">&nbsp;</td>
				<td valign="top" colspan="3">
				<div id="top">
				<table width="65%" border="0" cellspacing="0" cellpadding="3">
					<% bolguarantee = false;
					corpguarantee = false;
			arrRow = new ArrayList();
			arrData = new ArrayList();

			arrRow = (ArrayList) hshValues.get("arrGuarantors");

			if (arrRow != null && arrRow.size() != 0) {
				bolguarantee = true;

				%>
					<tr align="center" class="tblhead ">
						<td align="center"><b>Name</b></td>
						<td align="center"><b>Means (<%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%>)</b></td>
						<td align="center"><b>Means as On</b></td>
					</tr>
					<tr align="center">
						<td align="left" colspan="3"><b>PERSONAL GUARANTEE</b></td>
					</tr>
					<%for (int i = 0; i < arrRow.size(); i++) {
					arrData = (ArrayList) arrRow.get(i);

					%>
					<tr>
						<td align="left"><%=arrData.get(0)%>&nbsp;<%=arrData.get(2)%>&nbsp;<%=arrData.get(1)%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrData.get(4))))%></td>
						<td align="left"><%=arrData.get(5)%></td>
					</tr>
					<%}
			}

			%>
					<%
				if (Helper.correctNull(
						(String) hshValues.get("sel_applicantguarantee"))
						.equalsIgnoreCase("Y")) {
					if (!bolguarantee) {
						bolguarantee = true;%>
					<tr align="center" class="tblhead ">
						<td align="center"><b>Name</b></td>
						<td align="center"><b>Means (<%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%>)</b></td>
						<td align="center"><b>Means as On</b></td>
					</tr>
					<%}%>
					<%if(!corpguarantee){
                	corpguarantee=true;%>
					<tr align="center">
						<td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
					</tr>
					<%} %>
					<tr align="center">
						<td align="left"><%=Helper.correctNull((String) hshValues
									.get("comapp_companyname"))%>&nbsp;</td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("means"))))%>&nbsp;</td>
						<td align="left"><%=Helper.correctNull((String) hshValues
									.get("meansason"))%>&nbsp;</td>
					</tr>
					<%}%>
					
					<%arrRow = new ArrayList();
					arrData = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrCorpguarantee");
					if (arrRow != null && arrRow.size() > 0) {
						if (!bolguarantee) {
							bolguarantee = true;%>
					<tr align="center" class="tblhead ">
						<td align="center"><b>Name</b></td>
						<td align="center"><b>Means (<%=ApplicationParams.getCurrency()%>
						In <%=strProposalvalue%>)</b></td>
						<td align="center"><b>Means as On</b></td>
					</tr>
					<%}%>
					<%if(!corpguarantee){
                	corpguarantee=true;%>
					<tr align="center">
						<td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
					</tr>
					<%} %>
					<%for (int i = 0; i < arrRow.size(); i++) {
							arrData = (ArrayList) arrRow.get(i);

							%>
					<tr align="center">
						<td align="left"><%=Helper.correctNull((String) arrData
											.get(0))%>&nbsp;</td>
						<td align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrData
																			.get(4))))%>&nbsp;</td>
						<td align="left"><%=arrData.get(5)%></td>
					</tr>
					<%}
					}
				
			%>
				</table>
				</div>
				<%if (!bolguarantee) {
				out.print("Nil");
			}%></td>
			</tr>
		</table>
		</td>
	</tr>
</table>








<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="3%">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="3%"><b>13.&nbsp;</b></td>
				<td valign="top" width="97%"><b>TERMS AND CONDITIONS:</b></td>
			</tr>
			<%arrRow = new ArrayList();
			arrData = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow12");
			if (arrRow != null && arrRow.size() != 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrData = (ArrayList) arrRow.get(i);

					%>
			<tr>
				<td valign="top" width="3%">&nbsp;</td>
				<td valign="top" class="just" width="97%"><%=i + 1%>.&nbsp;<%=Helper
											.formatTextAreaData((String) arrData
													.get(0))%>&nbsp;</td>
			</tr>
			<%}
			}

			%>
		</table>
		</td>
	</tr>
</table>

<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		 <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr> 
       		<td width="10%">&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td valign="top" align="left">Submitted for Approval</td>
        </tr>
        <tr>
        	<td colspan="2">&nbsp;</td>
        </tr>
        <%if (!Helper.correctNull(
					(String) hshValues.get("exec_mcmresolution"))
					.equalsIgnoreCase("")) {%>
        <tr> 
	        <td width="10%">&nbsp;</td>
          <td valign="top" align="left" class="just"><b>Resolution:</b><br><br>
			<b>If approved,</b> the MANAGEMENT COMMITTEE <b>is requested to adopt the following resolution.
			</b><br><br>
        	<%=Helper.formatTextAreaData((String) hshValues
								.get("exec_mcmresolution"))%></td>
        </tr>
        
        <%}

			%>
        <tr> 
          <td valign="top" align="left" colspan="2">&nbsp;<br><br></td>
        </tr>
        <tr> 
        	<td width="10%">&nbsp;</td>
          <td valign="top" align="left"><b><%=Helper.correctNull((String) hshValues
							.get("exec_signatures"))%></b></td>
        </tr>
        <%if (!Helper
					.correctNull((String) hshValues.get("exec_gridcomments"))
					.equalsIgnoreCase("")) {%>
       <tr> 
          <td valign="top" align="left" colspan="2">&nbsp;</td>
        </tr>
        <tr> 
        	<td width="10%">&nbsp;</td>
          <td valign="top" class="just"><%=Helper.correctNull((String) hshValues
								.get("exec_gridcomments"))%></td>
        </tr>
        <%}

		%>
      </table>
		</td>
	</tr>
</table>
</body>
</html>
