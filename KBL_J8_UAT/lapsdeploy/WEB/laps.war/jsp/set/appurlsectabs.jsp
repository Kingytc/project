<%@include file="../share/directives.jsp"%>
<%
int pageid = Integer.parseInt(request.getParameter("pageid"));
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
if(pageid==1)
{
	sectype="";
}
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String securityid=Helper.correctNull((String)request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
if(strPagefrom.equalsIgnoreCase(""))
	strPagefrom = Helper.correctNull((String) request.getParameter("secpagefrom"));
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Security values</title>
<style>
.sub_tab_active_new
{
	background-color: #942188;
	 color: #FFFFFF;
	 font-weight: bold;
	 font-family: Trebuchet MS;
	 font-size: 13px;
	 padding: 10px 10px;
	 border: 1px solid #dcbad8;
	 text-decoration: none;
	/* background-color:#7a4d98 !important;
	color:#FFFFFF !important;
	font-weight:bold  !important;
	font-family: Trebuchet MS !important;
	font-size:11px; height: 20px !important; 
	border-bottom:2px solid #532e6c !important;
	border-right:1px solid #532e6c !important;
	border-left:1px solid #875ba4 !important;
	text-decoration:none !important;
	style :display inline-block  !important;
	padding:2px 10px !important; */
	 /*border-right:1px solid #b4c3d1; border-left:1px solid #b4c3d1;border-top:1px solid #b4c3d1;*/
}
</style>
<script language="JavaScript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var securityidval="<%=securityid%>";
var varPagefrom="<%=strPagefrom%>";
function callalert()
{
	alert("Click Freeze to view Security Coverage");
	return;
}
function callLink(bean,method,page)
{ 
	document.forms[0].hidBeanGetMethod.value=method;
 	document.forms[0].hidBeanId.value=bean;
 	document.forms[0].action=appURL+"action/"+page+"?pagefrom="+varPagefrom;
 	document.forms[0].submit();
}
function callLinkComments(bean,method,page)
{ 
	document.forms[0].hidBeanGetMethod.value=method;  
 	document.forms[0].hidBeanId.value=bean;
 	document.forms[0].action=appURL+"action/"+page+"?pagefrom="+varPagefrom+"&hpage=secoverage&hidsecid="+securityidval;
 	document.forms[0].submit();
}

function callLinkSecComments(bean,method,page)
{ 
	document.forms[0].hidBeanGetMethod.value=method;  
 	document.forms[0].hidBeanId.value=bean;
 	document.forms[0].action=appURL+"action/"+page+"?pagefrom="+varPagefrom+"&hpage=secoveragecmts&hidsecid="+securityidval;
 	document.forms[0].submit();
}

function callLinkSecComments1(bean,method,page)
{ 
	document.forms[0].hidBeanGetMethod.value=method;  
 	document.forms[0].hidBeanId.value=bean;
 	document.forms[0].action=appURL+"action/"+page+"?hidPageVal=seccomments&hpage=secoveragecmts&hidsecid="+securityidval;
 	document.forms[0].submit();
}
function callPerLinkComments(bean,method,page)
{ 
	document.forms[0].hidBeanGetMethod.value=method;  
 	document.forms[0].hidBeanId.value=bean;
 	document.forms[0].action=appURL+"action/"+page+"?pagefrom="+varPagefrom+"&hidPage1=secoverageretail&hidsecid="+securityidval;
 	document.forms[0].submit();
}
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
	<tr><td>
		<table width="10%" border="0" cellspacing="1" cellpadding="0" class="outertable">
		 <tr>
		 <%if(!strPagefrom.equalsIgnoreCase("secmailbox")){ %>
		   <%if(pageid==1){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Security</b></td>
		 	<%}else{ 
		 		 if(strSessionModuleType.equals("AGR")|| strSessionModuleType.equals("CORP")){
		 	%>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getSecurityValuesDetails','securitiesMasterPage.jsp')">
				Security</a></b></td>
		 	<%}
		 		 else
		 		 {
		 			 %>
		 			 <td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('bankappfi','getSecurityRetailDetails','securitymaster_retail.jsp')">
				Security</a></b></td>
		 			 <%
		 		 }
		 	}}%>
		   	<%if(!sectype.equalsIgnoreCase("")){ %>
		 	<%if(pageid==2){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Security Details</b></td>
		 	<%}else{ %>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getSecuritiesbySecId','security_detailsdisp.jsp')">
				Security Details</a></b></td>
			<%}}%>
		 	<%if(sectype.equalsIgnoreCase("5")){ %>
			<%if(pageid==5){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Financial Documents-Non Tradeable or Non Transferable</b></td>
		 	<%}else{ %>			
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getFinDocNonTradeable','setFinDocNonTradeable.jsp')">
				Financial Documents-Non Tradeable or Non Transferable</a></b></td>
			<%}}if(sectype.equalsIgnoreCase("6")){ %>
			<%if(pageid==6){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Financial Documents- Tradeable or Transferable</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getFinDocTradeable','setFinDocTradeable.jsp')">
				Financial Documents- Tradeable or Transferable</a></b></td>
			<%}}if(sectype.equalsIgnoreCase("7")){ %>
			<%if(pageid==7){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Bank Deposits</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getSecurityBankDeposit','securitiesBankDeposits.jsp')">
				Bank Deposits</a></b></td>
			<%}}if(sectype.equalsIgnoreCase("8")){ %>
			<%if(pageid==8){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Jewel Details</b></td>
		 	<%}else if(strSessionModuleType.equals("AGR")){if(pageid==23){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Jewel Details</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getJewelDetail','securitiesJewelDetail.jsp')">
				Jewel Details</a></b></td>
			<%}}else{%>
				<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getJewelDetail','securitiesJewelDetail.jsp')">
				Jewel Details</a></b></td>
			<%}
			}if(sectype.equalsIgnoreCase("9")){ %>
			<%if(pageid==9){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Title to Goods</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getTitleGoods','securitiesTitleGoods.jsp')">
				Title to Goods</a></b></td>
			<%}}if(Integer.parseInt(Helper.correctInt(sectype))>=10 && Integer.parseInt(Helper.correctInt(sectype))<=17){ %>
			<%if(pageid==11){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Property Details</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getPropertyDetData','sec_propertydet.jsp')">
				Property Details</a></b></td>
			<%}
			if(pageid==101){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Legal Opinion</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getLegalOpinion','sec_property_legalopinion.jsp')">
				Legal Opinion</a></b></td>
			<%}
			}if(sectype.equalsIgnoreCase("18")){ %>
			<%if(pageid==18){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Vehicle</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getSecurityVehicle','securitiesVehicle.jsp')">
				Vehicle</a></b></td>
			<%}}if(sectype.equalsIgnoreCase("19")){ %>
			<%if(pageid==19){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Plant & Machinery</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getPlantMachinery','securitiesPlantMachinery.jsp')">
				Plant & Machinery</a></b></td>
			<%}}if(sectype.equalsIgnoreCase("20")){ %>
			<%if(pageid==20){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Furniture & Fixtures</b></td>
		 	<%}else{ %>
			<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getFurnitures','securitiesFurnitureFixture.jsp')">
				Furniture & Fixtures</a></b></td>
			<%}}%>
			<%if(!strPagefrom.equalsIgnoreCase("secmailbox")){
			if(pageid==21){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Attached Securities</b></td>
		 	<%}else{
		 		 if(strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")){
		 	%>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLink('securitymaster','getAttachedSecurityDetails','attachedsecurities.jsp?pslink=y')">
				Attached Securities</a></b></td>
		 	<%}
		 		else
			 	{
		 			%>
				 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
						href="JavaScript:callLink('bankappfi','getAttachedRetailSecurityDetails','attachedsecurities_retail.jsp')">
						Attached Securities</a></b></td>
				 	<%
			 	}
		 	}
		 	%>
		 	<%if(pageid==22){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Security Coverage</b></td>
		 	<%}else{ %>
		 	<% String Freezeflag=Helper.correctNull((String)request.getParameter("Freezeflag"));
		 	if(Freezeflag.equalsIgnoreCase(""))
		 	{
		 		Freezeflag=Helper.correctNull((String)hshValues.get("Freezeflag"));
		 	}
		 	if(Freezeflag.equalsIgnoreCase(""))
		 	{
		 		Freezeflag=Helper.correctNull((String)hshValues.get("strFreezeflag"));
		 	}
		 	if(Freezeflag.equalsIgnoreCase("Y")){%>
		 	<%if(strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")){ %>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('securitymaster','getCollateralSecurityDisplaynew','com_attchsecuritydisplay.jsp')">
			 	Security Coverage</a></b></td>	
			 	<%}else{ %>	
			 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('securitymaster','getCollateralSecurityDisplayretail','com_attchsecuritydisplay_reatail.jsp')">
			 	Security Coverage</a></b></td>	
			 	<%} %>		
			<% }else{%>
			<td nowrap="nowrap" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
		 	<%}%>
		 	<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
		 	<%if(strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")){ %>
		 	<%if(pageid==99){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Additional Securities offered for the proposed facilities</b></td>
		 	<%}else{%>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLinkSecComments1('facilities','getComments','com_addseccomments.jsp')">
				Additional Securities offered for the proposed facilities</a></b></td>
		 	<%}}%>
		 	<%if(strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")){
		 		if(!Helper.correctNull((String)session.getAttribute("strECFlag")).equalsIgnoreCase("Y")){%>
		 	<%if(pageid==98){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Comments on security coverage</b></td>
		 	<%}else{%>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLinkComments('facilities','getComments','com_secucovergcomments.jsp')">
				Comments on security coverage</a></b></td>
		 	<%}}}else{%>	
		 	<%if(pageid==98){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Comments on security coverage</b></td>
		 	<%}else{%>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callPerLinkComments('facilities','getComments','per_commentsonseccovergae.jsp')">
				Comments on security coverage</a></b></td>
		 	<%}
		 	} %>
		 	<%if(strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")){ %>
		 	<%if(pageid==100){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Sec coverage Comments</b></td>
		 	<%}else{%>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLinkSecComments('facilities','getComments','securitycoveragecommentsnew.jsp')">
				Sec coverage Comments</a></b></td>
		 	<%}}
		 	if(strSessionModuleType.equals("AGR") || strSessionModuleType.equals("CORP")){ %>
		 	<%if(pageid==102){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>MDTD</b></td>
		 	<%}else{%>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callMDTD();">
				MDTD</a></b></td>
		 	<%}
		 	if(pageid==103){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Movement of Security Coverage </b></td>
		 	<%}else{%>
		 	
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLinkSecComments('securitymaster','getSecurityMovement','sec_coveragemovement.jsp');">Movement of Security Coverage</a></b></td>
		 	<%}
		 	if(pageid==104){%>
		 	<td nowrap="nowrap" class="sub_tab_active_new" align="center"><b>Legal opinion verification</b></td>
		 	<%}else{%>
		 	<td nowrap="nowrap" class="sub_tab_inactive_new"><b><a
				href="JavaScript:callLinkSecComments('bankappfi','getlegalopinionverification','legalopinionverificationfor_corp_agri.jsp?pslink=y');">Legal opinion verification</a></b></td>
		 	
		 	<%}
		 	}
		 	}}%>	
		 			 	
		</tr>
	  </table>
	</td></tr>
</table>
<input type="hidden" name="secpagefrom" value="<%=strPagefrom %>">
</body>
</html>