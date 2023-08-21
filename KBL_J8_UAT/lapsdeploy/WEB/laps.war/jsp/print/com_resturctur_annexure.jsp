<%@include file="../share/directives.jsp"%>
<%
	

String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
ArrayList arrRestRow=new ArrayList();
ArrayList arrRestCol=new ArrayList();
arrRestCol=(ArrayList)hshValues.get("arrRestRow");
%>
<html>
<head>
<title>Restructure Annexure</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
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
</head>
<body>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">

<tr><td>
	            <table width="100%" border="0" align="center" cellpadding="3"
						cellspacing="0">
	              <tr> 
	                <td align="center" colspan="4"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	              </tr>
	              </table>
			</td></tr>
			<tr><td align="center" class="title"><br>Restructure Annexure</td></tr>
<tr><td>
<table width="90%" align="center" cellpadding="3" cellspacing="0" border="0">
</table>
</td></tr>
<tr>
<td>
<div id="top">
<table width="90%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr class="tblhead" align="center">
				<td colspan="3"><b>&nbsp;&nbsp; Restructure Details:</b></td>
			</tr>
			<tr>
<td width="5%">a.</td>
<td width="65%">Name of the Branch </td>
<td  width="30%"><%//=Helper.correctNull(Helper.correctNull((String)hshValues.get("org_name"))).toUpperCase()%></td>
</tr>
			<tr>
<td width="5%">b.</td>
<td width="65%">Name of the Region  </td>
<td  width="30%"><%//=Helper.correctNull(Helper.correctNull((String)hshValues.get("Reg_org_name"))).toUpperCase()%></td>
</tr>

<tr>
<td width="5%">c.</td>
<td width="65%">Name of the Borrower </td>
<td  width="30%"><%//=Helper.correctNull((String)hshValues.get("perapp_fname"))%></td>
</tr>
<tr>
<td>d.</td>
<td>Restructure Settlement Scheme</td>
<%if(strSessionModuleType.equalsIgnoreCase("RET")){ %>
<td><%=Helper.correctNull((String)hshValues.get("strrestscheme"))%></td>
<%} else{%>
	<% if(arrRestCol!=null&&arrRestCol.size()>0)
{%>
<td align="left">
	<%for(int i=0;i<arrRestCol.size();i++)
	{
	 arrRestRow=(ArrayList)arrRestCol.get(i);%>
	
	<%=Helper.correctNull((String)arrRestRow.get(0))%></br>
<%
}%>	
	</td>
	<%}} %>
</tr>
<tr>
<td>e.</td>
<td >Proposed Limit </td>
<%if(strSessionModuleType.equalsIgnoreCase("RET")){ %>
<td><%=Helper.correctNull((String)hshValues.get("LOAN_RECMDAMT"))%></td>
<%} else{%>
	<% if(arrRestCol!=null&&arrRestCol.size()>0)
{%>
<td align="left">
	<%for(int i=0;i<arrRestCol.size();i++)
	{
	 arrRestRow=(ArrayList)arrRestCol.get(i);%>
	
	<%=Helper.correctNull((String)arrRestRow.get(1))%></br>
<%
}%>	
	</td>
	<%}} %>
</tr>
<tr>
<td>f.</td>
<td>Loan period</td>
<%if(strSessionModuleType.equalsIgnoreCase("RET")){ %>
<td><%=Helper.correctNull((String)hshValues.get("LOAN_REQTERMS"))%></td>
<%} else{%>
	<% if(arrRestCol!=null&&arrRestCol.size()>0)
{%>
<td align="left">
	<%for(int i=0;i<arrRestCol.size();i++)
	{
	 arrRestRow=(ArrayList)arrRestCol.get(i);%>
	
	<%=Helper.correctNull((String)arrRestRow.get(3))%></br>
<%
}%>	
	</td>
	<%}} %>
</tr>

<tr>
<td>g.</td>
<td>Moratorium period (in Months) if any </td>
<%if(strSessionModuleType.equalsIgnoreCase("RET")){ %>
<td><%=Helper.correctNull((String)hshValues.get("loan_noofinstallment"))%></td>
<%} else{%>
	<% if(arrRestCol!=null&&arrRestCol.size()>0)
{%>
<td align="left">
	<%for(int i=0;i<arrRestCol.size();i++)
	{
	 arrRestRow=(ArrayList)arrRestCol.get(i);%>
	
	<%=Helper.correctNull((String)arrRestRow.get(2))%></br>
<%
}%>	
	</td>
	<%}} %>
</tr>
<tr>
<td>h.</td>
<td>Rate of Interest </td>
<%if(strSessionModuleType.equalsIgnoreCase("RET")){ %>
<td><%=Helper.correctNull((String)hshValues.get("LOAN_INTRATE"))%></td>
<%} else{%>
	<% if(arrRestCol!=null&&arrRestCol.size()>0)
{%>
<td align="left">
	<%for(int i=0;i<arrRestCol.size();i++)
	{
	 arrRestRow=(ArrayList)arrRestCol.get(i);%>
	
	<%=Helper.correctNull((String)arrRestRow.get(4))%></br>
<%
}%>	
	</td>
	<%}} %>
</tr>
<tr>
<td>i.</td>
<td>Interest to be collected during moratorium </td>
<%if(strSessionModuleType.equalsIgnoreCase("RET")){ %>
<td><%=Helper.correctNull((String)hshValues.get("loan_servised"))%></td>
<%} else{%>
	<% if(arrRestCol!=null&&arrRestCol.size()>0)
{%>
<td align="left">
	<%for(int i=0;i<arrRestCol.size();i++)
	{
	 arrRestRow=(ArrayList)arrRestCol.get(i);%>
	
	<%=Helper.correctNull((String)arrRestRow.get(5))%></br>
<%
}%>	
	</td>
	<%}} %>
</tr>
</table>
</div>
</td>
</tr>

 -->

<tr>
<td>
<div id="top">
<table width="90%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr class="tblhead" align="center">
				<td colspan="4"><b>&nbsp;&nbsp; Eligibility under Restructure:</b></td>
			</tr>
<tr>
<td align="left" >a.</td>
<td align="left"><b>Type of Borrower</b></td>

<td align="left" colspan="2"><%=Helper.correctNull((String)hshValues.get("strborrower"))%></td>

</tr>
<tr>
<td align="left">b.</td>
<td align="left"><b>PurposeoftheLoan</b></td>
<td align="left" colspan="1"><%=Helper.correctNull((String)hshValues.get("strpurposeloan"))%></td>
<%if(Helper.correctNull((String)hshValues.get("COM_PURPOSE_OF_LOAN")).equalsIgnoreCase("3")){ %>
<td><%=Helper.correctNull((String)hshValues.get("stragriallied"))%></td>
<%}else{ %>
<td colspan="1"></td>
<%} %>
</tr>
		
				<tr class="dataheader">
					<td align="center" colspan="4" class="tblhead"><b>RBI Parameters</b></td>
				</tr>
			
				<tr class="tblhead">
					<td >S.No</td>
					<td >Parameters under</td>
					<td>Instant Case</td>
					<td >Eligible</td>
				</tr>
				<tr>
					<td>1.</td>
					<td nowrap="nowrap"><b>Permitted activities under Resolution Frame work</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strpermact"))%>
					<%  if(Helper.correctNull((String)hshValues.get("COM_PERM_ACT")).equalsIgnoreCase("6")){%><%="-"+Helper.correctNull((String)hshValues.get("COM_OTHER_LOAN"))%><%} %></td>
					<td><%=Helper.correctNull((String)hshValues.get("strpermactelig"))%></td>
				</tr>
				<tr>
					<td>2.</td>
					<td nowrap="nowrap"><b>Aggregate exposure across all Member Lending Institutions (MLIs) as on March 31,2021</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_EXPOSUE"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strexposueelig"))%></td>
				</tr>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")){%>
				<tr>
					<td id="val1">3.</td>
					<td nowrap="nowrap"><b>whether borrower availed Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strborroweravailed"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strborroweravailedelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")&& Helper.correctNull((String)hshValues.get("COM_BRW_AVAILED")).equalsIgnoreCase("Y")){%>
				<tr>
					<td nowrap="nowrap" id="val1">3.a)</td>
					<td nowrap="nowrap"><b>Previous Moratorium Granted</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_PRESENT_MOROTORIUM"))%></td>
<td></td>
				</tr>
				<tr>
					<td nowrap="nowrap">3.b)</td>
					<td nowrap="nowrap"><b>Already extended Due date in CBS</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_EXTENDED_DATE"))%></td>
					<td></td>
				</tr>
				<tr id="id_borrower3">
					<td nowrap="nowrap">3.c)</td>
					<td nowrap="nowrap"><b>Present Moratorium Granted</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_PREVIOUS_MOROTORIUM"))%></td>
<td></td>
				</tr>
<%} %>


				<tr>
								<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")){%>
				
					<td id="val2">4.</td>
					<%}else{ %>
						<td id="val2">3.</td>
					<%} %>
					<td nowrap="nowrap" ><b>Whether GSTIN Registered<b></td>
					<%
					String strwhethergstrn=Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG"));
					if(strwhethergstrn.equalsIgnoreCase("Y")){
						strwhethergstrn="Yes";
					}else if(strwhethergstrn.equalsIgnoreCase("N")){
						strwhethergstrn="No";
					}else if (strwhethergstrn.equalsIgnoreCase("NA")){
						strwhethergstrn="Not Applicable";
					}else{
						strwhethergstrn="";
					}
					 %>
					 <td><%=strwhethergstrn %></td>
					 <td>&nbsp;</td>
					 </tr>
					 <tr>
											
						<%if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("Y")){ %>
											<td >a)</td>
						
						<td nowrap="nowrap" ><b> GSTIN <b></td>	
						<td>			
						<%
						String[] strArr1=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN")).split("@");
						for(int a=0;a<strArr1.length;a++)
						{
							%>
							
						<%=strArr1[a] %><br/>
									 
						<%} }else if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("N")){%>
						<td >a)</td>
						<td nowrap="nowrap" ><b>Whether GSTIN Exempted <b></td>				
						<td>
						<%String strexempted=Helper.correctNull((String)hshValues.get("COMINFO_GST_EXEMPTED"));
						if(strexempted.equalsIgnoreCase("Y")){
							strexempted="Yes";
							
						}else if(strexempted.equalsIgnoreCase("N")){
							strexempted="No";
						}else{
							strexempted="";
						}
						%>
						<%=strexempted%><br/>
						
						<%} else{%>
			        		
						
						<%} %>
						</td>
						<td></td>
				</tr>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("3")){%>
				<tr>
					<td id="val3">4.</td>
					<td nowrap="nowrap"><b>Restructure under earlier MSME Restructuring Schemes</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strmsmerestscheme"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strmsmerestschemeelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("2")){%>
				<tr>
					<td id="val4">4.</td>
					<td nowrap="nowrap"><b>Restructured under earlier Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strframework"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strframeworkelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("4")){%>
				<tr>
					<td id="val4">4.</td>
					<td nowrap="nowrap"><b>Restructured under earlier Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strrestallied"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strrestalliedelig"))%></td>
				</tr>
				<%} %>
				</br>
				</br>
				</br>
	
</table>
</body>
</html>