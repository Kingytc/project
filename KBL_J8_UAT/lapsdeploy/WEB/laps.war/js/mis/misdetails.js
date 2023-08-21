
function callMISClassification() {

	document.forms[0].sel_CategoryType.value = varAgriIndustryType;

	document.forms[0].sel_Sector.value = varSectorType;
	document.forms[0].sel_SubSector.value = varSubSectorType;

	document.forms[0].sel_SensitiveSector.value = varSensitiveSectorType;

	document.forms[0].sel_WeakerSection.value = varSubSectorWeakerType;

	document.forms[0].sel_TwentyPointPgm.value = varTwentyPointPgmType;

	document.forms[0].sel_InfraCreditType.value=varInfraStructureCreditType;

	document.forms[0].sel_GovtAnnounceScheme.value=varGovtAnnounceScheme;
	
	document.forms[0].sel_StandupIndia.value=varStandUpIndia;

}

function callCBSDetails()

{

	if(varLoanType=="C" || varLoanType=="A" )

	{

		document.forms[0].sel_facilitysno.value="";

	}

	else

	{

		document.forms[0].sel_facilitysno.value="1";

	}
	document.forms[0].hidBeanId.value="FinacleBean";

	document.forms[0].hidBeanGetMethod.value="getCBSDetails";

	document.forms[0].action=appURL+"action/CBSData.jsp";

	document.forms[0].submit();

}

function doEdit() 
{
	if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
	{
		document.forms[0].sel_GuarCovered.value=="16";
		document.forms[0].sel_GuarCovered.disabled=true;
		document.forms[0].txt_GuarAmount.readOnly=true;
		callGuarCovered('N');
	}
	if(varDataFlag!="Y")
	{
		varTotalServiceLimit=parseFloat(varTotalServiceLimit);

		varTotalAgriLimit=parseFloat(varTotalAgriLimit);

		varSocialInfra=parseFloat(varSocialInfra)+parseFloat(varLoanAmount);

		varAgriAnci=parseFloat(varAgriAnci)+parseFloat(varLoanAmount);

		varAgriInfra=parseFloat(varAgriInfra)+parseFloat(varLoanAmount);

		varRenewEner=parseFloat(varRenewEner)+parseFloat(varLoanAmount);

		varRenewEnerIndv=parseFloat(varRenewEnerIndv)+parseFloat(varLoanAmount);

	}
	document.forms[0].txt_TotLimitService.value=roundVal(varTotalServiceLimit);
	document.forms[0].txt_TotLimitAgri.value=roundVal(varTotalAgriLimit);
	document.forms[0].txt_social_infra.value=roundVal(varSocialInfra);
	document.forms[0].txt_agri_anci.value=roundVal(varAgriAnci);
	document.forms[0].txt_agri_infra.value=roundVal(varAgriInfra);
	document.forms[0].txt_renew_energy.value=roundVal(varRenewEner);
	document.forms[0].txt_renew_energy_indv.value=roundVal(varRenewEnerIndv);
	if(varMISFlag=="N" && varstrSessionModuleType =="RET")
	{
		alert("Please Complete Appraisal Loan Details");
		return;
	}
	if(varstrSessionModuleType!="LAD")
	{
		if(varFreezeflag=="N")
		{
			alert("Please Freeze Securities in Security Master -> Attached Securities tab");
			return;	
		}
	}
	if(varconstitut!="01")
	{
		if(varstake_held=="")
		{
			alert("Please Select the majority of shareholding & controlling stake held by women - Customer Demographics Tab");
			return;
		}
		
		if(varmaj_member=="")
		{
			alert("Please Select the majority of members belongs to SC/ST - Customer Demographics Tab");
			return;
		}
		if(varcommunityminority==""||varcommunityminority=="0"){
			alert("Please fill Whether majority of members/owners belong to minority community in Customer Profile -> Demographics tab");
			return;
		}
	}
	if(varconstitut=="01")
	{
		if(varMinorty==""||varMinorty=="0")
		{
			alert("Please fill Minority Details in Customer Profile -> Demographics tab");
			return;
		}
	}	
	if(varconstitut=="01" ){
		if(varindreligion!="1" && varindreligion!="4")
		{	
			if(varminority=="N"){
				alert("if Religion is other than Hindu then Minority flag should be Yes,Kindly update the Minority Details in Customer Profile -> Demographics tab");
				return;
			}
		}
	}
	if(varconstitut=="01" && varindreligion=="1")
	{	
		if(varminority=="Y"){
			alert("If Religion Selected is Hindu then Whether majority of members/owners belong to minority community flag cannot be Yes ,Kindly update the Minority Details in Customer Profile -> Demographics tab");
			return;
		}
	}
	if(varconstitut=="01" && varindreligion=="4" && varindstate=="PB")
	{	
		if(varminority=="Y"){
			alert("If religion selected is Sikh and state of Applicant is punjab(Permanent Address State for NRI and Communication Address state for others) then Minority flag cannot be Yes, Kindly update the Minority Details in Customer Profile -> Demographics tab");
			return;
		}
	}
	if(varconstitut!="01" && nonindreligion=="1")
	{	
		if(varcommunityminority=="Y"){
			alert("if Religion is other than Hindu then Minority flag should be Yes,Kindly update the Minority Details in Customer Profile -> Demographics tab");
			return;
		}
	}
	if(varLoanType=="C" || varLoanType=="A")
	{
		if(document.forms[0].sel_facilitysno.value=="")
		{
			ShowAlert(111,"Facility");

			document.forms[0].sel_facilitysno.focus();

			return;
		}
	}
	if(varBankScheme=="061")
	{
		//if(varconstitut!="01")
		{
			if(eval(vartotalemp)>0 && varempasondate!="")
			{
				//Do Nothing
			}
			else
			{
				alert("Please fill Total No of Employee and as on Date in Customer Profile -> Demographics tab");
				return;
			}
		}
		
		if(!(varGSTReg=="Y" ||(varGSTReg=="N" && varGSTExempted=="Y")))
		{
			alert("Please Update GST Registration No/Exempted Details in Customer Profile -> Demographics tab");
			return;
		}
		document.forms[0].sel_GuarCovered.value="16";
		disableFields(false);
		document.forms[0].sel_GuarCovered.disabled=true;
		callGuarCovered('N');
	}
	else if(varBankScheme=="064")
	{
		if(varMinorty=="")
		{
			alert("Please fill Minority Details in Customer Profile -> Demographics tab");
			return;
		}
		document.forms[0].sel_GuarCovered.value="11";
		disableFields(false);
		document.forms[0].sel_GuarCovered.disabled=true;
		callGuarCovered('N');
	}
	else if(varBankScheme=="063"||varBankScheme=="065")
	{
		document.forms[0].sel_GuarCovered.value="11";
		disableFields(false);
		document.forms[0].sel_GuarCovered.disabled=true;
		callGuarCovered('N');
	}
	else
	{
		document.forms[0].sel_GuarCovered.disabled=false;
		disableFields(false);
		callGuarCovered('N');
	}
	disableCommandButtons(true, false, false, false, true);
	setFarmerCategory();
	disableFarmCat();

	if(varLoanType=="C" || varLoanType=="A" )
	{
		document.forms[0].sel_facilitysno.disabled=true;
	}
	if(PRD_CGTMSE=="Y")
	{
		document.forms[0].sel_GuarCovered.value="11";
		document.forms[0].sel_GuarCovered.disabled=true;
		callGuarCovered('N');
	}	
	if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
	{
		document.forms[0].txt_GuarAmount.readOnly=true;
	}
	if(	varBankScheme=="065"||	varBankScheme=="061"){	
		document.forms[0].txt_GuarAmount.readOnly=true;
	}
	document.forms[0].sel_majoritymem.disabled=true;
	document.forms[0].sel_heldwomen.disabled=true;
	document.forms[0].sel_applt_sex.disabled=true;
	document.forms[0].sel_caste.disabled=true;
	document.forms[0].sel_religion.disabled=true;
	document.forms[0].sel_minority.disabled=true;
	document.forms[0].sel_firm_minority.disabled=true;
	document.forms[0].sel_corp_religion.disabled=true;
	if(varstrSessionModuleType=="AGR"||varstrSessionModuleType=="CORP")
	{
	document.forms[0].txt_allied_ActivityCode.readOnly=true;
	}
}

function doSave() 
{   
	
	if(varBankScheme=="065")
    {
	    checkLoanAmt();
    }
	document.forms[0].sel_facilitysno.disabled=false;
	document.forms[0].sel_GuarCovered.disabled=false;
	if (document.forms[0].sel_BankScheme.value == "") {
		ShowAlert('111', "Bank's Scheme");
		document.forms[0].sel_BankScheme.focus();
		return;
	}
	if (document.forms[0].txt_LoanAmt.value == ""

			|| document.forms[0].txt_LoanAmt.value == "0"

			|| document.forms[0].txt_LoanAmt.value == "0.00") {

		ShowAlert('121', "Loan Amount in Loan Product page");

		return;
	}

	/*if(PRD_CGTMSE=='Y')
	{
		if(activitycgtmsecode=='N'){
		alert("Activity Code selected is not eligible to be covered under CGTMSE");
	     }
	}
	/*if (document.forms[0].sel_RestructFac.value == "") {

		ShowAlert('111',

				"Whether this facility is by restructuring of any existing accounts");

		document.forms[0].sel_RestructFac.focus();

		return;

	}

	if (document.forms[0].sel_RestructFac.value == "Y") {

		if (document.forms[0].sel_RestructUnder.value == "") {

			ShowAlert('111', "Restructured Under");

			document.forms[0].sel_RestructUnder.focus();

			return;

		}

		if (document.forms[0].txt_SettlementRefNo.value == "") {

			ShowAlert('121', "Settlement Ref. No");

			document.forms[0].txt_SettlementRefNo.focus();

			return;

		}

		if (document.forms[0].txt_SettlementDate.value == "") {

			ShowAlert('121', "Settlement Date");

			document.forms[0].txt_SettlementDate.focus();

			return;

		}

		if (document.forms[0].txt_OldFacID.value == "") {

			ShowAlert('121',

					"Old Facility ID/Account Number of account to be restructured");

			document.forms[0].txt_OldFacID.focus();

			return;

		}

		if (document.forms[0].txtarea_Reason.value == "") {

			ShowAlert('121', "Reason for entering into reschedule/rephase");

			document.forms[0].txtarea_Reason.focus();

			return;

		}

	}*/

	if (document.forms[0].txt_City.value == "") {

		ShowAlert('111', "City");

		document.forms[0].txt_City.focus();

		return;

	}

	if (document.forms[0].txt_State.value == "") {

		ShowAlert('111', "State");

		document.forms[0].txt_State.focus();

		return;

	}

	if (document.forms[0].txt_District.value == "") {

		ShowAlert('111', "District");

		document.forms[0].txt_District.focus();

		return;

	}

	if (document.forms[0].sel_Place.value == "") {

		ShowAlert('111', "Place");

		document.forms[0].sel_Place.focus();

		return;

	}

	if (document.forms[0].sel_AssetFinanced.value == "") {

		ShowAlert('111', "Does repayment depend purely on the asset financed");

		document.forms[0].sel_AssetFinanced.focus();

		return;

	}

	if (document.forms[0].sel_AssetFinanced.value == "Y") {

		if (document.forms[0].sel_RepaySource.value == "") {

			ShowAlert('111', "Source of repayment");

			document.forms[0].sel_RepaySource.focus();

			return;

		}

	}

	if (document.forms[0].sel_GuarCovered.value == "") {

		ShowAlert('111', "Guarantee Covered by");

		document.forms[0].sel_GuarCovered.focus();

		return;

	}

	if (varLoanType == "TL" || varLoanType == "DL") {

		if (document.forms[0].sel_NewProjectFac.value == "") {

			ShowAlert('111', "Whether the proposed facility is for New Project");

			document.forms[0].sel_NewProjectFac.focus();

			return;

		}

	}

	if (varFacilityType == "NF") {

		if (document.forms[0].sel_sharebroker.value == "" || document.forms[0].sel_sharebroker.value == "0" ) {

			ShowAlert('111', "Whether Guarantee is issued on behalf of share broker");

			document.forms[0].sel_sharebroker.focus();

			return;

		}

	}

	if (document.forms[0].sel_NewProjectFac.value == "Y") {

		if (document.forms[0].txt_DCCO.value == "") {

			ShowAlert('121',

					"Proposed date of Commencement of Commercial Operation (DCCO)");

			document.forms[0].txt_DCCO.focus();

			return;

		}

	}

	if (document.forms[0].hidmisdataflag.value == "N") {

		alert("Please Reselect the Activity Code");

		document.forms[0].txt_ActivityCode.focus();

		return;

	}
	if (document.forms[0].txt_ActivityCode.value == "") {
		
		ShowAlert('111', "Activity Code");
		
		document.forms[0].txt_ActivityCode.focus();
		
		return;
		
	}

	

	var varagri = "Y",varindustry="Y",varnbfc="Y",varhousunit="Y",varfixedinvestment="Y",varborrowerlending="Y",varCRE="Y",varsalesturnover="Y",varsalesturnoverdate="Y",varCriteriaSales="Y",varinvestdate="Y",varCriteriainvest="Y",varministry="Y",varcarpet="Y",varfloorarea="Y",varindhouse="Y",varproploanshg="Y",vardwellingunit="Y",varagrialliedcode="Y";

	var varDispScreenVal = document.forms[0].sel_DisplayScreen.value.split("@");


	for(var j=0;j<varDispScreenVal.length;j++)

	{

		if (varDispScreenVal[j].substring(0, 4) == "agri") varagri="N";

		if (varDispScreenVal[j] == "industry") varindustry="N";

		if (varDispScreenVal[j] == "nbfc") varnbfc="N";

		if (varDispScreenVal[j] == "housunit") varhousunit="N";

		if (varDispScreenVal[j] == "fixedinvestment") varfixedinvestment="N";

		if (varDispScreenVal[j] == "borrowerlending") varborrowerlending="N";

		if (varDispScreenVal[j] == "cre") varCRE="N";
		if (varDispScreenVal[j] == "salesvalue") varsalesturnover="N";
		if (varDispScreenVal[j] == "salesDate") varsalesturnoverdate="N";
		if (varDispScreenVal[j] == "criteria") varCriteriaSales="N";
		if (varDispScreenVal[j] == "investDate") varinvestdate="N";
		if (varDispScreenVal[j] == "criteriainvest") varCriteriainvest="N";
		if (varDispScreenVal[j] == "ministry") varministry="N";
		if (varDispScreenVal[j] == "Carpet") varcarpet="N";
		if (varDispScreenVal[j] == "floorarea") varfloorarea="N";
		if (varDispScreenVal[j] == "individualhouse") varindhouse="N";
		if (varDispScreenVal[j] == "proposedloanSHG") varproploanshg="N";
		if (varDispScreenVal[j] == "dwellingunit") vardwellingunit="N";
		if (varDispScreenVal[j] == "agriallied") varagrialliedcode="N";
	}
	if(varstrSessionModuleType=="AGR"||(varstrSessionModuleType=="LAD"&&varagrigoldproduct=="Y"))
	{
		if(varagrialliedcode=="N")
		{
			if(document.forms[0].txt_allied_ActivityCode.value=="")
			{
				ShowAlert('111', "Allied Activity Code");

				document.forms[0].txt_allied_ActivityCode.focus();

				return;
			}
		}
	}

	if (varagri == "N") {

		if (document.forms[0].txt_TotLandHold.value == "") {

			ShowAlert('121', "Total Land Holding (in Acres) in Customer Profile LandHolding ->Tab");

			document.forms[0].txt_TotLandHold.focus();

			return;

		} else if ((document.forms[0].txt_TotLandHold.value == "0"

				|| document.forms[0].txt_TotLandHold.value == "0.00")

				&& document.forms[0].sel_FarmerCategory.value=="") {

			ShowAlert('111', "Farmer's Category");

			document.forms[0].sel_FarmerCategory.focus();

			return;

		}

	}

	if (varindustry == "N") 

	{
		if (eval(document.forms[0].txt_OrigInvest.value)<1){
            alert("Investment in Plant & Machineries/Equipments value should not be less than 1");
			document.forms[0].txt_OrigInvest.focus();
			return;

		}
		if (document.forms[0].txt_OrigInvest.value == "") {

			ShowAlert('121', "Investment in Plant & Machineries/Equipments ");

			document.forms[0].txt_OrigInvest.focus();

			return;

		}
	}

	if (varfixedinvestment == "N") {

		if (eval(document.forms[0].txt_OriginalInvest.value)<1) {
			alert("Investment in Equipments / Cost of Vehicles Used in Business value should not be less than 1");
			document.forms[0].txt_OriginalInvest.focus();
			return;

		}
		if (document.forms[0].txt_OriginalInvest.value == "") {

			ShowAlert('121', "Investment in Equipments / Cost of Vehicles ");

			document.forms[0].txt_OriginalInvest.focus();

			return;

		}
	} 

	if (varhousunit=="N") {

		if (document.forms[0].txt_NoOfHousing.value == "") {

			ShowAlert('121', "Number of housing units in building");

			document.forms[0].txt_NoOfHousing.focus();

			return;

		}

	} 

	if (varnbfc=="N") {

		if (document.forms[0].sel_PublicDeposit.value == "") {

			ShowAlert('111', "Whether Accepts Deposits From Public");

			document.forms[0].sel_PublicDeposit.focus();

			return;

		}

	}

	if (varborrowerlending=="N") {

		if (document.forms[0].txt_onwardlending.value == "") {

			ShowAlert("Enter Onward Lending per Borrower per Hosuing unit");

			document.forms[0].txt_onwardlending.focus();

			return;

		}

	}

	if (varCRE=="N") {

		if (document.forms[0].txt_cre_percnt.value == "") {

			ShowAlert("Enter Percentage of commercial real estate on residential housing");

			document.forms[0].txt_cre_percnt.focus();

			return;

		}

	}

	if (varministry == "N" && varstartupconstitution=="Y") {

		if (document.forms[0].sel_min_industry.value == "s") {

			ShowAlert('111', "Whether Start up as per definition of Ministry of Commerce and Industry");
			document.forms[0].sel_min_industry.focus();

			return;

		}

	}
	if (varcarpet=="N") {

		if (document.forms[0].txt_carpetarea.value == ""||document.forms[0].txt_carpetarea.value == "0"||document.forms[0].txt_carpetarea.value == "0.00") {

			ShowAlert('121', "Carpet Area (in Sq mt)");
			document.forms[0].txt_carpetarea.focus();

			return;

		}

	}
	if (varfloorarea=="N") {

		if (document.forms[0].txt_floorarea.value == "") {

			ShowAlert('121', "Floor Area Ratio/Floor Space Index (in %)");
			document.forms[0].txt_floorarea.focus();

			return;

		}

	}
	if (varindhouse=="N") {

		if (document.forms[0].sel_maxind_house.value == "0"||document.forms[0].sel_maxind_house.value == "") {

			ShowAlert('121', "Maximum Area of Individual House");
			document.forms[0].sel_maxind_house.focus();

			return;

		}

	}
	if (varproploanshg=="N") {


		if (document.forms[0].txt_shgnumber.value == ""||document.forms[0].txt_shgnumber.value == "0"||document.forms[0].txt_shgnumber.value == "0.00") {

			ShowAlert('121', "maximum share in the proposed loan by each SHG member in facilities SHG member wise loan share tab.");
			document.forms[0].txt_shgnumber.focus();

			return;

		}

	}
	if(varBankScheme=="064")
	{
		if (document.forms[0].txt_GuarAmount.value == "" || document.forms[0].txt_GuarAmount.value == "0.00" ) 
		{
			ShowAlert('121', "Govt. Agency Guaranteed Amount");
			document.forms[0].txt_GuarAmount.focus();
			return;
		}
	}if(varBankncgtcScheme!="069")
	{
		//alert("varBankncgtcScheme"+varBankncgtcScheme);
		if(document.forms[0].sel_GuarCovered.value != "00")
		{
			if(varDataFlag!="Y")
			{
				if(document.forms[0].hid_gvtgamt.value == "N" )
				{
					alert("Please fill Govt. Agency Guaranteed Amount");
					document.forms[0].txt_GuarAmount.value="";
					document.forms[0].txt_GuarAmount.focus();
					return;
				}
			}
			if (document.forms[0].txt_GuarAmount.value == "" || document.forms[0].txt_GuarAmount.value == "0.00" ) 
			{
				ShowAlert('121', "Govt. Agency Guaranteed Amount");
				document.forms[0].txt_GuarAmount.focus();
				return;
			}
		}
	}
	
	if(varBankScheme!="061" && varBankScheme!="064" && (varBankncgtcScheme!="069" || varBankncgtcScheme!="071"))
	{
		//alert(varBankScheme);
		//alert(document.forms[0].hid_gvtgamt.value);
		if(document.forms[0].sel_GuarCovered.value != "00")
		{
			if(varDataFlag!="Y")
			{
				if(document.forms[0].hid_gvtgamt.value == "N" )
				{
					alert("Please fill Govt. Agency Guaranteed Amount");
					document.forms[0].txt_GuarAmount.value="";
					document.forms[0].txt_GuarAmount.focus();
					return;
				}
			}
			if (document.forms[0].txt_GuarAmount.value == "" || document.forms[0].txt_GuarAmount.value == "0.00" ) 
			{
				ShowAlert('121', "Govt. Agency Guaranteed Amount");
				document.forms[0].txt_GuarAmount.focus();
				return;
			}
		}
	}
	if (varsalesturnover == "N") 
	{
		if (document.forms[0].txt_sales_turnover.value==""||document.forms[0].txt_sales_turnover.value=="0.00"){

			ShowAlert('121',"Sales Turnover of the applicant in customer profile-Demographics Tab");

			document.forms[0].txt_sales_turnover.focus();

			return;
		}
		if (eval(document.forms[0].txt_sales_turnover.value)<1) {
			alert("Sales Turnover of the applicant value should not be less than 1 ,kindly update customer profile-Demographics Tab");
			document.forms[0].txt_sales_turnover.focus();
			return;

		}
	}
	if (varsalesturnoverdate == "N") 
	{

		if (document.forms[0].txt_turnover_asondate.value==""){

			ShowAlert('121',"Sales Turnover Date in customer profile-Demographics Tab");

			document.forms[0].txt_turnover_asondate.focus();

			return;

		}

	}
	if (varCriteriaSales == "N") 
	{

		if (document.forms[0].sel_sales_turnover.value=="0"||document.forms[0].sel_sales_turnover.value==""){

			ShowAlert('111',"Criteria for Sales Turnover in customer profile-Demographics Tab");

			document.forms[0].sel_sales_turnover.focus();

			return;

		}

	}
	if (varinvestdate == "N") 
	{

		if (document.forms[0].txt_investDate.value==""){

			ShowAlert('121',"Investment value as on Date");

			document.forms[0].txt_investDate.focus();

			return;

		}

	}
	if (varCriteriainvest == "N") 
	{

		if (document.forms[0].sel_criteria_invest.value=="0"||document.forms[0].sel_criteria_invest.value==""){

			ShowAlert('111',"Criteria for Investment value");

			document.forms[0].sel_criteria_invest.focus();

			return;

		}

	}
	if (vardwellingunit == "N") 
	{

		if (document.forms[0].txt_dwellingunit.value=="0"||document.forms[0].txt_dwellingunit.value==""||document.forms[0].txt_dwellingunit.value=="0.00"){

			ShowAlert('121',"overall cost of the dwelling unit");

			document.forms[0].txt_dwellingunit.focus();

			return;

		}

	}
	
	
	if(appstatus=="Open/Pending")
	{
		if(varPostSanc=="P"){
			var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
			for(var i=0;i<varPSterms.length;i++)
			{
				if(varPSterms[i] == "MIS")
				{
					if(document.forms[0].hid_State.value=="ZZ")
					{
						alert("State selected in utilization of credit should not be   " +document.forms[0].hid_State.value+".Kinldy select any other state")
						return;
					}
					if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
					{
						document.forms[0].sel_GuarCovered.value=="16";
						document.forms[0].sel_GuarCovered.disabled=true;
						callGuarCovered('N');
					}
				}
			}
		}else{
				if(document.forms[0].hid_State.value=="ZZ")
				{
					alert("State selected in utilization of credit should not be   " +document.forms[0].hid_State.value+".Kinldy select any other state")
					return;
				}
			}
		}
	
		disableFields(false);

		disablePermanent(false);
	
		disableActivityFields(false);
	
		disableMISClassificationFields(false);
	
		clearValues();
	
		if (varFacilityType != "NF") {
	
			document.forms[0].sel_sharebroker.value="0";
	
		}

	var varSubSector = document.forms[0].sel_SubSector.value;

	var varAgriInd = document.forms[0].sel_CategoryType.value;

	if(varSubSector == "1" || varSubSector == "2" || varSubSector == "26" || varSubSector == "27" || varSubSector == "28")
	{
		varTotalAgriLimit=parseFloat(varTotalAgriLimit);
	}
	else
	{
		varTotalAgriLimit=parseFloat(varTotalAgriLimit)+parseFloat(varLoanAmount);
	}

	if(varAgriInd == "11" || varAgriInd == "12" || varAgriInd == "14" || varAgriInd == "15" || varAgriInd == "19" || varAgriInd == "20" || varAgriInd == "21")
	{
		varTotalServiceLimit=parseFloat(varTotalServiceLimit);
	}
	else
	{
		varTotalServiceLimit=parseFloat(varTotalServiceLimit)+parseFloat(varLoanAmount);
	}

		
	document.forms[0].txt_TotLimitService.value=roundVal(varTotalServiceLimit);

	document.forms[0].txt_TotLimitAgri.value=roundVal(varTotalAgriLimit);
	
	if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
	{
		document.forms[0].txt_GuarAmount.value=document.forms[0].txt_LoanAmt.value;
	}
	if(varBankScheme=="061")
	{
		//alert("document.forms[0].txt_LoanAmt.value"+document.forms[0].txt_LoanAmt.value);
		document.forms[0].txt_GuarAmount.value=document.forms[0].txt_LoanAmt.value;
	}
	
	document.forms[0].sel_GuarCovered.disabled=false;
	document.forms[0].cmdsave.disabled=true;

	document.forms[0].hidAction.value = "insert";

	document.forms[0].hidBeanId.value = "mis";

	document.forms[0].hidSourceUrl.value = "/action/misdetails.jsp";

	document.forms[0].hidBeanGetMethod.value = "getMISDetails";

	document.forms[0].hidBeanMethod.value = "updateMISDetails";

	document.forms[0].action = appURL + "controllerservlet";

	document.forms[0].submit();

}

function doCancel() {

	if (ConfirmMsg('102')) {

		document.forms[0].hidBeanId.value = "mis";

		document.forms[0].hidBeanGetMethod.value = "getMISDetails";

		document.forms[0].action = appURL + "action/misdetails.jsp";

		document.forms[0].submit();

	}

}

function doDelete() {

	if (ConfirmMsg('101')) {

		document.forms[0].sel_facilitysno.disabled=false;

		document.forms[0].hidAction.value = "delete";

		document.forms[0].hidBeanId.value = "mis";

		document.forms[0].hidSourceUrl.value = "/action/misdetails.jsp";

		document.forms[0].hidBeanGetMethod.value = "getMISDetails";

		document.forms[0].hidBeanMethod.value = "updateMISDetails";

		document.forms[0].action = appURL + "controllerservlet";

		document.forms[0].submit();

	}

}

function doClose() {

	if (ConfirmMsg('100')) {

		window.close();

	}

}

function setSelValues() 

{
	document.forms[0].sel_BankScheme.value = varBankScheme;

	document.forms[0].sel_RestructFac.value = varRestructure;

	if (varService != "") {

		document.forms[0].sel_ServiceArea.value = varService;

	} else {

		document.forms[0].sel_ServiceArea.value = "N";

	}
	if (varcatageorysales != "") {

		document.forms[0].sel_sales_turnover.value = varcatageorysales;

	}
	if (varcriteriainvest != "") {

		document.forms[0].sel_criteria_invest.value = varcriteriainvest;

	}
	if (varministryindustry != "") {

		document.forms[0].sel_min_industry.value = varministryindustry;

	}
	if (varareaofindvhouse != "") {

		document.forms[0].sel_maxind_house.value = varareaofindvhouse;

	}
	document.forms[0].sel_RestructUnder.value = varResUnder;

	document.forms[0].sel_Place.value = varPlace;

	document.forms[0].sel_AssetFinanced.value = varRepayment;

	document.forms[0].sel_RepaySource.value = varSourceOfRepay;

	document.forms[0].sel_GuarCovered.value = varGuarantee;

	document.forms[0].sel_NewProjectFac.value = varNewFacility;

	document.forms[0].sel_MainActivity.value = varMainAct;

	document.forms[0].sel_SubActivity.value = varSubAct;

	document.forms[0].sel_Purpose.value = varPurpose;

	document.forms[0].sel_BSRCode.value = varBSRCode;

	document.forms[0].sel_BSR1Code.value = varBSR1Code;

	document.forms[0].sel_IndustryType.value = varIndustryType;

	if (varAsset != "") {

		document.forms[0].sel_AssetClassification.value = varAsset;

	} else {

		document.forms[0].sel_AssetClassification.value = "1";

	}

	document.forms[0].sel_FarmerCategory.value = varFarmerCat;

	if (varCropIns != "") {

		document.forms[0].sel_CropInsu.value = varCropIns;

	} else {

		document.forms[0].sel_CropInsu.value = "N";

	}

	if (varKrishiCard != "") {

		document.forms[0].sel_KrishiCard.value = varKrishiCard;

	} else {

		document.forms[0].sel_KrishiCard.value = "N";

	}

	if (varPAIS != "") {

		document.forms[0].sel_PAIS.value = varPAIS;

	} else {

		document.forms[0].sel_PAIS.value = "N";

	}

	if (varMeritoriousStatus != "") {

		document.forms[0].sel_Meritorious.value = varMeritoriousStatus;

	} else {

		document.forms[0].sel_Meritorious.value = "N";

	}

	document.forms[0].sel_PublicDeposit.value = varAccDep;

	document.forms[0].sel_CategoryType.value = varAgri;

	document.forms[0].sel_Sector.value = varSector;

	document.forms[0].sel_SubSector.value = varSubSector;

	document.forms[0].sel_SensitiveSector.value = varSensitiveSector;

	document.forms[0].sel_WeakerSection.value = varWeakerSec;

	document.forms[0].sel_TwentyPointPgm.value = varTwentyPntPgm;

	document.forms[0].sel_InfraCreditType.value = varInfraCode;

	document.forms[0].sel_sharebroker.value = varShareBroker;
	
	document.forms[0].sel_StandupIndia.value = varStandUpIndia;
	
	
}

function callRestructure() {

	/*if (document.forms[0].sel_RestructFac.value == "Y") {

		document.all.id_Restructure1.style.display = "block";

		document.all.id_Restructure2.style.display = "block";

		document.all.id_Restructure3.style.display = "block";

		document.all.id_Restructure4.style.display = "block";

	} else {*/

		document.all.id_Restructure1.style.display = "none";

		document.all.id_Restructure2.style.display = "none";

		document.all.id_Restructure3.style.display = "none";

		document.all.id_Restructure4.style.display = "none";

	/*}*/

}


function callAssetFinanced() {

	if (document.forms[0].sel_AssetFinanced.value == "Y") {

		document.all.id_RepaySource1.style.visibility = "visible";

		document.all.id_RepaySource2.style.visibility = "visible";

	} else {

		document.all.id_RepaySource1.style.visibility = "hidden";

		document.all.id_RepaySource2.style.visibility = "hidden";

	}

}

function callGuarCovered(val)
{
	if(val=="Y" && PRD_CGTMSE=="N" && document.forms[0].sel_GuarCovered.value =="11")
	{
		alert("Option is Not Applicable");
		document.forms[0].sel_GuarCovered.value = "";
		document.all.id_GuarCovered1.style.visibility = "hidden";
		document.all.id_GuarCovered2.style.visibility = "hidden";
		document.all.id_GuarCovered3.style.visibility = "hidden";
		return;
	}
	
	if (document.forms[0].sel_GuarCovered.value == "00" || document.forms[0].sel_GuarCovered.value == "") {
		document.all.id_GuarCovered1.style.visibility = "hidden";
		document.all.id_GuarCovered2.style.visibility = "hidden";
		document.all.id_GuarCovered3.style.visibility = "hidden";
	} else {
		document.all.id_GuarCovered1.style.visibility = "visible";
		document.all.id_GuarCovered2.style.visibility = "visible";
		document.all.id_GuarCovered3.style.visibility = "visible";
	}
	
	if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
	{
		document.all.id_GuarCovered1.style.visibility = "visible";
		document.all.id_GuarCovered2.style.visibility = "visible";
		document.all.id_GuarCovered3.style.visibility = "visible";
	}
	if(varSvanidhiType=="1" || varSvanidhiType=="2" || varSvanidhiType=="3" ){
		document.forms[0].txt_GuarAmount.readOnly=true;				
	}
	
	if(varBankncgtcScheme=="070")
	{
		if(document.forms[0].sel_GuarCovered.value=="16")
		{
			alert("For the Facility NCGTC Guarantee Scheme cannot be selected");
			document.forms[0].sel_GuarCovered.value="";
			document.all.id_GuarCovered1.style.visibility = "hidden";
			document.all.id_GuarCovered2.style.visibility = "hidden";
			document.all.id_GuarCovered3.style.visibility = "hidden";
			return;
		}
	}
}
function callNewProjectFac() {
	if (document.forms[0].sel_NewProjectFac.value == "Y") {
		document.all.id_NewProjectFac1.style.visibility = "visible";
		document.all.id_NewProjectFac2.style.visibility = "visible";
	} else {
		document.all.id_NewProjectFac1.style.visibility = "hidden";
		document.all.id_NewProjectFac2.style.visibility = "hidden";
	}
}

function callShareBroker()
{
	if (varFacilityType == "NF") {
		document.all.id_sharebroker.style.visibility = "visible";
		document.all.id_sharebroker.style.position = "relative";
	} else {
		document.all.id_sharebroker.style.visibility = "hidden";
		document.all.id_sharebroker.style.position = "absolute";
	}
}

function callIndustryType() {
	if (document.forms[0].sel_IndustryType.value == "") {
		document.all.id_IndustryType.style.display = "none";
	} else {
		document.all.id_IndustryType.style.display = "table-row";
	}
}

function callKrishiScheme() {

	if (document.forms[0].sel_KrishiCard.value == "Y") {

		document.all.id_KrishiCardlbl.style.display = "table-cell";

		document.all.id_KrishiCardtxt.style.display = "table-cell";

		document.all.id_KrishiCardlbl1.style.display = "table-cell";

		document.all.id_KrishiCardtxt1.style.display = "table-cell";

	} else {

		document.all.id_KrishiCardlbl.style.display = "none";

		document.all.id_KrishiCardtxt.style.display = "none";

		document.all.id_KrishiCardlbl1.style.display = "none";

		document.all.id_KrishiCardtxt1.style.display = "none";

		document.forms[0].sel_PAIS.value = "N";

	}

	callPAIS();

}

function callPAIS() {

	if (document.forms[0].sel_PAIS.value == "Y") {

		document.all.id_Premiumlbl.style.display = "table-cell";

		document.all.id_PremiumlblRs.style.display = "table-cell";

		document.all.id_Premiumtxt.style.display = "table-cell";

		document.all.id_NomineeNameAge.style.display = "table-row";

		document.all.id_NomineeRelationClaimDet.style.display = "table-row";

	} else {

		document.all.id_Premiumlbl.style.display = "none";

		document.all.id_PremiumlblRs.style.display = "none";

		document.all.id_Premiumtxt.style.display = "none";

		document.all.id_NomineeNameAge.style.display = "none";

		document.all.id_NomineeRelationClaimDet.style.display = "none";

	}

}


function callDisplayScreenChange() 

{	
	var varagri = "Y",varagricropinsukrishimain="Y",varagritenure="Y",varagriAgribus="Y",varindustry="Y";

	var varnbfc="Y",varhousunit="Y",varfixedinvestment="Y",vareducation="Y",varborrowerlending="Y",varCRE="Y";

	var varsocinfra="Y",varagrianci="Y",varagriinfra="Y",varrenewenrgy="Y",varrenenrgyin="Y",varsalesturnover="Y",varsalesturnoverdate="Y",
	varCriteriaSales="Y",varinvestdate="Y",varCriteriainvest="Y",varministry="Y",varcarpet="Y",varfloorarea="Y",varindhouse="Y",varproploanshg="Y",vardwellingunit="Y",varagrialliedcode="Y";

	var varDispScreenVal = document.forms[0].sel_DisplayScreen.value.split("@");
	
	for(var j=0;j<varDispScreenVal.length;j++)

	{
		if (varDispScreenVal[j].substring(0, 4) == "agri") varagri="N";

		if (varDispScreenVal[j] == "agricropinsukrishimain") varagricropinsukrishimain="N";

		if (varDispScreenVal[j] == "agritenure") varagritenure="N";

		if (varDispScreenVal[j] == "agriAgribus") varagriAgribus="N";

		if (varDispScreenVal[j] == "industry") varindustry="N";

		if (varDispScreenVal[j] == "nbfc") varnbfc="N";

		if (varDispScreenVal[j] == "housunit") varhousunit="N";

		if (varDispScreenVal[j] == "fixedinvestment") varfixedinvestment="N";

		if (varDispScreenVal[j] == "education") vareducation="N";

		if (varDispScreenVal[j] == "borrowerlending") varborrowerlending="N";

		if (varDispScreenVal[j] == "socinfra") varsocinfra="N";

		if (varDispScreenVal[j] == "agrianci") varagrianci="N";

		if (varDispScreenVal[j] == "agriinfra") varagriinfra="N";

		if (varDispScreenVal[j] == "renewenrgy") varrenewenrgy="N";

		if (varDispScreenVal[j] == "renenrgyin") varrenenrgyin="N";

		if (varDispScreenVal[j] == "cre") varCRE="N";
		
		if (varDispScreenVal[j] == "salesvalue") varsalesturnover="N";
		if (varDispScreenVal[j] == "salesDate") varsalesturnoverdate="N";
		if (varDispScreenVal[j] == "criteria") varCriteriaSales="N";
		if (varDispScreenVal[j] == "investDate") varinvestdate="N";
		if (varDispScreenVal[j] == "criteriainvest") varCriteriainvest="N";
		
		
		if (varDispScreenVal[j] == "ministry") varministry="N";
		if (varDispScreenVal[j] == "Carpet") varcarpet="N";
		if (varDispScreenVal[j] == "floorarea") varfloorarea="N";
		if (varDispScreenVal[j] == "individualhouse") varindhouse="N";
		if (varDispScreenVal[j] == "proposedloanSHG") varproploanshg="N";
		if (varDispScreenVal[j] == "dwellingunit") vardwellingunit="N";
		if (varDispScreenVal[j] == "agriallied") varagrialliedcode="N";
	}



	if (varagri == "N") {
         
		document.all.id_agri.style.display = "table";

	} else {
		document.all.id_agri.style.display = "none";

	}
	if(varstrSessionModuleType=="AGR"||varstrSessionModuleType=="CORP"||(varagrigoldproduct=="Y"&&varstrSessionModuleType=="LAD"))
	{
	if (varagrialliedcode == "N") {
		
		document.all.txt_allied_code.style.display = "table";

	} else {
		document.forms[0].txt_allied_ActivityCode.value = "";
		document.forms[0].allied_sel_MainActivity.value = "";
		document.forms[0].allied_sel_SubActivity.value = "";
		document.forms[0].allied_sel_Purpose.value = "";
		document.all.txt_allied_code.style.display = "none";

	}
	}

	if (varagriAgribus == "N") {

		document.all.id_agriAgribus.style.display = "table";

	} else {

		document.all.id_agriAgribus.style.display = "none";

	}

	if (varagricropinsukrishimain == "N") {

		document.all.id_agricropinsukrishimain.style.display = "table";

	} else {

		document.all.id_agricropinsukrishimain.style.display = "none";

	}

	if (varagriAgribus == "N") {

		document.all.id_agrikrishimain.style.display = "table";

	} else {

		document.all.id_agrikrishimain.style.display = "none";

	}

	if (varagritenure == "N") {

		document.all.id_agritenure.style.display = "table";

	} else {

		document.all.id_agritenure.style.display = "none";

	}

	if (varborrowerlending == "N") {

		document.all.id_borrowerlending.style.display = "table";

	} else {

		document.all.id_borrowerlending.style.display = "none";

	}

	if (vareducation == "N") {

		document.all.id_education.style.display = "table";

	} else {

		document.all.id_education.style.display = "none";

	}

	if (varfixedinvestment == "N") {

		document.all.id_fixedinvestment.style.display = "table";

	} else {

		document.all.id_fixedinvestment.style.display = "none";

	}

	if (varhousunit == "N") {

		document.all.id_housunit.style.display = "table";

	} else {

		document.all.id_housunit.style.display = "none";

	}

	if (varindustry == "N") {

		document.all.id_industry.style.display = "table";

	} else {

		document.all.id_industry.style.display = "none";

	}

	if (varnbfc == "N") {

		document.all.id_nbfc.style.display = "table";

	} else {

		document.all.id_nbfc.style.display = "none";

	}

	if (varCRE == "N") {

		document.all.id_cre.style.display = "table";

	} else {

		document.all.id_cre.style.display = "none";

	}
	

	//Added by guhan for New priority sector parameters

	

	if (varsocinfra == "N") { 

		document.all.id_socialinfra.style.display = "table";

	} else {

		document.all.id_socialinfra.style.display = "none";

	}

	if (varagrianci == "N") {

		document.all.id_agri_anci.style.display = "table";

	} else {

		document.all.id_agri_anci.style.display = "none";

	}

	if (varagriinfra == "N") {

		document.all.id_agri_infra.style.display = "table";

	} else {

		document.all.id_agri_infra.style.display = "none";

	}

	if (varrenewenrgy == "N") {

		document.all.id_renew_energy.style.display = "table";

	} else {

		document.all.id_renew_energy.style.display = "none";

	}

	if (varrenenrgyin == "N") {

		document.all.id_renew_energy_indv.style.display = "table";

	} else {

		document.all.id_renew_energy_indv.style.display = "none";

	}
	if (varsalesturnover == "N") {

		document.all.id_sales1.style.display = "table-cell";
		document.all.id_sales2.style.display = "table-cell";
		

	} else {

		document.all.id_sales1.style.display = "none";
		document.all.id_sales2.style.display = "none";
		

	}
	if (varsalesturnoverdate == "N") {

		document.all.id_sales3.style.display = "table-cell";
		document.all.id_sales4.style.display = "table-cell";
		

	} else {

		document.all.id_sales3.style.display = "none";
		document.all.id_sales4.style.display = "none";
		

	}
	if (varCriteriaSales == "N") {

		document.all.id_sales5.style.display = "table-cell";
		document.all.id_sales6.style.display = "table-cell";
		

	} else {

		document.all.id_sales5.style.display = "none";
		document.all.id_sales6.style.display = "none";
		

	}
	if (varinvestdate == "N") {

		document.all.id_sales7.style.display = "table-cell";
		document.all.id_sales8.style.display = "table-cell";
		

	} else {

		document.all.id_sales7.style.display = "none";
		document.all.id_sales8.style.display = "none";
		

	}
	if (varCriteriainvest == "N") {

		document.all.id_sales9.style.display = "table-cell";
		document.all.id_sales10.style.display = "table-cell";
		

	} else {

		document.all.id_sales9.style.display = "none";
		document.all.id_sales10.style.display = "none";
		

	}
	
	if (varsalesturnover == "N"||varsalesturnoverdate == "N"||varCriteriaSales == "N") {

		document.all.id_sales.style.display = "table";
	} else {

		document.all.id_sales.style.display = "none";
	}
	
	if (varinvestdate == "N"||varCriteriainvest == "N") {

		document.all.id_sales11.style.display = "table";
	} else {

		document.all.id_sales11.style.display = "none";
	}
	if (varministry == "N" && varstartupconstitution=="Y") {
		document.all.id_minority.style.display = "table";
		document.all.id_minority1.style.display = "table";
		

	} else {

		document.all.id_minority.style.display = "none";
		document.all.id_minority1.style.display = "none";
		

	}
	if (varcarpet == "N") {

		document.all.id_carpet.style.display = "table";
		document.all.id_carpet1.style.display = "table";
		

	} else {

		document.all.id_carpet.style.display = "none";
		document.all.id_carpet1.style.display = "none";
		

	}
	if (varfloorarea == "N") {

		document.all.id_floorarea.style.display = "table";
		document.all.id_floorarea1.style.display = "table";
		

	} else {

		document.all.id_floorarea.style.display = "none";
		document.all.id_floorarea1.style.display = "none";
		

	}
	if (varindhouse == "N") {

		document.all.id_indhouse.style.display = "table";
		document.all.id_indhouse1.style.display = "table";
		

	} else {

		document.all.id_indhouse.style.display = "none";
		document.all.id_indhouse1.style.display = "none";
		

	}
	if (varproploanshg == "N") {

		document.all.id_shgnumber.style.display = "table";
		document.all.id_shgnumber1.style.display = "table";
		

	} else {

		document.all.id_shgnumber.style.display = "none";
		document.all.id_shgnumber1.style.display = "none";
	}

	if (varministry == "N"||varcarpet == "N"||varfloorarea == "N"||varindhouse == "N"||varproploanshg == "N" ||vardwellingunit=="N") {

		document.all.id_newmis.style.display = "table";
	} else {

		document.all.id_newmis.style.display = "none";
	}
	if(vardwellingunit=="N"){
		document.all.id_dwelling.style.display = "table";
	}else{
		document.all.id_dwelling.style.display = "none";
	}
	
}

function callsalesrestriction(){
	var varsalesturnover="Y",varsalesturnoverdate="Y",
	varCriteriaSales="Y";

	var varDispScreenVal = document.forms[0].sel_DisplayScreen.value.split("@");
	
	for(var j=0;j<varDispScreenVal.length;j++)

	{
		
		if (varDispScreenVal[j] == "salesvalue") varsalesturnover="N";
		if (varDispScreenVal[j] == "salesDate") varsalesturnoverdate="N";
		if (varDispScreenVal[j] == "criteria") varCriteriaSales="N";

	}
	if (varsalesturnover == "N") 

	{

		if (document.forms[0].txt_sales_turnover.value==""||document.forms[0].txt_sales_turnover.value=="0.00"){

			ShowAlert('121',"Sales Turnover of the applicant in customer profile-Demographics Tab");

			document.forms[0].txt_sales_turnover.focus();

			return;

		}

	}
	if (varsalesturnoverdate == "N") 
	{

		if (document.forms[0].txt_turnover_asondate.value==""){

			ShowAlert('121',"Sales Turnover Date in customer profile-Demographics Tab");

			document.forms[0].txt_turnover_asondate.focus();

			return;

		}

	}
	if (varCriteriaSales == "N") 
	{

		if (document.forms[0].sel_sales_turnover.value=="0"||document.forms[0].sel_sales_turnover.value==""){

			ShowAlert('111',"Criteria for Sales Turnover in customer profile-Demographics Tab");

			document.forms[0].sel_sales_turnover.focus();

			return;

		}

	}

}
function callWhetherTLorDL() {

	if (varLoanType == "TL" || varLoanType == "DL") {

		document.all.id_FacilityForNew.style.display = "table-row";

	} else {

		document.all.id_FacilityForNew.style.display = "none";

	}

}

function changeIrrigationCultivationMode() {

	if (document.forms[0].txt_TotLandHold.value == ""

			|| document.forms[0].txt_TotLandHold.value == "0"

			|| document.forms[0].txt_TotLandHold.value == "0.00") {

		document.all.id_Irrigation.style.display = "none";

		document.all.id_Cultivation.style.display = "none";

		document.all.id_Temp.style.display = "table-cell";

		document.all.id_Temp2.style.display = "table-cell";

		document.all.id_Land.style.visibility = "visible";

		document.all.id_Land.style.position = "relative";

		if (document.forms[0].txt_TotLandHold.value == "0"

				|| document.forms[0].txt_TotLandHold.value == "0.00") {

			document.all.id_Farm.style.visibility = "visible";

			document.all.id_Farm.style.position = "relative";

		} else {

			document.all.id_Farm.style.visibility = "hidden";

			document.all.id_Farm.style.position = "absolute";

		}

	} else {

		document.all.id_Irrigation.style.display = "table-row";

		document.all.id_Cultivation.style.display = "table-row";

		document.all.id_Temp.style.display = "none";

		document.all.id_Temp2.style.display = "none";

		document.all.id_Land.style.visibility = "hidden";

		document.all.id_Land.style.position = "absolute";

		document.all.id_Farm.style.visibility = "hidden";

		document.all.id_Farm.style.position = "absolute";

	}

}

function setLandValues() {

	if (document.forms[0].txt_TotLandHold.value == "0"

			|| document.forms[0].txt_TotLandHold.value == "0.00") {

		document.all.txt_Irrigated.value = "0";

		document.all.txt_NonIrrigated.value = "0";

		document.all.txt_Cultivated.value = "0";

		document.all.txt_NonCultivated.value = "0";

	}

	disableFarmCat();

}

function calculateNonIrrigate() {

	var varTotalLand = document.forms[0].txt_TotLandHold.value;

	var varIrrigated = document.forms[0].txt_Irrigated.value;

	document.forms[0].txt_Irrigated.value = roundVal(round(

			document.forms[0].txt_Irrigated.value, 2));

	if (NanNumber(parseFloat(varTotalLand)) != ""

			&& NanNumber(parseFloat(varTotalLand)) != 0.00) {

		if (NanNumber(parseFloat(varTotalLand)) >= NanNumber(parseFloat(varIrrigated))) {

			document.forms[0].txt_NonIrrigated.value = roundVal(NanNumber(parseFloat(varTotalLand))

					- NanNumber(parseFloat(varIrrigated)));

		} else {

			alert("Irrigated land cannot be greater than Total land Holding");

			document.forms[0].txt_Irrigated.value = "";

			document.forms[0].txt_NonIrrigated.value = "";

			document.forms[0].txt_Irrigated.focus();

			return;

		}

	}

}

function calculateNonCultivate() {

	var varTotalLand = document.forms[0].txt_TotLandHold.value;

	var varCultivated = document.forms[0].txt_Cultivated.value;

	document.forms[0].txt_Cultivated.value = roundVal(round(

			document.forms[0].txt_Cultivated.value, 2));

	if (NanNumber(parseFloat(varTotalLand)) != ""

			&& NanNumber(parseFloat(varTotalLand)) != 0.00) {

		if (NanNumber(parseFloat(varTotalLand)) >= NanNumber(parseFloat(varCultivated))) {

			document.forms[0].txt_NonCultivated.value = roundVal(NanNumber(parseFloat(varTotalLand))

					- NanNumber(parseFloat(varCultivated)));

		} else {

			alert("Cultivated land cannot be greater than Total land Holding");

			document.forms[0].txt_Cultivated.value = "";

			document.forms[0].txt_NonCultivated.value = "";

			document.forms[0].txt_Cultivated.focus();

			return;

		}

	}

}

function showMISClassification() {

	if (varDataFlag == "Y") {

		document.all.id_misclassification.style.display = "table-row";

	} else {

		document.all.id_misclassification.style.display = "none";

	}

}

function callMISActvityHelp() {

	if (document.forms[0].cmdsave.disabled == false) {

		if(varstrSessionModuleType =="RET" || varstrSessionModuleType =="LAD"){

		var varQryString = appURL + "action/set_misactivityhelp.jsp?hidBeanId=mis&hidBeanGetMethod=getActivityCodebyApplication&master=mis"+"&LoanType="+document.forms[0].hidLoanType.value+"&CorpProdCode="+document.forms[0].hidCorpProdCode.value+"&strAppNo="+document.forms[0].hidapplno.value+"&FacilitySno=0";

		}else{

			var varQryString = appURL + "action/set_misactivityhelp.jsp?master=mis"+"&LoanType="+document.forms[0].hidLoanType.value+"&CorpProdCode="+document.forms[0].hidCorpProdCode.value+"&strAppNo="+document.forms[0].hidapplno.value+"&FacilitySno="+document.forms[0].sel_facilitysno.value;

		}

		var title = "MIS_ActivityCodeHelp";

		var prop = "scrollbars=no,width=850,height=400";

		prop = prop + ",left=200,top=200";

		window.open(varQryString, title, prop);

	}

}

function showCitySearch1(val1) {

	if (val1 == "MIS") {

		if (document.forms[0].cmdsave.disabled == false) {

			var varQryString = appURL + "action/searchCity.jsp?mis=" + val1;

			var title = "City";

			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";

			var xpos = (screen.width - 350) / 2;

			var ypos = (screen.height - 120) / 2;

			prop = prop + ",left=50,top=50";

			window.open(varQryString, title, prop);

		}

	}



}

function callDistrict() {

	var varstate = document.forms[0].hid_State.value;

	if (document.forms[0].cmdsave.disabled == false) {

		if (document.forms[0].txt_City.value == "") {

			ShowAlert(112, "City");

			document.forms[0].txt_City.focus();

			return;

		}

		if (document.forms[0].hid_State.value == "") {

			alert("Please Reselect the City");

			document.forms[0].txt_City.focus();

			return;

		} else {

			var varQryString = appURL

					+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="

					+ varstate + "&code=MIS";

			var title = "District";

			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';

			prop = prop + ",left=200,top=200";

			window.open(varQryString, title, prop);

		}

	}

}

function callApplicationSearch(varTextControl) {

	var varQryString = appURL

			+ "action/applicationsearch.jsp?hidBeanId=perapplicant&hidBeanGetMethod=getApplicationSearchDetails"

			+ "&hidcntrycontrol=" + varTextControl + "&hidapplicantid=" + appid

			+ "&hidPageFrom=" + document.forms[0].hidPageFrom.value

			+ "&hidPrdType=" + document.forms[0].hidPrdType.value;

	var title = "ApplicationSearch";

	var prop = "scrollbars=no,width=750,height=500";

	prop = prop + ",left=200,top=200";

	window.open(varQryString, title, prop);

}

function setSubActCode(val2) {

	var subactcode = val2;

	document.all.ifrm.src = appURL

			+ "action/iframemainactcode.jsp?hidBeanGetMethod=getMainActCode&hidBeanId=mis&strMainActCode="

			+ document.forms[0].sel_MainActivity.value + "&subactcode="

			+ subactcode;

}

function setFarmerCategory() {

	document.all.ifrm1.src = appURL

			+ "action/iframefarmcat.jsp?hidBeanGetMethod=getAppFarmersCategory&hidBeanId=mis&strTotLandVal="

			+ document.forms[0].txt_TotLandHold.value;

}

function disableFields(bool) {

	for ( var i = 0; i < document.forms[0].elements.length; i++) {

		if (document.forms[0].elements[i].type == "select-one") {

			document.forms[0].elements[i].disabled = bool;

		}

		if (document.forms[0].elements[i].type == "text") {

			document.forms[0].elements[i].readOnly = bool;

		}

	}

	disablePermanent(true);

	disableActivityFields(true);

	disableMISClassificationFields(true);
	if(varBankncgtcScheme=="069" || varBankncgtcScheme=="071")
	{
		document.forms[0].sel_GuarCovered.value="16";
		document.forms[0].sel_GuarCovered.disabled=true;
		document.forms[0].txt_GuarAmount.readOnly=true;
	}

}

function disablePermanent(stat) {

	document.forms[0].sel_BankScheme.disabled = stat;

	document.forms[0].sel_FarmerCategory.disabled = stat;

	document.forms[0].txt_SettlementDate.readOnly = stat;

	document.forms[0].txt_LoanAmt.readOnly = stat;

	document.forms[0].txt_TotLimit.readOnly = stat;

	document.forms[0].txt_TotLimitService.readOnly = stat;

	document.forms[0].txt_TotLimitAgri.readOnly = stat;

	document.forms[0].txt_City.readOnly = stat;

	document.forms[0].txt_State.readOnly = stat;

	document.forms[0].txt_District.readOnly = stat;

	document.forms[0].txt_DCCO.readOnly = stat;

	document.forms[0].txt_ActivityCode.readOnly = stat;

	document.forms[0].txt_Tenure.readOnly = stat;

	document.forms[0].txt_TotLandHold.readOnly = stat;

	document.forms[0].txt_Irrigated.readOnly = stat;

	document.forms[0].txt_NonIrrigated.readOnly = stat;

	document.forms[0].txt_Cultivated.readOnly = stat;

	document.forms[0].txt_NonCultivated.readOnly = stat;



	document.forms[0].txt_social_infra.readOnly = stat;

	document.forms[0].txt_agri_anci.readOnly = stat;

	document.forms[0].txt_renew_energy.readOnly = stat;

	document.forms[0].txt_renew_energy_indv.readOnly = stat;

	document.forms[0].txt_agri_infra.readOnly = stat;
	
	document.forms[0].txt_sales_turnover.readOnly = stat;

	document.forms[0].txt_turnover_asondate.readOnly = stat;
	
	document.forms[0].sel_sales_turnover.disabled = stat;
	document.forms[0].txt_carpetarea.readOnly = stat;
	document.forms[0].txt_shgnumber.readOnly = stat;
	

}

function disableActivityFields(one) {

	document.forms[0].sel_MainActivity.disabled = one;

	document.forms[0].sel_SubActivity.disabled = one;

	document.forms[0].sel_Purpose.disabled = one;

	document.forms[0].sel_BSRCode.disabled = one;

	document.forms[0].sel_BSR1Code.disabled = one;

	document.forms[0].sel_IndustryType.disabled = one;

	document.forms[0].sel_AssetClassification.disabled = one;

}

function disableMISClassificationFields(val) {

	document.forms[0].sel_CategoryType.disabled = val;

	document.forms[0].sel_Sector.disabled = val;

	document.forms[0].sel_SubSector.disabled = val;

	document.forms[0].sel_SensitiveSector.disabled = val;

	document.forms[0].sel_WeakerSection.disabled = val;

	document.forms[0].sel_TwentyPointPgm.disabled = val;

	document.forms[0].sel_InfraCreditType.disabled = val;

	document.forms[0].sel_GovtAnnounceScheme.disabled = val;
	
	document.forms[0].sel_StandupIndia.disabled = val;

}

function disableCommandButtons(cmdedit, cmdsave, cmdcancel, cmddelete, cmdclose) {

	document.forms[0].cmdedit.disabled = cmdedit;

	document.forms[0].cmdsave.disabled = cmdsave;

	document.forms[0].cmdcancel.disabled = cmdcancel;

	document.forms[0].cmddelete.disabled = cmddelete;

	document.forms[0].cmdclose.disabled = cmdclose;

}

function disableFarmCat()

{

	if(document.forms[0].txt_TotLandHold.value=="0.00"||document.forms[0].txt_TotLandHold.value=="0")

	{

		document.forms[0].sel_FarmerCategory.disabled=false;

	}

	else

	{

		document.forms[0].sel_FarmerCategory.disabled=true;

	}

}

function callCalender(cmdname) {

	if (document.forms[0].cmdsave.disabled == false) {

		showCal(appURL, cmdname);

	}

}

function callIFrame()
{
	document.forms[0].hidBeanId.value = "mis";

	document.forms[0].hidBeanGetMethod.value = "getMISDetails";

	document.forms[0].action = appURL + "action/misdetails.jsp";

	document.forms[0].submit();
}

function clearValues()
{
	var varagri = "Y",varagricropinsukrishimain="Y",varagritenure="Y",varagriAgribus="Y",varindustry="Y";

	var varnbfc="Y",varhousunit="Y",varfixedinvestment="Y",vareducation="Y",varborrowerlending="Y",varCRE="Y";

	var varsocinfra="Y",varagrianci="Y",varagriinfra="Y",varrenewenrgy="Y",varrenenrgyin="Y";

	var varDispScreenVal = document.forms[0].sel_DisplayScreen.value.split("@");

	for(var j=0;j<varDispScreenVal.length;j++)
	{
		if (varDispScreenVal[j].substring(0, 4) == "agri") varagri="N";

		if (varDispScreenVal[j] == "agricropinsukrishimain") varagricropinsukrishimain="N";

		if (varDispScreenVal[j] == "agritenure") varagritenure="N";

		if (varDispScreenVal[j] == "agriAgribus") varagriAgribus="N";

		if (varDispScreenVal[j] == "industry") varindustry="N";

		if (varDispScreenVal[j] == "nbfc") varnbfc="N";

		if (varDispScreenVal[j] == "housunit") varhousunit="N";

		if (varDispScreenVal[j] == "fixedinvestment") varfixedinvestment="N";

		if (varDispScreenVal[j] == "education") vareducation="N";

		if (varDispScreenVal[j] == "borrowerlending") varborrowerlending="N";

		if (varDispScreenVal[j] == "socinfra") varsocinfra="N";

		if (varDispScreenVal[j] == "agrianci") varagrianci="N";

		if (varDispScreenVal[j] == "agriinfra") varagriinfra="N";

		if (varDispScreenVal[j] == "renewenrgy") varrenewenrgy="N";

		if (varDispScreenVal[j] == "renenrgyin") varrenenrgyin="N";

		if (varDispScreenVal[j] == "cre") varCRE="N";
	}

	if (varagri == "Y")
	{
		document.forms[0].txt_TotLandHold.value="";

		document.forms[0].txt_Irrigated.value="";

		document.forms[0].txt_Cultivated.value="";

		document.forms[0].txt_NonIrrigated.value="";

		document.forms[0].txt_NonCultivated.value="";

		document.forms[0].sel_FarmerCategory.value="";

	}

	if (varagricropinsukrishimain == "Y") 

	{

		document.forms[0].sel_CropInsu.value="N";

		document.forms[0].sel_KrishiCard.value="N";

		document.forms[0].sel_PAIS.value="N";

		document.forms[0].txt_NomineeName.value="";

		document.forms[0].txt_NomineeRel.value="";

		document.forms[0].txt_KrishiCard.value="";

		document.forms[0].txt_Premium.value="";

		document.forms[0].txt_NomineeAge.value="";

		document.forms[0].txt_PAISClaim.value="";

	}

	if (varagritenure == "Y") 

	{

		document.forms[0].txt_Tenure.value="";

	}

	if (varagriAgribus == "Y") 

	{

		document.forms[0].txt_FinOutlays.value="";

		document.forms[0].txt_MarginMoney.value="";

		document.forms[0].txt_IndGroups.value="";

	}

	if (varindustry == "Y") 

	{

		document.forms[0].txt_OrigInvest.value="";

		document.forms[0].txt_IndName.value="";

	}

	if (varnbfc == "Y")

	{

		document.forms[0].sel_PublicDeposit.value="";

	}

	if (varhousunit == "Y")

	{

		document.forms[0].txt_NoOfHousing.value="";

	}

	if (varfixedinvestment == "Y")

	{

		document.forms[0].txt_OriginalInvest.value="";

	}

	if (vareducation == "Y")

	{

		document.forms[0].sel_Meritorious.value="N";

	}

	if (varborrowerlending == "Y") 

	{

		document.forms[0].txt_onwardlending.value="";

	}

	if (varsocinfra == "Y") 

	{

		document.forms[0].txt_social_infra.value="";

	}

	if (varagrianci == "Y") 

	{

		document.forms[0].txt_agri_anci.value="";

	}

	if (varagriinfra == "Y") 

	{

		document.forms[0].txt_agri_infra.value="";

	}

	if (varrenewenrgy == "Y") 

	{

		document.forms[0].txt_renew_energy.value="";

	}

	if (varrenenrgyin == "Y") 

	{

		document.forms[0].txt_renew_energy_indv.value="";

	}

	if (varCRE == "Y") 

	{

		document.forms[0].txt_cre_percnt.value="";

	}

}
function alliedcallMISActvityHelp() {

	if (document.forms[0].cmdsave.disabled == false) {
		

			//var varQryString = appURL + "action/allied_set_misactivityhelp.jsp?master=mis"+"&LoanType="+document.forms[0].hidLoanType.value+"&CorpProdCode="+document.forms[0].hidCorpProdCode.value+"&strAppNo="+document.forms[0].hidapplno.value+"&FacilitySno="+document.forms[0].sel_facilitysno.value;
		var varQryString = appURL + "action/allied_set_misactivityhelp.jsp?hidBeanId=mis&hidBeanGetMethod=alliedgetMISActivityCodeDetails&master=mis"+"&LoanType="+document.forms[0].hidLoanType.value+"&CorpProdCode="+document.forms[0].hidCorpProdCode.value+"&strAppNo="+document.forms[0].hidapplno.value+"&FacilitySno="+document.forms[0].sel_facilitysno.value+"&selectall=alliedcode";
		

		var title = "MIS_ActivityCodeHelp";

		var prop = "scrollbars=no,width=850,height=400";

		prop = prop + ",left=200,top=200";

		window.open(varQryString, title, prop);

	}

}