<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%ArrayList arrSubFac = new ArrayList();
			ArrayList arrSubFacRecords = new ArrayList();

			String strProposalvalue = Helper.correctNull((String) hshValues
					.get("proposalvaluesin"));

			if (strProposalvalue.equalsIgnoreCase("C"))
				strProposalvalue = "Crores";
			else
				strProposalvalue = "Lacs";

			String strSanctauth = Helper.correctNull((String) hshValues
					.get("exec_sancauth"));
			ArrayList arrrow = new ArrayList();
			ArrayList arrcol = new ArrayList();
			ArrayList presentrequest = new ArrayList();
			ArrayList requestcol = new ArrayList();
			ArrayList arrtotRemark = new ArrayList();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adhoc - Limit PrintOut</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/executivereport.css"
	type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="25px"
	topmargin="25px" marginwidth="25px" marginheight="25px">
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
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
										.get("exec_mcm"))%></td>
              </tr>
            </table>
          </td>
        </tr>
        <%}

			%>
        <tr> 
          <td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
        </tr>
        <tr> 
          <td align="center">Branch / Office, <%=Helper.correctNull((String) hshValues.get("strOrgName"))%> 
            <hr>
          </td>
        </tr>
        <tr> 
          <td align="center"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="center">
              <tr> 
                <td valign="top" width="80%">Reference No. :LCV:<%=Helper.correctNull((String) hshValues.get("exec_refno"))%>&nbsp;</td>
                <td valign="top">Date:<%=Helper.correctNull((String) hshValues.get("exec_date"))%>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr align="right"> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="6">
              <tr> 
                <%if (strSanctauth.equals("4") || strSanctauth.equals("5")) {%>
                <td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/GM.jpg"
							width="55" height="77"></td>
                <td>&nbsp;&nbsp;</td>
                <%}
			if (strSanctauth.equals("5") || strSanctauth.equals("6")
					|| strSanctauth.equals("7")) {%>
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
                <%}%>
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
      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
        <tr>
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td valign="top" colspan="4"><b>PRESENT REQUEST:Ad hoc Limit</b></td>
              </tr>
              <%presentrequest = (ArrayList)hshValues.get("presentrequest");
        if(presentrequest !=null && presentrequest.size()>0){ 
        for (int i = 0; i < presentrequest.size(); i++) {
        	requestcol = (ArrayList) presentrequest.get(i);
        	if(requestcol !=null && requestcol.size()>0){ 
        %>
              <tr> 
                <td width="20%">&nbsp;</td>
                <td width="13%"><b>NATURE OF LIMIT</b></td>
                <td  width="0%"><b>:</b></td>
                <td  width="67%"><%=Helper.correctNull((String)requestcol.get(0))%></td>
              </tr>
              <tr> 
                <td width="20%">&nbsp;</td>
                <td width="13%"><b>AMOUNT</b></td>
                <td  width="0%"><b>:</b></td>
                <td width="67%"> <%=ApplicationParams.getCurrency()%><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)requestcol.get(1))))%> 
                  <%=strProposalvalue%></td>
              </tr>
              <tr> 
                <td width="20%">&nbsp;</td>
                <td width="13%"> <b> PERIOD </b></td>
                <td width="0%"><b>: </b></td>
                <td width="67%"><%=Helper.correctNull((String)requestcol.get(2))%> 
                  Months </td>
              </tr>
              <tr> 
                <td width="20%">&nbsp;</td>
                <td width="13%"> <b> ROI/COMMISSION </b></td>
                <td width="0%"><b>:</b></td>
                <td width="67%"><%=Helper.correctNull((String)requestcol.get(3))%></td>
              </tr>
              <!--  <tr> 
          <td valign="top"><%//=Helper.formatTextAreaData((String) hshValues.get("exec_presentreq"))%></td>
        </tr> -->
              <%}}}%>
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
    <td> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr> 
            <td width="27%">GROUP</td>
            <td width="1%"><b>:</b></td>
            <td width="29%">&nbsp;<%=Helper.correctNull((String) hshValues.get("groupdesc"))%></td>
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td width="27%">BANKING ARRANGEMENT</td>
            <td width="1%"><b>:</b></td>
            <td width="29%">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("bankingtype"))%></td>
            <td width="21%">LEAD BANK</td>
            <td width="1%"><b>:</b></td>
            <%if (Helper.correctNull((String) hshValues.get("bankingtype"))
					.contains("Consortium")) {

				%>
            <td width="21%" colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
										.get("leadbank"))%></td>
            <%} else {%>
            <td width="21%" colspan="2">&nbsp;</td>
            <%}%>
          </tr>
          <!-- - -->
           <tr> 
            <%
	           if(Helper.correctNull((String) hshValues.get("bankingtype")).contains("Consortium")){
            %>
            <td width="27%">MONTH OF REVIEW</td>
            <td width="1%"><b>:</b></td>
            <td width="29%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("rev_duedate"))%></td>
            <td colspan="2"><b>OUR SHARE</b></td>
            <td><b>EXISTING</b></td>
            <td><b>PROPOSED</b></td>
            <%}else{ %>
            <td width="27%">MONTH OF REVIEW</td>
            <td width="1%"><b>:</b></td>
            <td colspan="5">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("rev_duedate"))%></td>
            <%} %>
          </tr>
          
           <%
	           if(Helper.correctNull((String) hshValues.get("bankingtype")).contains("Consortium")){
            %>
            <tr> 
            <td width="27%" rowspan="2">ASSET CLASSIFICATION</td>
            <td width="1%" rowspan="2"><b>:</b></td>
            <td width="29%" rowspan="2"><%=Helper.correctNull((String) hshValues
							.get("asset"))%></td>
            <td width="21%">Fund based</td>
            <td width="1%"><b>:</b></td>
            <td width="21%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String) hshValues
							.get("WC_SHARE_FE")))))%>&nbsp;%</td>
            <td width="21%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String) hshValues
							.get("WC_SHARE_FP")))))%>&nbsp;%</td>
          </tr>
          <tr> 
            <td width="21%">Non Fund based</td>
            <td width="1%"><b>:</b></td>
            <td width="21%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String) hshValues
							.get("WC_SHARE_NFE")))))%>&nbsp;%</td>
            <td width="21%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String) hshValues
							.get("WC_SHARE_NFP")))))%>&nbsp;%</td>
          </tr>
          <%}else{ %>
          <tr>
          <td>ASSET CLASSIFICATION</td>
            <td><b>:</b></td>
            <td colspan="5"><%=Helper.correctNull((String) hshValues
							.get("asset"))%></td>
			</tr>
          <%} %>
          <tr>
            <td width="27%" valign="top">INTERNAL CREDIT RATING</td>
            <td width="1%" valign="top"><b>:</b></td>
            <td width="29%"><%=Helper.correctNull((String) hshValues.get("int_rating"))%></td>
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td width="27%">EXTERNAL CREDIT RATING</td>
            <td width="1%"><b>:</b></td>
            <td colspan="5"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="38%">SHORT TERM</td>
                  <td colspan="3" width="62%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("ext_rating_short"))%></td>
                </tr>
                <tr> 
                  <td width="38%">LONG TERM</td>
                  <td colspan="3" width="62%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("ext_rating_long"))%></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="27%">STATUS OF ACCOUNT</td>
            <td width="1%"><b>:</b></td>
            <td width="29%"><%=Helper.correctNull((String) hshValues.get("accstatus"))%>&nbsp;</td>
            <td colspan="4">&nbsp;</td>
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
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%"><b>1.&nbsp;</b></td>
          <td width="43%"><b>NAME OF THE ACCOUNT</b></td>
          <td width="3%"><b><b>:</b></b></td>
          <td width="51%"><%=Helper.correctNull((String) hshValues
							.get("comapp_companyname"))%></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%"><b>1.1.&nbsp;</b></td>
          <td width="43%"><b>BRANCH / ZONE</b></td>
          <td width="3%"><b><b>:</b></b></td>
          <td width="51%"><%=Helper.correctNull((String) hshValues
							.get("appCreationBranch"))%></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" height="18"><b>2.&nbsp;</b></td>
          <td width="43%" height="18"><b>CONSTITUTION</b></td>
          <td width="3%" height="18"><b>:</b></td>
          <td width="51%" height="18"><%=Helper.correctNull((String) hshValues
									.get("strownership"))%> </td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%"><b>2.1.&nbsp;</b></td>
          <td width="43%"><b>DATE OF INCORPORATION</b></td>
          <td width="3%"><b><b>:</b></b></td>
          <td width="51%"><%=Helper.correctNull((String) hshValues
							.get("comapp_yrsinbusiness"))%></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top"><b>3.&nbsp;</b></td>
          <td width="43%" valign="top"><b>LINE OF ACTIVITY</b></td>
          <td width="3%" valign="top"><b><b>:</b></b></td>
          <td width="51%"><%=Helper.formatTextAreaData((String) hshValues
							.get("comapp_businessnature"))%>&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%"><b>4.&nbsp;</b></td>
          <td width="43%"><b> ADDRESS</b></td>
          <td width="3%">&nbsp;</td>
          <td width="51%">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top"><b>4.1.&nbsp;</b></td>
          <td width="43%" valign="top"><b>Regd./Admn.Office</b></td>
          <td width="3%" valign="top"><b><b>:</b></b></td>
          <td width="51%"><%=Helper.correctNull((String) hshValues
							.get("comapp_regadd1"))%>-<%=Helper.correctNull((String) hshValues
							.get("comapp_regadd2"))%><br>
            <%=Helper.correctNull((String) hshValues
									.get("Regcity_name"))%> <br>
            <%=Helper.correctNull((String) hshValues
							.get("Regstate_name"))%> <br>
            Pin:<%=Helper.correctNull((String) hshValues
							.get("comapp_regpin"))%><br>
          </td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
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
          <td valign="top" colspan="3">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>5.&nbsp;</b></td>
          <td valign="top" width="97%"><b>PRESENT POSITION OF THE ACCOUNT :</b></td>
        </tr>
        <tr> 
          <td valign="top" align="right" colspan="2"><b>(<%=ApplicationParams.getCurrency()%> 
            In <%=strProposalvalue%>)</b></td>
        </tr>
        <tr> 
          <td valign="top" width="3%">&nbsp;</td>
          <td align="right" valign="top" colspan="3" width="97%"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td align="center" width="27%"><b> Nature of Facility</b></td>
                  <td align="center" width="13%"><b> Amount</b></td>
                  <!-- <td align="center"><b> Limits Recommended</b></td>
						<td align="center"><b> D.P.</b></td> -->
                  <td align="center" width="18%"><b> O/S as On &nbsp; <%=Helper.correctNull((String) hshValues
							.get("detailsasondate"))%></b></td>
                  <td align="center" width="21%"><b> Value of Securities </b></td>
                  <td align="center" width="21%"><b> Over dues, if any</b></td>
                </tr>
                <tr> 
                  <td align="left" colspan="5"><b>A]FUND BASED LIMITS</b></td>
                </tr>
                <%String chkCategory = "", chkCategory1 = "";
			ArrayList OurBank_WC_Funded = new ArrayList();
			ArrayList WC_Funded = new ArrayList();
			int arrWC_Funded_Size = 0;
			OurBank_WC_Funded = (ArrayList) hshValues.get("OurBank_WC_Funded");
			if (OurBank_WC_Funded != null) {
				arrWC_Funded_Size = OurBank_WC_Funded.size();
			}
			for (int i = 0; i < arrWC_Funded_Size; i++) {
				WC_Funded = (ArrayList) OurBank_WC_Funded.get(i);
				if (Helper.correctNull((String) WC_Funded.get(12))
						.equalsIgnoreCase("A"))
					chkCategory = "<br> Adhoc Limit for "
							+ Helper.correctNull((String) WC_Funded.get(13))
							+ " Month";
				else
					chkCategory = "";

				%>
                <tr> 
                  <td align="left" width="27%">&nbsp;<%=Helper.correctNull((String) WC_Funded.get(0))%><%=chkCategory%></td>
                  <td align="right" width="13%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(2))))%></td>
                  <!--  <td align="right">&nbsp;<%//=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(2))))%></td>
						<td align="right">&nbsp;<%//=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(5))))%></td>-->
                  <td align="right" width="18%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(6))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(7))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.correctNull((String) WC_Funded.get(8))%></td>
                </tr>
                <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_Funded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);
						if (Helper.correctNull(
								(String) arrSubFacRecords.get(11))
								.equalsIgnoreCase("A"))
							chkCategory = "<br> Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month";
						else
							chkCategory = "";

						%>
                <%if (j == 0) {%>
                <tr> 
                  <td colspan="5">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
                </tr>
                <%}%>
                <tr> 
                  <td align="left" width="27%">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%><%=chkCategory%></td>
                  <td align="right" width="13%">&nbsp;(<%=Helper.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
                  <!--  <td align="right">&nbsp;(<%//=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))%>)</td>
						<td align="right">&nbsp;<%//=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(5))))%></td>-->
                  <td align="right" width="18%">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(6))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(7))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(8))%></td>
                </tr>
                <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
                <tr> 
                  <td align="right" width="27%"><b>Sub-total [A]</b></td>
                  <td align="right" width="13%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_funded_proposed"))))%></td>
                  <!--<td align="right">&nbsp;<%//=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_funded_proposed"))))%></td>
						<td align="center">&nbsp;</td>-->
                  <td align="center" width="18%">&nbsp;</td>
                  <td align="center" width="21%">&nbsp;</td>
                  <td align="center" width="21%">&nbsp;</td>
                </tr>
                <tr> 
                  <td align="left" colspan="5"><b>B] NONFUND BASED LIMITS</b></td>
                </tr>
                <%ArrayList OurBank_WC_NonFunded = new ArrayList();
			ArrayList WC_NonFunded = new ArrayList();
			int arrWC_NonFunded_Size = 0;

			OurBank_WC_NonFunded = (ArrayList) hshValues
					.get("OurBank_WC_NonFunded");

			if (OurBank_WC_NonFunded != null) {
				arrWC_NonFunded_Size = OurBank_WC_NonFunded.size();
			}

			for (int i = 0; i < arrWC_NonFunded_Size; i++) {
				WC_NonFunded = (ArrayList) OurBank_WC_NonFunded.get(i);

				if (Helper.correctNull((String) WC_NonFunded.get(12))
						.equalsIgnoreCase("A"))
					chkCategory = "<br> Adhoc Limit for "
							+ Helper.correctNull((String) WC_NonFunded.get(13))
							+ " Month";
				else
					chkCategory = "";

				%>
                <tr> 
                  <td align="left" width="27%">&nbsp;<%=Helper.correctNull((String) WC_NonFunded
										.get(0))%><%=chkCategory%></td>
                  <td align="right" width="13%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(2))))%></td>
                  <!--<td align="right">&nbsp;<%//=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(2))))%></td>
						<td align="right">&nbsp;<%//=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(5))))%></td>-->
                  <td align="right" width="18%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(6))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(7))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.correctNull((String) WC_NonFunded
										.get(8))%></td>
                </tr>
                <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_NonFunded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						if (Helper.correctNull(
								(String) arrSubFacRecords.get(11))
								.equalsIgnoreCase("A"))
							chkCategory = "<br> Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month";
						else
							chkCategory = "";

						%>
                <%if (j == 0) {%>
                <tr> 
                  <td colspan="5">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
                </tr>
                <%}%>
                <tr> 
                  <td align="left" width="27%">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%><%=chkCategory%></td>
                  <td align="right" width="13%">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
                  <!--<td align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))%>)</td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(5))))%></td>-->
                  <td align="right" width="18%">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(6))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(7))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(8))%></td>
                </tr>
                <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
                <tr> 
                  <td align="right" width="27%"><b>Sub-total [B]</b></td>
                  <td align="right" width="13%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_proposed"))))%></td>
                  <%--  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_proposed"))))%></td>
						<td align="center">&nbsp;</td>--%>
                  <td align="center" width="18%">&nbsp;</td>
                  <td align="center" width="21%">&nbsp;</td>
                  <td align="center" width="21%">&nbsp;</td>
                </tr>
                <tr> 
                  <td align="left" colspan="5"><b>C] TERM LOAN</b></td>
                </tr>
                <%ArrayList OurBank_TL = new ArrayList();
			ArrayList TL_Funded_NonFunded = new ArrayList();
			int arrTL_Funded_NonFunded_Size = 0;

			OurBank_TL = (ArrayList) hshValues.get("OurBank_TL");

			if (OurBank_TL != null) {
				arrTL_Funded_NonFunded_Size = OurBank_TL.size();
			}

			for (int i = 0; i < arrTL_Funded_NonFunded_Size; i++) {
				TL_Funded_NonFunded = (ArrayList) OurBank_TL.get(i);
				if (Helper.correctNull((String) TL_Funded_NonFunded.get(12))
						.equalsIgnoreCase("A"))
					chkCategory = "<br> Adhoc Limit for "
							+ Helper.correctNull((String) TL_Funded_NonFunded
									.get(13)) + " Month";
				else
					chkCategory = "";

				%>
                <tr> 
                  <td align="left" width="27%">&nbsp;<%=Helper.correctNull((String) TL_Funded_NonFunded
								.get(0))%><%=chkCategory%></td>
                  <td align="right" width="13%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(2))))%></td>
                  <%--<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(2))))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(5))))%></td>--%>
                  <td align="right" width="18%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(6))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(7))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.correctNull((String) TL_Funded_NonFunded
								.get(8))%></td>
                </tr>
                <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);
						if (Helper.correctNull(
								(String) arrSubFacRecords.get(11))
								.equalsIgnoreCase("A"))
							chkCategory = "<br> Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month";
						else
							chkCategory = "";

						%>
                <%if (j == 0) {%>
                <tr> 
                  <td colspan="5">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
                </tr>
                <%}%>
                <tr> 
                  <td align="left" width="27%">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%><%=chkCategory%></td>
                  <td align="right" width="13%">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
                  <%--  <td align="right">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
						<td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(5))))%></td>--%>
                  <td align="right" width="18%">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(6))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(7))))%></td>
                  <td align="right" width="21%">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(8))%></td>
                </tr>
                <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
                <tr> 
                  <td align="right" width="22%"><b>Sub-total [C]</b></td>
                  <td align="right" width="13%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tl_total_proposed"))))%></td>
                  <%-- <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tl_total_proposed"))))%></td>
						<td align="center">&nbsp;</td> --%>
                  <td align="center" width="18%">&nbsp;</td>
                  <td align="center" width="21%">&nbsp;</td>
                  <td align="center" width="26%">&nbsp;</td>
                </tr>
                <tr> 
                  <td align="center" width="22%"><b>TOTAL [A+B+C]</b></td>
                  <td align="right" width="13%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("total_proposed"))))%></td>
                  <%--  <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("total_proposed"))))%></td>
						<td align="center">&nbsp;</td>--%>
                  <td align="center" width="18%">&nbsp;</td>
                  <td align="center" width="21%">&nbsp;</td>
                  <td align="center" width="26%">&nbsp;</td>
                </tr>
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
          <td valign="top" width="3%"><b>6.1</b></td>
          <td valign="top" width="97%"><b>NATURE AND VALUE OF COLLATERAL SECURITY 
            :</b></td>
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
                  <td width="32%"><b>Nature / Description of collateral security 
                    indicating area &amp; location of property</b></td>
                  <td width="12%"><b>Value</b></td>
                  <td width="19%"><b>Date of Valuation along with name of Valuer</b></td>
                  <td width="21%"><b>Insurance Amount &amp; Date of Expiry</b></td>
                  <td width="17%"><b>Remarks</b></td>
                </tr>
                <%ArrayList arrColldetails = new ArrayList();
			ArrayList arrValues = new ArrayList();
			arrColldetails = (ArrayList) hshValues.get("arrColldetails");
			double dbltotal=0.00;
			if (arrColldetails != null && arrColldetails.size() != 0) {
				for (int i = 0; i < arrColldetails.size(); i++) {
					arrValues = (ArrayList) arrColldetails.get(i);
					dbltotal = dbltotal+Double.parseDouble(Helper.correctDouble((String) arrValues.get(1)));
					%>
                <tr valign="top"> 
                  <td width="32%"><%=Helper.formatTextAreaData((String) arrValues
									.get(0))%> &nbsp;</td>
                  <td width="12%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrValues
													.get(1))))%></td>
                  <td width="19%">&nbsp;<%=Helper.correctNull((String) arrValues.get(2))%> 
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
                  <td width="17%" class="just">&nbsp;<%=Helper.formatTextAreaData((String) arrValues
									.get(6))%></td>
                </tr>
                <%}%>
                <tr> 
                  <td><b>Total</b></td>
                  <td align="right"><%=Helper.formatDoubleValue(dbltotal)%></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <%} else {%>
                <tr> 
                  <td width="32%">&nbsp;</td>
                  <td width="12%">&nbsp;</td>
                  <td width="19%">&nbsp;</td>
                  <td width="21%">&nbsp;</td>
                  <td width="17%">&nbsp;</td>
                </tr>
                <%}%>
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
    <td valign="top">&nbsp;</td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top" width="3%"><b>6.2</b></td>
    <td valign="top"><b>PERSONAL/CORPORATE GUARANTEE :</b></td>
  </tr>
  <tr> 
    <td valign="top" width="3%">&nbsp;</td>
    <td valign="top" colspan="2"> 
      <div id="top"> 
        <table width="50%" border="0" cellspacing="0" cellpadding="3">
          <%boolean bolguarantee = false;
          boolean corpguarantee = false;
                ArrayList arrRow = new ArrayList();
                ArrayList arrData = new ArrayList();

			arrRow = (ArrayList) hshValues.get("arrGuarantors");

			if (arrRow != null && arrRow.size() != 0) 
			{
				bolguarantee = true;

				%>
          <tr align="center" class="tblhead "> 
            <td align="center"><b>Name</b></td>
            <td align="center"><b>Means (<%=ApplicationParams.getCurrency()%> 
              In <%=strProposalvalue%>)</b></td>
              <td align="center"><b>Means As on</b></td>
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
				if (Helper.correctNull((String) hshValues.get("sel_applicantguarantee")).equalsIgnoreCase("Y")) 
				{
					if (!bolguarantee) 
					{
						bolguarantee = true;%>
          <tr align="center" class="tblhead "> 
           <td align="center"><b>Name</b></td>
            <td align="center"><b>Means (<%=ApplicationParams.getCurrency()%> 
              In <%=strProposalvalue%>)</b></td>
              <td align="center"><b>Means As on</b></td>
          </tr>
          <%}%>
            <%if(!corpguarantee){
                	corpguarantee=true;%>
               
          <tr align="center"> 
            <td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
          </tr>
          <%} %>
          <tr align="center"> 
            <td width="50%" align="left"><%=Helper.correctNull((String) hshValues.get("comapp_companyname"))%>&nbsp;</td>
            <td width="50%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("means"))))%>&nbsp;</td>
            <td align="left"><%=Helper.correctNull((String) hshValues.get("meansason"))%></td>
          </tr>
          <% } 
				 %>
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
            <td align="center"><b>Means (<%=ApplicationParams.getCurrency()%> 
              In <%=strProposalvalue%>)</b></td>
              <td align="center"><b>Means As on</b></td>
          </tr>
          <%}%>
            <%if(!corpguarantee){
                	corpguarantee=true;%>
          <tr align="center"> 
            <td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
          </tr>
          <%} %>
          <%for (int i = 0; i < arrRow.size(); i++) 
                {
					arrData = (ArrayList) arrRow.get(i);
				%>
          <tr align="center"> 
            <td width="50%" align="left"><%=Helper.correctNull((String) arrData.get(0))%>&nbsp;</td>
            <td width="50%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrData.get(4))))%>&nbsp;</td>
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
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top">&nbsp;</td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td width="3%"><b>7.&nbsp;</b></td>
    <td><b>BRIEF FINANCIALS :</b></td>
  </tr>
  <%ArrayList arr = null;
			int arrsize = 0;

			if (hshValues != null) {
				arr = (ArrayList) hshValues.get("arrValFin");
			}
			if (arr != null) {
				arrsize = arr.size();
			}

			ArrayList g1 = null;

			for (int l = 0; l < 23; l++) {
				int arrSize = 0;
				if (l < arrsize) {
					g1 = (ArrayList) arr.get(l);

					if (g1 != null) {
						arrSize = g1.size();
					}
				}

				if (arrSize > 0) {
					if (l == 0) {

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
          <%} else if (l == 1) {

						%>
          <tr> 
            <td>&nbsp;</td>
            <td align="center"><%=Helper.correctNull((String) g1.get(0))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(1))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(2))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(3))%></td>
          </tr>
          <%} else {

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
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top" width="3%"><b>7.1</b></td>
    <td valign="top"><b>COMMENTS ON PERFORMANCE OF THE COMPANY DURING CURRENT 
      YEAR </b></td>
  </tr>
  <tr> 
    <td valign="top" width="3%">&nbsp;</td>
    <td><%=Helper.correctEditor((String) hshValues
							.get("comments"))%></td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top" width="3%"><b>8.</b></td>
    <td valign="top"><b>VALUE OF ACCOUNT:</b></td>
  </tr>
  <tr> 
    <td valign="top" width="3%">&nbsp;</td>
    <td><%=Helper.correctEditor((String) hshValues
							.get("valueaccount"))%></td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top">&nbsp;</td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top" width="3%"><b>9.</b></td>
    <td valign="top"><b>PRESENT REQUEST:</b></td>
  </tr>
  <tr> 
    <td valign="top" width="3%">&nbsp;</td>
    <td class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_presentreq"))%></td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top">&nbsp;</td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top" width="3%"><b>10.</b></td>
    <td valign="top"><b>COMMENTS ON LIMIT SOUGHT:</b></td>
  </tr>
  <tr> 
    <td valign="top" width="3%">&nbsp;</td>
    <td><%=Helper.correctEditor((String) hshValues
							.get("limit_comment"))%></td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top">&nbsp;</td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top" width="3%" nowrap="nowrap"><b>11.</b></td>
    <td valign="top"><b>DELEGATED AUTHORITY:</b></td>
  </tr>
  <tr> 
    <td valign="top" width="3%">&nbsp;</td>
    <td class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_delegated"))%></td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0"
	align="center">
  <tr> 
    <td valign="top" colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top" width="3%"><b>12.&nbsp;</b></td>
    <td valign="top" colspan="4" width="97%"><b>RECOMMENDATIONS</b></td>
  </tr>
  <tr> 
    <td valign="top"  colspan="5">In view of the above, we recommend for sanction 
      of ad hic limit in favour of the company as under:</td>
  </tr>
  <tr> 
    <td valign="top" align="right" colspan="5"><b>(<%=ApplicationParams.getCurrency()%>In 
      <%=strProposalvalue%>)</b></td>
  </tr>
  <tr> 
    <td valign="top" rowspan="4" width="3%">&nbsp;</td>
    <td valign="top" colspan="4" width="97%"> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr class="tblhead" align="center"> 
            <td >Nature of Limit</td>
            <td >Amount</td>
            <td >Margin (%)</td>
            <td >Int./ Comm.</td>
            <td >Security</td>
          </tr>
            <!--  <tr class="tblhead"> 
            <td align="center">Existing</td>
            <td align="center">Proposed</td>
          </tr>
        <tr>
				<td colspan="6"><b>A] NON-FUND BASED LIMITS</b></td>
			</tr>-->
			
			
			<%
			OurBank_WC_NonFunded = new ArrayList();
			WC_NonFunded = new ArrayList();
			arrWC_NonFunded_Size = 0;
			ArrayList arrCol = new ArrayList();
			OurBank_WC_NonFunded = (ArrayList) hshValues.get("OurBank_WC_NonFunded_sec");
			double existing =0;
			double total_proposed_sec=0;
			String chkCategory_sub="";
			if (OurBank_WC_NonFunded != null) 
			{
				arrWC_NonFunded_Size = OurBank_WC_NonFunded.size();
			}

			for (int i = 0; i < arrWC_NonFunded_Size; i++) 
			{
				WC_NonFunded = (ArrayList) OurBank_WC_NonFunded.get(i);
				chkCategory = Helper.correctNull((String) WC_NonFunded.get(12));
				existing = Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(1)));
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_NonFunded.get(9);
			
				if (arrSubFac != null && arrSubFac.size() > 0) 
				{
					for (int j = 0; j < arrSubFac.size(); j++) 
					{
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);
						chkCategory_sub = Helper.correctNull((String) arrSubFacRecords.get(11));
					}
				}
				
				if ((chkCategory.equals("A")&& existing==0)||(chkCategory_sub.equals("A")))
				{
					
				if(chkCategory.equals("A"))
				{
					chkCategory1 = "<br>(Adhoc Limit for " + Helper.correctNull((String) WC_NonFunded.get(13))+ " Month ) ";
				}
				else 
				{
					chkCategory1 = "";
				}
				int introwspan = Integer.parseInt(Helper.correctInt((String) WC_NonFunded.get(16)));

				%>
				
				
			<tr>
				<td align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) WC_NonFunded.get(0))%> <%=chkCategory1%></b></td>
				<%--<td align="right" valign="top" rowspan="<%=introwspan%>">&nbsp;
				<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(1))))%></td>--%>
				<td align="right" valign="top" rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(2))))%></td>
				<%total_proposed_sec =Double.parseDouble(Helper.correctDouble((String) WC_NonFunded.get(2)));%>
				
				<%ArrayList arrSecurities = new ArrayList();
				ArrayList arrRemarkrow = new ArrayList();
				ArrayList arrRemarkcol;
				arrSecurities = (ArrayList) WC_NonFunded.get(15);
				arrRemarkrow = (ArrayList) WC_NonFunded.get(17);
				if (arrSecurities != null && arrSecurities.size() > 0)
				{
					for (int j = 0; j < arrSecurities.size(); j++) {
						arrCol = new ArrayList();
						String strBorder = "";
						arrCol = (ArrayList) arrSecurities.get(j);
						arrRemarkcol= (ArrayList) arrRemarkrow.get(j);
						arrtotRemark.add(arrRemarkcol);
						if ((introwspan - 1) == j && j != 0) 
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
						}
						if (j == 0) 
						{
							%>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="8%" align="right" valign="top" rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_NonFunded.get(4))%>&nbsp;</td>
				<td width="31%" align="left" valign="top" <%=strBorder%> class="just"><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<%} else {%>
			</tr>
			
			<tr>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="31%" valign="top" align="left" <%=strBorder%>><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<%}
					}
				} else {%>
				<td valign="top">&nbsp;</td>
				<td width="8%" align="right" valign="top" rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_NonFunded.get(4))%>&nbsp;</td>
				<td width="31%" valign="top" align="left">&nbsp;</td>
				<%}%>
				
								
                     
			</tr>
			
			<%//For the Sub-limits, under each one
				
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
							chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) arrSubFacRecords.get(12)) + " Month) ";
						} 
						else 
						{
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper.correctInt((String) arrSubFacRecords.get(15)));

						%>
						<%if (j == 0) {%>
						
			<tr>
				<td colspan="5">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
			</tr>
			
			<%}%>
			
			<tr>
				<td align="left" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;
					 <%=Helper.correctNull((String) arrSubFacRecords.get(0))%><%=chkCategory1%></td>
				<%-- %><td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;
					 (<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))%>)</td>--%>
				<td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;
					 (<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))%>)</td>
					 
				<%
					ArrayList arrsubSecurities = new ArrayList();
					arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
					if (arrSecurities != null && arrsubSecurities.size() > 0) 
					 {
					 	for (int k = 0; k < arrsubSecurities.size(); k++) 
					 	{
								arrCol = new ArrayList();
								String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								if ((intsubrowspan - 1) == k) 
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
								}
								if (k == 0) 
								{
				%>
				
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;
				  	<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="8%" align="right" valign="top" rowspan="<%=intsubrowspan%>">
					<%=Helper.correctNull((String) arrSubFacRecords.get(4))%>&nbsp;</td>
				<td width="31%" align="left" valign="top" <%=strBorder%>>
					<%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<%} else {%>
			</tr>
			
			<tr>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="31%" align="left" valign="top" <%=strBorder%>>
					<%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<%}
							}
						} else {%>
				<td valign="top">&nbsp;</td>
				<td width="8%" align="right" valign="top">
					<%=Helper.correctNull((String) arrSubFacRecords.get(4))%>&nbsp;</td>
				<td width="31%" align="left" valign="top">&nbsp;</td>
				<%}
					%>
			</tr>
			
			<%}
				}
				//End of 'Sub-Facilities' details               
			}}
			%>
			
			<%--  <tr>
				<td width="27%" align="left"><b> Sub- Total [A]</b></td>
				<td width="13%" align="right">&nbsp;
					 <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_nonfunded_existing"))))%></td>
				<td width="13%" align="right">&nbsp;
				 	 <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_nonfunded_proposed"))))%></td>
				<td width="8%">&nbsp;</td>
				<td width="8%">&nbsp;</td>
				<td width="31%">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="6"><b>B] FUND BASED LIMITS</b></td>
			</tr>--%>

				<%OurBank_WC_Funded = new ArrayList();
				WC_Funded = new ArrayList();
				arrWC_Funded_Size = 0;
				OurBank_WC_Funded = (ArrayList) hshValues.get("OurBank_WC_Funded_sec");
				if (OurBank_WC_Funded != null) 
				{
					arrWC_Funded_Size = OurBank_WC_Funded.size();
				}
				for (int i = 0; i < arrWC_Funded_Size; i++) 
				{
					WC_Funded = (ArrayList) OurBank_WC_Funded.get(i);
					chkCategory = Helper.correctNull((String) WC_Funded.get(12));
					existing = Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(1)));
					arrSubFac = new ArrayList();
					arrSubFac = (ArrayList) WC_Funded.get(9);
					chkCategory_sub="";
				if (arrSubFac != null && arrSubFac.size() > 0) 
				{
					for (int j = 0; j < arrSubFac.size(); j++) 
					{
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);
						chkCategory_sub = Helper.correctNull((String) arrSubFacRecords.get(11));
					}
				}
				
				if ((chkCategory.equals("A")&& existing==0)||(chkCategory_sub.equals("A")))
				{
					
					if (chkCategory.equals("A")) 
					{
						chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) WC_Funded.get(13))+ " Month ) ";
					}
					else
					{
						chkCategory1 = "";
					}
						int introwspan = Integer.parseInt(Helper.correctInt((String) WC_Funded.get(16)));
				%>
			<tr>
				<td width="27%" align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<b>
					<%=Helper.correctNull((String) WC_Funded.get(0))%><%=chkCategory1%></b></td>
				<%--<td width="13%" align="right" valign="top" rowspan="<%=introwspan%>">&nbsp;
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(1))))%></td>--%>
				<td width="13%" align="right" valign="top" rowspan="<%=introwspan%>">&nbsp;
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(2))))%></td>
					<%total_proposed_sec =total_proposed_sec + Double.parseDouble(Helper.correctDouble((String) WC_Funded.get(2)));%>
					<%ArrayList arrSecurities = new ArrayList();
					ArrayList arrRemarkrow = new ArrayList();
					ArrayList arrRemarkcol;
					arrSecurities = (ArrayList) WC_Funded.get(15);
					arrRemarkrow = (ArrayList) WC_Funded.get(17);
					if (arrSecurities != null && arrSecurities.size() > 0) 
					{
						for (int j = 0; j < arrSecurities.size(); j++) 
						{
							arrCol = new ArrayList();
							String strBorder = "";
							arrCol = (ArrayList) arrSecurities.get(j);
							arrRemarkcol= (ArrayList) arrRemarkrow.get(j);
							arrtotRemark.add(arrRemarkcol);
							if ((introwspan - 1) == j && j != 0) 
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
							}
							if (j == 0) {
					%>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;
					 <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="8%" align="right" valign="top" rowspan="<%=introwspan%>">
					<%=Helper.correctNull((String) WC_Funded.get(4))%>&nbsp;</td>
				<td width="31%" align="left" <%=strBorder%>>
					<%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<%} else {%>
			</tr>
			
			<tr>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp; 
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="31%" align="left" <%=strBorder%>>
					<%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<%}
					}
				} else {%>
				<td>&nbsp;</td>
				<td width="8%" align="right" valign="top">
					<%=Helper.correctNull((String) WC_Funded.get(4))%>&nbsp;</td>
				<td width="31%" align="left">&nbsp;</td>
				<%}
				%>
			</tr>
			
			
			<%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_Funded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) 
				{
					for (int j = 0; j < subFacSize; j++) 
					{
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);
						ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);

						chkCategory = Helper.correctNull((String) arrSubFacRecords.get(11));
						if (chkCategory.equals("A"))
						{
							chkCategory1 = "<br>(Adhoc Limit for " + Helper.correctNull((String) arrSubFacRecords.get(12)) + " Month )";
						} 
						else 
						{
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper.correctInt((String) arrSubFacRecords.get(15)));

			%>
			<%if (j == 0) {%>
			
			<tr>
				<td colspan="5">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
			</tr>
			<%}%>
			
			<tr>
				<td align="left" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;
					 <%=Helper.correctNull((String) arrSubFacRecords.get(0))%><%=chkCategory1%></td>
				<%-- %><td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;
					 (<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(1))))%>)</td>--%>
				<td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;
					 (<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacRecords.get(2))))%>)</td>
				<%arrsubSecurities = new ArrayList();
 				  arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
				  if (arrSecurities != null	&& arrsubSecurities.size() > 0) 
				  {
					for (int k = 0; k < arrsubSecurities.size(); k++) 
					{
						arrCol = new ArrayList();
						String strBorder = "";
						arrCol = (ArrayList) arrsubSecurities.get(k);
							if ((intsubrowspan - 1) == k) {
									strBorder = "style=\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "style=\"border-bottom-width:0\";";
								} else {
									strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								}
								if (k == 0) {

									%>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp; 
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="8%" align="right" valign="top" rowspan="<%=intsubrowspan%>">
				    <%=Helper.correctNull((String) arrSubFacRecords.get(4))%>&nbsp;</td>
				<td width="31%" align="left" valign="top" <%=strBorder%>>
					<%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<%} else {%>
			</tr>
			
			<tr>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="31%" align="left" valign="top" <%=strBorder%>>
					<%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<%}
							}
						} else {%>
				<td valign="top">&nbsp;</td>
				<td width="8%" align="right" valign="top">
					<%=Helper.correctNull((String) arrSubFacRecords.get(4))%>&nbsp;</td>
				<td width="31%" align="left" valign="top">&nbsp;</td>
				<%}
					%>
			</tr>
			
			<%}
				}
				//End of 'Sub-Facilities' details               
			}}
			%>
			
			<%--<tr>
				<td width="27%" align="left"><b>Sub- Total [B]</b></td>
				<td width="13%" align="right">&nbsp;
					 <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_funded_existing"))))%></td>
				<td width="13%" align="right">&nbsp;
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("wc_funded_proposed"))))%></td>
				<td width="8%">&nbsp;</td>
				<td width="8%">&nbsp;</td>
				<td width="31%">&nbsp;</td>
			</tr>

			<tr>
				<td colspan="6"><b>C] TERM LOAN </b></td>
			</tr>--%>
			
			<%	
				OurBank_TL = new ArrayList();
				TL_Funded_NonFunded = new ArrayList();
				arrTL_Funded_NonFunded_Size = 0;
				OurBank_TL = (ArrayList) hshValues.get("OurBank_TL_sec");
	
				if (OurBank_TL != null) 
				{
					arrTL_Funded_NonFunded_Size = OurBank_TL.size();
				}

				for (int i = 0; i < arrTL_Funded_NonFunded_Size; i++) 
				{
					TL_Funded_NonFunded = (ArrayList) OurBank_TL.get(i);
					chkCategory = Helper.correctNull((String) TL_Funded_NonFunded.get(12));
					
					existing = Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(1)));
					arrSubFac = new ArrayList();
					arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
					chkCategory_sub="";
						if (arrSubFac != null && arrSubFac.size() > 0) 
						{
							for (int j = 0; j < arrSubFac.size(); j++) 
							{
								arrSubFacRecords = new ArrayList();
								arrSubFacRecords = (ArrayList) arrSubFac.get(j);
								chkCategory_sub = Helper.correctNull((String) arrSubFacRecords.get(11));
							}
						}
				
				if ((chkCategory.equals("A")&& existing==0)||(chkCategory_sub.equals("A")))
				{
					
					
					if (chkCategory.equals("A"))
					{
						chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) TL_Funded_NonFunded.get(13)) + " Month )";
					} 
					else 
					{
						chkCategory1 = "";
					}
					int introwspan = Integer.parseInt(Helper.correctInt((String) TL_Funded_NonFunded.get(16)));
				%>
				
			<tr>
				<td width="27%" align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<b>
					<%=Helper.correctNull((String) TL_Funded_NonFunded.get(0))%> <%=chkCategory1%><b></b></b></td>
				<%--<td width="13%" align="right" valign="top" rowspan="<%=introwspan%>">&nbsp;
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(1))))%></td>--%>
				<td width="13%" align="right" valign="top" rowspan="<%=introwspan%>">&nbsp;
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(2))))%></td>
					<%total_proposed_sec =total_proposed_sec + Double.parseDouble(Helper.correctDouble((String) TL_Funded_NonFunded.get(2)));%>
					<%ArrayList arrSecurities = new ArrayList();
					ArrayList arrRemarkrow = new ArrayList();
					ArrayList arrRemarkcol;
					arrSecurities = (ArrayList) TL_Funded_NonFunded.get(15);
					arrRemarkrow = (ArrayList) TL_Funded_NonFunded.get(17);
					if (arrSecurities != null && arrSecurities.size() > 0) 
					{
						for (int j = 0; j < arrSecurities.size(); j++) 
						{
							arrCol = new ArrayList();
							String strBorder = "";
							arrCol = (ArrayList) arrSecurities.get(j);
							arrRemarkcol= (ArrayList) arrRemarkrow.get(j);
							arrtotRemark.add(arrRemarkcol);
							if ((introwspan - 1) == j && j != 0) 
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
							}
							if (j == 0) 
							{
				%>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;
					<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))%></td>
				<td width="8%" align="right" valign="top" rowspan="<%=introwspan%>">
					<%=Helper							.correctNull((String) TL_Funded_NonFunded
															.get(4))%>&nbsp;</td>
				<td width="31%" align="left" <%=strBorder%>><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
				<%} else {%>
			</tr>
			<tr>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
				<td width="31%" align="left" <%=strBorder%>><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
				<%}
					}
				} else {%>
				<td>&nbsp;</td>
				<td width="8%" align="right" valign="top"><%=Helper.correctNull((String) TL_Funded_NonFunded
									.get(4))%>&nbsp;</td>
				<td width="31%" align="left">&nbsp;</td>
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
				<td colspan="5">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
			</tr>
			<%}%>
			
			<tr>
				<td align="left" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%> <%=chkCategory1%></td>
				<%-- %><td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>--%>
				<td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
				<%ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
						if (arrSecurities != null
								&& arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								arrCol = new ArrayList();
								String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								if ((intsubrowspan - 1) == k) {
									strBorder = "style=\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "style=\"border-bottom-width:0\";";
								} else {
									strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								}
								if (k == 0) {

									%>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
				<td width="8%" align="right" valign="top"
					rowspan="<%=intsubrowspan%>"><%=Helper
															.correctNull((String) arrSubFacRecords
																	.get(4))%>&nbsp;</td>
				<td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
				<%} else {%>

			</tr>
			<tr>
				<td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
				<td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
				<%}
							}
						} else {%>
				<td valign="top">&nbsp;</td>
				<td width="8%" align="right" valign="top"><%=Helper
													.correctNull((String) arrSubFacRecords
															.get(4))%>&nbsp;</td>
				<td width="31%" align="left" valign="top">&nbsp;</td>
				<%}

					%>
			</tr>
			<%}
				}
				//End of 'Sub-Facilities' details               
			}}

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
				<%-- %><td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("total_existing"))))%></td>--%>
				<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(total_proposed_sec)%></td>
				<td width="8%">&nbsp;</td>
				<td width="8%">&nbsp;</td>
				<td width="31%">&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>

  <%
                   // arrRow=new ArrayList();
                    arrData=new ArrayList();
                   // arrRow=(ArrayList)hshValues.get("arrSecRemarks");
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

				<td valign="top" width="3%"><b>13.&nbsp;</b></td>

				<td valign="top" width="97%"><b>TERMS AND CONDITIONS:</b></td>
			</tr>
			<%arrrow = null;
			arrcol = null;
			arrrow = (ArrayList) hshValues.get("arrtermcond");
			if (arrrow != null && arrrow.size() != 0) {
				for (int i = 0; i < arrrow.size(); i++) {
					arrcol = (ArrayList) arrrow.get(i);

					%>
			<tr>

				<td valign="top" width="3%">&nbsp;</td>
				<td valign="top" class="just" width="97%"><%=i + 1%>. <%=Helper.formatTextAreaData((String) arrcol
											.get(0))%>&nbsp;</td>
			</tr>
			<%}
			}%>
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

        <!-- </table>
      </div>
</table> -->
