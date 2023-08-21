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
	String strUserClass=Helper.correctNull((String) hshValues.get("userClass")); 
	String strSubType=Helper.correctNull((String) hshValues.get("subLoanType"));
	String strConstitution= Helper.correctNull((String) hshValues.get("perapp_constitution")); 
	String strDigiRating=Helper.correctNull((String) session.getAttribute("DigiRating"));

	
	
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
var varUserClass="<%=strUserClass%>";
var varLoanSubType="<%=strSubType%>";
function gototab(beanid, methodname, pagename) 
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


		if(varLoanSubType=="PR"){

			if(document.forms[0].schemetype &&  document.forms[0].hidPMAYDet && document.forms[0].appstatus.value=="Open/Pending")
			{
				if((document.forms[0].schemetype.value=="079" || document.forms[0].schemetype.value=="078") && document.forms[0].hidPMAYDet.value=="N"  && varUserClass<130)
				{
					alert("Please Enter the PMAY Details");
					return;
				}
			}
		}

		else{
		
		if((document.forms[0].schemetype.value=="079" || document.forms[0].schemetype.value=="078") && document.forms[0].hidPMAYDet.value=="N"
			&&  document.forms[0].appstatus.value=="Open/Pending" )
		{
			alert("Please Enter the PMAY Details");
			return;
		}
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
					  {
					 %> 
					 <a
					href="javascript:gototab('perapplicant','getLoanProducts','perDigiLoandetails.jsp')"
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
					if((prd_type .equalsIgnoreCase("pH") || prd_type .equalsIgnoreCase("pA"))&& !prd_type .equalsIgnoreCase("pM") && !prd_type .equalsIgnoreCase("pC"))
					{
							if(strPrdPurpose.equalsIgnoreCase("T") || strPrdPurpose.equalsIgnoreCase("HC"))
							{
										if (linkid == 111) 
								{
							%>
							<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Source of Margin</b></td>
							<%
							} 
						}else  {
					%>
					<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><b><a
						href="JavaScript:gototab('perapplicant','getSourceOfMargin','persource_of_margin.jsp')">Source of Margin</a></b></td>
					<%
						}
					}
					else if  (prd_type.equalsIgnoreCase("pB"))
					{
									if (linkid == 25) {
							%>
							<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>GST Return Details</b></td>
									<%
								} else {
							%>
							<td class="sub_tab_inactive"  WIDTH="15%"><a href="#" onclick="javascript:callLink('pergstdetails.jsp','appraisal','getGSTDetails')"> GST Return Details</a></td>
						<%
							}
						}%>
				
				
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
				}
				%>
				
				
				<%
				String temppage="";
				if((prd_type.equalsIgnoreCase("pH"))||(prd_type.equalsIgnoreCase("pM")))
				{
					temppage="appl_digitalisation_decision_HL.jsp";
				}else if(prd_type.equalsIgnoreCase("pA") || prd_type.equalsIgnoreCase("pB"))
				{
					temppage="appl_digitalisation_decision_autoLoan.jsp";
				}
				else
				{
					temppage="appl_digitalisation_decision.jsp";
				}
				%>				
				
				<%
				if(true)
				{
					if (linkid == 77) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Verification</b></td>
				<%
					} else {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><b><a
					href="JavaScript:gototab('DigitalAppInterface','getDigiDecisionDetail','<%=temppage%>')">Verification</a></b></td>
				<%
					}
				}
				%>
				<%
				if(prd_type.equalsIgnoreCase("pB")|| (prd_type.equalsIgnoreCase("pA") && strDigiRating.equalsIgnoreCase("Exist") && !strConstitution.equalsIgnoreCase("01")))
				{ 
					if(true)
					{
				if (linkid == 26) { %>
							<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Digi Rating</b></td>
			<%} else {%>
                  <td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><b><a
					href="JavaScript:gototab('MsmeDigitalAppInterface','getScorecardDetails','msmeScoreCard.jsp')">Digi Rating</a></b></td>
                  <%}}}%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidAgriProduct" value="<%=strAgriPrdFlag %>">
</BODY>
</HTML>
