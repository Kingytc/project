<%@include file="../share/directives.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
ArrayList arrGrpexpRow = new ArrayList();
ArrayList arrGrpexpCol = new ArrayList();
ArrayList arrGrpsecRow = new ArrayList();
ArrayList arrGrpsecCol = new ArrayList();
double subTotalexp=0.00,totalExp=0.00,subSectot=0.00,Sectot=0.00;
double subExpExitotal=0.00,subExpProtot=0.00,subSecExitot=0.00,subSecProtot=0.00;
double ExpExitot=0.00,ExpExiProtot=0.00,SecExitot=0.00,SecProtot=0.00,dblRatingExposure=0.00,dblRatingExposureNF=0.00;
String strFlag=Helper.correctNull((String)hshValues.get("strFlag"));
if(hshValues !=null){
	arrGrpexpRow=(ArrayList)hshValues.get("arrExposureRow");
	arrGrpsecRow=(ArrayList)hshValues.get("Securities");
	int SecSize=arrGrpsecRow.size();
	int ExpSize=arrGrpexpRow.size();
}

java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
nft= java.text.NumberFormat.getInstance();
nft.setMaximumFractionDigits(2);
nft.setMinimumFractionDigits(2);
nft.setGroupingUsed(false);
dblRatingExposure=Double.parseDouble(Helper.correctDouble((String)hshValues.get("RatingExposureFund")));
dblRatingExposureNF=Double.parseDouble(Helper.correctDouble((String)hshValues.get("RatingExposureNonFund")));

String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
int linkid = Integer.parseInt(Helper.correctInt(request.getParameter("linkid")));

 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<script type="text/javascript">
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callLinkComments(page,bean,method,title)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hpage.value=title;	 
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
</script>
<body>
<form method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<% if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } else { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application  -&gt; Security Master -&gt; Attached Securities</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application  -&gt; Security Master -&gt; Attached Securities</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Borrower Securities</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
            
           <%if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("DIGI") ){ %>
          	 <%
				  if (prd_type.substring(0, 1).equalsIgnoreCase("p")
								&& !prd_type.equalsIgnoreCase("pE")
								&& !prd_type.equalsIgnoreCase("pG")
								&& !prd_type.equalsIgnoreCase("pM")
								&& !prd_type.equalsIgnoreCase("pL")
								&& !prd_type.equalsIgnoreCase("pI")) {
							if (linkid == 5) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Proposed/Offered
				Asset</b></td>
				<%
					} else if ((prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC")))
									|| prd_type.equalsIgnoreCase("pM")
									|| prd_type.equalsIgnoreCase("pI")
									|| prd_type.equalsIgnoreCase("pT")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pA")||(prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('percollateral','getBoatAuto','perappvehicle.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pD")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getOtherAssetData','otherassets.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pK")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agreconomic','getSolarlightData','per_solarlight.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					}
						}	
         		 %>
          <% } %>
            
            <td align="center" width="15%" class="sub_tab_active"><b>Security Coverage</b>
            </td>
          <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLinkComments('per_commentsonseccovergae.jsp','facilities','getComments','secoverageretail')">Comments on Security Coverage</a></b></b></td>
          <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callMDTD()">MDTD</a></b></b></td>
          <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitynewtab.jsp','bankappfi','getlegalopinionverification')">Legal opinion verification</a></b></b></td>		
          </tr>
        </table>
      </td>
    </tr>
  </table>
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="107" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Security</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
            <%
			if (prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC"))) {
%>
<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap" align="center"><a
	href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
Asset</b></a></td>
<%
	}
			%>
            <td align="center" width="15%" class="sub_tab_active"><b>Security Coverage</b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<%} %>
  
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr  class="dataHeader">
<td>&nbsp;</td>
<td align="center"><b>Existing Exposure</td>
<td align="center"><b>Proposed Exposure</td>
<td align="center"><b>Total Exposure</td>
<td  align="center" colspan="4"><b>Value of Securities</td>
</tr>
<tr  class="dataHeader">
<%for(int i=0;i<5;i++)
	{
	%>
	<td>&nbsp;</td>
	<%
	}
	%>
<td align="center"><b>Existing </td>
<td align="center"><b>Proposed </td>
<td align="center"><b>Total </td></tr>


<%int k=0; 
String strFlgchk="";
if(arrGrpexpRow!=null && arrGrpexpRow.size()>0)
	{
	for(int i=0;i<arrGrpexpRow.size();i++)
	{
		arrGrpexpCol=(ArrayList)arrGrpexpRow.get(i);
		if(arrGrpexpCol.get(4).equals("A"))
		{
			
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)));
			subExpProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)));
			ExpExiProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)));
	%>
	<tr class="datagrid"><td colspan="8"><b>Applicant : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr class="datagrid">
	<td><b>Fund Based</b></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8))))%></td>
	<% if(arrGrpsecRow!=null && arrGrpsecRow.size()>0)
	{
		for(k=0;k<1;k++)
		{
			arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
			subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<% }%>
	</tr>
	<%}else{
		if(!(strFlgchk.equalsIgnoreCase("Y")))
		{
			strFlgchk=Helper.correctNull((String)arrGrpexpCol.get(6));
		}
	}}
	for(int i=0;i<arrGrpexpRow.size();i++)
	{
		arrGrpexpCol=(ArrayList)arrGrpexpRow.get(i);
		if(arrGrpexpCol.get(4).equals("A"))
		{
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)));
			subExpProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)));
			ExpExiProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)));
		%>
		<tr class="datagrid">
		<td><b>Non-Fund Based</b></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9))))%></td>
	<% if(arrGrpsecRow!=null && arrGrpsecRow.size()>1)
	{
		for(;k<2;k++)
		{
			arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
			subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<%} %>
	</tr>
			
		<%}
	}%>
	<%
	int SecSize=arrGrpsecRow.size();
	if(SecSize>2){
	for(;k<arrGrpsecRow.size();k++)
	{
		arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
		subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
		SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
		subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
		Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<tr class="datagrid">
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	</tr>
	<%}}%>
	<%if(strFlgchk.equalsIgnoreCase("Y")){ %>
	<tr  class="datagrid">
	<td align="left">Sub total</td>
	<td align="right"><%=nft.format(subExpExitotal)%></td>
	<td align="right"><%=nft.format(subExpProtot)%></td>
	<td align="right"><%=nft.format(subTotalexp)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=nft.format(subSecExitot)%></td>
	<td align="right"><%=nft.format(subSecProtot)%></td>
	<td align="right"><%=nft.format(subSectot)%></td>
	</tr> 
	<% }
	}%>
	
<%
int n=0;
if(arrGrpexpRow!=null && arrGrpexpRow.size()>0)
	{
	for(int i=0;i<arrGrpexpRow.size();i++)
	{
		subExpExitotal=0.00;
		subExpProtot=0.00;
		subSecExitot=0.00;
		subSecProtot=0.00;
		subTotalexp=0.00;
		subSectot=0.00;
		arrGrpexpCol=(ArrayList)arrGrpexpRow.get(i);
		if(arrGrpexpCol.get(4).equals("O"))
		{
			n++;
			if((arrGrpexpCol.get(6).equals("Y"))){
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)));
			subExpProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)));
			ExpExiProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)));
	%>
	<tr class="datagrid"><td colspan="8"><b>Group Concern : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr class="datagrid">
	<td><b>Fund Based</b></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8))))%></td>
	
	
	<% 
	arrGrpsecRow=(ArrayList)hshValues.get("Securities"+n);
	if(arrGrpsecRow!=null && arrGrpsecRow.size()>0)
	{
		for(k=0;k<1;k++)
		{
			arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
			subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<% }%>
	</tr>
	<%
	subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)));
	subExpProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3)));
	ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)));
	ExpExiProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3)));
	subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)));
	totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)));
	%>
		<tr class="datagrid">
		<td><b>Non-Fund Based</b></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9))))%></td>
	
	<% 
	if(arrGrpsecRow!=null && arrGrpsecRow.size()>1)
	{
		for(;k<2;k++)
		{
			arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
			subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<% }%>
	</tr>
	
	
	<% int SecSize=arrGrpsecRow.size();
	if(SecSize>2){
	for(;k<arrGrpsecRow.size();k++)
	{
		arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
		subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
		SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
		subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
		Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<tr class="datagrid">
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	</tr>
	<%}}%>
	
	
<!--  Securities --> 
	
	<tr  class="datagrid">
	<td align="left">Sub total</td>
	<td align="right"><%=nft.format(subExpExitotal)%></td>
	<td align="right"><%=nft.format(subExpProtot)%></td>
	<td align="right"><%=nft.format(subTotalexp)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=nft.format(subSecExitot)%></td>
	<td align="right"><%=nft.format(subSecProtot)%></td>
	<td align="right"><%=nft.format(subSectot)%></td>
	</tr>
	<%}}}
	}%>
<tr  class="datagrid">
<td><b>Total</b></td>
<td align="right"><%=nft.format(ExpExitot)%></td>
<td align="right"><%=nft.format(ExpExiProtot)%></td>
<td align="right"><%=nft.format(totalExp)%></td>
<td><strong>Total</strong></td>
<td align="right"><%=nft.format(SecExitot)%></td>
<td align="right"><%=nft.format(SecProtot)%></td>
<td align="right"><%=nft.format(Sectot)%></td>
</tr>
<tr class="datagrid">
	<td colspan="4">&nbsp;</td>
	<%double dblExiscove=0.00,dblExisprop=0.00,dblFincove=0.00;
	double dblExistingExp=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblRestrValFund")))+Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblRestrValNF")));
	ExpExitot=ExpExitot-dblExistingExp;
	if(ExpExitot>0)
	{
		dblExiscove=(SecExitot/ExpExitot)*100;
	}
		dblExisprop=(SecProtot/ExpExiProtot)*100;
		dblFincove=(Sectot/totalExp)*100;
	%>
<td><b>Coverage(%)</b></td>
<td align="right"><%=nft.format(dblExiscove) %></td>
<td align="right"><%=nft.format(dblExisprop) %></td>
<td align="right"><%=nft.format(dblFincove) %></td>
</tr>
<tr  class="datagrid"><td colspan="3"><b>Total Rating Exposure Fund Based</b></td>
<td align="right"><%=nft.format(dblRatingExposure) %></td>
<td colspan="4">&nbsp;</td>
</tr>
<tr  class="datagrid"><td colspan="3"><b>Total Rating Exposure Non Fund Based</b></td>
<td align="right"><%=nft.format(dblRatingExposureNF) %></td>
<td colspan="4">&nbsp;</td>
</tr>
</table>
<input type="hidden" name="hid_categoryType" value=""><br>
<lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="cmdsave" disabled />
<input type="hidden" name="hpage">
<input type="hidden" name="hidValuationFlag" value="<%=Helper.correctNull((String)hshValues.get("valuationFlag"))%>">
<input type="hidden" name="hidHouseEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))%>">
<input type="hidden" name="hidVehicleEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))%>">
</form>
</body>
</html>