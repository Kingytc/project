<%@ page import="com.sai.laps.helper.*"%>
<%
int tabid =Integer.parseInt(request.getParameter("tabid"));
String prd_type = Helper.correctNull((String)session.getAttribute("strProductType"));
String strProAvailableFor=Helper.correctNull((String)request.getParameter("hidApplicableFor"));

%>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable" > 
				<tr>
					<%if(prd_type.equalsIgnoreCase("pH") || prd_type.equalsIgnoreCase("pM") || prd_type.equalsIgnoreCase("pI") || prd_type.equalsIgnoreCase("pT")){
					if(tabid == 1) { %>
					<td align="center" class="sub_tab_active" width="15%">
						<b>House</b>
					</td>
					<% 	} else {%>
					<td align="center" class="sub_tab_inactive" width="15%">
						<a href="JavaScript:gotoTab(appURL,'perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='House';return true;">
							<b>House</b>
						</a>
					</td>
					<%}}
					if(prd_type.equalsIgnoreCase("pA") || prd_type.equalsIgnoreCase("pI") || ( prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {if(tabid==2){ %>
					<td align="center" class="sub_tab_active" width="15%"><b>Vehicle</b></td>
					<%}else { %>
					<td align="center" class="sub_tab_inactive" width="15%">
						<a href="JavaScript:gotoTab(appURL,'percollateral','getBoatAuto','perappvehicle.jsp')"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='Vehicle';return true;">
							<b>Vehicle</b>
						</a>
					</td>
					<%}}
					if(prd_type.equalsIgnoreCase("pK")) {if(tabid==7){ %>
					<td align="center" class="sub_tab_active" width="15%"><b>Solar Lighting</b></td>
					<%}else { %>
					<td align="center" class="sub_tab_inactive" width="15%">
						<a href="JavaScript:gotoTab(appURL,'agreconomic','getSolarlightData','per_solarlight.jsp')"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='Solar Lighting';return true;">
							<b>Solar Lighting</b>
						</a>
					</td>
					<%}}
					if(prd_type.equalsIgnoreCase("pD") || prd_type.equalsIgnoreCase("pI")) {
					if(tabid==3){ %>
					<td align="center" class="sub_tab_active" width="15%">
						<b>Other Asset</b>
					</td>
					<%}else { %>
					<td align="center" class="sub_tab_inactive" width="15%">
						<a href="JavaScript:gotoTab(appURL,'perpropertydetails','getOtherAssetData','otherassets.jsp')"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='Other Asset';return true;">
							<b>Other Asset</b>
						</a>
					</td>
					
					<%}}
					
					if(tabid==4){ %>
					<td align="center" class="sub_tab_active" width="15%">
						<b>Verification Details</b>
					</td>
					<%}else { %>
					<td align="center" nowrap="nowrap" class="sub_tab_inactive" width="15%">
						<a href="JavaScript:gotoTab(appURL,'percollateral','getVerification','perverificationdetails.jsp')"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='Legal Opinion';return true;">
							<b>Verification Details</b>
						</a>
					</td>
					<%}%>
					<!-- if(prd_type.equalsIgnoreCase("pH") || prd_type.equalsIgnoreCase("pM") || prd_type.equalsIgnoreCase("pT")) {
					if(tabid==5){ %>
					<td align="center" class="sub_tab_active" width="15%">
						<b>Legal Opinion</b>
					</td>
					<%//}else { %>
					<td align="center" nowrap="nowrap" class="sub_tab_inactive" width="15%">
						<a href="JavaScript:gotoTab(appURL,'securitymaster','getLegalOpinion','sec_property_legalopinion.jsp')"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='Legal Opinion';return true;">
							<b>Legal Opinion</b>
						</a>
					</td>
					//}} -->
					<%if(prd_type.equalsIgnoreCase("pH") || prd_type.equalsIgnoreCase("pA") || prd_type.equalsIgnoreCase("pM") || prd_type.equalsIgnoreCase("pT") || prd_type.equalsIgnoreCase("pU")) {
					if(tabid==6){ %>
					<td align="center" class="sub_tab_active" width="15%">
						<b>Valuation Entry</b>
					</td>
					<%}else { %>
					<td align="center" nowrap="nowrap" class="sub_tab_inactive" width="15%">
						<a href="JavaScript:gotoTab(appURL,'perpropertydetails','getValuerEntryData','valuation_entry.jsp')"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='Valuation Entry';return true;">
							<b>Valuation Entry</b>
						</a>
					</td>
				<%}} %>				
				</tr>
			 </table>
		</td>
	</tr>
</table>
			