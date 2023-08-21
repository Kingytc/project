<%@ page import="com.sai.laps.helper.*,java.util.*,java.text.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%

HashMap hshRecord=new HashMap();
hshRecord=(HashMap)hshValues.get(request.getParameter("pagevalue"));

ArrayList arrCol		= new ArrayList();
ArrayList arrSingleCons =  new ArrayList();
ArrayList arrMultipleCons = new ArrayList();
ArrayList arrMultiple 	= new ArrayList();
ArrayList arrSingleConsWC = new ArrayList();
ArrayList arrMultipleConsWC = new ArrayList();
ArrayList arrMultipleWC = new ArrayList();
ArrayList arrMultiBnk = new ArrayList();
ArrayList arrColCons	= new ArrayList();
String flag="",val="";
String multipleConsWCflag="",multipleConsflag="";
String intRate = "";
int count=0,arrCount=0;
String strTLsingle="",strWCsingle="",strTLMultiple="",strWCMultiple="",strTLCons="",strWCCons="";
if(hshRecord!=null)
{
	arrSingleCons = (ArrayList)hshRecord.get("arrSingleCons");
	arrMultipleCons = (ArrayList)hshRecord.get("arrMultipleCons");
	arrMultiple		= (ArrayList)hshRecord.get("arrMultiple");
	arrSingleConsWC = (ArrayList)hshRecord.get("arrSingleConsWC");
	arrMultipleConsWC = (ArrayList)hshRecord.get("arrMultipleConsWC");
	arrMultipleWC 	= (ArrayList)hshRecord.get("arrMultipleWC");
	arrMultiBnk		= (ArrayList)hshRecord.get("arrMultiBnk");
	
	strTLsingle=Helper.correctNull((String)hshRecord.get("StrRemarksFlagTL"));
	strWCsingle=Helper.correctNull((String)hshRecord.get("StrRemarksFlagWC"));
	strTLMultiple=Helper.correctNull((String)hshRecord.get("StrRemarksFlagTL_M"));
	strWCMultiple=Helper.correctNull((String)hshRecord.get("StrRemarksFlagWC_M"));
	strTLCons=Helper.correctNull((String)hshRecord.get("StrRemarksFlagTL_MC"));
	strWCCons=Helper.correctNull((String)hshRecord.get("StrRemarksFlagWC_MC"));
}
String strAmtValueIn = request.getParameter("pagevalueAmt");
String strAmountValue=Helper.correctNull((String)hshValues.get("strAmountValue"));

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();

jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
//Added by Kishan
count=0;arrCount=0;
/*if(arrMultipleConsWC!=null && arrMultipleConsWC.size()>0)
{ 
	for(int i=0;i<arrMultipleConsWC.size();i++)
	{
		count=0;
		arrCol	= (ArrayList)arrMultipleConsWC.get(i);
		arrCount=arrCol.size();
		for(int j=0;j<arrCount;j++)
		{
			arrColCons	= (ArrayList)arrCol.get(j);
			if(Helper.correctNull((String)arrColCons.get(7)).equals(""))
				count++;
		}
		if(count==arrCount && arrCount != 0)
			multipleConsWCflag+="Y,";
		else
			multipleConsWCflag+="N,";
	}
	if(!multipleConsWCflag.equals(""))
		multipleConsWCflag = multipleConsWCflag.substring(0,multipleConsWCflag.length()-1);
}
if(arrMultipleCons!=null && arrMultipleCons.size()>0)
{ 
	for(int i=0;i<arrMultipleCons.size();i++)
	{
		count=0;
		arrCol	= (ArrayList)arrMultipleCons.get(i);
		arrCount=arrCol.size();
		for(int j=0;j<arrCount;j++)
		{
			arrColCons	= (ArrayList)arrCol.get(j);
			if(Helper.correctNull((String)arrColCons.get(7)).equals(""))
				count++;
		}
		if(count==arrCount && arrCount != 0)
			multipleConsflag+="Y,";
		else
			multipleConsflag+="N,";
	}
	if(!multipleConsflag.equals(""))
		multipleConsflag = multipleConsflag.substring(0,multipleConsflag.length()-1);
}*/
%>


<!-- Banking Arrangement -->


<% if(Helper.correctNull((String)hshRecord.get("strBnkargWC")).equalsIgnoreCase("S")) { %>
<tr>
	<td class="title"><br>Working Capital : &nbsp; Sole </td>
</tr>

<%}else if(Helper.correctNull((String)hshRecord.get("strBnkargWC")).equalsIgnoreCase("C")) { %>
<tr>
	<td class="title"><br>Working Capital :&nbsp;Consortium </td>
</tr>

<%}else if(Helper.correctNull((String)hshRecord.get("strBnkargWC")).equalsIgnoreCase("M")) { %>
<tr>
	<td class="title"><br>Working Capital :&nbsp;Multiple</td>
</tr>

<%} %>

<% if(Helper.correctNull((String)hshRecord.get("strBnkargTL")).equalsIgnoreCase("S")) { %>
<tr>
	<td class="title"><br>Term Loan :&nbsp;Sole</td>
</tr>

<%}else if(Helper.correctNull((String)hshRecord.get("strBnkargTL")).equalsIgnoreCase("C")) { %>
<tr>
	<td class="title"><br>Term Loan :&nbsp;Consortium</td>
</tr>

<%}else if(Helper.correctNull((String)hshRecord.get("strBnkargTL")).equalsIgnoreCase("M")) { %>
<tr>
	<td class="title"><br>Term Loan :&nbsp;Multiple</td>
</tr>

<%} %>

<!-- Single - Consortium -->
<%
String intRate1="",totalIntRate="";
if(arrSingleCons!=null && arrSingleCons.size()>0){ 
%>
<tr>
	<td class="title"><br>Term Loan:<b>&nbsp;Leader of the Consortium</b>-&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshRecord.get("com_cons_bank_name"))) %>&nbsp;</td>
</tr>
			
<%
if(arrSingleCons!=null && arrSingleCons.size()>0)
{ 
	totalIntRate = Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblSglIntRate")));
%>
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="15%" align="center">Name of the Bank</td>
						<td width="15%" align="center">Facility</td>
						<td width="10%" align="center">Type</td>
						<td width="8%" align="center">Limit</td>
						<td width="8%" align="center">Outstanding</td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td width="8%" align="center">Interest (%)</td>
						<% }%>
						<td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
						<% if(strTLsingle.equalsIgnoreCase("Y")){ %>
						<td width="16%" align="center">Remarks</td>
						<%} %>
						
					</tr>
			<%	for(int i=0;i<arrSingleCons.size();i++)
				{
					arrCol	= (ArrayList)arrSingleCons.get(i);
				%>
					<tr>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(10))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="right">
						<%
							intRate1 = Helper.correctNull((String)arrCol.get(7));
							if(intRate1.equals("")) {
								out.print(intRate1);
							}
							else {
								out.print(Helper.checkDecimal(intRate1));
							}
							}%>
						</td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(15))%></td>
						
					   <td align="left"><%=Helper.correctNull((String)arrCol.get(14))%></td>
						<% if(strTLsingle.equalsIgnoreCase("Y")){ %>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
						<%} %>
												
						
					</tr>
			<%} %>
				<% if(arrSingleCons.size()>0) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblSglLimit"))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblSglOutstand"))))),strAmountValue)%></td>
						<!--<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblSglIntRate")))%></td>
						-->
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="left">&nbsp;</td>
						<% } %>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%if(strTLsingle.equalsIgnoreCase("Y")){%>
						<td align="left">&nbsp;</td>
						<%} %>
						
					</tr>
				<%} %>
				</table>
			</div>
		</td>
	</tr>
<%} } %>


<%
intRate1="";totalIntRate="";
if(arrMultipleCons!=null && arrMultipleCons.size()>0){ %>
<tr>
	<td class="title"><br>Term Loan:</td>
</tr>

<!-- Multiple - Consortium -->			
<%
if(arrMultipleCons!=null && arrMultipleCons.size()>0)
{
	//StringTokenizer st1 = new StringTokenizer(multipleConsflag,",");
	for(int i=0;i<arrMultipleCons.size();i++)
	{
		totalIntRate = Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblMtplConsIntRate"+(i+1))));
		/*if(st1.hasMoreTokens())
		{
			val = (String)st1.nextToken();
			if(val.equals("Y")) flag="Y";
			else flag="N";
			*/
			arrCol	= (ArrayList)arrMultipleCons.get(i);
			
%>
	<tr>
		<td class="title"><br>Consortium<% if(arrMultipleCons.size()>1) out.println(" "+(i+1));%>:<b>Leader:</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshRecord.get("com_cons_bank_name"+(i+1)))) %>
	&nbsp;</td>
	</tr>	
	
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="15%" align="center">Name of the Bank</td>
						<td width="15%" align="center">Facility</td>
						<td width="10%" align="center">Type</td>
						<td width="8%" align="center">Limit</td>
						<td width="8%" align="center">Outstanding</td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td width="8%" align="center">Interest (%)</td>
						<% } %>
						<td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
						<% if(strTLCons.equalsIgnoreCase("Y")){%>
						<td width="14%" align="center">Remarks</td>
						<%} %>
						
					</tr>
		<%		for(int j=0;j<arrCol.size();j++)
				{
					arrColCons	= (ArrayList)arrCol.get(j);
		%>	
					<tr>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrColCons.get(9))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrColCons.get(10))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(3))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColCons.get(5))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColCons.get(6))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="right">
						<%
							intRate1 = Helper.correctNull((String)arrColCons.get(7));
							if(intRate1.equals("")) {
								out.print(intRate1);
							}
							else {
								out.print(Helper.checkDecimal(intRate1));
							}}
							%>
						</td>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(15))%></td>
						
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(14))%></td>
						<% if(strTLCons.equalsIgnoreCase("Y")){%>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(8))%></td>
						<%} %>
						
						
					</tr>
			<%} %>	
			<% if(arrMultipleCons.size()>0) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblMtplConsLimit"+(i+1)))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblMtplConsOutstand"+(i+1)))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<!-- <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblMtplConsIntRate"+(i+1))))%></td> -->
						<td>&nbsp;</td>
						
						<% }  %>
							<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%if(strTLCons.equalsIgnoreCase("Y")){%>
						<td align="left">&nbsp;</td>
						<%} %>
					
					</tr>
				<%} %>	
				</table>
			</div>
		</td>
	</tr>
<% } } } %>

<!-- TL : Multiple -->
<%
intRate1="";totalIntRate="";
if(arrMultiple!=null && arrMultiple.size()>0){ %>
<tr>
	<td class="title"><br>Term Loan:</td>
</tr>
<%
if(arrMultiple!=null && arrMultiple.size()>0)
{ 
	totalIntRate = Helper.correctDouble(Helper.correctNull((String)hshRecord.get("dblMtplIntRate")));
%>
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="15%" align="center">Name of the Bank</td>
						<td width="15%" align="center">Facility</td>
						<td width="10%" align="center">Type</td>
						<td width="8%" align="center">Limit</td>
						<td width="8%" align="center">Outstanding</td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td width="8%" align="center">Interest (%)</td>
						<% } %>	<td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
						<% if(strTLMultiple.equalsIgnoreCase("Y")){%>
						<td width="26%" align="center">Remarks</td>
						<%} %>
					
					</tr>
			<%	for(int i=0;i<arrMultiple.size();i++)
				{
					arrCol	= (ArrayList)arrMultiple.get(i);
				%>
					<tr>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(10))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="right">
						<%
							intRate1 = Helper.correctNull((String)arrCol.get(7));
							if(intRate1.equals("")) {
								out.print(intRate1);
							}
							else {
								out.print(Helper.checkDecimal(intRate1));
							}}
							%>
						</td>
							<td align="left"><%=Helper.correctNull((String)arrCol.get(15))%></td>
						
												<td align="left"><%=Helper.correctNull((String)arrCol.get(14))%></td>
						<% if(strTLMultiple.equalsIgnoreCase("Y")){ %>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
						<%} %>
											
						
					</tr>
			<%} %>
			<% if(arrMultiple.size()>0) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblMtplLimit"))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblMtplOutstand"))))),strAmountValue)%></td>
						<!--<td align="right"><%=Helper.correctNull((String)hshRecord.get("dblMtplIntRate"))%></td>
						-->
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="left">&nbsp;</td>
						<% }%><td>&nbsp;</td>
						<td>&nbsp;</td>
						<% if(strTLMultiple.equalsIgnoreCase("Y")){%>
						<td align="left">&nbsp;</td>
						<%} %>
						
					</tr>
				<%} %>
				</table>
			</div>
		</td>
	</tr>
<%} } %>

<!-- WC : Single - Consortium -->
<%
intRate1="";totalIntRate="";
if(arrSingleConsWC!=null && arrSingleConsWC.size()>0)
{
%>
<tr>
	<td class="title"><br>Working Capital:<b>&nbsp;Leader of the Consortium -</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshRecord.get("com_cons_bank_name_WC"))) %>&nbsp;</td>
</tr>
<%
if(arrSingleConsWC!=null && arrSingleConsWC.size()>0)
{ 
	totalIntRate =  Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblWCSinConsIntRate")));
%>
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="15%" align="center">Name of the Bank</td>
						<td width="15%" align="center">Facility</td>
						<td width="10%" align="center">Type</td>
						<td width="8%" align="center">Limit</td>
						<td width="18%" align="center">Outstanding</td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td width="8%" align="center">Interest (%)</td>
						<% }%><td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
						<%if(strWCsingle.equalsIgnoreCase("Y")){  %>
						<td width="14%" align="center">Remarks</td>
						<%} %>
						
					</tr>
					<%
					for(int i=0;i<arrSingleConsWC.size();i++)
					{
						arrCol	= (ArrayList)arrSingleConsWC.get(i);
					%>
					<tr>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(10))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="right"><%=Helper.correctNull((String)arrCol.get(7)) %></td>
						<% }%>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(13))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(12))%></td>
						<%if(strWCsingle.equalsIgnoreCase("Y")){  %>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
						<%} %>
						
						
					</tr>
					<%} %>
					<% if(arrSingleConsWC.size()>0) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblWCSinConsLimit"))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblWCSinConsOutstand"))))),strAmountValue)%></td>
						<!-- <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblWCSinConsIntRate")))%></td> -->
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="left">&nbsp;</td>
						<% }%>
							<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%if(strWCsingle.equalsIgnoreCase("Y")){  %>
						<td align="left">&nbsp;</td>
						<%} %>
					
					</tr>
				<%} %>
				</table>
			</div>
		</td>
	</tr>
<%} } %>

<%
intRate1="";totalIntRate="";
if(arrMultipleConsWC!=null && arrMultipleConsWC.size()>0){ %>
<tr>
	<td class="title"><br>Working Capital:</td>
</tr>

<!-- WC : Multiple - Consortium -->			
<%
if(arrMultipleConsWC!=null && arrMultipleConsWC.size()>0)
{ 
	//StringTokenizer st = new StringTokenizer(multipleConsWCflag,",");
	for(int i=0;i<arrMultipleConsWC.size();i++)
	{
		/*if(st.hasMoreTokens())
		{
			val = (String)st.nextToken();
			if(val.equals("Y")) flag="Y";
			else flag="N";
			*/
		totalIntRate = Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblWCMulConsIntRate"+(i+1))));
		arrCol	= (ArrayList)arrMultipleConsWC.get(i);
		
%>
	<tr>
		<td class="title"><br>Consortium<% if(arrMultipleConsWC.size()>1) out.println(" "+(i+1)); %>:<b>Leader of the Consortium -</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshRecord.get("com_cons_bank_name_WC"+(i+1)))) %>
	&nbsp;</td>
 	</tr>
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="15%" align="center">Name of the Bank WC</td>
						<td width="15%" align="center">Facility</td>
						<td width="10%" align="center">Type</td>
						<td width="8%" align="center">Limit</td>
						<td width="8%" align="center">Outstanding</td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td width="8%" align="center">Interest (%)</td>
						<% }%><td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
						<% if(strWCCons.equalsIgnoreCase("Y")){ %>
						<td width="16%" align="center">Remarks</td>
						<%} %>
						
					</tr>
	<%		for(int j=0;j<arrCol.size();j++)
			{
				arrColCons	= (ArrayList)arrCol.get(j);
	%>	
					<tr>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrColCons.get(9))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrColCons.get(10))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(3))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColCons.get(5))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColCons.get(6))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="right">
						<%
							intRate1 = Helper.correctNull((String)arrColCons.get(7));
							if(intRate1.equals("")) {
								out.print(intRate1);
							}
							else {
								out.print(Helper.checkDecimal(intRate1));
							}}
							%>
						</td>
							<td align="left"><%=Helper.correctNull((String)arrColCons.get(13))%></td>
						
																		<td align="left"><%=Helper.correctNull((String)arrColCons.get(12))%></td>
						
						<%if(strWCCons.equalsIgnoreCase("Y")){ %>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(8))%></td>
						<%} %>
																	
					</tr>
		<%} if(arrMultipleConsWC!=null && arrMultipleConsWC.size()>0) {%>
				<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblWCMulConsLimit"+(i+1)))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblWCMulConsOutstand"+(i+1)))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<!-- <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblWCMulConsIntRate"+(i+1))))%></td> -->
						<td>&nbsp;</td>
						<% } %><td>&nbsp;</td>
						<td>&nbsp;</td>
						<%  if(strWCCons.equalsIgnoreCase("Y")){%>
						<td align="left">&nbsp;</td>
						<%} %>
						
					</tr>
				<% } %>
				</table>
			</div>
		</td>
	</tr>
<% } } }%>

<!-- WC : Multiple - Consortium -->
<%
intRate1="";totalIntRate="";
if(arrMultipleWC!=null && arrMultipleWC.size()>0)
{ 
	totalIntRate = Helper.correctNull((String)hshRecord.get("dblWCMtplIntRate"));
%>
	<tr>
		<td class="title"><br>Working Capital:</td>
	</tr>
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="15%" align="center">Name of the Bank</td>
						<td width="15%" align="center">Facility</td>
						<td width="10%" align="center">Type</td>
						<td width="8%" align="center">Limit</td>
						<td width="8%" align="center">Outstanding</td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td width="8%" align="center">Interest (%)</td>
						<% } %><td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
						<%if(strWCMultiple.equalsIgnoreCase("Y")){ %>
						<td width="24%" align="center">Remarks</td>
						<%} %>
						
					</tr>
			<%	for(int i=0;i<arrMultipleWC.size();i++)
				{
					arrCol	= (ArrayList)arrMultipleWC.get(i);
				%>
					<tr>
					<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(10))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="right">
						<%
							intRate1 = Helper.correctNull((String)arrCol.get(7));
							if(intRate1.equals("")) {
								out.print(intRate1);
							}
							else {
								out.print(Helper.checkDecimal(intRate1));
							}}
							%>
						</td>
							<td align="left"><%=Helper.correctNull((String)arrCol.get(13))%></td>
						
												<td align="left"><%=Helper.correctNull((String)arrCol.get(12))%></td>
						<% if(strWCMultiple.equalsIgnoreCase("Y")){ %>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
						<%} %>
											
						
					</tr>
			<%}  if(arrMultipleWC!=null && arrMultipleWC.size()>0) { %>
				<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblWCMtplLimit"))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblWCMtplOutstand"))))),strAmountValue)%></td>
						<!--<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblWCMtplIntRate")))%></td>
						-->
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="left">&nbsp;</td>
						<% }%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%if(strWCMultiple.equalsIgnoreCase("Y")){%>
						<td align="left">&nbsp;</td>
						<%} %>
						
					</tr>
				
				<% } %>
				</table>
			</div>
		</td>
	</tr>
<% }  %>


<!-- Multiple Banking -->
<%
if(arrMultiBnk!=null && arrMultiBnk.size()>0){ %>
<tr>
	<td class="title"><br>Existing and Proposed Exposure:</td>
</tr>
<%
if(arrMultiBnk!=null && arrMultiBnk.size()>0)
{ 
	for(int j=0;j<arrMultiBnk.size();j++)
	{
		arrColCons	= (ArrayList)arrMultiBnk.get(j);
%>
	
	<%if(Helper.correctNull((String)hshRecord.get("countexiting")).equalsIgnoreCase("Y"))
		{%>
	
	<%}else{
		%>
		<tr>
		<td class="title"><br>Consortium <%=j+1%>:</td>
	</tr>
	<%} %>
	
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
	  			  	<td> &nbsp;&nbsp;	Name of the Bank  </td>
	  			  	<td colspan="6" align="center">Existing Exposure  </td>
	  			  	<td colspan="6" align="center">Proposed Exposure </td>
	  			</tr>
	  			<tr align="center">
	  			  	<td>&nbsp;</td>
	  			  	<td>FB</td>
	  			  	<td>% FB<br> exposure</td>
	  			  	<td>NFB</td>
	  			  	<td>% NFB<br> Exposure</td>
	  			  	<td>Total</td>
	  			  	<td>% Total<br> exposure</td>
	  				<td>FB</td>
	  			  	<td>% FB<br> exposure</td>
	  			  	<td>NFB</td>
	  			  	<td>% NFB<br> exposure</td>
	  			  	<td>Total</td>
	  			  	<td>% Total<br> exposure</td>
	  			</tr>
			<%	for(int i=0;i<arrColCons.size();i++)
				{
					arrCol	= (ArrayList)arrColCons.get(i);
				%>
					<tr>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(1))).toUpperCase()%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(3)))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(5)))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))),strAmountValue)%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(9)))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(10))))),strAmountValue)%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(11)))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))),strAmountValue)%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(13)))%></td>
					</tr>
			<%} %>
			<% 
			if(arrMultiBnk.size()>0) { 
				%>
					<tr>
						<td align="left">TOTAL</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("FbSum"+(j+1)))))),strAmountValue)%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("NfbSum"+(j+1)))))),strAmountValue)%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("ExistSum"+(j+1)))))),strAmountValue)%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("ProFbSum"+(j+1)))))),strAmountValue)%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("ProNfbSum"+(j+1)))))),strAmountValue)%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("ProSum"+(j+1)))))),strAmountValue)%>&nbsp;</td>
						<td align="right">100.00</td>
					</tr>
			<%} %>		
				</table>
			</div>
		</td>
	</tr>
<%} } } %>