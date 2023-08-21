<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	int linkid = Integer.parseInt(request.getParameter("linkid"));
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strcategorytype = Helper.correctNull((String) request.getParameter("hidCategoryType"));
	String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
	String strEmploymentStatus=Helper.correctNull((String)session.getAttribute("perapp_employment"));
	
	String strTakeOverFlag =Helper.correctNull((String)request.getParameter("hidTakeOverFlag"));
	if(strTakeOverFlag.equals(""))
	{
		strTakeOverFlag	=Helper.correctNull((String) hshValues.get("loan_takeover"));	
	}
	String strTakeOverAvailFlag =Helper.correctNull((String) request.getParameter("hidtakeoveravail"));
	if(strTakeOverAvailFlag.equals(""))
	{
		strTakeOverAvailFlag =Helper.correctNull((String) hshValues.get("TakeOverAvailFlag"));
	}
	String strAgriPrdFlag=Helper.correctNull((String) hshValues.get("prd_whetheragri"));
	if(strAgriPrdFlag.equalsIgnoreCase(""))
	{
		strAgriPrdFlag=Helper.correctNull((String) request.getParameter("hidAgriProduct"));
	}
	String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
	if(strProAvailableFor.equals(""))
	{
		strProAvailableFor= Helper.correctNull((String) request.getParameter("hidApplicableFor"));
	}
	String digiGoldFlag = Helper.correctNull((String) session.getAttribute("digiGoldFlag"));
	String sessionModuleType = Helper.correctNull((String) session.getAttribute("sessionModuleType")); //vindhya

%>
<HTML>
<HEAD>
<TITLE>Application Form Navigation</TITLE>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script type="text/javascript">
var varTakeOverAvailFlag="<%=strTakeOverAvailFlag%>";
var varTakeOverFlag="<%=strTakeOverFlag%>";
var varlinkid = "<%=linkid%>";
var sessionModuleType = "<%=sessionModuleType%>";
function gototab(beanid, methodname, pagename) 
{//vindhya begin
	if(sessionModuleType=="RET")
	{
		if(document.forms[0].freezeflag)
		{
		if(document.forms[0].freezeflag.value=="Y")
		{ 
			if(document.forms[0].varPanCheck.value=="Y")
			{ 
				if(sessionModuleType!="AGR")
				{			
						 if(document.forms[0].Explimitchk.value=="F")
							 {
								 if (document.forms[0].varPancount.value=="N")
								{
								 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
									return;
								}	 
							}
						}	
				
					 
				}		
				
			}
			}	
		}	
	
	//vindhya end
	if(sessionModuleType=="RET")
	{
	if(varlinkid == "1")
	{
		var varTakeOver =  document.forms[0].sel_take_over.value;
		var varTakeoverpageFilled =  document.forms[0].hidtakeoveravail.value;
		if(varTakeOver=="Y" && varTakeoverpageFilled=="N")
		{
			ShowAlert('192');
			return;
		}
		if((document.forms[0].schemetype.value=="079" || document.forms[0].schemetype.value=="078") && document.forms[0].hidPMAYDet.value=="N"
			&&  document.forms[0].appstatus.value=="Open/Pending")
		{
			alert("Please Enter the PMAY Details");
			return;
		}
		if((document.forms[0].schemetype.value=="080" || document.forms[0].schemetype.value=="081") && document.forms[0].hidAHPDet.value=="N"
			&&  document.forms[0].appstatus.value=="Open/Pending")
		{
			alert("Please Enter the Affordable Housing in Partnership Details");
			return;
		}
		if(document.forms[0].hidCGTMSE)
		{
			if(document.forms[0].hid_cgtmse_applicable.value=="Y")
			{
				if(document.forms[0].hidCGTMSE.value=="N")
				{
					alert("Please Fill the CGTMSE Coverage Page");
					return;
				}
			}
		}
	}
	}
	
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value = beanid;
		document.forms[0].hidBeanGetMethod.value = methodname;
		document.forms[0].action = appURL + "action/" + pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
		return;
	}
}
</script>
</HEAD>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable" >
	<tr>
		<td>
		<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<%
					if (linkid == 1) 
					{
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Loan Product</b></td>
				<%
					} 
					else 
					{
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap">
				<%
					if (strcategorytype.equalsIgnoreCase("LAD")) {
				%> 
					<a
					href="javascript:gototab('perapplicant','getLoanProducts','ladloandetails.jsp')"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Applicant';return true;"> <b>Loan
				Product </b></a> <%
 					} else {
					 %> 
					 <a
					href="javascript:gototab('perapplicant','getLoanProducts','perloandetails.jsp')"
					onMouseOut="window.status = '';return true;"
					onMouseOver="window.status='Applicant';return true;"> <b>Loan
					Product </b></a> 
					<%
 						}
 					%>
 					<%
 					}
 					%>
				</td>
					<%
					if (!prd_type.equalsIgnoreCase("")) {
						if (prd_type.equalsIgnoreCase("pR")
								|| prd_type.equalsIgnoreCase("aR")) {
							if (linkid == 8) {
				%>

				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Deposit Details</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getLoanAgainstDep','loanagainstdep.jsp')"><b>Deposit
				Details</b></a></td>
				<%
					}
						}
						if (prd_type.equalsIgnoreCase("pG")
								|| prd_type.equalsIgnoreCase("aH")) {
							if (linkid == 8) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Gold Ornaments</b></td>
				<%
					}else{
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agrotherassets','getgolddetails','agr_goldloan.jsp')"><b>Gold
				Ornaments</b></a></td>
				<%
					}
						} %>
						
<!--						
						
				<%		if (prd_type.substring(0, 1).equalsIgnoreCase("p")
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
						} %>
					-->	
						
				<%		if (prd_type.equalsIgnoreCase("pE")) {
							if (linkid == 7) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Details for Education Loan</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('edudetails','getData','edueducational.jsp')"><b>Details for Education Loan</b></a></td>
				<%
					}
						}
				if (prd_type.equalsIgnoreCase("pP")) {
							if (linkid == 117) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Income Details</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perapplicant','getdataPerincomedetaildate','Perincomedetails.jsp')"><b>Income Details</b></a></td>
				<%
					}
						}
				if (prd_type.equalsIgnoreCase("pL")) {
					if (linkid == 9) {%>
						<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Lease Details</b></td>
				<%} else {%>
					<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perapplicant','getLeaseperiod','Per_leaseperiod.jsp')"><b>Lease Details</b></a></td>
				<%}}
				if (prd_type.equalsIgnoreCase("pI")) {
					if (linkid == 24) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Insta Cash</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
				href="JavaScript:gototab('perapplicant','getinstacash','per_instacash.jsp')"><b>Insta Cash</b></a></td>
			<%
				}
				}
				if (prd_type.equalsIgnoreCase("pB")) {
					if (linkid == 25) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>GST Return Details</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive"  WIDTH="15%"><a href="#" onclick="javascript:callLink('pergstdetails.jsp','appraisal','getGSTDetails')"> GST Return Details</a></td>
			<%
				}
				}
				}%>
				<%if((prd_type.equalsIgnoreCase("pH")&& !strPrdPurpose.equalsIgnoreCase("T"))||(prd_type.equalsIgnoreCase("pH")&& !strPrdPurpose.equalsIgnoreCase("HC")) || prd_type.equalsIgnoreCase("pA") )
				{
					if (!strcategorytype.equalsIgnoreCase("LAD")) {
				
						if (linkid == 111) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Source of Margin</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><b><a
					href="JavaScript:gototab('perapplicant','getSourceOfMargin','persource_of_margin.jsp')">Source of Margin</a></b></td>
				<%
					}
					}
				}
				if(prd_type.equalsIgnoreCase("pG")&& (strEmploymentStatus.equalsIgnoreCase("4")&& strAgriPrdFlag.equalsIgnoreCase("Y")))
				{
					if (linkid == 10) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Agriculture</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><b><a
					href="JavaScript:gototab('perapplicant','getAgricultureGold','peragriculturegold.jsp')">Agriculture</a></b></td>
				<%
					}}
				%>
				<%
				if(true)
				{
					if (linkid == 6) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Co-Applicant / Guarantor</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><b><a
					href="JavaScript:gototab('perapplicant','getCoAppGuarantor','percoappguarantor.jsp')">Co-Applicant / Guarantor</a></b></td>
				<%
					}
				}if(digiGoldFlag.equalsIgnoreCase("PJ")){
				%>
				<%
				{
					if (linkid == 77) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Verification</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><b><a
					href="JavaScript:gototab('DigitalAppInterface','getDigiDecisionDetail','appl_digitalisation_decision.jsp')">Verification</a></b></td>
				<%
					}
				}
				} %>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidAgriProduct" value="<%=strAgriPrdFlag %>">
</BODY>
</HTML>
