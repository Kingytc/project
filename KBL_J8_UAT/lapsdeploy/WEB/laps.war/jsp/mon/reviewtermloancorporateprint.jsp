<%@page import="com.sai.laps.helper.*,java.util.ArrayList,java.util.StringTokenizer"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strOrgName" class="java.lang.String" scope="session" />

<%

ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrComRowList = null;
ArrayList arrComColList = null;
arrRow = ((ArrayList)hshValues.get("arrRow"));

String[] strIncurred1= new String[24];
String[] strIncurred2= new String[24];
String[] strIncurred3= new String[24];
String[] strIncurred4= new String[24];

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
		if(i!=23)
		{
			strIncurred1[i] = Helper.correctNull((String)arrCol.get(0));
			strIncurred2[i] = Helper.correctNull((String)arrCol.get(1));
			strIncurred3[i] = Helper.correctNull((String)arrCol.get(2));
			strIncurred4[i] = Helper.correctNull((String)arrCol.get(3));
		}
		else
		{
			
			
			strIncurred1[i] = Helper.correctNull((String)arrCol.get(0));
						
			strIncurred2[i] = Helper.correctNull((String)arrCol.get(1));
			strIncurred3[i] = Helper.correctNull((String)arrCol.get(2));
			strIncurred4[i] = Helper.correctNull((String)arrCol.get(3));
			
			if(strIncurred1[i].equals("a"))
				strIncurred1[i] = "Audited";
			else if(strIncurred1[i].equals("e"))
				strIncurred1[i] = "Estimated";
			else if(strIncurred1[i].equals("u"))
				strIncurred1[i] = "Unaudited";
			else if(strIncurred1[i].equals("p"))
				strIncurred1[i] = "Projection";
			else
			 	strIncurred1[i] ="";
			
			if(strIncurred2[i].equals("a"))
				strIncurred2[i] = "Audited";
			else if(strIncurred2[i].equals("e"))
				strIncurred2[i] = "Estimated";
			else if(strIncurred2[i].equals("u"))
				strIncurred2[i] = "Unaudited";
			else if(strIncurred2[i].equals("p"))
				strIncurred2[i] = "Projection";
			else
			 	strIncurred2[i] ="";	
			
			if(strIncurred3[i].equals("a"))
				strIncurred3[i] = "Audited";
				
			else if(strIncurred3[i].equals("e"))
				strIncurred3[i] = "Estimated";
			else if(strIncurred3[i].equals("u"))
				strIncurred3[i] = "Unaudited";
			else if(strIncurred3[i].equals("p"))
				strIncurred3[i] = "Projection";
			else
			 	strIncurred3[i] ="";
			
			if(strIncurred4[i].equals("a"))
				strIncurred4[i] = "Audited";
				
			else if(strIncurred4[i].equals("e"))
				strIncurred4[i] = "Estimated";
			else if(strIncurred4[i].equals("u"))
				strIncurred4[i] = "Unaudited";
			else if(strIncurred4[i].equals("p"))
				strIncurred4[i] = "Projection";
			else
			 	strIncurred4[i] ="";
		}	
	}	
}

String monBanking = Helper.correctNull((String)hshValues.get("tlr_bankarrangement"));
String leadBank ="", ourShare="";

if(monBanking.equals("2") || monBanking.equals("4") || monBanking.equals("6") || monBanking.equals("7"))
{
	leadBank = Helper.correctNull((String)hshValues.get("tlr_leadbank"));
	ourShare = "Y";
	
}
else
{
	leadBank ="N.A.";

}

if(monBanking.equals("1"))
{
	monBanking ="Sole";
}
else if(monBanking.equals("2"))
{
	monBanking ="Consortium";
}
else if(monBanking.equals("3"))
{
	monBanking ="Multiple";
}
else if(monBanking.equals("4"))
{
	monBanking ="Sole/Consortium";
}
else if(monBanking.equals("5"))
{
	monBanking ="Sole/Multiple";
}
else if(monBanking.equals("6"))
{
	monBanking ="Consortium/Multiple";
}
else if(monBanking.equals("7"))
{
	monBanking ="Sole/Consortium/Multiple";
}
else
{
	monBanking ="";
}

String status_account = Helper.correctNull((String)hshValues.get("tlr_status"));
if(status_account.equals("1"))
{
	status_account="Regular";
}
else if(status_account.equals("2"))
{
	status_account="EAS - I";
}
else if(status_account.equals("3"))
{
	status_account="Eas-II";
}
else if(status_account.equals("4"))
{
	status_account="SMA";
}
else if(status_account.equals("5"))
{
	status_account="Not Applicable";
}
else 
{
	status_account="";
}



String strSanctauth = Helper.correctNull((String) hshValues
		.get("tlr_sancauthority"));

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

<body>
<form name="safaeri3" method="post">
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">

			<%if (strSanctauth.equals("7")) {%>
			<tr align="right">
				<td>
				<table border="0" cellspacing="0" cellpadding="3" width="">
					<tr>
						<td align="left">Agenda Item No:<%=Helper.correctNull((String) hshValues
								.get("tlr_agendano"))%> <br>
						MCM of: <%=Helper.correctNull((String) hshValues
										.get("tlr_mcmdate"))%></td>
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
			<tr align="right">
				<td>
				<table border="0" cellspacing="0" cellpadding="6">
					<tr>
						<%if (strSanctauth.equals("4") || strSanctauth.equals("5")) {

				%>
						<td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/GM.jpg"
							width="55" height="77"></td>
						<td>&nbsp;&nbsp;</td>
						<%}
			if (strSanctauth.equals("5") || strSanctauth.equals("6")
					|| strSanctauth.equals("7")) {

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
			<%if(strSanctauth.equals("7"))
			{ %>
			<tr>
				<td align="center"><b><U>MEMORANDUM TO MANAGEMENT COMMITTEE FOR
				APPROVAL</U></b></td>
			</tr>
			<%} %>
			<tr>
				<td align="center"><b><U><b>Proposal for : Review of Term Loan
				</b></U></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" cellspacing="0" cellpadding="4" align="center">
	<tr>

		<td>
		<div id="top">
		<table width="100%" cellspacing="0" cellpadding="3" align="center">
			<tr>
				<td width="23%"><b>Group</b></td>
				<td colspan="3">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_group"))%></td>
			</tr>

			<tr>
				<td width="23%"><b>Banking</b></td>
				<td width="24%">&nbsp;<%=monBanking%></td>
				<td width="15%"><b>Lead Bank : -</b></td>
				<td width="31%"><%=leadBank%></td>
			</tr>
			<tr>
				<td width="23%"><b>Month of Review</b></td>
				<td width="24%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_reviewdate1"))%></td>
				<td width="15%"><b>Our Share (%) :-</b></td>
				<%if(ourShare.equals("Y")){ %>
				<td width="31%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_ourshare"))))%>&nbsp;
				</td>
				<%}else{ %>
				<td>N.A.</td>
				<%} %>
			</tr>
			<tr>
				<td width="23%"><b>Asset Classification</b></td>
				<td colspan="3">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_assetclassify"))%></td>
			</tr>
			<tr>
				<td width="23%" valign="top"><b>Internal Credit Rating</b></td>
				<td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr align="center"> 
                  <td>&nbsp;</td>
                  <td><b>Grade</b></td>
                  <td><b>Score</b></td>
                  <td><b>Risk definition</b></td>
                </tr>
                <tr align="left"> 
                  <td><b>Previous Year</b></td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_prevyeargrade"))%></td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_prevyearscore"))%></td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_prevyearrisk"))%></td>
                </tr>
                <tr align="left"> 
                  <td><b>Current Year</b></td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_currentyeargrade"))%></td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_currentyearscore"))%></td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_currentyearrisk"))%></td>
                </tr>
              </table></td>
			</tr>
			<tr>
				<td width="23%" valign="top"><b>External Credit Rating</b></td>
				<td colspan="3">
				<table width="100%" border="0"  cellspacing="0" cellpadding="3">
                <tr> 
                  <td><b>Rating Agency</b></td>
                  <td><b>Previous Year</b></td>
                  <td><b>Current Year</b></td>
                </tr>
                <tr> 
                  <td>&nbsp;<%=Helper.correctNull((String) hshValues.get("tlr_agencyname"))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String) hshValues
									.get("tlr_lastrating"))%></td>
                  <td>&nbsp;<%=Helper.correctNull((String) hshValues.get("tlr_currating"))%></td>
                </tr>
              </table>
				</td>
			</tr>
			<tr>
				<td width="23%"><b>Status of Account</b></td>
				<td colspan="3">&nbsp;<%=status_account%></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>

		<td>


		<table width="100%" cellspacing="0" cellpadding="3">
			<tr>
				<td width="2%"><b>1</b></td>
				<td width="44%"><b>Name of the Account</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp;<%=Helper.decodeAmpersand(Helper.correctNull((String)hshValues.get("custName")))%>
				</td>
			</tr>
			<tr>
				<td width="2%"><b>2</b></td>
				<td width="44%"><b>Branch</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp;<%=Helper.decodeAmpersand(Helper.correctNull((String)hshValues.get("branchName")))%>
				</td>
			</tr>
			<tr>
				<td width="2%" valign="top"><b>3</b></td>
				<td width="44%" valign="top"><b>Names of the Directors / Partners</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="53%">&nbsp;</td>
			</tr>
				<tr>
				<td>&nbsp;</td>
			
			<% 
                arrComRowList = new ArrayList();
                arrComRowList = (ArrayList)hshValues.get("arrPromoterDetails");
                if(arrComRowList != null && arrComRowList.size()>0)
                {
          
                %>
			<td colspan="3">
				<div id="top">
				<table width="60%" cellspacing="0" cellpadding="3">

					<tr class="tblhead">
						<td align="center" width="4%"><b>S.No</b></td>
						<td align="center"><b>Name</b></td>
						<td align="center"><b>Designation</b></td>
					</tr>
					<%
                  for(int i=0;i<arrComRowList.size();i++)
                  {
                	  arrComColList = new ArrayList();
                	  arrComColList = (ArrayList)arrComRowList.get(i);
                %>
					<tr>
						<td><%=i+1%></td>
						<td><%=Helper.correctNull((String)arrComColList.get(1)) %></td>
						<td><%=Helper.correctNull((String)arrComColList.get(2)) %></td>
					</tr>
					<%
                  } %>

				</table>
				</div>
				</td>
			
			<% }else{ %>
			
				<td colspan="3">N.A.</td>
	
			<%} %>
			</tr>
			<tr>
				<td width="2%"><b>4</b></td>
				<td width="44%"><b>Activity</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_activity"))%></td>
			</tr>
			<tr>
				<td width="2%"><b>5</b></td>
				<td width="44%"><b>Dealing with Bank since</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_banksince"))%></td>
			</tr>
			<tr>
				<td width="2%"><b>6</b></td>
				<td width="44%"><b>Renewal Due</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_renewal"))%></td>
			</tr>
			<tr>
				<td width="2%"><b>7</b></td>
				<td width="44%"><b>Credit facilities since</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_facilitysince"))%></td>
			</tr>
			<tr>
				<td width="2%" valign="top" align="left"><b>8</b></td>
				<td width="44%" valign="top" align="left"><b>Present Position Of the Account </b></td>
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
%></td>
			</tr>	
			<tr>
				<td width="2%"><b>9</b></td>
				<td width="44%"><b>Brief Background</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp;</td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td colspan="3"><%String strBriefBackground = Helper.correctEditor((String) hshValues
					.get("tlr_briefbackground"));%> <%if (strBriefBackground.trim().equals("")) {%>
				N.A. <%}else{%> <%= strBriefBackground%> <%}%></td>
			</tr>
			
			<%
		  //  arrRow = new ArrayList();
			//arrRow = (ArrayList)hshValues.get("arrIntRemarksrow");
			//if (arrRow != null && arrRow.size() >0) {

				%>
				<!-- 
			<tr>
				<td colspan="4">
				<table width="90%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">

							<% //for (int i = 0; i < arrRow.size(); i++) {
    	 // arrCol = (ArrayList) arrRow.get(i);
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
				<td width="2%" valign="top" align="left"><b>10</b></td>
				<td width="44%" valign="top" align="left"><b>Financial Highlights</b></td>
				<td width="1%">&nbsp;</td>
				<td width="53%">&nbsp;</td>
			</tr>
			<tr valign="top"> 
    			<td align="right" colspan="4"><b>(<%=valuesin%>)</b></td>
			  </tr>
			<tr>
				<td colspan="4">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="center" bordercolordark="#DEDACF" bordercolorlight="#FFFFFB"
					dwcopytype="CopyTableRow">
					<tr>
						<td width="31%" align="center"><b>Year Ended / Ending</b></td>
						<td width="17%" align="center" valign="middle"><b><%=strIncurred1[0]%></b></td>
						<td width="17%" align="center" valign="middle"><b><%=strIncurred2[0]%></b></td>
						<td width="18%" align="center" valign="middle"><b><%=strIncurred3[0]%></b></td>
						<td width="17%" align="center" valign="middle"><b><%=strIncurred4[0]%></b></td>
					</tr>
					<tr>
						<td width="31%">&nbsp;</td>
						<td width="17%" align="center" valign="middle"><b>&nbsp;<%=strIncurred1[23]%></b></td>
						<td width="17%" align="center" valign="middle"><b>&nbsp;<%=strIncurred2[23]%></b></td>
						<td width="18%" align="center" valign="middle"><b>&nbsp;<%=strIncurred3[23]%></b></td>
						<td width="17%" align="center" valign="middle"><b>&nbsp;<%=strIncurred4[23]%></b></td>
					</tr>
					<tr>
						<td width="31%"><b>1. Paid-Up Capital</b></td>
						<td width="17%" align="right"><%=strIncurred1[1]%></td>
						<td width="17%" align="right"><%=strIncurred2[1]%></td>
						<td width="18%" align="right"><%=strIncurred3[1]%></td>
						<td width="17%" align="right"><%=strIncurred4[1]%></td>
					</tr>
					<tr>
						<td width="31%"><b>2. Reserves &amp; Surplus</b></td>
						<td width="17%" align="right"><%=strIncurred1[2]%></td>
						<td width="17%" align="right"><%=strIncurred2[2]%></td>
						<td width="18%" align="right"><%=strIncurred3[2]%></td>
						<td width="17%" align="right"><%=strIncurred4[2]%></td>
					</tr>
					<tr>
						<td width="31%"><b>3. Intangible assets</b></td>
						<td width="17%" align="right"><%=strIncurred1[3]%></td>
						<td width="17%" align="right"><%=strIncurred2[3]%></td>
						<td width="18%" align="right"><%=strIncurred3[3]%></td>
						<td width="17%" align="right"><%=strIncurred4[3]%></td>
					</tr>
					<tr>
						<td width="31%"><b>4. Tangible Net Worth</b></td>
						<td width="17%" align="right"><%=strIncurred1[4]%></td>
						<td width="17%" align="right"><%=strIncurred2[4]%></td>
						<td width="18%" align="right"><%=strIncurred3[4]%></td>
						<td width="17%" align="right"><%=strIncurred4[4]%></td>
					</tr>
					<tr>
						<td width="31%"><b>5. Long Term Liabilities</b></td>
						<td width="17%" align="right"><%=strIncurred1[5]%></td>
						<td width="17%" align="right"><%=strIncurred2[5]%></td>
						<td width="18%" align="right"><%=strIncurred3[5]%></td>
						<td width="17%" align="right"><%=strIncurred4[5]%></td>
					</tr>
					<tr>
						<td width="31%" height="2"><b>6. Capital Employed</b></td>
						<td width="17%" height="2" align="right"><%=strIncurred1[6]%></td>
						<td width="17%" height="2" align="right"><%=strIncurred2[6]%></td>
						<td width="18%" height="2" align="right"><%=strIncurred3[6]%></td>
						<td width="17%" height="2" align="right"><%=strIncurred4[6]%></td>
					</tr>
					<tr>
						<td width="31%"><b>7. Net Block</b></td>
						<td width="17%" align="right"><%=strIncurred1[7]%></td>
						<td width="17%" align="right"><%=strIncurred2[7]%></td>
						<td width="18%" align="right"><%=strIncurred3[7]%></td>
						<td width="17%" align="right"><%=strIncurred4[7]%></td>
					</tr>
					<tr>
						<td width="31%"><b>8. Investments</b></td>
						<td width="17%" align="right"><%=strIncurred1[8]%></td>
						<td width="17%" align="right"><%=strIncurred2[8]%></td>
						<td width="18%" align="right"><%=strIncurred3[8]%></td>
						<td width="17%" align="right"><%=strIncurred4[8]%></td>
					</tr>
					<tr>
						<td width="31%"><b>9. Non Current Assets</b></td>
						<td width="17%" align="right"><%=strIncurred1[9]%></td>
						<td width="17%" align="right"><%=strIncurred2[9]%></td>
						<td width="18%" align="right"><%=strIncurred3[9]%></td>
						<td width="17%" align="right"><%=strIncurred4[9]%></td>
					</tr>
					<tr>
						<td width="31%"><b>10. Net Working Capital (Tally with Item 11 -
						item 12)</b></td>
						<td width="17%" align="right"><%=strIncurred1[10]%></td>
						<td width="17%" align="right"><%=strIncurred2[10]%></td>
						<td width="18%" align="right"><%=strIncurred3[10]%></td>
						<td width="17%" align="right"><%=strIncurred4[10]%></td>
					</tr>
					<tr>
						<td width="31%"><b>11. Current Assets</b></td>
						<td width="17%" align="right"><%=strIncurred1[11]%></td>
						<td width="17%" align="right"><%=strIncurred2[11]%></td>
						<td width="18%" align="right"><%=strIncurred3[11]%></td>
						<td width="17%" align="right"><%=strIncurred4[11]%></td>
					</tr>
					<tr>
						<td width="31%"><b>12. Current Liabilites</b></td>
						<td width="17%" align="right"><%=strIncurred1[12]%></td>
						<td width="17%" align="right"><%=strIncurred2[12]%></td>
						<td width="18%" align="right"><%=strIncurred3[12]%></td>
						<td width="17%" align="right"><%=strIncurred4[12]%></td>
					</tr>
					<tr>
						<td width="31%"><b>13. Current Ratio</b></td>
						<td width="17%" align="right"><%=strIncurred1[13]%></td>
						<td width="17%" align="right"><%=strIncurred2[13]%></td>
						<td width="18%" align="right"><%=strIncurred3[13]%></td>
						<td width="17%" align="right"><%=strIncurred4[13]%></td>
					</tr>
					<tr>
						<td width="31%"><b>14. DER(TL/TNW)</b></td>
						<td width="17%" align="right"><%=strIncurred1[14]%></td>
						<td width="17%" align="right"><%=strIncurred2[14]%></td>
						<td width="18%" align="right"><%=strIncurred3[14]%></td>
						<td width="17%" align="right"><%=strIncurred4[14]%></td>
					</tr>
					<tr>
						<td width="31%"><b>15. TOL/TNW Ratio</b></td>
						<td width="17%" align="right"><%=strIncurred1[15]%></td>
						<td width="17%" align="right"><%=strIncurred2[15]%></td>
						<td width="18%" align="right"><%=strIncurred3[15]%></td>
						<td width="17%" align="right"><%=strIncurred4[15]%></td>
					</tr>
					<tr>
						<td width="31%"><b>16. Net Sales</b></td>
						<td width="17%" align="right"><%=strIncurred1[16]%></td>
						<td width="17%" align="right"><%=strIncurred2[16]%></td>
						<td width="18%" align="right"><%=strIncurred3[16]%></td>
						<td width="17%" align="right"><%=strIncurred4[16]%></td>
					</tr>
					<tr>
						<td width="31%"><b>17. Other Income</b></td>
						<td width="17%" align="right"><%=strIncurred1[17]%></td>
						<td width="17%" align="right"><%=strIncurred2[17]%></td>
						<td width="18%" align="right"><%=strIncurred3[17]%></td>
						<td width="17%" align="right"><%=strIncurred4[17]%></td>
					</tr>
					<tr>
						<td width="31%"><b>18. Net Profit Before Tax</b></td>
						<td width="17%" align="right"><%=strIncurred1[18]%></td>
						<td width="17%" align="right"><%=strIncurred2[18]%></td>
						<td width="18%" align="right"><%=strIncurred3[18]%></td>
						<td width="17%" align="right"><%=strIncurred4[18]%></td>
					</tr>
					<tr>
						<td width="31%"><b>19. Net Profit After Tax</b></td>
						<td width="17%" align="right"><%=strIncurred1[19]%></td>
						<td width="17%" align="right"><%=strIncurred2[19]%></td>
						<td width="18%" align="right"><%=strIncurred3[19]%></td>
						<td width="17%" align="right"><%=strIncurred4[19]%></td>
					</tr>
					<tr>
						<td width="31%"><b>20. Depreciation</b></td>
						<td width="17%" align="right"><%=strIncurred1[20]%></td>
						<td width="17%" align="right"><%=strIncurred2[20]%></td>
						<td width="18%" align="right"><%=strIncurred3[20]%></td>
						<td width="17%" align="right"><%=strIncurred4[20]%></td>
					</tr>
					<tr>
						<td width="31%"><b>21. Cash Accruals</b></td>
						<td width="17%" align="right"><%=strIncurred1[21]%></td>
						<td width="17%" align="right"><%=strIncurred2[21]%></td>
						<td width="18%" align="right"><%=strIncurred3[21]%></td>
						<td width="17%" align="right"><%=strIncurred4[21]%></td>
					</tr>
					<tr>
						<td width="31%"><b>22. DSCR</b></td>
						<td width="17%" align="right"><%=strIncurred1[22]%></td>
						<td width="17%" align="right"><%=strIncurred2[22]%></td>
						<td width="18%" align="right"><%=strIncurred3[22]%></td>
						<td width="17%" align="right"><%=strIncurred4[22]%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="2%"><b>10.1</b></td>
				<td width="44%"><b>Comments on Financial Indicators</b></td>
				<td width="1%">&nbsp;</td>
				<td width="53%">&nbsp;</td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td colspan="3">
				<P><%=Helper.formatTextAreaData((String)hshValues.get("comments"))%></P>
				</td>
			</tr>
			<tr>
				<td width="2%"><b>11</b></td>
				<td width="44%"><b>Present status of the Project</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp;</td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td colspan="3"><%String strPresentStatus = Helper.correctEditor((String) hshValues
					.get("tlr_presentstatus"));%> <%if (strPresentStatus.trim().equals("")) {%>
				N.A. <%}else{%> <%= strPresentStatus%> <%}%></td>
			</tr>
			<tr>
				<td width="2%"><b>12</b></td>
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
						<td align="center" width="15%">Maximum Debit</td>
						<td width="8%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_maxdebit"))))%>
						</td>
						<td width="15%" align="center">Minimum Debit</td>
						<td width="8%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_mindebit"))))%>
						</td>
						<td align="center" width="15%">No. of Days in Debit</td>
						<td width="8%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_noofdaysdebit"))%>
						</td>
					</tr>
					<tr>
					<td align="center">Maximum Credit</td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_maxcredit"))))%>
						</td>
					<td align="center">Minimum Credit</td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("tlr_mincredit"))))%></td>
						<td align="center">No. of Days in Credit</td>
						<td align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("tlr_noofdayscredit"))%>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		
			<tr>
				<td width="2%"><b>13</b></td>
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
				<td width="53%">&nbsp; <%
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
				%></td>
			</tr>

			<tr>
				<td width="2%">&nbsp;</td>
				<td width="44%"><b>Wheteher interest serviced regularly?</b></td>
				<td width="1%"><b>:</b></td>
				<td width="53%">&nbsp; <%
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
				%></td>
			</tr>

			<tr>
				<td width="2%"><b>14</b></td>
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
				<td colspan="3"><b>Registration of Charges with ROC /Date of last
				search report held on records&nbsp;:</b></td>
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
				<td width="53%">&nbsp; <%
				if(Helper.correctNull((String)hshValues.get("tlr_doccheck")).equalsIgnoreCase("Y")) {
					out.println("Yes"); 
				} else{
					out.println("No"); 
				}
			%></td>
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
				<td colspan="3"><b>Whether securities are adequtely insured and
				valid policy held on record&nbsp;:</b></td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td colspan="3">
				<P><%=Helper.formatTextAreaData((String)hshValues.get("tlr_secdesc"))%></P>
				</td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td colspan="3"><b>Observation of the Inspecting
				official/Irregularities if any and compliance thereof&nbsp;:</b></td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td colspan="3">
				<P><%=Helper.formatTextAreaData((String)hshValues.get("tlr_observ"))%></P>
				</td>
			</tr>
			<tr>
				<td width="2%"><b>15</b></td>
				<td><b>Audit Observation &amp; Compliance thereof</b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top"><b>15.1.&nbsp;</b></td>
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
				<td valign="top" width="3%"><b>15.2.&nbsp;</b></td>
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
				<td valign="top" width="3%"><b>15.3.&nbsp;</b></td>
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
				<td valign="top" width="3%"><b>15.4.&nbsp;</b></td>
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
				<td valign="top" width="3%"><b>15.5.&nbsp;</b></td>
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
				<td width="2%"><b>16</b></td>
				<td><b>Internal Credit Rating</b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		 <tr> 
          <td valign="top"><b>a)</b></td>
          <td valign="top" colspan="3"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="42%" align="center"><b>Year</b></td>
                  <td align="center">Previous Year&nbsp;</td>
                  <td align="center">Current Year&nbsp;</td>
                </tr>
                <tr align="center"> 
                  <td align="left">Total score obtained</td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_prevyearscore"))%></td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_currentyearscore"))%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Grade</td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_prevyeargrade"))%></td>
                  <td><%=Helper.correctNull((String)hshValues.get("tlr_currentyeargrade"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <%
        ArrayList arrRating = new ArrayList();
		arrCol = new ArrayList();
		arrRating = (ArrayList) hshValues.get("arrInternalParam");
    	String[] strprevious = new String[5];
		String[] strcurrent = new String[5];
		for (int i = 0; i < strprevious.length; i++) {
			strprevious[i] = "";
			strcurrent[i] = "";
		}
		if (arrRating != null) {
			for (int i = 0; i < arrRating.size(); i++) {
				arrCol = (ArrayList) arrRating.get(i);

				strprevious[i] = Helper.correctNull((String) arrCol.get(0));
				strcurrent[i] = Helper.correctNull((String) arrCol.get(1));
			}
		}
        %>
        <tr> 
          <td valign="top" width="3%"><b>b)</b></td>
          <td valign="top" width="97%" colspan="3"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="42%" align="center"><b>Parameters</b></td>
                  <td align="center" colspan="2"><b>Marks obtained</b></td>
                </tr>
                
                <tr align="center"> 
                  <td align="left">Borrower rating</td>
                  <td><%=strprevious[0]%></td>
                  <td><%=strcurrent[0]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Facility rating</td>
                  <td><%=strprevious[1]%></td>
                  <td><%=strcurrent[1]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Cash flow related parameters</td>
                  <td><%=strprevious[2]%></td>
                  <td><%=strcurrent[2]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Business aspects</td>
                  <td><%=strprevious[3]%></td>
                  <td><%=strcurrent[3]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Total Marks with grade</td>
                  <td><%=strprevious[4]%></td>
                  <td><%=strcurrent[4]%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        
			<tr>
				<td width="2%"><b>17</b></td>
				<td><b>Group Concerns </b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top"> 
    			<td align="right" colspan="4"><b>(<%=valuesin%>)</b></td>
			  </tr>
			<tr>
				<td colspan="4" valign="top">
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
					<%
                arrComRowList =   (ArrayList)hshValues.get("arrGroupConcern");
                if (arrComRowList != null && arrComRowList.size() > 0) {
				for (int j = 0; j < arrComRowList.size(); j++) {

					arrComColList = (ArrayList) arrComRowList.get(j);

					%>
					<tr>
						<td width="15%" align="left">&nbsp;<font size="1"><%=Helper.correctNull((String) arrComColList
									.get(0))%></font></td>
						<td width="15%" align="left">&nbsp;<font size="1"><%=Helper
											.correctNull((String) arrComColList
													.get(1))%></font></td>
						<td width="10%" align="left">&nbsp;<font size="1"><%=Helper
											.correctNull((String) arrComColList
													.get(2))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arrComColList
																	.get(3))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arrComColList
																	.get(4))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arrComColList
																	.get(5))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arrComColList
																	.get(6))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arrComColList
																	.get(7))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arrComColList
																	.get(8))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arrComColList
																	.get(9))))%></font></td>
						<td width="5%" align="right">&nbsp;<font size="1"><%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arrComColList
																	.get(10))))%></font></td>
						<td width="10%" align="left">&nbsp;<font size="1"><%=Helper.correctNull((String) arrComColList
									.get(11))%></font></td>
						<td width="10%" align="left">&nbsp;<font size="1"><%=Helper.correctNull((String) arrComColList
									.get(12))%></font></td>
					</tr>
					<%}
			} else {

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

			if (arrComRowList != null && arrComRowList.size() != 0) {

				%>
					<tr>
						<td width="15%"><b>Total Exposure</b></td>
						<td width="15%">&nbsp;</td>
						<td width="10%">&nbsp;</td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TLR_GCCOMLIMIT"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TLR_GCCOMOS"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TLR_GCFBWCLT"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TLR_GCFBWCDP"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TLR_GCFBWCOS"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TLR_GCTLLT"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TLR_GCTLOS"))))%></font></td>
						<td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("TLR_GCINS"))))%></font></td>
						<td width="10%">&nbsp;</td>
						<td width="10%">&nbsp;</td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>

			<tr>
				<td width="2%"><b>18</b></td>
				<td><b>Any other Matter</b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td colspan="3"><%String strOthers = Helper.correctEditor((String) hshValues
					.get("tlr_others"));%> <%if (strOthers.trim().equals("")) {%> N.A.
				<%}else{%> <%= strOthers%> <%}%></td>
			</tr>
			<tr>
				<td width="2%"><b>19</b></td>
				<td><b>RECOMMENDATIONS</b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			
			<tr>
				<td width="2%"><B>19.1</B>&nbsp;</td>
				<td colspan="3">In view of above we recommend for review Term Loan of Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("proposedlimit")))) %> <%=strValuesin %> on the terms mentioned hereunder:</td>
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
					   <td rowspan="2" width="10%">
						<div align="center">Margin(%)</div>
						</td>
						<td rowspan="2" width="8%">
						<div align="center">Int./Comm.</div>
						</td>

						<td rowspan="2" width="31%">
						<div align="center">Security Details</div>
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
					<td align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) arrComColList
										.get(1))%> </b></td>
					<td  align="right" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) arrComColList.get(3))))%></td>
					<td  align="right" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) arrComColList.get(7))))%></td>
					
					

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

					<td  align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
													.correctDouble((String)arrSecCol
															.get(2))))%>&nbsp;</td>
					<td  align="left" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.correctNull((String) arrComColList
										.get(8))%></td>
																				
						<td align="left" valign="top"><%=Helper
					.correctNull((String)arrSecCol
							.get(0))%>&nbsp;</td>										
					<%} else { %>
					<tr>

						<td  valign="top" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
													.correctDouble((String)arrSecCol
															.get(2))))%>&nbsp;</td>
							<td  valign="top" align="left"><%=Helper
													.correctNull((String) arrSecCol
															.get(0))%>&nbsp;</td>											
						<%}
					}
				} else { %>

					<td valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
					<td align="left" valign="top"
						rowspan="<%=introwspan%>">&nbsp;<%=Helper.correctNull((String) arrComColList
										.get(8))%></td>
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
			<tr>
				<td width="2%"><b>20</b></td>
				<td><b>TERMS AND CONDITIONS:</b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="2%">&nbsp;</td>
				<td colspan="3"><% String strtlconditions = Helper.correctEditor((String) hshValues
					.get("tlr_condtions"));%> <%if (strtlconditions.trim().equals("")) {%>
				N.A. <%}else{%> <%= strtlconditions%> <%}%></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
<tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr> 
       	   <td colspan="2">Submitted for Approval,</td>
        </tr>
        <tr>
        	<td colspan="2">&nbsp;</td>
        </tr>
        <%if (!Helper.correctNull(
					(String) hshValues.get("tlr_mcmresolution"))
					.equalsIgnoreCase("")) {%>
        <tr> 
	    
          <td colspan="2" class="just"><b>Resolution:</b><br><br>
			<b>If approved,</b> the MANAGEMENT COMMITTEE <b>is requested to adopt the following resolution.
			</b><br><br>
        	<%=Helper.formatTextAreaData((String) hshValues
								.get("tlr_mcmresolution"))%></td>
        </tr>
        
        <%}

			%>
        <tr> 
          <td valign="top" align="left" colspan="2">&nbsp;</td>
        </tr>
        <%
        if((!Helper.correctNull((String)hshValues.get("tlr_gridmeeting")).equals("")) || 
           (!Helper.correctNull((String)hshValues.get("tlr_meetingdate")).equals("")))
        {
        %>
          <tr> 
           <td colspan="2">The above proposal was placed before the Credit Approval Grid in
          the <b><%=Helper.correctNull((String)hshValues.get("tlr_gridmeeting"))%></b> meeting held on <b><%=Helper.correctNull((String)hshValues.get("tlr_meetingdate"))%></b>.The Grid	has recommended the proposal.</td>
        </tr>
        <%} %>
           <tr> 
        	<td width="10%">&nbsp;</td>
          <td valign="top" align="left">&nbsp;</td>
          <tr> 
        
          <td colspan="2"><b><%=Helper.correctNull((String) hshValues
							.get("tlr_signatories"))%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
</body>
</html>

