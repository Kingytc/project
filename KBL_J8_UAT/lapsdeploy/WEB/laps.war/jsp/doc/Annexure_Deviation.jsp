    <%@include file="../share/directives.jsp"%>
  <%ArrayList arryRow = (ArrayList) hshValues.get("arrRow1");
	ArrayList arrRow = (ArrayList)hshValues.get("arrData");
ArrayList arryCol = new ArrayList();
ArrayList arrRow9 = (ArrayList) hshValues.get("arrRow9");

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
String sancAuth=Helper.correctNull((String) hshValues.get("PERM_SANC_AUTH"));
ArrayList arrPermID=(ArrayList) hshValues.get("arrPermID");
String strpermissionfalg=Helper.correctNull((String) hshValues.get("flag"));

%>
    

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
<title>Deviation Annexure</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>

<body>
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
<tr>
	<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr><td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>
		<%if(Helper.correctNull((String)hshValues.get("PERM_SANC_DEPT")).equalsIgnoreCase("008")){ %>
		<tr><td align="center" width="50%">Credit LCFD&nbsp;&nbsp;</td></tr>
		<%}else if(Helper.correctNull((String)hshValues.get("PERM_SANC_DEPT")).equalsIgnoreCase("010")){ 
		String strComSancbranchcode=Helper.correctNull((String)hshValues.get("PERM_SANC_BRANCH"));
		if(strComSancbranchcode.equalsIgnoreCase("MCFD"))
			strComSancbranchcode="Credit MCFD";
		else
			strComSancbranchcode="Credit RFD";
		%>
		<tr><td align="center" width="50%"><%=strComSancbranchcode%>&nbsp;&nbsp;</td></tr>
		<%}else{ %>
		<tr><td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=strOrgName.toUpperCase()%></td></tr>
		<%} %>
		</table>
	</td>
</tr>
<tr>
	<td>	
	<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr>
				<td width= "20%"><b>Branch code:</b></td>
				<td width= "30%"><%=Helper.correctNull((String) hshValues.get("hshorg_scode"))%>&nbsp;</td>
				<td width= "20%"><b>Date:</b></td>
				<td width= "30%"> <%=Helper.getCurrentDateTime()%> &nbsp;</td>
			</tr>
			<tr>
				<td width= "20%"><b>Branch:</b></td>
				<td width= "30%"><%=Helper.correctNull((String) hshValues.get("hshorg_name"))%>&nbsp;</td>
				<td width= "20%"> <b>Region:</b></td>
				<td width= "30%"><%=Helper.correctNull((String) hshValues.get("hshorg_Regionname"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width= "20%"><b>Manager Contact no:</b></td>
				<td width="30%"><%=Helper.correctNull((String) hshValues.get("hshORG_MANAGER_CTNUM"))%>&nbsp;</td>
				<td width="20%"><b>Proposal No:</b></td>
				<td width="30%"><%=Helper.correctNull((String) hshValues.get("DEV_APPNO"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="20%"><b>Permission Type:</b></td>
				<td width="30%"><%=Helper.correctNull((String) hshValues.get("DEV_MAINTYPE"))%>&nbsp;</td>
				<td width="20%"><b>Permission SubType:</b></td>
				<td width="30%"><%=Helper.correctNull((String) hshValues.get("DEV_SUBTYPE"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="20%" nowrap="nowrap"><b>PERMISSION PARAMETERS</b></td>
				<td colspan="3"><%=Helper.correctNull((String) hshValues.get("DEV_DEVPARAMDESC"))%>&nbsp;</td>
			</tr>
				<%if(sancAuth.equals("14")||sancAuth.equals("15")||sancAuth.equals("16")) {  %>
					<tr>
						<td width= "20%">Permission Reference No.</td>
						<td colspan="3"><%=Helper.correctNull((String)hshValues.get("PERM_REFNO"))%>&nbsp;</td>			
					</tr>
					<tr>
						<td width= "20%">Sanction date </td>	
						<td colspan="3"><%=Helper.correctNull((String) hshValues.get("PERM_SANC_DATE"))%>&nbsp;</td>
					</tr>	
				<% } %>
		</table>
		</div>
	</td>
</tr>		
<tr>
	<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr>
				<td><b>Reg:&nbsp;Permission sought to entertain loan proposal from &nbsp;&nbsp;<u><%=Helper.correctNull((String) hshValues.get("PG_APPLIANTNAME"))%></u>&nbsp;
						under <% ArrayList arrColl = new ArrayList();
								if(arrRow!=null && arrRow.size()>0){
								for(int i=0;i<arrRow.size();i++){ 
								arrColl = (ArrayList)arrRow.get(i);%>
								<br>&nbsp;"<u><%=(String)arrColl.get(5)%>&nbsp;</u>" Scheme for Rs &nbsp;<u><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrColl.get(1))))%></u> 
					 <%}} %> with deviation.</b>
					
				</td>
			</tr>
		</table>		
 	</td>
</tr> 	
<tr>
	<td>
	<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			
			<tr valign="top">
				<td width="50%">Name  and Address of the Applicant</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_APPLIANTNAME"))%><br/>
				<%=Helper.correctNull((String) hshValues.get("PG_APPLADDRESS"))%></td>
			</tr>
			
			<tr>
				<td width="50%">Dealing since </td>
				<%if(!Helper.correctNull((String) hshValues.get("PG_DEALINGSINCE")).equalsIgnoreCase("")){ %>
					<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_DEALINGSINCE"))%></td>
				<% } else { %>
				 	<td width="50%">&nbsp;Not a Customer</td>
				<% } %>			
			</tr>
			
			<tr>
				<td width="50%">Constitution</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_CONSTITUTION"))%></td>
			</tr>
			
			
			<tr>
				<td width="50%">Nature of Activity</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_ACTIVITY"))%></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<%if(!Helper.correctNull((String) hshValues.get("PG_CONSTITUTIONS")).equalsIgnoreCase("01"))
				{%>
				
				<tr>
				<td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
				<td class="title">Management Details</td>
				</tr>
				</table>
				</td>
				</tr>
			<tr>
				<td>  
				<div id="top">
						<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
						<tr class="tblhead">
							<td>S.no.</td><td>Name</td><td>Concern type</td><td>Sub type</td>
						</tr>
						<% 
				ArrayList arrCol4 = new ArrayList();
				ArrayList arrRow4 = (ArrayList)hshValues.get("arrData4");
				String Designation="";
				if(arrRow4!=null && arrRow4.size()>0)
				{
					for(int i=0;i<arrRow4.size();i++)
					{ 
					arrCol4 = (ArrayList)arrRow4.get(i);
				
				%> 
						 
						 
						<tr>
						<td width="5%">&nbsp;<%=i+1%></td>
						<td width="35%">&nbsp;<%=arrCol4.get(0)%></td>
						<td width="30%">&nbsp;<%=arrCol4.get(1)%></td>
						<td width="30%">&nbsp;<%=arrCol4.get(2)%></td>
						
						</tr>
						<%}}else{ %>
						<tr>
						<td width="5%">&nbsp;</td>
						<td width="35%">&nbsp;</td>
						<td width="30%">&nbsp;</td>
						<td width="30%">&nbsp;</td>
						</tr>
						<%} %>
						</table>
						</div>
				</td>
			</tr>
			<%} %>
			<%if(arrPermID!=null && arrPermID.size()>0){
				if(arrPermID.contains("29")||arrPermID.contains("30")||arrPermID.contains("14")||arrPermID.contains("15")){%>
				<tr>
				<td>
				<div id="top">
					<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
						<tr class="tblhead">
							<td width="5%">S.No</td>
							<td width="16%">CIBIL/CRIF Details</td>
							<td width="15%">Score</td>
							<td width="16%">Reported Date</td>
							<td width="19%">Comments</td>
						</tr>
						<tr>
						<td align="center">1.</td>
						<td>CIBIL</td>
						<td><%=Helper.correctNull((String)hshValues.get("PG_CIBIL_SCORE")) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)hshValues.get("PG_CIBIL_REPORTEDDATE")) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)hshValues.get("PG_CIBIL_DETAILS")) %>&nbsp;</td>
						</tr>
						<tr>
						<td align="center">2.</td>
						<td>CRIF</td>
						<td><%=Helper.correctNull((String)hshValues.get("PG_CRIF_SCORE")) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)hshValues.get("PG_CRIF_DATE")) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)hshValues.get("PG_CRIF_DETAILS")) %>&nbsp;</td>
						</tr>
					</table>
					</div>
					</td>
					</tr>
			
			<%}} %>
			
			
			
				<tr>
				<td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
				<td class="title">Details of deposit accounts</td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
				</tr>
				</table>
				</td>
				</tr>
				<tr>
				<td>
				<div id="top"> 
					<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
						<tr class="tblhead">
							<td width="5%">S.No</td>
							<td width="16%">Name</td>
							<td width="15%">Account No.</td>
							<td width="16%">Deposit Amt (Rs.)</td>
							<td width="19%">Present balance (Rs.)</td>
							<td width="14%">Maturity Date</td>
							<td width="15%">Rate of Int (%)</td>
						</tr>
						<% 
							ArrayList arrCol6 = new ArrayList();
							ArrayList arrRow6 = (ArrayList)hshValues.get("arrData6");
							int p=0;
							if(arrRow6!=null && arrRow6.size()>0)
							{
							for(int i=0;i<arrRow6.size();i++)
							{ 
							arrCol6 = (ArrayList)arrRow6.get(i);
							p=p+1;
							%>
						<tr>
							<td style="text-align:center">&nbsp;<%=p%></td>
							<td style="text-align:left">&nbsp;<%=arrCol6.get(0)%></td>
							<td style="text-align:right">&nbsp;<%=arrCol6.get(1)%></td>
							<td style="text-align:right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol6.get(2))))%></td>
							<td style="text-align:right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol6.get(3))))%></td>
							<td style="text-align:center">&nbsp;<%=arrCol6.get(4)%></td>
							<td style="text-align:center">&nbsp;<%=arrCol6.get(5)%></td>
							
						</tr>
						<%}} else{%>	
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<%}%>
					</table>
					</div>	
				</td>
			</tr>
		
			<tr>
			<td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
				<td class="title">Details of existing facilities with the Branch &nbsp;</td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
				</tr>
				</table>
				</td>
				</tr>
				<tr>
				<td>
				<div id="top">
						<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
						<tr class="tblhead">
							<td width="4%">S.No</td>
							<td width="8%">Borrower Name</td>
							<td width="8%">Proposal No </td>
							<td width="10%">Nature of facility</td>
							<td width="10%">Limit</td>
							<td width="10%">Purpose</td>
							<td width="8%">Sanction Ref & Date</td>
							<td width="8%">Sanctioned ROI</td>
							<td width="10%">Present ROI charged to the facility</td>
							<td width="8%">Bal o/s</td>
							<td width="8%">Due Date</td>
							<td width="10%">Arrears if any/ Status</td>
						</tr>
					<% 
					ArrayList arrCol5 = new ArrayList();
					ArrayList arrRow5 = (ArrayList)hshValues.get("arrData5");
					int q=0;
					if(arrRow5!=null && arrRow5.size()>0)
					{
					for(int i=0;i<arrRow5.size();i++)
					{ 
					arrCol5 = (ArrayList)arrRow5.get(i);
					q=q+1;
					%>	
						<tr>
							<td>&nbsp;<%=q%></td>
							<td>&nbsp;<%=arrCol5.get(14)%></td>
							<td>&nbsp;<%=arrCol5.get(0)%></td>
							<td>&nbsp;<%=arrCol5.get(2)%></td>
							<td>&nbsp;<%=arrCol5.get(5)%></td>
							<td>&nbsp;<%=arrCol5.get(6)%></td>
							<td>&nbsp;<%=arrCol5.get(7)%>&nbsp;-<br/><%=arrCol5.get(8)%></td>
							<td>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol5.get(9))))%></td>
							<td>&nbsp;<%=arrCol5.get(10)%></td>
							<td>&nbsp;<%=arrCol5.get(11)%></td>
							<td>&nbsp;<%=arrCol5.get(12)%></td>
							<td>&nbsp;<%=arrCol5.get(13)%></td>
						</tr>
						<%}%>
						
						<tr>
						<td colspan="4" style="border: none;" align="right">Total</td>
						<td><%=Helper.correctDouble((String)hshValues.get("strExposureTot")) %></td>
						<td colspan="4" style="border: none;" align="right">&nbsp;</td>
						<td><%=Helper.correctDouble((String)hshValues.get("strOutstandingTot")) %></td>
						</tr>
					
					<%}else{ %>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<%} %>
					</table>
					</div>
				</td>
			</tr>
			
			<tr>
			<td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
				<td class="title">Security Details for the Existing Facilities</td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
				</tr>
				</table>
				</td>
				</tr>
				<tr>
				<td>
				<div id="top">
					<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
						<tr class="tblhead">
							<td width="5%">S.No</td>
							<td width="12%">Proposal Number</td>
							<td width="11%">Facility S.no</td>
							<td width="12%">Security ID</td>
							<td width="12%">Applicant Name</td>
							<td width="20%">Security Description</td>
							<td width="11%">Security Value</td>
							<td width="11%">Security Type</td>
							<td width="11%">Security Margin (%)</td>
						</tr>
						<% 
							ArrayList arrCol7 = new ArrayList();
							ArrayList arrRow7 = (ArrayList)hshValues.get("arrData7");
							int q2=0;
							if(arrRow7!=null && arrRow7.size()>0)
							{
							for(int i=0;i<arrRow7.size();i++)
							{ 
							arrCol7 = (ArrayList)arrRow7.get(i);
							q2=q2+1;
							%>
						<tr>
							<td style="text-align:center">&nbsp;<%=q2%></td>
							<td style="text-align:left">&nbsp;<%=arrCol7.get(0)%></td>
							<td style="text-align:left">&nbsp;<%=arrCol7.get(1)%></td>
							<td style="text-align:left">&nbsp;<%=arrCol7.get(2)%></td>
							<td style="text-align:left">&nbsp;<%=arrCol7.get(3)%></td>
							<td>&nbsp;<%=arrCol7.get(4)%></td>
							<td style="text-align:right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol7.get(5))))%></td>
							<td style="text-align:center">&nbsp;<%=arrCol7.get(6)%></td>
							<td style="text-align:center">&nbsp;<%=arrCol7.get(7)%></td>
							
						</tr>
						<%}%>
						
						<tr>
						<td colspan="6" style="border: none;" align="right">Total</td>
						<td align="right"><%=Helper.correctDouble((String)hshValues.get("dblSecTotal")) %></td>
						</tr>
					
					<%} else{%>	
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<%}%>
					</table>	
					</div>
				</td>
			</tr>
			
			<tr>
			<td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>	
				<td class="title">Details of loan accounts maintained with other Bank </td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
				</tr>
				</table>
				</td>
				</tr>
				<tr>
				<td>
				<div id="top">
					<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
					<tr class="tblhead">
						<td width="3%" align="center">S.No</td>
						<td width="18%" align="center">Name of the Bank</td>
						<td width="18%" align="center">Facility</td>
						<td width="18%" align="center">Limit</td>
						<td width="18%" align="center">Due Date</td>
						<td width="25%" align="center">Arrears if any</td>
					</tr>
					<% 
					ArrayList arrCol8 = new ArrayList();
					ArrayList arrRow8 = (ArrayList)hshValues.get("arrData8");
					int e1=0;
					if(arrRow8!=null && arrRow8.size()>0)
					{
					for(int i=0;i<arrRow8.size();i++)
					{ 
					arrCol8 = (ArrayList)arrRow8.get(i);
					e1=e1+1;
					%>
					<tr>	
						<td style="text-align:center">&nbsp;<%=e1%></td>
						<td style="text-align:center">&nbsp;<%=arrCol8.get(5)%></td>
						<td style="text-align:center">&nbsp;<%=arrCol8.get(1)%></td>
						<td style="text-align:right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol8.get(2))))%></td>
						<td style="text-align:center">&nbsp;<%=arrCol8.get(3)%></td>
						<td style="text-align:center">&nbsp;<%=arrCol8.get(4)%></td>
					</tr>
					<%}} else{%>	
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<%}%>
				</table>
				</div>
				</td>	
			</tr>
			
			<tr>
			<td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
			<td class="title">Present Request</td>
			 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
			</tr>
			</table>
			</td>
			</tr>
			<tr>
			<td>
			<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3" "outertable" align="center">
			<tr class="tblhead">
			<td width="5%">S.No</td>
				<td width="15%">Nature of loan/facility</td>
				<td width="15%">Bank Scheme</td>
				<td width="15%">Loan Amount</td>
				<td width="15%">ROI/ Commission</td>
				<td width="15%">Period(including holiday if any)(Months)</td>
				<td width="20%">Purpose of the loan</td>
			</tr>
			<% 
				ArrayList arrCol = new ArrayList();
				int e=0;
				if(arrRow!=null && arrRow.size()>0)
				{
				for(int i=0;i<arrRow.size();i++)
				{ 
				arrCol = (ArrayList)arrRow.get(i);
				e=e+1;
				%>
			<tr>
				<td style="text-align:center">&nbsp;<%=e%></td>
				<td style="text-align:center">&nbsp;<%=arrCol.get(0)%></td>
				<td style="text-align:center">&nbsp;<%=arrCol.get(5)%></td>
				<td style="text-align:right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
				<td style="text-align:right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td>
				<td style="text-align:right">&nbsp;<%=arrCol.get(3)%></td>
				<td style="text-align:center">&nbsp;<%=arrCol.get(4)%></td>
			</tr>
			<%}} else{%>	
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<%}%>
		</table>	
		</div>
	</td>
</tr>
			
			<tr>
			<td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
			<td class="title">Complete details of securities offered for the proposed facility  </td>
			 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
			</tr>
			</table>
			</td>
			</tr>
			<tr>
			<td>
			<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr class="tblhead">
				<td width="15%">Type</td>
				<td width="20%">Value of Securities</td>
				<td width="20%">Comments</td>
			</tr>
			<tr>
			<td>Primary</td>
			<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("PG_PRIME_SECVAL"))))%>&nbsp;</td>
			<td><%=Helper.correctNull((String) hshValues.get("PG_PROPFAC_SEC_PRIME"))%>&nbsp;</td>
			</tr>
			<tr>
			<td>Collateral</td>
			<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("PG_COLLATERAL_SECVAL"))))%>&nbsp;</td>
			<td><%=Helper.correctNull((String) hshValues.get("PG_PROPFAC_SEC_COLLATERAL"))%>&nbsp;</td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<tr>
			<td>
			<div id="top">
			<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr>
				<td width="50%">Last two years Income as per IT Returns net off taxes paid.(if joint applicants, furnish the same separately)</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_ITRETURNS_TAXPAID"))%></td>
			</tr>
			<tr>
				<td width="50%">Scheme/Loan policy  Guidelines</td>
				<td width="50%"><%=Helper.correctNull((String) hshValues.get("PG_SCHEME_GUIDELINES"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="50%">Deviations for which permission sought other than Interest concession</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_DEVPERM_SOUGHTOTHERS"))%></td>
			</tr>
			<tr>
				<td width="50%">Concession sought in ROI, processing charges, commission on guarantees etc., </td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_CONCESSION_RECOMMENDED"))%></td>
			</tr>
			<tr>
				<td width="50%">Earlier concessions if any, along with permission reference no.</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_EARLIERCONCESSION"))%></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<%if(Helper.correctNull((String) hshValues.get("assessment")).equalsIgnoreCase("Y"))
				{%>
			<tr>
			<td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
						<td class="title">Eligible interest concession based on the parameters:<br/>
								 Rating of the borrower (based on audited financial as on <%=Helper.correctNull((String) hshValues.get("PG_RATINGDATE"))%>): <%=Helper.correctNull((String) hshValues.get("PG_BOR_RATING"))%>
								 </td>
								 </tr>
								 </table>
								 </td>
								 </tr>
						<tr>
						<td>
						<div id="top">
						<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
						
						<tr class="tblhead">
							<td width="45%">General assessment of the party </td>
							<td width="15%">Marks</td>
							<td width="15%">Marks Prescribed By the Br.</td>
							<td width="15%">Marks Awarded at RO/HO</td>
						</tr>
						
						<% 
				//int val1=0;		
				ArrayList arrCol1 = new ArrayList();
				ArrayList arrRow2 = (ArrayList)hshValues.get("arrData1");
				if(arrRow2!=null && arrRow2.size()>0)
				{
				for(int i=0;i<arrRow2.size();i++)
				{ 
				arrCol1 = (ArrayList)arrRow2.get(i);
				%>	
					
						<tr>
							<td>&nbsp;<%=arrCol1.get(0)%>  <%if(!Helper.correctNull((String)arrCol1.get(1)).equalsIgnoreCase("")){%>(<%=Helper.correctNull((String)arrCol1.get(1))%>)<%} %></td>
							<td>&nbsp;<%=arrCol1.get(2)%></td>
							<td>&nbsp;<%=arrCol1.get(3)%></td>
							<td>&nbsp;<%=arrCol1.get(4)%></td>
						</tr>
					<%}}
					else{%>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					<%} %>
						<tr>
							<td class="title">TOTAL AGGREGATE MARKS</td>
							<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("temp"))%></td>
							<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("temp1"))%></td>
							<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("temp2"))%></td>
						</tr>
					
						<tr>
							<td colspan="4" class="title">Concession recommended</td>
						</tr>
						
						<tr>
							<td colspan="4" class="title"><u>Particulars of scores to consider interest rebate:</u><br/>
						
								<table width="50%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
								 	<tr class="tblhead">
										<td align="center">Score</td><td align="center">Rebate</td>
									</tr>
									<tr>
										<td align="center">Above 45%</td><td align="center"> 2.00%</td>
									</tr>
									<tr>
										<td align="center">35% to 44%</td><td align="center">2.00%</td>
									</tr>
									<tr>
										<td align="center">30% to 34%</td><td align="center">1.50%</td>
									</tr>
									<tr>
										<td align="center">25% to 29%</td><td align="center">1.00%</td>
									</tr>
									<tr>
										<td align="center">Below 25%</td><td align="center">0.50%</td>
									</tr>
								</table>
								<br>
							</td>
						</tr>
						</table></div>
						
					</td>
			</tr>
				<%} %>
		
		    <%if(Helper.correctNull((String) hshValues.get("finance")).equalsIgnoreCase("Y"))
		    	{%>
		    	
		    <tr>
		    <td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
				<td class="title">Gist of Balance Sheet Analysis</td>
				</tr>
				</table>
				</td>
		    </tr>	
		      <tr>
			    <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
			    </tr>
		    <tr>
			    <td>
			    <div id="top">
			    	<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
					<tr class="tblhead">
						 <td rowspan="2">Particulars</td>
					<%	
					int colsize=Integer.parseInt(Helper.correctInt((String)hshValues.get("yearno")));
					for(int j=1;j<=colsize;j++)
					 {
					  %>
						 <td><%=Helper.correctNull((String) hshValues.get("txt_year"+j))%>&nbsp;</td>
					 <% } %>
					  </tr>
					 
					 <tr>
					<%	
					for(int j=1;j<=colsize;j++)
					 {
						 String finyeartype=Helper.correctNull((String) hshValues.get("combo"+j));
						 if(finyeartype.equals("a"))
							 finyeartype="Audited";
						 else if(finyeartype.equals("u"))
							 finyeartype="Unaudited";
						 else if(finyeartype.equals("e"))
							 finyeartype="Estimated";
						 else if(finyeartype.equals("p"))
							 finyeartype="Projected";
					  %>
						 <td class="tblhead"><%=finyeartype%>&nbsp;</td>
					 <% } %>
					  </tr>
					 
					 
					 <%
					 	for(int i=1;i<=15;i++)
					 	{
					 	%>	
					 	<tr>
					 		<td><%=Helper.correctNull((String) hshValues.get("hsh_row"+i+"c0"))%>&nbsp;</td>
					 	<%	for(int j=1;j<=colsize;j++)
					 		{
					  %>
								 <td align="right"><%=Helper.correctNull((String) hshValues.get("hsh_row"+i+"c"+j))%>&nbsp;</td>
					 <% }  %>
						 </tr>
					 <% } %>

					 
					 </table>
					 </div>
				 </td>
			 </tr>
			<%} %> 
			<tr>
			<td>
			<div id="top">
			<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr>
					<%if(strpermissionfalg.equalsIgnoreCase("Y")){%>
						<td   width="44%">Hunter Score</td>
				        <td   width="54%"><%=Helper.correctNull((String) hshValues.get("intHuntScore1"))%></td>
					<%} %>
			</tr>
			<tr>
				<td width="50%" valign="top"> Background of the applicant</td>
				<td width="50%" valign="top">&nbsp;<%=Helper.correctNull((String) hshValues.get("strBkgroundcmts")) %></td>
		    </tr>
			 <tr>
				 <td width="50%">Justification by the Branch for specific consideration of the credit facility with deviation</td>
				 <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("PG_JUSTF_SPECCONSID"))%></td>
			 </tr>
			
			<tr>
				 <td width="50%">Branch/RLPC Recommendation</td>
				 <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("PG_RECOMMEND_BRANCH"))%></td>
			 </tr>	
			
			<tr>
				 <td width="50%">Sanction Department View</td>
				 <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("PG_RECOMMEND_HOVIEW"))%></td>
			 </tr>
			
			<tr>
				 <td width="50%">Sanction Department Recommendation</td>
				 <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("PG_RECOMMEND_HO"))%></td>
			 </tr>
			 <tr>
				<td colspan="2">
					 <b>Other conditions:</b> 
				        <ol type="i">
				         <%
											if (arrRow9 != null && arrRow9.size() > 0) {
												for (int i = 0; i < arrRow9.size(); i++) {
													arrCol = (ArrayList) arrRow9.get(i);
										%>
				        <li><%=Helper.correctNull((String) arrCol.get(0))%></li>
						<%}%>
						<%} %>
						<li>Collect handling charges of Rs.<%=Helper.correctDouble((String)hshValues.get("PERM_HANDLING_CHARGE")) %> plus applicable taxes.</li>
						</ol>
				</td>
			</tr>
		</table>
		</div>
		</td>
		</tr>
	
<tr><td><table width="98%" align="center" cellpadding="0" cellspacing="0" border="0">
	 								 <%
                                   
	 								if(arryRow!=null && arryRow.size()>0)
	 								{
	 										for(int i=0;i<arryRow.size();i++)
	 										{
	 											arryCol=(ArrayList)arryRow.get(i); 
									
                                   %>
                                   			<%
								if (i % 2 == 0) {
												%>
									 <tr><td>&nbsp; </td></tr>
									<tr><td align="left"><br><b><%= Helper.correctNull((String)arryCol.get(0))%></b> </td></tr>
									<tr><td align="left" class="title"><%= Helper.correctNull((String)arryCol.get(1))%></td></tr>
									<%} else {
										%>
										
										<tr><td align="right"><br><b><%= Helper.correctNull((String)arryCol.get(0))%></b></td></tr>
										<tr><td align="right" class="title"><%= Helper.correctNull((String)arryCol.get(1))%></td></tr>
										<%
										}
										%>
										<%}} %>
									
									
										
</table></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
</table>	

</body>
</html>