<%@ page import="com.sai.laps.helper.*,java.util.*,java.text.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

String strFlag = "",strAppSecFlag="",strAppSecManualFlag="";

boolean bflag1 = true;

String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));
String strPagevalue = Helper.correctNull((String)request.getParameter("pagevalue"));
String strAmountvalue=Helper.correctNull((String) hshValues.get("com_amountvalue"));
String strNil = "Nil";
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strWhetherBRAvail = Helper.correctNull((String) hshValues
		.get("strWhetherBRAvail"));
if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
	
	
}
HashMap hshValuesAN3 = (HashMap) hshValues.get("AN3");

if(hshValuesAN3!=null)
{
	strAppSecFlag = Helper.correctNull((String) hshValuesAN3
			.get("COMSEC_APPCOVERAGE"));
	strAppSecManualFlag = Helper
			.correctNull((String) hshValuesAN3
					.get("COMSEC_SECTYPE"));
	
	
	HashMap hshSecdata = (HashMap) hshValuesAN3.get("hshsecdet");
	if (hshSecdata != null)
		strFlag = Helper.correctNull((String) hshSecdata
				.get("strFlag"));
}
ArrayList arrRecommRow = new ArrayList();
ArrayList arrFinCommRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrRowNonBr = new ArrayList();
ArrayList arrColNonBr = new ArrayList();
ArrayList arrMCLRRow = new ArrayList();
ArrayList arrDeleRow = new ArrayList();
ArrayList arrRow12 = new ArrayList();
ArrayList arrCol12 = new ArrayList();
ArrayList arrGuaRow = new ArrayList();
ArrayList arrRowtemp= new ArrayList();
ArrayList arrColtemp= new ArrayList();

ArrayList arrProfitability = new ArrayList();
arrProfitability = (ArrayList) hshValues.get("arrProfitability");
arrFinCommRow = (ArrayList) hshValues.get("arrfinComments");
arrRecommRow = (ArrayList) hshValues.get("arrRecommRow");
arrRowNonBr = (ArrayList) hshValues.get("arrRowNonBr");
arrMCLRRow = (ArrayList) hshValues.get("arrMCLR");
arrDeleRow = (ArrayList) hshValues.get("arrDeleRow");
arrRow12 = (ArrayList) hshValues.get("arrRow2");
ArrayList arrFacilityTerm0 = (ArrayList) hshValues.get("arrFacilityTerm0");
ArrayList arrFacilityIdVal0 = (ArrayList) hshValues.get("arrFacilityIdVal0");
ArrayList arrParentID0 = (ArrayList) hshValues.get("arrParentID0");
ArrayList arrFacilityTermApp0 = (ArrayList) hshValues.get("arrFacilityTermApp0");

ArrayList arrNFBRowIM = new ArrayList();
ArrayList arrNFBRow = new ArrayList();
ArrayList arrBGLmtRow = new ArrayList();
ArrayList arrBCLmtRow = new ArrayList();

arrNFBRowIM = (ArrayList) hshValues.get("arrNFBRowIM");
arrNFBRow = (ArrayList) hshValues.get("arrNFBRow");
arrBGLmtRow = (ArrayList) hshValues.get("arrBGLmtRow");
arrBCLmtRow = (ArrayList) hshValues.get("arrBCLmtRow");
ArrayList arrMISRow = (ArrayList) hshValues.get("arrMISRow");
ArrayList arrColMIS = new ArrayList();

ArrayList temparrCol = new ArrayList();

int intRatiCount = Integer.parseInt(Helper.correctInt((String) hshValues.get("rati_Count")));
HashMap hshAddeDetails1 = (HashMap) hshValues.get("PROPOSALLC");
if (hshAddeDetails1 != null) {
	arrGuaRow = (ArrayList) hshAddeDetails1.get("arrGuaRow");
}
arrMISRow = (ArrayList) hshValues.get("arrMISRow");
int intODCCRow=0;
ArrayList arrOthDetRow=new ArrayList();

if (hshValues != null) {
	arrOthDetRow = (ArrayList) hshValues.get("arrOthDetRow");


	if (arrOthDetRow != null)
		intODCCRow = arrOthDetRow.size();

	if (intODCCRow == 0)
		intODCCRow = 1;
}
String strmisDesc[] = { "Facility Desc", "Type of Facility and Facility Serial Number",
		"Activity Code", "Main Activity", "Sub Activity",
		"Agriculture/Industry/Service Category type","Sector",
		"Sub sector","Sensitive sector",
		"StandUp India","Government announced scheme","Guarantee Cover By",
		"Guarantee Covered Amount","Sales Turnover of the Applicant",
		"Sales Turnover As on Date",
		"Criteria for Sales Turnover","Investment in Plant & Machineries/Equipments","Industry Name",
		"Investment value as on Date","Criteria for Investment value","Weaker Section","Whether Start up as per definition of Ministry of Commerce and Industry"
		};
%>
<%
if(!strPagevalue.equalsIgnoreCase("LC")){
	if (Helper.correctNull((String) hshValues.get("com_sancauthority"))
			.equals("15")
			|| Helper.correctNull(
					(String) hshValues.get("com_sancauthority"))
					.equals("16")) {
%>
<tr><td>In the light of the above, we recommend for considering the proposal and the following resolution may be passed with or without modifications.<br><br>
"Resolved that <b><%=Helper.correctNull((String) hshValues
								.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues
								.get("perapp_name"))%></b> be sanctioned the following facilities on the terms and conditions, mentioned here under:
</tr>
<%
	} else {
%>
<tr><td>In the light of the above,<b><%=Helper.correctNull((String) hshValues
								.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues
								.get("perapp_name"))%></b> be sanctioned the following facilities on the terms and conditions, mentioned here under :</td></tr>
<%
	}
%>
<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										MIS Classification</td>
									</tr>
									<tr>
										<td align="right" width=""><%=strAmtValueIn%></td>
									</tr>
								</table>
								</td>
							</tr>
								<%
										if (arrMISRow != null && arrMISRow.size() > 0) {
											
											int lensize=0;
									%>
									<%for(int i=0;i<arrMISRow.size();i++) {
										
										if(lensize < 4){
											
										arrColtemp.add(i);
										lensize++;
										
										}else{
											arrRowtemp.add(arrColtemp);
											arrColtemp= new ArrayList();
											lensize=0;
											arrColtemp.add(i);
											lensize++;
										}
										
									}
									arrRowtemp.add(arrColtemp);
									}%>
									<%
										if (arrMISRow != null && arrMISRow.size() > 0) {
											arrColtemp= new ArrayList();
											for(int k=0;k<arrRowtemp.size();k++){
												arrColtemp=(ArrayList)arrRowtemp.get(k);
											
									%>
									<tr>
								<td>
								<div id="top"><span title="pagebreak"
									contentEditable="TRUE" onPaste="event.returnValue=false"
									onKeyDown="callKeyDown()"></span>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
			int intlength=0;
			String val="";						
				intlength=(strmisDesc.length);
				String strstatus="",strrestruc="";
			%>
		
				<tr>
				<td><b><%=strmisDesc[1] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(21))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[2] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(3))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[3] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.changetoTitlecase((String)arrColMIS.get(1))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[4] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.changetoTitlecase((String)arrColMIS.get(2))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[5] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(18))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[6] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(4))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[7] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(5))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[8] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(6))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[20] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(22))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[9] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(7))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[10] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(8))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[11] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(9))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[12] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(11)))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[13] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(13)))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[14] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(14))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[15] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(15))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[16] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(16)))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[17] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(17))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[18] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(19))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[19] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(20))%></td>
			   <%} %>
			 </tr>
			<%if(Helper.correctNull((String)arrColMIS.get(24)).equalsIgnoreCase("Y")){%>
			 <tr>
				<td><b><%=strmisDesc[21] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(23))%></td>
			   <%}} %>
			 </tr>
			
				</table>
								</div>
								</td>
							</tr>					<%
										}
											}
										else {
									%>
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>	
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>NATURE OF FACILITY AND LIMITS:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="25%" align="center">Type of Facility</td>
				<td width="15%" align="center">Type of Limit</td>
				<td width="15%" align="center">Nature of Facility</td>
				<td align="center" colspan="2">Amount</td>
				<td width="27%" align="center" nowrap="nowrap">Facility Availing Branch</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				
				<%if(Double.parseDouble(Helper.correctDouble((String)arrCol.get(17)))!=0){ %>
				<td align="center" rowspan="3"><%=i + 1%>.</td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(5))%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(26))%></td>
				<td>Loan Sanction Amount</td>
				<%if(!Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("SF")){ %>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))-Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(17)))),strAmountvalue)%></td>
					<%}else{ %>
				<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))),strAmountvalue)%></td>
				<%} %>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(18))%></td>		
				</tr>
				<tr>
					<td><%=Helper.correctNull((String) arrCol.get(19))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(17))))),strAmountvalue)%></td>
				</tr>
				<tr class="title">
					<td>Total Loan Sanction Limit</td>
					
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)))),strAmountvalue)%></td>
				<%}else{ %>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(5))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(26))%></td>
				<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%><br/>Without any insurance coverage.</td>
				<td align="left" rowspan=""><%=Helper.correctNull((String) arrCol.get(18))%></td>
				<%} %>
				</tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% int w=0;
			if(arrRecommRow!=null&&arrRecommRow.size()>0){ 
			
			boolean bflag=false;
			
			for(int i=0;i<arrRecommRow.size();i++)
			{
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					if(Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("SF"))
						bflag=true;
				}
			}%>
			 <%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					 if(!Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("NC")&&!Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("")){
					w++;
		
			if(w==1) {%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="20%" align="center">Type of Facility</td>
				<td width="15%"align="center">Insurance Covered Under</td>
				<td width="7%" align="center" >Premium Tenor<br>(in Months)</td>
				<td width="10%" align="center">Loan amount covered under the scheme</td>
				<%if(bflag){ %>
				<td width="10%" align="center">Premium Amount</td>
				<td width="10%" align="center">Operative account number from which<br> premium account will be debited </td>
				<td width="10%" align="center">Company Name </td>
				<%} %>
			 </tr>
			 <%} %>
			
			<tr>
				<td align="center"><%=w%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(19))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(21))%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(22))))),strAmountvalue)%></td>
				<%if(Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(17))))),strAmountvalue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(23))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(25))%></td>
				<%}
				else if(bflag)
				{%>
				<td align="right" colspan="3">&nbsp;</td>
				<%} %>
				
				
		   	</tr>
			<%}}} %>
			
	 <%} %>
	 </table>
	 </div>
	 </td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>RATE OF INTEREST/ COMMISSION:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<%if(strSessionModuleType.equalsIgnoreCase("CORP")){ %>
<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%int j=0;
			if(arrRecommRow!=null&&arrRecommRow.size()>0 && strWhetherBRAvail.equalsIgnoreCase("Y")){ 
				 %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||
						Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB")
						||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS")
						||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("FTBR")){
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
			</tr>
			<%} }}%>
<%if((arrRowNonBr!=null && arrRowNonBr.size()>0)&&(!Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("FTBR")))
	{
		for(int k=0;k<arrRowNonBr.size();k++)
		{
			arrColNonBr=(ArrayList)arrRowNonBr.get(k);
			if(arrColNonBr.size()>0)
			{
			%>
			<tr>
			<td align="center"><%=j+1%>.</td>
			<td><%=Helper.correctNull((String)arrColNonBr.get(0)).toUpperCase()%></td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrColNonBr.get(2))))),strAmountvalue)%></td>
			<td><%=Helper.correctNull((String)arrColNonBr.get(1))%></td>
			</tr>
			<%	
			}
			j=j+1;
		}
	}%>
	
	<%if(arrMCLRRow!=null && arrMCLRRow.size()>0){ %>
	<tr>
	<td colspan="4">
	<%for(int k=0;k<arrMCLRRow.size();k++)
	{ %>
	<%=Helper.correctNull((String)arrMCLRRow.get(k))%><br/>
	<%} %>
	</td>
	</tr>
	<%} %>
	</table>
		</div>
	<%
}else{%>
	<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ 
				int j=0; %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%></td>
				<%if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLEC")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS")){ %>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
				<%}else{ %>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(16))%> at the Rate of <%=Helper.correctNull((String)arrCol.get(3))%> % </td>
				<%} %>
			</tr>
			<%}}%>
			
				<%if(arrMCLRRow!=null && arrMCLRRow.size()>0){ %>
				<tr>
				<td colspan="4">
				<%for(int k=0;k<arrMCLRRow.size();k++)
				{ %>
				<%=Helper.correctNull((String)arrMCLRRow.get(k))%><br/>
				<%} %>
				</td>
				</tr>
				<%} %>
			</table>
		</div>
	</td>
</tr>
<%}%>



<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MARGIN:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Margin</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(10))%><br/>
				<%if(!Helper.correctNull((String) arrCol.get(29)).equalsIgnoreCase("")){ %>Relaxation in margin as per RBI COVID relief Package Policy : <%=Helper.correctNull((String) arrCol.get(29))%><%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(27)).equalsIgnoreCase("")){ %>Actual Margin(%) :<%=Helper.correctNull((String) arrCol.get(27)) %> <%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(28)).equalsIgnoreCase("")){ %>Relaxed Margin(%):<%=Helper.correctNull((String) arrCol.get(28)) %> <%} %>
				</td>
			</tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>PERIOD:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="37%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="15%" align="center">Tenor <br>(in Months)</td>
				<td width="15%" align="center">Initial Holiday/ Gestation/ Moratorium Period <br>(in Months)</td>
				<td width="15%" align="center">Due Date</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%></td>
				<td align="right"><%=Helper.correctInt((String) arrCol.get(6))%></td>
				<td align="right"><%=Helper.correctNull((String) arrCol.get(11))%></td>
				<%if(!Helper.correctNull((String) arrCol.get(15)).equalsIgnoreCase("")){ %>
				<td align="center"><%=Helper.correctNull((String) arrCol.get(15))%></td>
				<%}else{ %>
				<td align="center">-</td>
				<%} %>
			</tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>


<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MODE OF REPAYMENT:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>


<tr>
	<td>
		
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0 )
				{
			%>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td width="4%" align="center">Sl.No</td>
				<td width="46%" align="center">Type of Facility</td>
				<td width="46%" align="center">Mode of Repayment</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
					//	arrOutCol1 = (ArrayList) arrOutRow1.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(9))%></td>
				
			</tr>
			<%
				}		%>
				</table>
		</div>
				<%}else{ %>
			Nil
			<%} %>
	</td>
</tr>

<%
		ArrayList arrOutCol1	= new ArrayList();
		ArrayList arrOutRow1	= (ArrayList) hshValues.get("arrOutRow1");
	%>
	
	
	<tr><td><b>REPAYMENT SCHEDULE COMMENTS:</b></td></tr>
	<tr>
		<td>&nbsp;
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<%
				if (arrOutRow1 != null && arrOutRow1.size() > 0 )
				{
					for (int i = 0; i < arrOutRow1.size(); i++) 
					{
						arrOutCol1 = (ArrayList) arrOutRow1.get(i);
			%>
				<tr>
					<td align="left" width="20%"  class="title">&nbsp;<u><%=Helper.correctNull((String) arrOutCol1.get(0))%>-<%=Helper.correctNull((String) arrOutCol1.get(1))%> :</u></td></tr>
				<tr><td align="left" width="50%"><%=Helper.correctNull((String) arrOutCol1.get(2))%></td></tr>
	           <%String StrStageWiseRelease=Helper.correctNull((String) arrOutCol1.get(3));
										if(StrStageWiseRelease.equalsIgnoreCase("Y")){
											StrStageWiseRelease="Yes";
										}else if(StrStageWiseRelease.equalsIgnoreCase("N")){
											StrStageWiseRelease="No";
										}else{
											StrStageWiseRelease="";
										}%>
										<% if(!StrStageWiseRelease.equalsIgnoreCase("")){%>
									<tr><td><b>Stage Wise Release Of Loan &nbsp;<b>:</b>&nbsp;&nbsp;&nbsp;</b><%=StrStageWiseRelease%></td></tr>
								<%}
									}
										}else{		
								%>
								<tr><td>&nbsp;Nil</td></tr>
								<%} %>
			</table>
		</td>
	</tr>
<tr>
	<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> + Applicable Taxes</td>
</tr>
<tr> 
	<td>&nbsp;</td>
</tr>
<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<%ArrayList vecNcgtcRow=new ArrayList();
	ArrayList vecNcgtcCol=new ArrayList();
	vecNcgtcRow=(ArrayList)hshValues.get("vecNcgtcRow");
	if(vecNcgtcRow!=null){
				vecNcgtcCol=new ArrayList();
				int intncgtcSize = 0;
				intncgtcSize = vecNcgtcRow.size();
				if(intncgtcSize>0){
				%>
			
				<tr>
				<td colspan="3"><b>KBL Aarogya NCGTC Details</b></td>
				</tr>
				<%for(int s=0;s<intncgtcSize ;s++)
				{
					vecNcgtcCol = (ArrayList) vecNcgtcRow.get(s);%>
	<tr>
	<td colspan="3"><b><%=Helper.correctNull((String)vecNcgtcCol.get(13))%> - <%=Helper.correctNull((String)vecNcgtcCol.get(14))%></b></td>
	</tr>
	<tr class="">
		<td width="40%" style="text-align: center"><b>Details of the Project</b></td>
		<td width="30%" style="text-align: center"><b>Project description</b></td>
		<td width="30%" style="text-align: center"><b>Eligibility</b></td>
	</tr>
	<%if(Helper.correctNull((String)vecNcgtcCol.get(2)).equals("1")){ %>
	<tr>
		<td width="40%">Type of the Project</td> 
		<td width="30%"><%=Helper.correctNull((String)vecNcgtcCol.get(3))%></td>
		<td width="30%">&nbsp;</td>
	</tr>
	<tr id="t1">
		<td>New employment likely to be generated in case of greenfield projects&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(4))%>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<%}else if(Helper.correctNull((String)vecNcgtcCol.get(2)).equals("2")){ %>
	<tr>
		<td width="40%">Type of the Project</td> 
		<td width="30%"><%=Helper.correctNull((String)vecNcgtcCol.get(3))%></td>
		<td width="30%">&nbsp;</td>
	</tr>
	<tr id="t2">
		<td>Additional employment likely to be generated in case of brownfield&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(5))%>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<%}%>
	<tr>
		<td>Whether the project is in any of the metropolitan cities  Ahmedabad, Bengaluru, Hyderabad, Chennai, Kolkata, Mumbai, New Delhi and Pune&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(6))%>&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(7))%>&nbsp;</td>
	</tr>
	<tr>
		<td>Industry Sector&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(8))%>&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(9))%>&nbsp;</td>
	</tr>
		<tr>
		<td>Udyog Aadhaar Number(12 Digits)&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(10))%>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="60%">Project unit pin code</td>
		<td width="40%"><%=Helper.correctNull((String)vecNcgtcCol.get(11))%></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="60%">Nature of the Project</td>
		<td width="40%"><%=Helper.correctNull((String)vecNcgtcCol.get(12))%></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
	<td colspan="3"><b>&nbsp;</b></td>
	</tr>
	<%}}} %>
</table>
</td>
</tr>
<tr>
<td> &nbsp;</td>
</tr>
<tr><td class="title"><br><br><b>Security :</b> As per Annexure III-(a)-(C).</td></tr>
 
<tr><td class="title">TERMS AND CONDITIONS:</td></tr>

<%
	int j = 0;
	int sub = 0;
	int main = 0;
	String prevSno = "";
	String currParentId = "";
	String termsno = "";
	boolean booflag = true;
	boolean subflag = true;

	if (arrFacilityTerm0 != null && arrFacilityTerm0.size() > 0) {
%>
		<tr><td class="title"><b>Specific:</b></td></tr>
	<%
		j = arrFacilityTerm0.size();
			for (int i = 0; i < arrFacilityTerm0.size(); i++) {
				termsno = Helper.correctNull((String) arrFacilityIdVal0
						.get(i));
				currParentId = Helper.correctNull((String) arrParentID0
						.get(i));
				if (currParentId.equalsIgnoreCase("0") && subflag == true) {
					booflag = true;
					sub = 0;
				}
				if (booflag) {
					main = main + 1;
					prevSno = Helper.correctNull((String) arrFacilityIdVal0
							.get(i));
					booflag = false;
				}
	%>
		<%
			if (currParentId.equalsIgnoreCase("0")) {
						subflag = true;
		%>
		<tr> 
		  	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="100%" >
			      	<tr>
			      		<td width="2%" valign="top"><%=main%>.</td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
		</tr>
		<%
			}
					if (prevSno.equalsIgnoreCase(currParentId)
							&& (!currParentId.equalsIgnoreCase("0"))) {
		%>
		<tr> 
	      	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="98%" align="right">
			      	<tr>
			      		<td width="2%" valign="top">&nbsp;<%=main%>.<%=++sub%></td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
	    </tr>
		
		<%
					}
						}
					}
				%>
	<%
		if (arrFacilityTermApp0 != null) {
			for (int i = 0; i < arrFacilityTermApp0.size(); i++) {
				main = main + 1;
	%>
		<tr > 
		  <td align="center"> 
		    <div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
		  </td>
		</tr>
		<%
			}
			}
		%>

<tr><td class="title"><b>General:</b> &nbsp;Indicated in Annexure VI</td></tr>

<%if (intRatiCount > 0) {
	%>
	<tr><td class="title"><b>Ratifications: </b></td></tr>

	 <%
	 	for (int i = 0; i < intRatiCount; i++) {
	 %>
		<tr><td class="title"><%=Helper.correctNull((String) hshValues
											.get("rati_desc" + i))%></td></tr>
		<tr><td><%=Helper.correctNull((String) hshValues
											.get("rati_comments" + i))%></td></tr>
	<%
		}
			} %>
<tr>
<td>
<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
	if (arrDeleRow != null && arrDeleRow.size() > 0) {
		for (int i = 0; i < arrDeleRow.size(); i++) {
			arrCol = (ArrayList) arrDeleRow.get(i);
			boolean bflag=false;
			if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("021") && !Helper.correctNull((String)hshValues.get("com_griddate")).equalsIgnoreCase(""))
			{
				bflag=true;
			}
%>
<%
	if (i % 2 == 0) {
%>
<tr><td align="left"><br> <%=Helper.correctNull((String) arrCol.get(0))%> </td></tr>
<tr><td align="left"> <%=Helper.correctNull((String) arrCol.get(1))%> </td></tr>
<%} else {
%>
<tr><td align="right"><br> <%=Helper.correctNull((String) arrCol.get(0))%> </td></tr>
<tr><td align="right"> <%=Helper.correctNull((String) arrCol.get(1))%> </td></tr>
<%
	}
%>
<%
	}
	}
%>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>

</table>
<div id="top" >
<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0" style="page-break-before:always">
	<tr>
		<td>Annexure No</td>
		<td>Particulars</td>
	</tr>
	<tr>
		<td>I</td>
		<td>Branch Indices</td>
	</tr>
	<tr>
		<td>II</td>
		<td>Grid Observations and Justification</td>
	</tr>
	<tr>
		<td>III</td>
		<td>Details Of Credit Facilities</td>
	</tr>
	<tr>
		<td>IV</td>
		<td>Financial Statement/ Ratio Analysis </td>
	</tr>
	<tr>
		<td>V</td>
		<td>Conduct of operations </td>
	</tr>
	<tr>
		<td>VI</td>
		<td>Calculation of rate of interest under MCLR Guidelines</td>
	</tr>
	<tr>
		<td>VII</td>
		<td>General Conditions</td>
	</tr>

		<tr>
			<td>VIII</td>
			<td>Rate of interest for Export finance</td>
		</tr>
		<tr>
			<td>IX</td>
			<td>Projected Financial Statements </td>
		</tr>
		<tr>
			<td>X</td>
			<td>Any other enclosures with relevance to the proposal like Work on hand statement, Unaudited financial results for the quarter ended (latest quarter), Discussion with regard to compliance to RBI Circulars etc</td>
		</tr>
		<%}else{%>
		
		<tr>
	<td>
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0">
		<!-- Non Funded Limits - Inland LC -->

		<%
			if ((arrNFBRow != null && arrNFBRow.size() > 0)
					|| (arrNFBRowIM != null && arrNFBRowIM.size() > 0)
					|| (arrBGLmtRow != null && arrBGLmtRow.size() > 0)
					|| (arrBCLmtRow != null && arrBCLmtRow.size() > 0)) {
		%>
		<tr>
			<td width="25%" class="title">V. Non Funded Limits</td>
			<td colspan="<%=intODCCRow + intODCCRow%>">&nbsp;</td>
		</tr>
		
		<%if(arrOthDetRow!=null && arrOthDetRow.size()>0){ %>
				<tr>
					<td width="25%" valign="top">Period</td>
					<%for(int i=0;i<arrOthDetRow.size();i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="center" colspan="2"><b><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;&nbsp;to&nbsp;&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></b></td>
					<%} else { %>
					<td colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%}} %>

		<%
			if (arrNFBRow != null && arrNFBRow.size() > 0) {
		%>
		<tr>
			<td width="25%" class="title">InLand LC Limit</td>
			<td colspan="<%=intODCCRow + intODCCRow%>">&nbsp;</td>
		</tr>

		<tr>
			<td width="25%">Sanctioned Inland LC Limit</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRow.size(); j++) {
							arrCol = (ArrayList) arrNFBRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="right" colspan="2"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(0))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">&nbsp;</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRow.size(); j++) {
							arrCol = (ArrayList) arrNFBRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center" class="title">No.</td>
			<td align="center" class="title">Amount</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>


		<tr>
			
			<td width="25%">Inland LC (DP)</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRow.size(); j++) {
							arrCol = (ArrayList) arrNFBRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol
													.get(1))%></td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(2))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Inland LC (DA)</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRow.size(); j++) {
							arrCol = (ArrayList) arrNFBRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol
													.get(3))%></td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(4))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Devolvement under Inland LC</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRow.size(); j++) {
							arrCol = (ArrayList) arrNFBRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol
													.get(9))%></td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(10))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<tr>
			
			<td width="25%">No. of occasion excesses permitted</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRow.size(); j++) {
							arrCol = (ArrayList) arrNFBRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="right" colspan="2"><%=Helper.correctInt((String) arrCol
													.get(11))%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<tr>
			
			<td width="25%">Remarks</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRow.size(); j++) {
							arrCol = (ArrayList) arrNFBRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td colspan="2">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(12))%></td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<tr>
			
			<td width="25%">Comments on performance</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRow.size(); j++) {
							arrCol = (ArrayList) arrNFBRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td colspan="2">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(14))%></td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<%
			}
		%>


		<!-- Non Funded Limits - Import LC -->

		<%
			if (arrNFBRowIM != null && arrNFBRowIM.size() > 0) {
		%>
		<tr>
			
			<td width="25%" class="title">Import LC Limit</td>
			<td colspan="<%=intODCCRow + intODCCRow%>">&nbsp;</td>
		</tr>
		<tr>
			
			<td width="25%">Sanctioned Import LC Limit</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRowIM.size(); j++) {
							arrCol = (ArrayList) arrNFBRowIM.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="right" colspan="2"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(0))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">&nbsp;</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRowIM.size(); j++) {
							arrCol = (ArrayList) arrNFBRowIM.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center" class="title">No.</td>
			<td align="center" class="title">Amount</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>


		<tr>
			
			<td width="25%">Import LC (DP)</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRowIM.size(); j++) {
							arrCol = (ArrayList) arrNFBRowIM.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol
													.get(5))%></td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(6))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Import LC (DA)</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRowIM.size(); j++) {
							arrCol = (ArrayList) arrNFBRowIM.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol
													.get(7))%></td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(8))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Devolvement under Import LC</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRowIM.size(); j++) {
							arrCol = (ArrayList) arrNFBRowIM.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol
													.get(9))%></td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(10))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">No. of occasion excesses permitted</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRowIM.size(); j++) {
							arrCol = (ArrayList) arrNFBRowIM.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="right" colspan="2"><%=Helper.correctInt((String) arrCol
													.get(11))%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		
		<tr>
			
			<td width="25%">Remarks</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRowIM.size(); j++) {
							arrCol = (ArrayList) arrNFBRowIM.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td colspan="2">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(12))%></td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Comments on Performance</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrNFBRowIM.size(); j++) {
							arrCol = (ArrayList) arrNFBRowIM.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(13));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td colspan="2">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(14))%></td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<%
			}
		%>

		<!-- Sanctioned Bank Guarantee Limit -->

		<%
			if (arrBGLmtRow != null && arrBGLmtRow.size() > 0) {
		%>
		<tr>
			
			<td width="25%" class="title">Bank Guarantee Limit</td>
			<td colspan="<%=intODCCRow + intODCCRow%>">&nbsp;</td>
		</tr>
		<tr>
			
			<td width="25%">Sanctioned Bank Guarantee Limit</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBGLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBGLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(6));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="right" colspan="2"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(0))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">&nbsp;</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBGLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBGLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(6));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center" class="title">No.</td>
			<td align="center" class="title">Amount</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Guarantees issued</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBGLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBGLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(6));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="right"><%=Helper.correctInt((String) arrCol
													.get(1))%>&nbsp;</td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(2))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Guarantees invoked</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBGLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBGLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(6));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="right"><%=Helper.correctInt((String) arrCol
													.get(3))%>&nbsp;</td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(4))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Remarks on Guarantees Invoked. Reasons, present
			status of such guarantees</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBGLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBGLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(6));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td colspan="2">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(5))%></td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<tr>
			
			<td width="25%">Comments on Performance</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBGLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBGLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(6));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td colspan="2">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(7))%></td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<%
			}
		%>

		<!-- Sanctioned Buyers credit limit -->

		<%
			if (arrBCLmtRow != null && arrBCLmtRow.size() > 0) {
		%>
		<tr>
			
			<td width="25%" class="title">Buyers credit limit</td>
			<td colspan="<%=intODCCRow + intODCCRow%>">&nbsp;</td>
		</tr>

		<tr>
			
			<td width="25%">Sanctioned Limit</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBCLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBCLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(8));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="right" colspan="2"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(0))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">&nbsp;</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBCLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBCLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(8));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center" class="title">No.</td>
			<td align="center" class="title">Amount</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<tr>
			<td width="25%">Buyers credit for LC bills</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBCLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBCLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(8));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol.get(1))%></td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))),strAmountvalue)%>&nbsp;</td>
			<%
				}}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}}
			%>
		</tr>
		<tr>
			<td width="25%">&nbsp;</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBCLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBCLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(8));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol.get(3))%></td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))),strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<tr>
			<td width="25%">Buyers credit for LC bills</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBCLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBCLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(8));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol
													.get(1))%></td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(2))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Devolvement</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBCLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBCLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(8));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td align="center"><%=Helper.correctInt((String) arrCol
													.get(5))%></td>
			<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(6))))),
															strAmountvalue)%>&nbsp;</td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			
			<td width="25%">Remarks</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBCLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBCLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(8));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td colspan="2">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(7))%></td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<tr>
			<td width="25%">Comments on Performance</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						boolean bflag = true;
						for (int j = 0; j < arrBCLmtRow.size(); j++) {
							arrCol = (ArrayList) arrBCLmtRow.get(j);
							String yearsno = Helper.correctNull((String) arrCol
									.get(8));

							temparrCol = (ArrayList) arrOthDetRow.get(i);
							String mainyearsno = Helper
									.correctNull((String) temparrCol.get(5));
							if (yearsno.equalsIgnoreCase(mainyearsno)) {
								bflag = false;
			%>
			<td colspan="2">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(9))%></td>
			<%
				}
						}
						if (bflag) {
			%>
			<td colspan="2">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<%
			}
		%>
	</table>
	</div>
	</td>
</tr>
		
		<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
		border="0">
		<tr>
			<td class="title" align="left">VI. Comments of Significant
			variations in Financial Indicators with proper Justifications</td>
		</tr>
	</table>
	</td>
</tr>

<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0">
		<%
			if (Helper.correctNull((String) hshValues.get("fincommcheck"))
					.equalsIgnoreCase("Y")) {
		%>
		<%
			if (arrFinCommRow != null && arrFinCommRow.size() > 0) {

					for (int j = 0; j < arrFinCommRow.size(); j++) {
						arrCol = (ArrayList) arrFinCommRow.get(j);
		%>
		<tr>
			<td align="left" class="title"><%=Helper.correctNull((String) arrCol.get(0))%></td>
		</tr>
		<tr>
			<td align="left"><%=Helper.correctNull((String) arrCol.get(1))%></td>
		</tr>
		<%
			}
				}
			} 
		%>
	</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>

<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
		border="0">
		<%
	if(!strAppSecFlag.equalsIgnoreCase("M")){
	if((strFlag.equalsIgnoreCase("C"))){%>
	<tr>
	<td class="title">VII.Common securities for Associate Concern/Group Concerns:<div align="right"><%=strAmtValueIn%></div></td>
	</tr>
	<tr>
		<td>
			<div align="left" id="top">
				<jsp:include page="../print/Securitiesprint.jsp" flush="true">
				<jsp:param name="pageVal" value="Security"/>
				</jsp:include>
			</div>
		</td>
	</tr>
	<%}else{%>
	<tr>
	<td class="title">VII.Common securities for Associate Concern/Group Concerns:<%=strNil%></td>
	</tr>
	<%}}else if(strAppSecFlag.equalsIgnoreCase("M") && strAppSecManualFlag.equalsIgnoreCase("C")){ %>
	<tr>
	<td class="title">VII.Common securities for Associate Concern/Group Concerns:</div></td>
	</tr>
	<tr>
	<td><%=Helper.correctNull((String)hshValues.get("COMSEC_APPCOMMENTS"))%></td>
	</tr>
	<%}%>
	</table>
	</td>
</tr>
		
		<br>
<!-- TRANSACTIONS IN THE EXISTING ACCOUNTS-->
<tr>
	<td><span title="pagebreak" contentEditable="TRUE"
		onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span> <jsp:include
		page="../print/com_AnnexureV.jsp" flush="true">
		<jsp:param name="pageVal" value="ANN5" />
		<jsp:param name="proposalFormat" value="RPN" />
	</jsp:include></td>
</tr>

<!-- END -->
<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
		border="0">
		<tr>
			<td class="title" align="left">IX: Profitability of the
			Borrower</td>
		</tr>
	</table>
	</td>
</tr>
<tr>
	<td align="center">
	<%if (arrProfitability != null && arrProfitability.size() > 0) { %>
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0">
		<tr align="center" class="title">
			<td width="5%">Sl.No &nbsp;</td>
			<td width="15%">Particulars &nbsp;</td>
			<td width="25%">FTP - Profit/(Loss) &nbsp;</td>
			<td width="25%">FTP Yield (%) &nbsp;</td>
			<td width="25%">RAROC &nbsp;</td>
		</tr>
		<%
			if (arrProfitability != null && arrProfitability.size() > 0) {
				for (int c = 0; c < arrProfitability.size(); c++) {
					arrCol = (ArrayList) arrProfitability.get(c);
		%>
		<tr>
			<td><%=c + 1%>&nbsp;</td>
			<td><%=Helper.correctNull((String) arrCol.get(0))%> - <%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
			<td align="right"><%=Helper.converAmount(Helper
									.correctDouble((String) arrCol.get(2)),
									strAmountvalue)%>&nbsp;</td>
			<td align="right"><%=Helper.correctDouble((String) arrCol
											.get(3))%>&nbsp;</td>
			<td align="right"><%=Helper.correctDouble((String) arrCol
											.get(4))%>&nbsp;</td>
		</tr>
		<%
			}
			} else {
		%>
		<tr>
			<td colspan="5" align="center"><%=strNil%>&nbsp;</td>
		</tr>
		<%
			}
		%>
	</table>
	</div>
	<%} %>
	</td>
</tr>
<%if (arrProfitability != null && arrProfitability.size() > 0) { %>
<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
		border="0">
		<tr>
			<td class="title" align="left">The breakup of FTP for the period
			(Latest available) is as under:</td>
		</tr>
		<tr>
	<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	</table>
	</td>
</tr>
<tr>
	<td>
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0">
		<tr align="center" class="title">
			<td width="30%">Description &nbsp;</td>
			<td width="20%">Amount &nbsp;</td>
		</tr>
		<tr>
			<td>Asset Margin &nbsp;</td>
			<td align="right"><%=Helper.converAmount(Helper
							.correctDouble((String) hshValues
									.get("strFTPAmtAM")), strAmountvalue)%>&nbsp;</td>
		</tr>
		<tr>
			<td>Liability Margin &nbsp;</td>
			<td align="right"><%=Helper.converAmount(Helper
							.correctDouble((String) hshValues
									.get("strFTPAmtLM")), strAmountvalue)%>&nbsp;</td>
		</tr>
		<tr>
			<td>Other Income &nbsp;</td>
			<td align="right"><%=Helper.converAmount(Helper
							.correctDouble((String) hshValues
									.get("strFTPAmtOI")), strAmountvalue)%>&nbsp;</td>
		</tr>
		<tr>
			<td>Other Expenditure &nbsp;</td>
			<td align="right"><%=Helper.converAmount(Helper
							.correctDouble((String) hshValues
									.get("strFTPAmtOE")), strAmountvalue)%>&nbsp;</td>
		</tr>
		<tr>
			<td>Total &nbsp;</td>
			<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("strFTPAmtAM")))
							+ Double.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("strFTPAmtLM")))
							+ Double.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("strFTPAmtOI")))
							+ Double.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("strFTPAmtOE")))),
							strAmountvalue)%>&nbsp;</td>
		</tr>
	</table>
	</div>
	</td>
</tr>
<%} %>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0">


		<%
			if (arrOthDetRow != null && arrOthDetRow.size() > 0) {
		%>
		<tr>
			<td>&nbsp;</td>
			<td>Advance</td>
			<%
			for (int i = 0; i < intODCCRow; i++) {
				if (i < arrOthDetRow.size()-1) {
					arrCol = (ArrayList) arrOthDetRow.get(i);
	%>
	<td align="center">Previous&nbsp;</td>
	<%
		} else {
	%>
	<td align="center">Current&nbsp;</td>
	<%
		}
			}
			%>
		</tr>
		<tr>
			<td width="3%"> &nbsp;
			</td>
			<td width="25%">Interest Income <br>
			a) Interest from all facilities</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						if (i < arrOthDetRow.size()) {
							arrCol = (ArrayList) arrOthDetRow.get(i);
			%>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(0))))),
										strAmountvalue)%>&nbsp;</td>
			<%
				} else {
			%>
			<td align="center">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>

		<tr>
			<td width="3%">&nbsp;</td>
			<td width="25%"> Fee based Income</td>
			<%
				for (int i = 0; i < intODCCRow; i++) {
						if (i < arrOthDetRow.size()) {
							arrCol = (ArrayList) arrOthDetRow.get(i);
			%>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))),
										strAmountvalue)%>&nbsp;</td>
			<%
				} else {
			%>
			<td align="center">&nbsp;</td>
			<%
				}
					}
			%>
		</tr>
		<%
			}
		%>

	</table>
	</div>
	</td>
</tr>
		
		<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
		border="0">
		<tr>
			<td class="title" align="left">X: Pricing</td>
		</tr>
	</table>
	</td>
</tr>

<tr>
	<td>
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0">
		<tbody>
			<tr class="title" align="center">
			<td width="5%" rowspan="2">Sl.No</td>
				<td width="15%" rowspan="2">Facility</td>
				<td width="15%" colspan="3">Existing Rate</td>
				<td width="35%" colspan="4">Proposed Rate</td>
			</tr>
			<tr class="title" align="center">
			<td>Benchmark Rate</td>
			<td>Spread</td>
			<td>Effective Rate</td>
			<td>Benchmark Rate</td>
			<td>Spread</td>
			<td>Interest Modification</td>
			<td>Effective Rate</td>
			</tr>
			<%
					if (arrRecommRow != null && arrRecommRow.size() > 0) {
						
						for (int i = 0; i < arrRecommRow.size(); i++) {
							arrCol = (ArrayList) arrRecommRow.get(i);
				%>
				<tr>
				<td><%=i+1 %>&nbsp;</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%if(Helper.correctNull((String) arrCol.get(42)).equalsIgnoreCase("2")){%><%=Helper.correctNull((String) arrCol.get(31))%> %<%} %>&nbsp;</td>
				<td align="left"><%if(Helper.correctNull((String) arrCol.get(42)).equalsIgnoreCase("2")){%><%=Helper.correctNull((String) arrCol.get(32))%> %<%} %>&nbsp;</td>
				<td align="left"><%if(Helper.correctNull((String) arrCol.get(42)).equalsIgnoreCase("2")){%><%=Helper.correctNull((String) arrCol.get(30))%> %<%} %>&nbsp;</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(40))%> %</td>
				<td align="left"><%=(Double.parseDouble(Helper.correctDouble((String) arrCol.get(41)))-(Double.parseDouble(Helper.correctDouble((String) arrCol.get(33)))-
						Double.parseDouble(Helper.correctDouble((String) arrCol.get(34)))+Double.parseDouble(Helper.correctDouble((String) arrCol.get(35)))))%> %</td>
				<td align="left">
				<%if(Double.parseDouble(Helper.correctDouble((String) arrCol.get(30)))!=Double.parseDouble(Helper.correctDouble((String) arrCol.get(39)))){ %>
				<%if(Double.parseDouble(Helper.correctDouble((String) arrCol.get(33)))!=0) {%>
				<br/><b>Deviation :<%=Helper.correctNull((String) arrCol.get(33)) %> %</b>
				<%if(!Helper.correctNull((String) arrCol.get(36)).equalsIgnoreCase("")) {%>
				<br/>(<%=Helper.correctNull((String) arrCol.get(36)) %>)
				<%} %>
				<%} %>
				<%if(Double.parseDouble(Helper.correctDouble((String) arrCol.get(34)))!=0) {%>
				<br/><b>Concession :- <%=Helper.correctNull((String) arrCol.get(34)) %> %</b>
				<%if(!Helper.correctNull((String) arrCol.get(37)).equalsIgnoreCase("")) {%>
				<br/>(<%=Helper.correctNull((String) arrCol.get(37)) %>)
				<%} %>
				<%} %>
				<%if(Double.parseDouble(Helper.correctDouble((String) arrCol.get(35)))!=0) {%>
				<br/><b>As Per Circular :<%=Helper.correctNull((String) arrCol.get(35)) %> %</b>
				<%if(!Helper.correctNull((String) arrCol.get(38)).equalsIgnoreCase("")) {%>
				<br/>(<%=Helper.correctNull((String) arrCol.get(38)) %>)
				<%} %>
				<%} %>
				<%} %>&nbsp;
				</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(39))%> %</td>
				</tr>
				
				<%}}else{ %>
			<tr>
				<td colspan="4" align="center"> - Nil -&nbsp;</td>
			</tr>
			<%} %>
		</tbody>
	</table>
	</div>
	</td>
</tr>
		
		<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
		border="0">
		<tr>
			<td class="title" align="left">XI: Department Observations</td>
		</tr>
	</table>
	</td>
</tr>

<tr>
	<td>
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0">
		<tr>
			<td width="25%">Compliance of previous terms & Conditions</td>
			<td width="80%"><%=Helper.correctNull((String) hshValues
							.get("strSanctionTerms"))%>
			</td>
		</tr>
		<tr class="title">
			<td colspan="2">Audit observations</td>
		</tr>
		<tr>
			<td width="25%">Internal (position as on <%=Helper.correctNull((String) hshValues
							.get("COMRBI_ASDATEIPOAS"))%>)</td>
			<td><%=Helper.correctNull((String) hshValues
							.get("COMRBI_COMMENTSIPOAS"))%></td>
		</tr>
		<tr>
			<td width="25%">RBI Inspection (position as on <%=Helper.correctNull((String) hshValues
							.get("COMRBI_ASDATERBIPO"))%>)</td>
			<td><%=Helper.correctNull((String) hshValues
							.get("COMRBI_COMMENTSRBIPO"))%></td>
		</tr>
		<tr>
			<td width="25%">Stock Audit Reports (position as on <%=Helper.correctNull((String) hshValues
							.get("COMRBI_ASDATESTAUR"))%>)</td>
			<td><%=Helper.correctNull((String) hshValues
							.get("COMRBI_COMMENTSSTAUR"))%></td>
		</tr>
		<tr>
			<td width="25%">Credit Audit Report (position as on <%=Helper.correctNull((String) hshValues
							.get("COMRBI_ASDATECRAUR"))%>)</td>
			<td><%=Helper.correctNull((String) hshValues
							.get("COMRBI_COMMENTSCRAUR"))%></td>
		</tr>
		<tr>
			<td width="25%">Unit Inspection Reports</td>
			<td><%=Helper.correctNull((String) hshValues
							.get("COMRBI_COMMENTSUNINR"))%></td>
		</tr>
		<tr>
			<td colspan="2">Any TOD /Arrears/over dues in the existing
			accounts
			<br />&nbsp;
			<table width="95%" align="center" cellpadding="3" cellspacing="0">
				<tr>
					<td>Serial Number</td>
					<td>Account Number</td>
					<td>TOD Sanc. Ref.No</td>
					<td>TOD Amount</td>
					<td>Due Date</td>
					<td>Regularisation date</td>
					<td>Comments if not regularised</td>
				</tr>


				<%
					ArrayList arrratifrow = new ArrayList();
					ArrayList arrratifcol = new ArrayList();
					arrratifrow = (ArrayList) hshValues.get("ratificationarrRow");

					if (arrratifrow != null && arrratifrow.size() > 0) {
						for (int j = 0; j < arrratifrow.size(); j++) {
							arrratifcol = (ArrayList) arrratifrow.get(j);
				%>
				<tr>
					<td><%=j+1%></td>
					<td><%=Helper.correctNull((String) arrratifcol.get(1))%></td>
					<td><%=Helper.correctNull((String) arrratifcol.get(2))%></td>
					<td><%=Helper.converAmount(Helper.correctDouble((String) arrratifcol.get(3)),strAmountvalue)%></td>
					<td><%=Helper.correctNull((String) arrratifcol.get(4))%></td>
					<td><%=Helper.correctNull((String) arrratifcol.get(5))%></td>
					<td><%=Helper.correctNull((String) arrratifcol.get(6))%></td>
				</tr>
				<%
					}
					} else {
				%>
				<tr>
					<td align="center" colspan="7"><%=strNil%></td>
				</tr>
				<%
					}
				%>


			</table>
			</td>
		</tr>
		</table>
		</div>
		</td>
		</tr>
		
		<tr>
			<td>
			<table width="95%" align="center" cellpadding="3" cellspacing="0"
				border="0">
				<tr>
					<td class="title" align="left">Recommendation</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0"
				border="0">
				<%
					if (arrRecommRow != null && arrRecommRow.size() > 0) {
				%>
				<tr>
					<td width="3%" align="center">Sl.No</td>
					<td width="15%" align="center">Type of Facility</td>
					<td width="10%" align="center" colspan="2">Amount</td>
					<td width="10%" align="center">Rate of Interest/Commission</td>
					<td align="center" width="10%">Margin</td>
					<td align="center" width="10%">Tenor (In Months)</td>
					<td align="center" width="10%">Due Date</td>
					<td align="center" width="15%">Mode of Repayment</td>
					<td width="15%" align="center">Facility Availing Branch</td>
				</tr>
				<%
					for (int i = 0; i < arrRecommRow.size(); i++) {
							arrCol = (ArrayList) arrRecommRow.get(i);
				%>
				<%
					if (Double.parseDouble(Helper.correctDouble((String) arrCol
									.get(17))) != 0) {
				%>
				<tr>
					<td align="center" rowspan="3"><%=i + 1%>.</td>
					<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(0))
										.toUpperCase()%></td>
					<td>Loan Sanction Amount</td>
					<%
						if (!Helper.correctNull((String) arrCol.get(20))
											.equalsIgnoreCase("SF")) {
					%>
					<td align="right"><%=Helper
													.converAmount(
															jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(1)))
																			- Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(17)))),
															strAmountvalue)%></td>
					<%
						} else {
					%>
					<td align="right"><%=Helper
													.converAmount(
															jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(1)))),
															strAmountvalue)%></td>
					<%
						}
					%>
					<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(3))%></td>
					<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(10))%></td>
					<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(6))%></td>
					<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(13))%></td>
					<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(9))%></td>
					<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(18))%></td>
				</tr>
				<tr>
					<td><%=Helper.correctNull((String) arrCol.get(19))%></td>
					<td align="right"><%=Helper.converAmount(jtn.format(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(17)))),
										strAmountvalue)%></td>
				</tr>
				<tr class="title">
					<td>Total Loan Sanction Limit</td>
					<td align="right"><%=Helper.converAmount(jtn.format(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1)))),
										strAmountvalue)%></td>
					<%
						} else {
					%>
				
				<tr>
					<td align="center"><%=i + 1%>.</td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(0))
										.toUpperCase()%></td>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))),
										strAmountvalue)%><br />
					Without any insurance coverage.</td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(3))%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(10))%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(6))%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(13))%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(9))%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(18))%></td>
					<%
						}
					%>
				</tr>
				<%
					}
					} else {
				%>
				<tr>
					<td align="left" style="border: none;"><%=strNil%></td>
				</tr>
				<%
					}
				%>
			</table>
			</div>
			</td>
		</tr>
		
		<% if((arrFacilityTerm0!=null && arrFacilityTerm0.size()>0) || arrFacilityTermApp0!=null)
{ %>
<tr>
	<td><br>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr><td><b>Specific Terms & Conditions:</b></td></tr>
		</table>
	</td>
</tr>
	
<%} %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">

<%
	int j=0;
	int sub=0;
	int main=0;
	String prevSno="";
	String currParentId="";
	String termsno = "";
	boolean booflag=true;
	boolean subflag=true;

	if(arrFacilityTerm0!=null && arrFacilityTerm0.size()>0)
	{ %>
	<%	j=arrFacilityTerm0.size();
		for(int i=0;i<arrFacilityTerm0.size();i++)
		{
			termsno = Helper.correctNull((String) arrFacilityIdVal0.get(i));
			currParentId=Helper.correctNull((String) arrParentID0.get(i));
			if(currParentId.equalsIgnoreCase("0") && subflag==true )
			{
				booflag=true;
				sub=0;
			}
			if(booflag)
			{
				main = main+1;
				prevSno=Helper.correctNull((String) arrFacilityIdVal0.get(i));
				booflag=false;
			}
		%>
		<%if(currParentId.equalsIgnoreCase("0"))
		{
			subflag=true;
		%>
		<tr> 
		  	<td nowrap="nowrap"><br>
		      	<table cellpadding="3" cellspacing="0" width="95%" align="center">
			      	<tr>
			      		<td width="2%" valign="top"><%=main%>.</td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
		</tr>
		<%}
		if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0")))
		{
		%>
		<tr> 
	      	<td nowrap="nowrap"><br>
		      	<table cellpadding="0" cellspacing="0" width="95%" align="right">
			      	<tr>
			      		<td width="2%" valign="top">&nbsp;<%=main%>.<%=++sub%></td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
	    </tr>
		
		<%}
		}
	} %>
	<%
	if(arrFacilityTermApp0!=null)
	{
		for(int i=0;i<arrFacilityTermApp0.size();i++)
		{  main = main+1;
		%>
		<tr> 
	      	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="0" cellspacing="0" width="95%" align="center">
				<tr > 
				  <td align="center"> 
				    <div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
				  </td>
				</tr>
				</table>
			</td>
		</tr>
		<%
		}
	} %>
		</table>
	</td>
<tr>
		
			

		<tr>
			<td>&nbsp;
			<table width="95%" align="center" cellpadding="3" cellspacing="0"
				border="0">
				<tr>
					<td>&nbsp;<b>REPAYMENT SCHEDULE COMMENTS:</b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<%
					ArrayList arrOutCol1 = new ArrayList();
					ArrayList arrOutRow1 = (ArrayList) hshValues.get("arrOutRow1");

					if (arrOutRow1 != null && arrOutRow1.size() > 0) {
						for (int i = 0; i < arrOutRow1.size(); i++) {
							arrOutCol1 = (ArrayList) arrOutRow1.get(i);
				%>
				<tr>
					<td align="left" width="20%" class="title">&nbsp;<u><%=Helper.correctNull((String) arrOutCol1.get(0))%>-<%=Helper.correctNull((String) arrOutCol1.get(1))%>
					:</u></td>
				</tr>
				<tr>
					<td align="left" width="50%"><%=Helper.correctNull((String) arrOutCol1.get(2))%></td>
				</tr>
				<%String StrStageWiseRelease=Helper.correctNull((String) arrOutCol1.get(3));
										if(StrStageWiseRelease.equalsIgnoreCase("Y")){
											StrStageWiseRelease="Yes";
										}else if(StrStageWiseRelease.equalsIgnoreCase("N")){
											StrStageWiseRelease="No";
										}else{
											StrStageWiseRelease="";
										}%>
										<% if(!StrStageWiseRelease.equalsIgnoreCase("")){%>
									<tr><td><b>Stage Wise Release Of Loan &nbsp;<b>:</b>&nbsp;&nbsp;&nbsp;</b><%=StrStageWiseRelease%></td></tr>
									<%}
					}
					} else {
				%>
				<tr>
					<td align="center">&nbsp;Nil</td>
				</tr>
				<%
					}
				%>
			</table>
			</td>
		</tr>
		
		<%
ArrayList arrpropsecurityRow=new ArrayList();
ArrayList arrpropsecCollRow=new ArrayList();
arrpropsecurityRow=(ArrayList)hshValuesAN3.get("arrproposedSecfacwise");
arrpropsecCollRow=(ArrayList)hshValuesAN3.get("arrRowCollSec");
String strProposedSecurity=Helper.correctNull((String)hshValuesAN3.get("strProposedSecurity"));
if(!strProposedSecurity.equalsIgnoreCase("M")){
if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td><table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Securities&nbsp;:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table></td></tr>
<tr><td>
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
<tr align="left">
<td colspan="4"><b>Prime :</b></td>
</tr>
<% 

ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
String secValue = "";
if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
	for(int i=0;i<arrpropsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
				  secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountvalue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.converAmount(Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountvalue)%>)</td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		  <td align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>
		<%} else {
		%>
		<tr>
		 <td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.converAmount(Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountvalue)%>)</td>
		</tr>		
		<%	}}
	}
} }
if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr>
<td colspan="4" align="left"><b>Collateral:</b></td>
</tr>
<% 
ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
String secValue = "";
if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
	for(int i=0;i<arrpropsecCollRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(i);
		 secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountvalue);
			if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	
	}
} }
%>
</TABLE>
</div><br>
</td>
</tr>
<% }}else if(strProposedSecurity.equalsIgnoreCase("M")){%>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Securities&nbsp;:</td>
			</tr>
			<tr>
				<td><%=Helper.correctNull((String)hshValuesAN3.get("strProposedSecurityComments"))%></td>
			</tr>
		</table>
</td>
</tr>
<%} %>




		<%
			if (arrGuaRow != null && arrGuaRow.size() > 0) {
		%>
		<tr>
			<td>
			<table width="95%" align="center" cellpadding="0" cellspacing="0"
				border="0">
				<tr>
					<td class="title"><br>
					<b>Co-Obligants/ Guarantors:</br>
					</b></td>
				</tr>
			</table>
			</td>
		</tr>
		<br>
		<tr>
			<td>
			<div id="top">
			<table width="60%" align="center" cellpadding="3" cellspacing="0"
				border="0">
				<tr>
					<td width="5%" align="center" class="title">S.No</td>
					<td width="65%" align="center" class="title">Name</td>
					<td width="20%" align="center" class="title">Type</td>
				</tr>
				<%
						ArrayList arrOutCol=new ArrayList();
						String strAppltype="";
						int x=0;
						if(arrGuaRow!=null&&arrGuaRow.size()>0){
							for(int i=0;i<arrGuaRow.size();i++) {
								arrOutCol	= (ArrayList)arrGuaRow.get(i);
								if(arrOutCol!=null&&arrOutCol.size()>0){
								if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("G") || Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("CO")){
								bflag1=false;
								if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("G")){
									strAppltype="Guarantor";
								}else if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("CO")){
									strAppltype="Co-Obligant";
								}
								else{
									strAppltype="";
								}%>
									<tr>
										<td><%x=x+1; %><%=x %></td>
										<td><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
										<td><%=strAppltype%></td>
									</tr>
								<%}}
							}
						}
						if(bflag1)
						{%>
						<tr>
										<td colspan="3" align="center"> - Nil -</td>
									</tr>
						<%}
						%>
			</table>
			</div>
			</td>
		</tr>
		<%
			}
		%>
			<tr>
				<td>
				<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<jsp:include page="../print/com_misprocessnote.jsp" flush="true">
						<jsp:param name="pageVal" value="MIS" />
						<jsp:param name="pagevalue" value="MIS" />
					</jsp:include>
				</table>
				</td>
			</tr>
		<tr>
			<td>
			<table width="95%" align="center" cellpadding="3" cellspacing="0"
				border="0">
				<tr>
					<td><br>
					Processing Charges : Rs. <b><%=Helper.correctNull((String) hshValues
							.get("com_processingfee"))%></b>
					+ Applicable Taxes</td>
				</tr>
			</table>
			</td>
		</tr>
		
		<tr>
				<td><!-- Terms and Conditon - General --> <jsp:include
					page="../print/com_AnnexureVII.jsp" flush="true">
					<jsp:param name="pagetype" value="RPN" />
				</jsp:include> <!-- End --></td>
			</tr>

		<%
		int intDelegation=0;
		ArrayList arrPropFlow=(ArrayList)hshValues.get("arrPropFlow");
		if(arrPropFlow!=null && arrPropFlow.size()>0)
		{
			if(arrPropFlow.size()>5)
				intDelegation=5;
			else
				intDelegation=arrPropFlow.size();
			
			if(arrPropFlow!=null && arrPropFlow.size()>0){
			%>

		<tr>
			<td>
			<table width="95%" align="center" cellpadding="0" cellspacing="0">
			<tr>
			<td>
			<div id="top">
			<table align="center" cellpadding="3" cellspacing="0" width="100%">
				<tr align="center" class="title">
					<td>Details</td></tr><tr>
					<td>Name</td></tr><tr>
					<td>Designation</td></tr>
					<tr>
					<td>Signature</td></tr><tr>
					<td>Date</td>
				</tr>
			</table>
			</div>
			</td>
			<%
			
			for(int i=0;i<intDelegation;i++)
			{
				arrCol=(ArrayList)arrPropFlow.get(i);
			%>
				<td>
				<div id="top">
			<table align="center" cellpadding="3" cellspacing="0" width="100%">
				<tr align="center" class="title">
					<td nowrap="nowrap"><%if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("S")){ %>Sanctioned By<%}else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("A")){ %>Appraised By<%}
					else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("V")){ %>Vetted By<%}else{%>&nbsp;<%} %></td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td></tr>
					<tr>
					<td nowrap="nowrap">&nbsp;</td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
			<%}
			}
			else
			{%><td>
			<div id="top">
			<table align="center" cellpadding="3" cellspacing="0" width="100%">
				<tr align="center">
					<td>&nbsp;</td></tr><tr>
					<td>&nbsp;</td></tr><tr>
					<td>&nbsp;</td></tr><tr>
					<td>&nbsp;</td></tr><tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
				
			
			</tr>
			</table>
			</td>
		</tr>
		<%}}
		{

			
			if(arrPropFlow!=null && arrPropFlow.size()>5){
				intDelegation=5;
			%>

		<tr>
			<td>
			<table width="95%" align="center" cellpadding="0" cellspacing="0">
			<tr>
			<td>
			<div id="top">
			<table align="center" cellpadding="3" cellspacing="0" width="100%">
				<tr align="center" class="title">
					<td>Details</td></tr><tr>
					<td>Name</td></tr><tr>
					<td>Designation</td></tr>
					<tr>
					<td>Signature</td></tr><tr>
					<td>Date</td>
				</tr>
			</table>
			</div>
			</td>
			<%
			
			for(int i=intDelegation;i<arrPropFlow.size();i++)
			{
				arrCol=(ArrayList)arrPropFlow.get(i);
			%>
				<td>
				<div id="top">
			<table align="center" cellpadding="3" cellspacing="0" width="100%">
				<tr align="center" class="title">
					<td nowrap="nowrap"><%if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("S")){ %>Sanctioned By<%}else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("A")){ %>Appraised By<%}
					else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("V")){ %>Vetted By<%}else{%>&nbsp;<%} %></td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td></tr>
					<tr>
					<td nowrap="nowrap">&nbsp;</td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
			<%}
			}
		}
			%>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
		
		<%}%>