<%@page import="com.sai.laps.helper.*,java.util.ArrayList,java.util.StringTokenizer"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strOrgName" class="java.lang.String" scope="session" />

<%

ArrayList arrComRowList = null;
ArrayList arrComColList = null;

ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();

arrRow = ((ArrayList)hshValues.get("arrRow"));

String[] strIncurred1= new String[23];
String[] strIncurred2= new String[23];
String[] strIncurred3= new String[23];
String[] strIncurred4= new String[23];

for(int i=0;i<strIncurred1.length;i++)
{
	strIncurred1[i]="";
	strIncurred2[i]="";
	strIncurred3[i]="";
	strIncurred4[i]="";
	
}

if(arrRow!=null)
{
	for(int i =0;i<arrRow.size();i++)
	{	
		arrCol = (ArrayList) arrRow.get(i);
		
		strIncurred1[i] = Helper.correctNull((String)arrCol.get(0));
		strIncurred2[i] = Helper.correctNull((String)arrCol.get(1));
		strIncurred3[i] = Helper.correctNull((String)arrCol.get(2));
		strIncurred4[i] = Helper.correctNull((String)arrCol.get(3));
	}	
}

String valuesin = Helper.correctNull((String) hshValues
		.get("valuesin"));
String strValuesin="";
if(valuesin.equalsIgnoreCase("C"))
{
	valuesin = "Rs. In Crores";
	strValuesin="crores";
}
else if(valuesin.equalsIgnoreCase("L"))
{
	valuesin = "Rs. In Lacs";
	strValuesin="lacs";
}
else
{
	valuesin="Amount In Rs.";
	strValuesin="";
}
%>

<html>
<head>
<title>TermLoanReviewNote-Corporate</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body><form name="safaeri3" method="post">
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
        </tr>
        <tr> 
          <td align="center">Branch / Office, <%=strOrgName%> 
            <hr>
          </td>
        </tr>
        <tr> 
          <td height="2"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td width="10%"><b>Ref No:</b></td>
                <td width="60%"><%=Helper.correctNull((String) hshValues.get("tlr_refno"))%>&nbsp;</td>
                <td width="17%" align="right"><b>Date :&nbsp;</b></td>
                <td width="13%" align="right"><%=Helper.correctNull((String) hshValues.get("tlr_proposaldate"))%>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td align="center"><b><U><b>Proposal for : Review of Term Loan (Retail 
            / Tertiary)</b></U></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" cellspacing="0" cellpadding="4" align="center">
  <tr> 
    <td> 
      <table width="100%" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="2%"><b>1</b></td>
          <td width="44%"><b>Name of the Account</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;<%=Helper.decodeAmpersand(Helper.correctNull((String)hshValues.get("custName")))%> 
            <%=Helper.correctNull((String)hshValues.get("tlr_activity"))%> </td>
        </tr>
        <tr> 
          <td width="2%"><b>2</b></td>
          <td width="44%"><b>Activity</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%"><b>3</b></td>
          <td width="44%"><b>Dealing with Bank since</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_banksince"))%></td>
        </tr>
        <tr> 
          <td width="2%"><b>4</b></td>
          <td width="44%"><b>Asset Classification</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_assetclassify"))%></td>
        </tr>
        <tr> 
          <td width="2%"><b>5</b></td>
          <td width="44%"><b>Renewal Due</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_renewal"))%></td>
        </tr>
        <tr> 
          <td width="2%"><b>6</b></td>
          <td width="44%"><b>Credit facilities since</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_facilitysince"))%></td>
        </tr>
        <tr> 
          <td width="2%" valign="top" align="left"><b>7</b></td>
          <td width="44%" valign="top" align="left"><b>Present Position Of the 
            Account </b></td>
          <td width="1%">&nbsp;</td>
          <td width="53%">&nbsp;</td>
        </tr>
        <tr valign="top"> 
          <td align="right" colspan="4"><b>(<%=valuesin%>)</b></td>
        </tr>
        <tr> 
          <td colspan="4"> 
            <div id="top"> 
              <table width="100%" cellspacing="0" cellpadding="3" align="center">
                <tr class="tblhead"> 
                  <td width="32%"> 
                    <div align="center">Name of Facility</div>
                  </td>
                  <td> 
                    <div align="center">Existing Limit</div>
                  </td>
                  <td width="8%"> 
                    <div align="center">O/S Amount</div>
                  </td>
                  <td width="8%"> 
                    <div align="center">Overdue,if any</div>
                  </td>
                  <td width="30%"> 
                    <div align="center">Security Details</div>
                  </td>
                  <td width="15%"> 
                    <div align="center">Value of Security</div>
                  </td>
                </tr>
                <% 
                arrComRowList = new ArrayList();
                arrComRowList = (ArrayList)hshValues.get("arrFacility");
                if(arrComRowList != null && arrComRowList.size()>0)
                {
                
                    for(int i=0;i<arrComRowList.size();i++)
                    {
                  	  arrComColList = new ArrayList();
                  	  arrComColList = (ArrayList)arrComRowList.get(i);
                  	int introwspan = Integer.parseInt(Helper
    						.correctInt((String) arrComColList.get(12)));
                  %>
                <td width="27%" align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) arrComColList
										.get(1))%> </b></td>
                <td width="13%" align="right" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) arrComColList.get(3))))%></td>
                <td width="13%" align="right" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
						.correctDouble((String) arrComColList.get(4))))%></td>
                <td width="13%" align="right" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
						.correctDouble((String) arrComColList.get(5))))%></td>
                <%
                ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) arrComColList.get(11);
				if(arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						ArrayList arrSecCol = new ArrayList();
						String strBorder = "";
						arrSecCol = (ArrayList)arrSecurities.get(j);
						if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}
						if (j == 0) {

							%>
                <td width="31%" align="left" valign="top"><%=Helper
													.correctNull((String)arrSecCol
															.get(0))%>&nbsp;</td>
                <td width="31%" align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
					.correctDouble((String)arrSecCol
							.get(1))))%>&nbsp;</td>
                <%} else { %>
                <tr> 
                  <td width="31%" valign="top" align="left"><%=Helper
													.correctNull((String) arrSecCol
															.get(0))%>&nbsp;</td>
                  <td width="31%" valign="top" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
													.correctDouble((String) arrSecCol
															.get(1))))%>&nbsp;</td>
                  <%}
					}
				} else { %>
                  <td width="8%" valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
                  <td width="8%" valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
                  <%}

				%>
                </tr>
                <%}
                    }%>
              </table>
            </div>
          </td>
        </tr>
        <%
		    arrRow = new ArrayList();
			arrRow = (ArrayList)hshValues.get("arrSecRemarks");
			if (arrRow != null && arrRow.size() != 0) {

				%>
        <tr> 
          <td colspan="4"> 
            <table width="90%" border="0" cellspacing="0" cellpadding="3"
					align="center">
              <tr> 
                <td valign="top"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><b>Security Remarks</b></td>
                    </tr>
                    <%for (int i = 0; i < arrRow.size(); i++) {
    	  arrCol = (ArrayList) arrRow.get(i);
					if (!Helper.formatTextAreaData((String) arrCol.get(0))
							.equalsIgnoreCase("")) {

						%>
                    <tr> 
                      <td valign="top" class="just"><%=Helper.formatTextAreaData((String) arrCol
										.get(0))%>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <%}
				}

			%>
                  </table>
                </td>
              </tr>
            </table>
            <%}
%>
          </td>
        </tr>
        <tr> 
          <td width="2%"><b>8</b></td>
          <td width="44%"><b>Brief Background</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3">
            <%String strBriefBackground = Helper.correctEditor((String) hshValues
					.get("tlr_briefbackground"));%>
            <%if (strBriefBackground.trim().equals("")) {%>
            N.A. 
            <%}else{%>
            <%= strBriefBackground%> 
            <%}%>
          </td>
        </tr>
        <%
		    //arrRow = new ArrayList();
		//	arrRow = (ArrayList)hshValues.get("arrIntRemarksrow");
			//if (arrRow != null && arrRow.size() >0) {

				%>
        <!-- 	<tr>
				<td colspan="4">
				<table width="90%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">

							<%//for (int i = 0; i < arrRow.size(); i++) {
    	//  arrCol = (ArrayList) arrRow.get(i);
					//if (!Helper.formatTextAreaData((String) arrCol.get(0))
							//.equalsIgnoreCase("")) {

						%>
							<%//if(i==0){ %>

							<tr>
								<td><b>Interest Remarks</b></td>
							</tr>
							<%//} %>
							<tr>
								<td valign="top" class="just"><%//=Helper.formatTextAreaData((String) arrCol
										//.get(0))%>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>

							<%//}
				//}

			%>
						</table>
						</td>
					</tr>
				</table>
				<%//}
%></td>
			</tr> -->
        <tr> 
          <td width="2%"><b>9</b></td>
          <td width="44%"><b>Present status of the Project</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3">
            <%String strPresentStatus = Helper.correctEditor((String) hshValues
					.get("tlr_presentstatus"));%>
            <%if (strPresentStatus.trim().equals("")) {%>
            N.A. 
            <%}else{%>
            <%= strPresentStatus%> 
            <%}%>
          </td>
        </tr>
        <tr> 
          <td width="2%"><b>10</b></td>
          <td width="44%"><b>Operation in CD Account</b></td>
          <td width="1%">&nbsp;</td>
          <td width="53%">&nbsp;</td>
        </tr>
        <tr valign="top"> 
          <td align="right" colspan="4"><b>(<%=valuesin%>)</b></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td colspan="3"> 
            <div id="top"> 
              <table width="100%" cellspacing="0" cellpadding="3">
                <tr> 
                  <td align="center" width="25%">Maximum Debit</td>
                  <td width="21%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_maxdebit"))))%> 
                  </td>
                  <td align="center" width="25%">Maximum Credit</td>
                  <td width="29%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_maxcredit"))))%> 
                  </td>
                </tr>
                <tr> 
                  <td width="25%" align="center">Minimum Debit</td>
                  <td width="21%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_mindebit"))))%> 
                  </td>
                  <td width="25%" align="center">Minimum Credit</td>
                  <td width="29%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_mincredit"))))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td width="44%"><b>No. of Days in Debit</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_noofdaysdebit"))%></td>
        </tr>
        <tr> 
          <td width="2%"><b>11</b></td>
          <td><b>Operations in Term Loan A/C</b></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td width="44%"><b>Date of First disbursement</b></td>
          <td width="1%">:</td>
          <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_disbursaldate"))%> 
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td><b>Repaymemt Schedule</b></td>
          <td>:</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"> 
            <P><%=Helper.correctEditor((String)hshValues.get("tlr_repay"))%></P>
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td width="44%"><b>Wheteher installment are paid regularly?</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp; 
            <%
				if(Helper.correctNull((String)hshValues.get("tlr_instalmentpaid")).equalsIgnoreCase("1")) 
				{
					out.println("Yes"); 
				}
				else if(Helper.correctNull((String)hshValues.get("tlr_instalmentpaid")).equalsIgnoreCase("2"))
				{
					out.println("No"); 
				}
				else if(Helper.correctNull((String)hshValues.get("tlr_instalmentpaid")).equalsIgnoreCase("3"))
				{
					out.println("Not Applicable"); 
				}
				%>
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td width="44%"><b>Wheteher interest serviced regularly?</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp; 
            <%
				if(Helper.correctNull((String)hshValues.get("tlr_intserviced")).equalsIgnoreCase("1")) 
				{
					out.println("Yes"); 
				}
				else if(Helper.correctNull((String)hshValues.get("tlr_intserviced")).equalsIgnoreCase("2"))
				{
					out.println("No"); 
				}
				else if(Helper.correctNull((String)hshValues.get("tlr_intserviced")).equalsIgnoreCase("3"))
				{
					out.println("Not Applicable"); 
				}
				%>
          </td>
        </tr>
        <tr> 
          <td width="2%"><b>12</b></td>
          <td><b>Compliance to terms of sanction</b></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td><b>Completion of Mortgage formalities</b></td>
          <td><b>:</b></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"> 
            <P><%=Helper.formatTextAreaData((String)hshValues.get("tlr_formalities"))%></P>
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"><b>Registration of Charges with ROC /Date of last search 
            report held on records&nbsp;:</b></td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"> 
            <P><%=Helper.formatTextAreaData((String)hshValues.get("tlr_registrationcharge"))%></P>
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td width="44%"><b>Whether documents are valid and in force</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp; 
            <%
				if(Helper.correctNull((String)hshValues.get("tlr_doccheck")).equalsIgnoreCase("Y")) {
					out.println("Yes"); 
				} else{
					out.println("No"); 
				}
			%>
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td width="44%"><b>Date of last DBC obtained</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_dbcdate"))%></td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"><b>Details of Collateral Security and value Date of 
            last valution&nbsp;:</b></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <% arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrCollSec");
			if (arrRow != null && arrRow.size() > 0) {

				%>
          <td colspan="3"> 
            <div id="top"> 
              <table width="80%" border="0" cellspacing="0" cellpadding="3">
                <tr valign="top"> 
                  <td align="right" colspan="3"><b>(<%=valuesin%>)</b></td>
                </tr>
                <tr> 
                  <td width="50%" align="center"><b>Security Description </b></td>
                  <td width="15%" align="center"><b>Security Value</b></td>
                  <td width="35%" align="center"><b>Date of Last Valuation</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++) {
				     arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(3))%>&nbsp;</td>
                  <td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol
											.get(5))))%>&nbsp;</td>
                  <td width="50%" valign="top"><%=Helper.correctNull((String) arrCol
											.get(6))%>&nbsp;</td>
                </tr>
                <%}%>
              </table>
            </div>
          </td>
          <%} else { %>
          <td colspan="3">Nil</td>
          <%}
			%>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td width="44%"><b>Date of last inspection of securities</b></td>
          <td width="1%"><b>:</b></td>
          <td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_inspectiondate"))%> 
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"><b>Whether securities are adequtely insured and valid 
            policy held on record&nbsp;:</b></td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"> 
            <P><%=Helper.formatTextAreaData((String)hshValues.get("tlr_secdesc"))%></P>
          </td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"><b>Observation of the Inspecting official/Irregularities 
            if any and compliance thereof&nbsp;:</b></td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3"> 
            <P><%=Helper.formatTextAreaData((String)hshValues.get("tlr_observ"))%></P>
          </td>
        </tr>
        <tr> 
          <td width="2%"><b>13</b></td>
          <td><b>Audit Observation &amp; Compliance thereof</b></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"><b>13.1.&nbsp;</b></td>
          <td valign="top"><b> Internal Audit<%=Helper.correctNull((String) hshValues
							.get("audit_internal_date"))%> </b></td>
          <td><b>:</b></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrInternal");
			if (arrRow != null && arrRow.size() > 0) {

				%>
          <td colspan="4" valign="top"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++) {
					 arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}%>
              </table>
            </div>
          </td>
          <%} else {%>
          <%=Helper.correctNull((String)hshValues.get("notapplicable"))%> 
          <%}

			%>
        </tr>
        <tr> 
          <td colspan="5">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>13.2.&nbsp;</b></td>
          <td valign="top"><b> Concurrent Audit<%=Helper.correctNull((String) hshValues
							.get("audit_concurrent_date"))%></b></td>
          <td><b>:</b></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrConcurrent");
			if (arrRow != null && arrRow.size() > 0) {

				%>
          <td colspan="4" valign="top"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++) {
				    arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}%>
              </table>
            </div>
          </td>
          <%} else {%>
          <%=Helper.correctNull((String)hshValues.get("notapplicable"))%> 
          <%}
			%>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>13.3.&nbsp;</b></td>
          <td valign="top"><b> Statutory Audit<%=Helper.correctNull((String)hshValues.get("audit_statutory_date"))%></b></td>
          <td><b>:</b></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrStatutory");
			if (arrRow != null && arrRow.size() > 0) {

				%>
          <td colspan="4" valign="top"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++) {
				     arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}%>
              </table>
            </div>
          </td>
          <%} else {%>
          <%=Helper.correctNull((String)hshValues.get("notapplicable"))%> 
          <%}
			%>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>13.4.&nbsp;</b></td>
          <td valign="top"><b> RBI Inspection Audit<%=Helper.correctNull((String)hshValues.get("audit_inspection_date"))%></b></td>
          <td><b>:</b></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRBI");
			if (arrRow != null && arrRow.size() > 0) {

				%>
          <td colspan="4" valign="top"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++) {
				    arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}%>
              </table>
            </div>
          </td>
          <%} else {%>
          <%=Helper.correctNull((String)hshValues.get("notapplicable"))%> 
          <%}
			%>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>13.5.&nbsp;</b></td>
          <td valign="top"><b> Stock Audit<%=Helper.correctNull((String)hshValues.get("audit_stock_date"))%></b></td>
          <td><b>:</b></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrStock");
			if (arrRow != null && arrRow.size() > 0) {

				%>
          <td colspan="4"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}%>
              </table>
            </div>
          </td>
          <%} else { %>
          <%=Helper.correctNull((String)hshValues.get("notapplicable"))%> 
          <%}
			%>
        </tr>
        <tr> 
          <td width="2%"><b>14</b></td>
          <td><b>Any other Matter</b></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
          <td colspan="3">
            <%String strOthers = Helper.correctEditor((String) hshValues
					.get("tlr_others"));%>
            <%if (strOthers.trim().equals("")) {%>
            N.A. 
            <%}else{%>
            <%= strOthers%> 
            <%}%>
          </td>
        </tr>
        <tr> 
          <td width="2%"><b>15</b></td>
          <td><b>RECOMMENDATIONS</b></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%"><B>15.1</B>&nbsp;</td>
          <td colspan="3">In view of above we recommend for review Term Loan of 
            Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("proposedlimit")))) %> 
            <%=strValuesin %> on the terms mentioned hereunder:</td>
        </tr>
        <tr valign="top"> 
          <td align="right" colspan="4"><b>(<%=valuesin%>)</b></td>
        </tr>
        <tr> 
          <td colspan="4"> 
            <div id="top"> 
              <table width="100%" cellspacing="0" cellpadding="3" align="center">
                <tr class="tblhead"> 
                  <td rowspan="2" width="27%"> 
                    <div align="center">Name of Facility</div>
                  </td>
                  <td colspan="2"> 
                    <div align="center">Limit</div>
                  </td>
                  <td rowspan="2" width="8%"> 
                    <div align="center">Int./Comm.</div>
                  </td>
                  <td rowspan="2" width="31%"> 
                    <div align="center">Security Details</div>
                  </td>
                  <td rowspan="2" width="31%"> 
                    <div align="center">Margin</div>
                  </td>
                </tr>
                <tr class="tblhead"> 
                  <td width="13%" align="center">Existing</td>
                  <td width="13%" align="center">Proposed</td>
                </tr>
                <% 
                arrComRowList = new ArrayList();
                arrComRowList = (ArrayList)hshValues.get("arrFacility");
                if(arrComRowList != null && arrComRowList.size()>0)
                {
                
                    for(int i=0;i<arrComRowList.size();i++)
                    {
                  	  arrComColList = new ArrayList();
                  	  arrComColList = (ArrayList)arrComRowList.get(i);
                  	int introwspan = Integer.parseInt(Helper
    						.correctInt((String) arrComColList.get(12)));
                  %>
                <td width="27%" align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) arrComColList
										.get(1))%> </b></td>
                <td width="13%" align="right" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) arrComColList.get(3))))%></td>
                <td width="13%" align="right" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) arrComColList.get(7))))%></td>
                <td width="13%" align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<%=Helper.correctNull((String) arrComColList
										.get(8))%></td>
                <%
                ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) arrComColList.get(11);
				if(arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						ArrayList arrSecCol = new ArrayList();
						String strBorder = "";
						arrSecCol = (ArrayList)arrSecurities.get(j);
						if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}
						if (j == 0) {

							%>
                <td width="31%" align="left" valign="top"><%=Helper
													.correctNull((String)arrSecCol
															.get(0))%>&nbsp;</td>
                <td align="left" valign="top"><%=Helper
					.correctNull((String)arrSecCol
							.get(2))%>&nbsp;</td>
                <%} else { %>
                <tr> 
                  <td width="31%" valign="top" align="left"><%=Helper
													.correctNull((String) arrSecCol
															.get(0))%>&nbsp;</td>
                  <td width="31%" valign="top" align="left"><%=Helper
													.correctNull((String) arrSecCol
															.get(2))%>&nbsp;</td>
                  <%}
					}
				} else { %>
                  <td valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
                  <td valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
                  <%}

				%>
                </tr>
                <%}
                    }%>
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
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td>Submitted for Approval,</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td> 
                  <%arrRow=(ArrayList)hshValues.get("mailcomments");
				if(arrRow!=null && arrRow.size()>0)
	          	{ %>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3" align="center" class="td_bg"><strong>Recommended 
                        for Sanction</strong></td>
                    </tr>
            <%for(int i=0;i<arrRow.size();i++)
			 {
				arrCol = new ArrayList();
				arrCol = (ArrayList)arrRow.get(i);
			%>
                    <tr> 
                      <td valign="top"><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>
                      <td valign="top">:&nbsp;</td>
                      <td valign="top">
                        <P><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</P>
                      </td>
                    </tr>
                    <%}
			     %>
                  </table>
                  <%} %>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
              <%
              if(!Helper.correctNull((String) hshValues
						.get("tlr_status")).equals("op"))
              {
              %>
	              <tr> 
	                <td align="center"><b>Approved</b></td>
	              </tr>
	              <tr>
	              <td>
	                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td valign="top" width="25%" valign="top">Date of Approval</td>
                        <td valign="top" width="5%" valign="top">:&nbsp;</td>
                        <td valign="top" width="70%" valign="top"><%=Helper.correctNull((String)hshValues.get("tlr_processdate"))%>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="25%" valign="top">Sanctioning Authority&nbsp;</td>
                        <td valign="top" width="5%" valign="top">:&nbsp;</td>
                        <td valign="top" width="70%" valign="top"><%=Helper.correctNull((String)hshValues.get("tlr_processedby"))%>&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" width="25%" valign="top"> Sanctioning Authority Comments&nbsp;</td>
                        <td valign="top" width="5%" valign="top">:&nbsp;</td>
                        <td valign="top" width="70%" valign="top"> 
                          <P><%=Helper.correctNull((String)hshValues.get("tlr_comments"))%>&nbsp;</P>
                        </td>
                      </tr>
                    </table>
	              </td>
	              </tr>
	              
              <%}
              %>     
              <%-- <tr> 
                <td><b><%=Helper.correctNull((String) hshValues
							.get("tlr_signatories"))%></b></td>
              </tr>--%>
            </table>
          </td>
        </tr>
      </table>
      </td>
      </tr>
      </table>
      </form>

</body>
</html>

