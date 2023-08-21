<%@include file="../share/directives.jsp"%>

<%String strValuesIn="";

String strValIn =Helper.correctNull((String)hshValues.get("strValuesIn"));
strValuesIn	= "(Rs. in  "+strValIn+")";
java.text.NumberFormat nf = java.text.NumberFormat
.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String agrigoldproduct=Helper.correctNull((String)hshValues.get("agrigoldproduct")).trim();
 %>

<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_agri">
<tr>
	<td class="dataheader">&nbsp;<b>Agri</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="30%">Total Land Holding (in Acres)<b><span class="mantatory" id="id_Land">&nbsp;*</span></b></td>
			<td width="20%">
				<input type="text" name="txt_TotLandHold" maxlength="15" tabindex="23" value="<%=Helper.correctNull((String)hshValues.get("land_acreage"))%>"
					onBlur="setLandValues();changeIrrigationCultivationMode();calculateNonIrrigate();calculateNonCultivate();setFarmerCategory();" /></td>
			<td id="id_Temp" width="30%">&nbsp;</td>
			<td id="id_Temp2" width="20%">&nbsp;</td>
		</tr>
		<tr id="id_Irrigation">
			<td>Irrigated</td>
			<td><lapschoice:CurrencyTag name="txt_Irrigated" onBlur="calculateNonIrrigate();" maxlength="15" tabindex="24" value='<%=Helper.correctDouble((String)hshValues.get("app_totirrigatedland"))%>' /></td>
			<td width="30%">Non Irrigated</td>
			<td width="20%"><lapschoice:CurrencyTag name="txt_NonIrrigated" value='<%=Helper.correctDouble((String)hshValues.get("app_totnonirrigatedland"))%>' /></td>
		</tr>
		<tr id="id_Cultivation">
			<td>Cultivated</td>
			<td><lapschoice:CurrencyTag name="txt_Cultivated" onBlur="calculateNonCultivate();" maxlength="15" tabindex="25" value='<%=Helper.correctDouble((String)hshValues.get("app_totcultivatedland"))%>' /></td>
			<td>Non Cultivated</td>
			<td><lapschoice:CurrencyTag name="txt_NonCultivated" value='<%=Helper.correctDouble((String)hshValues.get("app_totnoncultivatedland"))%>' /></td>
		</tr>
		<tr>
			<td>Farmer's Category<b><span class="mantatory" id="id_Farm">&nbsp;*</span></b></td>
			<td colspan="3">
				<select name="sel_FarmerCategory" style="width: 80%">
					<option value="" selected="selected">--Select--</option>
					<lapschoice:BanksSchemeStaticDataNewTag apptype="13" />
				</select>
			</td>
		</tr>
		
		</table>
	</td>
</tr>
</table>
<%if(strSessionModuleType.equalsIgnoreCase("AGR")||strSessionModuleType.equalsIgnoreCase("CORP")||(strSessionModuleType.equalsIgnoreCase("LAD")&&agrigoldproduct.equalsIgnoreCase("Y")))  {%>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="txt_allied_code">
<tr>
	<td class="dataheader">&nbsp;<b>Agri Allied Code </b></td>
</tr>
<tr>
<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
							<td width="30%">Allied Activity Code<b>
								<%if(strSessionModuleType.equalsIgnoreCase("AGR"))  {%><span class="mantatory">&nbsp;*</span><%} %>
							</b></td>
							<td width="70%">
								<input type="text" name="txt_allied_ActivityCode" readOnly="readonly" onKeyPress="notAllowSplChar();" value="<%=Helper.correctNull((String)hshValues.get("alliedactivitycode"))%>">
								<a href="#" onClick="alliedcallMISActvityHelp()" style="cursor: hand">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="22">
								</a>
							</td>
						</tr>
						<tr>
							<td>Main Activity</td>
							<td>
							<input style="width: 50%" type="text" name="allied_sel_MainActivity" disabled="disabled" readOnly="readonly" value="<%=Helper.correctNull((String)hshValues.get("alliedmaincode"))%>">
			
							</td>
						</tr>
						<tr>
							<td>Sub Activity</td>
							<td>
							<input style="width: 50%" type="text" name="allied_sel_SubActivity" disabled="disabled" readOnly="readonly" value="<%=Helper.correctNull((String)hshValues.get("alliedstrSubActivityCode"))%>">
							</td>
						</tr>
						<tr>
							<td>Purpose</td>
							<td>
							<input style="width: 50%" type="text" name="allied_sel_Purpose" disabled="disabled" readOnly="readonly" value="<%=Helper.correctNull((String)hshValues.get("alliedpurpose"))%>">
							</td>
						</tr>
		</table>
		</td>
		</tr>
</table>
<%} %>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_agricropinsukrishimain">
<tr>
	<td class="dataheader">&nbsp;<b>Agri Cropinsu Krishimain</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td>Whether covered under Crop Insurance</td>
			<td colspan="4">
				<select name="sel_CropInsu" tabindex="23">
					<option value="Y">Yes</option>
					<option value="N" selected="selected">No</option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="30%">Whether covered under Krishi Card Scheme</td>
			<td width="20%">
				<select name="sel_KrishiCard" onChange="callKrishiScheme();" tabindex="24">
					<option value="Y">Yes</option>
					<option value="N" selected="selected">No</option>
				</select>
			</td>
			<td width="30%" id="id_KrishiCardlbl" colspan="2">Krishi Card No</td>
			<td width="20%" id="id_KrishiCardtxt"><input type="text" name="txt_KrishiCard" maxlength="30" tabindex="25" value="<%=Helper.correctNull((String)hshValues.get("app_krishicardno"))%>"></td>
		</tr>
		<tr>
			<td id="id_KrishiCardlbl1">Whether Card converted under PAIS</td>
			<td id="id_KrishiCardtxt1">
				<select name="sel_PAIS" onChange="callPAIS();" tabindex="26">
					<option value="Y">Yes</option>
					<option value="N" selected="selected">No</option>
				</select>
			</td>
			<td id="id_Premiumlbl">Premium Paid Amount in Rs.</td>
			<td id="id_PremiumlblRs" width="5%">&nbsp;</td>
			<td id="id_Premiumtxt"><lapschoice:CurrencyTag name="txt_Premium" maxlength="15" tabindex="27" value='<%=Helper.correctDouble((String)hshValues.get("app_premiumamt"))%>' /></td>
		</tr>
		<tr id="id_NomineeNameAge">
			<td>Nominee Name</td>
			<td><input type="text" name="txt_NomineeName" maxlength="50" tabindex="28" value="<%=Helper.correctNull((String)hshValues.get("app_nomineename"))%>"></td>
			<td colspan="2">Nominee Age</td>
			<td><input type="text" name="txt_NomineeAge" maxlength="3" onKeyPress="allowInteger()" tabindex="29" value="<%=Helper.correctInt((String)hshValues.get("app_nomineeage"))%>"></td>
		</tr>
		<tr id="id_NomineeRelationClaimDet">
			<td>Nominee Relationship</td>
			<td><input type="text" name="txt_NomineeRel" maxlength="50" tabindex="30" value="<%=Helper.correctNull((String)hshValues.get("app_nomineerelation"))%>"></td>
			<td>Claim Details under PAIS</td>
			<td width="5%">&nbsp;</td>
			<td><lapschoice:CurrencyTag name="txt_PAISClaim" maxlength="15" tabindex="31" value='<%=Helper.correctDouble((String)hshValues.get("app_claimdet"))%>' /></td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_agritenure">
<tr>
	<td class="dataheader">&nbsp;<b>Agri Tenure</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="30%">Loan Tenure (in months)</td>
			<td width="70%">
				<input type="text" name="txt_Tenure" value="<%=Helper.correctInt((String)hshValues.get("strReqTerms"))%>">
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_agriAgribus">
<tr>
	<td class="dataheader">&nbsp;<b>Agri Agribus</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="25%">Total financial outlays</td>
			<td width="5%">&nbsp;</td>
			<td width="20%"><lapschoice:CurrencyTag name="txt_FinOutlays" maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("app_totfinancialoutlays"))%>' /></td>
			<td width="30%">Individual Groups</td>
			<td width="20%"><input type="text" name="txt_IndGroups" maxlength="30" tabindex="24" value="<%=Helper.correctNull((String)hshValues.get("app_individualgrp"))%>"></td>
		</tr>
		<tr>
			<td>Margin Money assistance amount</td>
			<td>&nbsp;</td>
			<td colspan="3"><lapschoice:CurrencyTag name="txt_MarginMoney" maxlength="15" tabindex="25" value='<%=Helper.correctDouble((String)hshValues.get("app_margin"))%>' /></td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_industry">
<tr>
	<td class="dataheader">&nbsp;<b>Industry</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="20%"> Investment in Plant & Machineries/Equipments</td>
			<td width="20%"><input type="text" name="txt_OrigInvest" maxlength="15" tabindex="23" value='<%=Helper.correctNull((String)hshValues.get("app_plantval"))%>' onblur="checkplvalue();">&nbsp;<span align="left"><%=strValuesIn%></span></td>
			<td width="10%">&nbsp;</td>
			<td width="20%">Industry Name</td>
			<td width="15%"><input type="text" name="txt_IndName" maxlength="30" tabindex="24" value="<%=Helper.correctNull((String)hshValues.get("app_indname"))%>"></td>
			
		</tr>
		</table>
	</td>
</tr>
</table>

<!-- Added by Guhan for CRE-->
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_cre">
<tr>
	<td class="dataheader">&nbsp;<b>Commercial Real Estate</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="2" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="30%">Percentage of commercial real estate on residential housing</td>
			<td width="70%"><input type="text" name="txt_cre_percnt" onblur="checkPercentage(this);" maxlength="3" value="<%=Helper.correctNull((String)hshValues.get("APP_CRE_PERCNT"))%>" onkeypress="allowNumber(this)" /></td>
		</tr>
		</table>
	</td>
</tr>
</table>

<!-- End -->


<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_nbfc">
<tr>
	<td class="dataheader">&nbsp;<b>NBFC</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="30%">Whether Accepts Deposits From Public<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="70%">
				<select name="sel_PublicDeposit" tabindex="23">
					<option value="" selected="selected">--Select--</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_housunit">
<tr>
	<td class="dataheader">&nbsp;<b>Housing Unit</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="30%">Number of housing units in building<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="70%">
				<input type="text" name="txt_NoOfHousing" onKeyPress="allowInteger()" maxlength="10" tabindex="23" value="<%=Helper.correctInt((String)hshValues.get("app_noofunits"))%>">
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_fixedinvestment">
<tr>
	<td class="dataheader">&nbsp;<b>Fixed Investment</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="55%"> Investment in Equipments / Cost of Vehicles Used in Business<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="5%" >&nbsp;</td>
			<td width="40%">
				<input type="text" name="txt_OriginalInvest" maxlength="15" tabindex="23" value='<%=Helper.correctNull((String)hshValues.get("app_equipval"))%>'>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_education">
<tr>
	<td class="dataheader">&nbsp;<b>Education</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="30%">Is the student meritorious?</td>
			<td width="70%">
				<select name="sel_Meritorious" tabindex="23">
					<option value="Y">Yes</option>
					<option value="N" selected="selected">No</option>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_agrikrishimain">
</table>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_borrowerlending">
<tr>
	<td class="dataheader">&nbsp;<b>Onward Lending</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="55%">Onward Lending per borrower per Housing unit<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="5%">&nbsp;</td>
			<td width="40%">
				<lapschoice:CurrencyTag name="txt_onwardlending" maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("app_borrowerlending"))%>' />
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<!-- Added by Guhan for new priority sector parameters -->

<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_socialinfra">
<tr>
	<td class="dataheader">&nbsp;<b>Social Infrastructure</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="55%">Total value of the advances under Social Infrastructure<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="5%">&nbsp;</td>
			<td width="40%">
				<lapschoice:CurrencyTag name="txt_social_infra" maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("app_socialinfra"))%>' />
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_agri_anci">
<tr>
	<td class="dataheader">&nbsp;<b>Agriculture & Ancillary activities</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="55%">Loan/s value for Food and Agro-processing<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="5%">&nbsp;</td>
			<td width="40%">
				<lapschoice:CurrencyTag name="txt_agri_anci" maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("app_agri_anci"))%>' />
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_agri_infra">
<tr>
	<td class="dataheader">&nbsp;<b>Agriculture Infrastructure</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="55%">Loan/s value for Agriculture Infrastructure<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="5%">&nbsp;</td>
			<td width="40%">
				<lapschoice:CurrencyTag name="txt_agri_infra" maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("app_agri_infra"))%>' />
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_renew_energy">
<tr>
	<td class="dataheader">&nbsp;<b>Renewable Energy</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="55%">Total value of the advances under Renewable Energy<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="5%">&nbsp;</td>
			<td width="40%">
				<lapschoice:CurrencyTag name="txt_renew_energy" maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("app_renewenergy"))%>' />
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_renew_energy_indv">
<tr>
	<td class="dataheader">&nbsp;<b>Renewable Energy for Individual</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="55%">Total value of the advances under Renewable Energy for Individual<b><span class="mantatory">&nbsp;*</span></b></td>
			<td width="5%">&nbsp;</td>
			<td width="40%">
				<lapschoice:CurrencyTag name="txt_renew_energy_indv" maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("app_renewenergy_indv"))%>' />
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_sales">
<tr>
	<td class="dataheader">&nbsp;<b>Sales TurnOver Details</b></td>
</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
		<tr>
			<td width="25%"  id="id_sales1">Sales Turnover of the Applicant</td>
			<td width="20%" id="id_sales2"><lapschoice:CurrencyTag name="txt_sales_turnover" style="background: #FFFFCC; font-weight: bold;text-align: right;" maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("PERAPP_SALES_TURNOVER"))%>' /></td>
			<td width="30%" id="id_sales3">Sales Turnover as on date</td>
			<td width="20%" id="id_sales4"><input type="text" name="txt_turnover_asondate" style="background: #FFFFCC; font-weight: bold;text-align: right;"maxlength="30" tabindex="24" value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER_DATE"))%>"></td>
		</tr>
		<tr>
			<td id="id_sales5">Criteria for Sales Turnover</td>
			<td id="id_sales6"><select name="sel_sales_turnover" style="background: #FFFFCC; font-weight: bold;text-align: right;">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%String apptype = "243";%>
                          <lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
                        </select></td>
                      	</tr>
                      	</table>
	</td>
</tr>
<table align="center" border="0" cellpadding="1" cellspacing="0" class="outertable" width="100%" id="id_sales11">
<tr>
	<td class="dataheader">&nbsp;<b>Investment Details</b></td>
</tr>
                      	<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
                      	<tr>
                      	<td id="id_sales7">Investment value as on Date <b><span class="mantatory">&nbsp;*</span></b></td>
							<td id="id_sales8">
								<input type="text" name="txt_investDate" onblur="checkDate(this);checkmaxdate(this,currentDate)" size="15%" value="<%=Helper.correctNull((String)hshValues.get("APP_INVESTMENT_DATE"))%>">
								<a alt="Select date from calender" href="javascript:callCalender('txt_investDate')" tabindex="10">
									<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0">
								</a>
							</td>
			<td id="id_sales9">Criteria for Investment value</td>
			<td id="id_sales10"><select name="sel_criteria_invest" style="width:200px">
                          <option value="0">&lt;--Select--&gt;</option>
                          <%String strapptype = "248";%>
                          <lapschoice:StaticDataNewTag apptype='<%=strapptype%>' />
                        </select></td>
                      	</tr>
		</table>
	</td>
</tr>
</table>
	
		<table align="center" border="0" cellpadding="1" cellspacing="0"
			class="outertable" width="100%" id="id_newmis">
			<tr>
				<td class="dataheader">&nbsp;<b>Priority Sector Guidelines</b></td>
			</tr>
<tr>
	<td>
		<table align="center" border="0" cellpadding="5" cellspacing="5" class="outertable" width="100%">
			<tr>
				
				<td nowrap="nowrap" id="id_minority">Whether Start up as per definition
				of Ministry of Commerce and Industry<span class="mantatory">*</span></td>
				<td id="id_minority1"><select name="sel_min_industry">
					<option value="s">--Select--</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
				<td id="id_carpet">Carpet Area (in Sq mt)<b><span
					class="mantatory">&nbsp;*</span></b></td>
				<td id="id_carpet1"><input type="text" name="txt_carpetarea" style="background: #FFFFCC; font-weight: bold;text-align: right;"
					onKeyPress="allowInteger()" maxlength="10" tabindex="23" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbltotalextbuild"))))%>">
				</td>
			</tr>
			
			<tr>
				<td id="id_floorarea">Floor Area Ratio/Floor Space Index (in %)<b><span
					class="mantatory">&nbsp;*</span></b></td>
				<td id="id_floorarea1"><input type="text" name="txt_floorarea"
					size="15"  maxlength="3"  onBlur="roundtxt(this);checkPercentage(this);" onkeypress="allowNumber(this)" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("APP_FLOOR_AREA"))%>">
				</td>
				<td nowrap="nowrap" id="id_indhouse">Maximum Area of Individual House<span class="mantatory">*</span></td>
				<td id="id_indhouse1"><select name="sel_maxind_house">
					<option value="0">&lt;--Select--&gt;</option>
                          <%String strapptype1 = "253";%>
                          <lapschoice:StaticDataNewTag apptype='<%=strapptype1%>' />
                        </select></td>
			</tr>
	        <tr>
				<td id="id_shgnumber">Maximum Share in the proposed loan by each SHG member<b><span
					class="mantatory">&nbsp;*</span></b></td>
				<td id="id_shgnumber1"><input type="text" name="txt_shgnumber" style="background: #FFFFCC; font-weight: bold;text-align: right;"
					onKeyPress="allowInteger()" maxlength="10" tabindex="23" value="<%=Helper.correctNull((String)hshValues.get("purposeofloan"))%>">
				</td>
			</tr>
			<tr id="id_dwelling">
			<td width="25%" >overall cost of the dwelling unit</td>
			<td width="20%"><lapschoice:CurrencyTag name="txt_dwellingunit"  maxlength="15" tabindex="23" value='<%=Helper.correctDouble((String)hshValues.get("APP_DWELLING_UNIT"))%>' /></td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
	</table>
	<!-- End -->