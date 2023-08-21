function showCorporate()
{
	if(document.forms[0].sel_applt_constitution.value!="01"&&document.forms[0].sel_applt_constitution.value!="02")
	{
		document.all.id_individual.style.visibility="hidden";
		document.all.id_individual.style.position="absolute";
		document.all.id_non_individual.style.visibility="visible";
		document.all.id_non_individual.style.position="relative";
		
		document.all.id_incorp_lbl.style.visibility="visible";
		document.all.id_incorp_lbl.style.position="relative";
		document.all.id_incorp_fld.style.visibility="visible";
		document.all.id_incorp_fld.style.position="relative";
		
		document.all.id_buss_comm_lbl.style.visibility="visible";
		document.all.id_buss_comm_lbl.style.position="relative";
		document.all.id_buss_comm_fld.style.visibility="visible";
		document.all.id_buss_comm_fld.style.position="relative";
		
		document.all.id_borr_dob_lbl.innerHTML="Date of Establishment<span class='mantatory'>*</span>";
		
		document.all.id_martial_lbl.style.visibility="hidden";
		document.all.id_martial_lbl.style.position="absolute";
		document.all.id_martial_fld.style.visibility="hidden";
		document.all.id_martial_fld.style.position="absolute";
		
		document.all.id_borr_sex_lbl.style.visibility="hidden";
		document.all.id_borr_sex_lbl.style.position="absolute";
		document.all.id_borr_sex_fld.style.visibility="hidden";
		document.all.id_borr_sex_fld.style.position="absolute";
	} else {
		document.all.id_individual.style.visibility="visible";
		document.all.id_individual.style.position="relative";
		document.all.id_non_individual.style.visibility="hidden";
		document.all.id_non_individual.style.position="absolute";
		
		document.all.id_incorp_lbl.style.visibility="hidden";
		document.all.id_incorp_lbl.style.position="absolute";
		document.all.id_incorp_fld.style.visibility="hidden";
		document.all.id_incorp_fld.style.position="absolute";
		
		document.all.id_buss_comm_lbl.style.visibility="hidden";
		document.all.id_buss_comm_lbl.style.position="absolute";
		document.all.id_buss_comm_fld.style.visibility="hidden";
		document.all.id_buss_comm_fld.style.position="absolute";
		
		document.all.id_borr_dob_lbl.innerHTML="Date of Birth<span class='mantatory'>*</span>";
		
		document.all.id_martial_lbl.style.visibility="visible";
		document.all.id_martial_lbl.style.position="relative";
		document.all.id_martial_fld.style.visibility="visible";
		document.all.id_martial_fld.style.position="relative";
		
		document.all.id_borr_sex_lbl.style.visibility="visible";
		document.all.id_borr_sex_lbl.style.position="relative";
		document.all.id_borr_sex_fld.style.visibility="visible";
		document.all.id_borr_sex_fld.style.position="relative";
	}
	showFatherName(document.forms[0].sel_applt_constitution.value);
	showisStaffDetails();
	showExServiceMenDetails();
	showGaurdianDetails();
	showSpouseDetails();
	showSHGDetails();
	showNBFCDetails();
	showMinorityDetails();
	showSalaryRouted();
}
function showBankingDetails()
{
	if(document.forms[0].sel_banking_with.value=="2")
	{
		document.all.id_borr_since_lbl.style.visibility="hidden";
		document.all.id_borr_since_lbl.style.position="absolute";
		document.all.id_borr_since_fld.style.visibility="hidden";
		document.all.id_borr_since_fld.style.position="absolute";
		document.all.id_satisfactory_row.style.visibility="hidden";
		document.all.id_satisfactory_row.style.position="absolute";
		
	} else {
		document.all.id_borr_since_lbl.style.visibility="visible";
		document.all.id_borr_since_lbl.style.position="relative";
		document.all.id_borr_since_fld.style.visibility="visible";
		document.all.id_borr_since_fld.style.position="relative";
		document.all.id_satisfactory_row.style.visibility="visible";
		document.all.id_satisfactory_row.style.position="relative";
		
	}
		
}
function showStaffRelationDetails()
{
	if(document.forms[0].sel_relative_bank.value=="001" || 
			document.forms[0].sel_relative_bank.value=="0")
	{
		document.all.id_staff_name_lbl.style.visibility="hidden";
		document.all.id_staff_name_lbl.style.position="absolute";
		document.all.id_staff_name_fld.style.visibility="hidden";
		document.all.id_staff_name_fld.style.position="absolute";
		document.all.id_blood_reln_lbl.style.visibility="hidden";
		document.all.id_blood_reln_lbl.style.position="absolute";
		document.all.id_blood_reln_fld.style.visibility="hidden";
		document.all.id_blood_reln_fld.style.position="absolute";
		document.all.id_staff_relat.style.visibility="hidden";
		document.all.id_staff_relat.style.position="absolute";
		
	} else {
		if(document.forms[0].sel_relative_bank.value=="005"||
				document.forms[0].sel_relative_bank.value=="006")
		{
			document.all.id_staff_relat.style.visibility="visible";
			document.all.id_staff_relat.style.position="relative";
		}
		else
		{
			document.all.id_staff_relat.style.visibility="hidden";
			document.all.id_staff_relat.style.position="absolute";
		}
		document.all.id_staff_name_lbl.style.visibility="visible";
		document.all.id_staff_name_lbl.style.position="relative";
		document.all.id_staff_name_fld.style.visibility="visible";
		document.all.id_staff_name_fld.style.position="relative";
		document.all.id_blood_reln_lbl.style.visibility="visible";
		document.all.id_blood_reln_lbl.style.position="relative";
		document.all.id_blood_reln_fld.style.visibility="visible";
		document.all.id_blood_reln_fld.style.position="relative";
		
	}
}
function showisStaffDetails()
{
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
	if(document.forms[0].sel_istaff.value=="01")
	{
		document.all.id_staffid_lbl.style.visibility="hidden";
		document.all.id_staffid_lbl.style.position="absolute";
		
		document.all.id_staffid_fld.style.visibility="hidden";
		document.all.id_staffid_fld.style.position="absolute";
		
		document.all.id_joiningdt_lbl.style.visibility="hidden";
		document.all.id_joiningdt_lbl.style.position="absolute";
		
		document.all.id_joiningdt_fld.style.visibility="hidden";
		document.all.id_joiningdt_fld.style.position="absolute";
		
	} else {
		document.all.id_staffid_lbl.style.visibility="visible";
		document.all.id_staffid_lbl.style.position="relative";
		
		document.all.id_staffid_fld.style.visibility="visible";
		document.all.id_staffid_fld.style.position="relative";
		
		document.all.id_joiningdt_lbl.style.visibility="visible";
		document.all.id_joiningdt_lbl.style.position="relative";
		
		document.all.id_joiningdt_fld.style.visibility="visible";
		document.all.id_joiningdt_fld.style.position="relative";
		
	}
	} else {
		document.all.id_staffid_lbl.style.visibility="hidden";
		document.all.id_staffid_lbl.style.position="absolute";
		
		document.all.id_staffid_fld.style.visibility="hidden";
		document.all.id_staffid_fld.style.position="absolute";
		
		document.all.id_joiningdt_lbl.style.visibility="hidden";
		document.all.id_joiningdt_lbl.style.position="absolute";
		
		document.all.id_joiningdt_fld.style.visibility="hidden";
		document.all.id_joiningdt_fld.style.position="absolute";
	}
}
function showExServiceMenDetails()
{
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
	if(document.forms[0].sel_ex_servicemen.value=="N")
	{
		document.all.id_exservice_years_lbl.style.visibility="hidden";
		document.all.id_exservice_years_lbl.style.position="absolute";
		
		document.all.id_exservice_years_fld.style.visibility="hidden";
		document.all.id_exservice_years_fld.style.position="absolute";
		
	} else {
		document.all.id_exservice_years_lbl.style.visibility="visible";
		document.all.id_exservice_years_lbl.style.position="relative";
		
		document.all.id_exservice_years_fld.style.visibility="visible";
		document.all.id_exservice_years_fld.style.position="relative";
		
	}
	} else {
		document.all.id_exservice_years_lbl.style.visibility="hidden";
		document.all.id_exservice_years_lbl.style.position="absolute";
		
		document.all.id_exservice_years_fld.style.visibility="hidden";
		document.all.id_exservice_years_fld.style.position="absolute";
	}
}
function showGaurdianDetails()
{
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
	if(document.forms[0].sel_minor.value=="N")
	{
		document.all.id_gaurdian_name_lbl.style.visibility="hidden";
		document.all.id_gaurdian_name_lbl.style.position="absolute";
		document.all.id_gaurdian_cbsid_lbl.style.visibility="hidden";
		document.all.id_gaurdian_cbsid_lbl.style.position="absolute";
		
		document.all.id_gaurdian_name_fld.style.visibility="hidden";
		document.all.id_gaurdian_name_fld.style.position="absolute";
		document.all.id_gaurdian_cbsid_txt.style.visibility="hidden";
		document.all.id_gaurdian_cbsid_txt.style.position="absolute";
		
		document.all.id_gaurdian_det_row.style.visibility="hidden";
		document.all.id_gaurdian_det_row.style.position="absolute";
		
	} else {
		document.all.id_gaurdian_name_lbl.style.visibility="visible";
		document.all.id_gaurdian_name_lbl.style.position="relative";
		document.all.id_gaurdian_cbsid_lbl.style.visibility="visible";
		document.all.id_gaurdian_cbsid_lbl.style.position="relative";
		
		document.all.id_gaurdian_name_fld.style.visibility="visible";
		document.all.id_gaurdian_name_fld.style.position="relative";
		document.all.id_gaurdian_cbsid_txt.style.visibility="visible";
		document.all.id_gaurdian_cbsid_txt.style.position="relative";
		
		document.all.id_gaurdian_det_row.style.visibility="visible";
		document.all.id_gaurdian_det_row.style.position="relative";
		
	}
	} else {
		document.all.id_gaurdian_name_lbl.style.visibility="hidden";
		document.all.id_gaurdian_name_lbl.style.position="absolute";
		document.all.id_gaurdian_cbsid_lbl.style.visibility="hidden";
		document.all.id_gaurdian_cbsid_lbl.style.position="absolute";
		
		document.all.id_gaurdian_name_fld.style.visibility="hidden";
		document.all.id_gaurdian_name_fld.style.position="absolute";
		document.all.id_gaurdian_cbsid_txt.style.visibility="hidden";
		document.all.id_gaurdian_cbsid_txt.style.position="absolute";
		
		document.all.id_gaurdian_det_row.style.visibility="hidden";
		document.all.id_gaurdian_det_row.style.position="absolute";
	}
}
function showSpouseDetails()
{
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
	if(document.forms[0].sel_applt_martial_status.value=="MARID")
	{
		document.all.spouse.style.visibility="visible";
		document.all.spouse.style.position="relative";
	} else {
		document.all.spouse.style.visibility="hidden";
		document.all.spouse.style.position="absolute";
	}
	} else {
		document.all.spouse.style.visibility="hidden";
		document.all.spouse.style.position="absolute";
	}
}
function showSHGDetails()
{
	if(document.forms[0].sel_applt_constitution.value=="023" ||
			document.forms[0].sel_applt_constitution.value=="024" ||
			document.forms[0].sel_applt_constitution.value=="025")
	{
		document.all.id_shg_details.style.visibility="visible";
		document.all.id_shg_details.style.position="relative";
	} else {
		document.all.id_shg_details.style.visibility="hidden";
		document.all.id_shg_details.style.position="absolute";
	}
}
function showNBFCDetails()
{
	if(document.forms[0].sel_applt_constitution.value!="01" && document.forms[0].sel_loa_nbfc.value=="Y")
	{
		document.all.id_nbfc_row2.style.visibility="visible";
		document.all.id_nbfc_row2.style.position="relative";
	} else {
		document.all.id_nbfc_row2.style.visibility="hidden";
		document.all.id_nbfc_row2.style.position="absolute";
	}
}
function showMinorityDetails()
{
	if(document.forms[0].sel_applt_constitution.value!="01" && document.forms[0].sel_firm_minority.value=="Y")
	{
		document.all.id_nonind_religion_lbl.style.visibility="visible";
		document.all.id_nonind_religion_lbl.style.position="relative";
		document.all.id_nonind_religion_fld.style.visibility="visible";
		document.all.id_nonind_religion_fld.style.position="relative";
	} else {
		document.all.id_nonind_religion_lbl.style.visibility="hidden";
		document.all.id_nonind_religion_lbl.style.position="relative";
		document.all.id_nonind_religion_fld.style.visibility="hidden";
		document.all.id_nonind_religion_fld.style.position="relative";
	}
}
function showTradeFinanceDetails()
{
	if(document.forms[0].sel_trade.value=="Y")
	{
		document.all.id_inland_lbl.style.visibility="visible";
		document.all.id_inland_lbl.style.position="relative";
		document.all.id_inland_fld.style.visibility="visible";
		document.all.id_inland_fld.style.position="relative";
	} else {
		document.all.id_inland_lbl.style.visibility="hidden";
		document.all.id_inland_lbl.style.position="relative";
		document.all.id_inland_fld.style.visibility="hidden";
		document.all.id_inland_fld.style.position="relative";
	}
}
function showCountry()
{
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
		if(document.forms[0].sel_resident_status.value=="Y")
		{
			document.all.id_country_lbl.style.visibility="visible";
			document.all.id_country_lbl.style.position="relative";
			document.all.id_country_fld.style.visibility="visible";
			document.all.id_country_fld.style.position="relative";
		} else {
			document.all.id_country_lbl.style.visibility="hidden";
			document.all.id_country_lbl.style.position="relative";
			document.all.id_country_fld.style.visibility="hidden";
			document.all.id_country_fld.style.position="relative";
		}
	} else {
		document.all.id_country_lbl.style.visibility="hidden";
		document.all.id_country_lbl.style.position="relative";
		document.all.id_country_fld.style.visibility="hidden";
		document.all.id_country_fld.style.position="relative";
	}
}
function showSalaryRouted()
{
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
		document.all.id_salary_routed_lbl.style.visibility="visible";
		document.all.id_salary_routed_lbl.style.position="relative";
		document.all.id_salary_routed_fld.style.visibility="visible";
		document.all.id_salary_routed_fld.style.position="relative";
	} else {
		document.all.id_salary_routed_lbl.style.visibility="hidden";
		document.all.id_salary_routed_lbl.style.position="absolute";
		document.all.id_salary_routed_fld.style.visibility="hidden";
		document.all.id_salary_routed_fld.style.position="absolute";
	}
}
function onloadDetails()
{
		document.getElementById("staff").style.display="none";
		document.getElementById("cbsid").style.display="none";	
		document.forms[0].sel_applt_constitution.value=varConstitution;
	 	document.forms[0].sel_applt_occupation.length =11;
		document.forms[0].sel_applt_occupation.options[0].text= "---- Select ----";
		document.forms[0].sel_applt_occupation.options[0].value= "0";
		document.forms[0].sel_applt_occupation.options[1].text= "Employee";
		document.forms[0].sel_applt_occupation.options[1].value= "1";
		document.forms[0].sel_applt_occupation.options[2].text= "Business Man";
		document.forms[0].sel_applt_occupation.options[2].value= "2";
		document.forms[0].sel_applt_occupation.options[3].text= "Professionals";
		document.forms[0].sel_applt_occupation.options[3].value= "3";
		document.forms[0].sel_applt_occupation.options[4].text= "Agriculture and allied activities";
		document.forms[0].sel_applt_occupation.options[4].value= "4";
		document.forms[0].sel_applt_occupation.options[5].text= "Trading";
		document.forms[0].sel_applt_occupation.options[5].value= "6";
		document.forms[0].sel_applt_occupation.options[6].text= "Services";
		document.forms[0].sel_applt_occupation.options[6].value= "7";
		document.forms[0].sel_applt_occupation.options[7].text= "Manufacturing";
		document.forms[0].sel_applt_occupation.options[7].value= "8";
		document.forms[0].sel_applt_occupation.options[8].text= "Pensioner";
		document.forms[0].sel_applt_occupation.options[8].value= "9";
		document.forms[0].sel_applt_occupation.options[9].text= "Student";
		document.forms[0].sel_applt_occupation.options[9].value= "10";
		document.forms[0].sel_applt_occupation.options[10].text= "Others";
		document.forms[0].sel_applt_occupation.options[10].value= "11";
	if(id.toUpperCase()=="NEW")
	{	
		//disableControls(true,false,true,true,false);
		document.forms[0].cmdNridetails.disabled=true;	
		if(document.forms[0].sel_applt_constitution.value =="01")
		{
		document.forms[0].cmdpartners.disabled=true;
		}
		document.forms[0].cmdmodify.disabled=true;
		document.forms[0].sel_applt_constitution.value="01";
		disablefields(false);
		disableCbsFields(false);
	}else
	{
		if(varTitle!=null)
		{
			document.forms[0].txt_applt_title.value=varTitle;
		}
		if(varConstitution!=null)
		{
			document.forms[0].sel_applt_constitution.value=varConstitution;
		}
		if(varSex!=null)
		{
			document.forms[0].sel_applt_sex.value=varSex;
		}
		if(varMartialStatus!=null)
		{
			document.forms[0].sel_applt_martial_status.value=varMartialStatus;
		}
		if(varStatus!=null)
		{
			document.forms[0].sel_istatus.value=varStatus;
		}
		if(varBorrStatus!=null&&varBorrStatus!="")
		{
			document.forms[0].sel_borr_status.value=varBorrStatus;
		}
		else
		{
			document.forms[0].sel_borr_status.value="0";
		}
		if(varTaxSlab!=null)
		{
			document.forms[0].sel_tax_slab.value=varTaxSlab;
		}
		if(varEmployment!=null&&varEmployment!="")
		{
			document.forms[0].sel_applt_occupation.value=varEmployment;
		}
		else
		{
			document.forms[0].sel_applt_occupation.value="0";
		}
		if(varLineofActivity!=null)
		{
			document.forms[0].sel_applt_loa.value=varLineofActivity;
		}
		if(varBanking!=null&&varBanking!="")
		{
			document.forms[0].sel_banking_with.value=varBanking;
		}
		else
		{
			document.forms[0].sel_banking_with.value="2";
		}
		if(varSalaryRouted!=null&&varSalaryRouted!="")
		{
			document.forms[0].sel_salary_routed.value=varSalaryRouted;
		}
		else
		{
			document.forms[0].sel_salary_routed.value="2";
		}
		if(varStaffRelation!=null&&varStaffRelation!="")
		{
			document.forms[0].sel_relative_bank.value=varStaffRelation;
		}
		else
		{
			document.forms[0].sel_relative_bank.value="0";
		}
		if(varBloodRelation!=null)
		{
			document.forms[0].sel_blood_relation.value=varBloodRelation;
		}
		
		if(varIntroStatus!=null&&varIntroStatus!="")
		{
			document.forms[0].sel_introducer_status.value=varIntroStatus;
		}
		else
		{
			document.forms[0].sel_introducer_status.value="0";
		}
		if(varTradeFinance!=null)
		{
			document.forms[0].sel_trade.value=varTradeFinance;
		}
		if(varInlandTrade!=null)
		{
			document.forms[0].sel_inland.value=varInlandTrade;
		}
		if(varCorpReligion!=null)
		{
			document.forms[0].sel_corp_religion.value=varCorpReligion;
		}
		if(varResidentStatus!=null)
		{
			document.forms[0].sel_resident_status.value=varResidentStatus;
		}
		if(varisStaff!=null&&varisStaff!="")
		{
			document.forms[0].sel_istaff.value=varisStaff;
		}
		else
		{
			document.forms[0].sel_istaff.value="01";
		}
		if(varReligion!=null)
		{
			document.forms[0].sel_religion.value=varReligion;
		}
		if(varCaste!=null)
		{
			document.forms[0].sel_caste.value=varCaste;
		}
		if(varMinority!=null&&varMinority!="")
		{
			document.forms[0].sel_minority.value=varMinority;
		}
		else
		{
			document.forms[0].sel_minority.value="N";
		}
		if(varEduQual!=null)
		{
			document.forms[0].sel_edu_qual.value=varEduQual;
		}
		if(varSeniorCitizen!=null)
		{
			document.forms[0].sel_senior_citizen.value=varSeniorCitizen;
		}
		if(varPhysicallyChgd!=null&&varPhysicallyChgd!="")
		{
			document.forms[0].sel_phy_hycpd.value=varPhysicallyChgd;
		}
		else
		{
			document.forms[0].sel_phy_hycpd.value="N";
		}
		if(varBlind!=null&&varBlind!="")
		{
			document.forms[0].sel_blind.value=varBlind;
		}
		else
		{
			document.forms[0].sel_blind.value="N";
		}
		if(varExService!=null&&varExService!="")
		{
			document.forms[0].sel_ex_servicemen.value=varExService;
		}
		else
		{
			document.forms[0].sel_ex_servicemen.value="N";
		}
		if(varMinor!=null&&varMinor!="")
		{
			document.forms[0].sel_minor.value=varMinor;
		}
		else
		{
			document.forms[0].sel_minor.value="N";
		}
		if(varGaurdianReln!=null)
		{
			document.forms[0].sel_gaurdian_relationship.value=varGaurdianReln;
		}
		if(varSpouseTitle!=null)
		{
			document.forms[0].sel_spouse_title.value=varSpouseTitle;
		}
		if(varSpouseOcc!=null)
		{
			document.forms[0].txt_spouse_occupation.value=varSpouseOcc;
		}
		if(varSpouseQual!=null)
		{
			document.forms[0].sel_spouse_qualification.value=varSpouseQual;
		}
		
		if(varOwnershipType!=null)
		{
			document.forms[0].sel_ownership_type.value=varOwnershipType;
		}
		if(varIndustryType!=null&&varIndustryType!="")
		{
			document.forms[0].sel_industry_type.value=varIndustryType;
		}
		else
		{
			document.forms[0].sel_industry_type.value="0";
		}
		if(varNBFCLoA!=null&&varNBFCLoA!="")
		{
			document.forms[0].sel_loa_nbfc.value=varNBFCLoA;
		}
		else
		{
			document.forms[0].sel_loa_nbfc.value="0";
		}
		if(varNBFCDeposit!=null&&varNBFCDeposit!="")
		{
			document.forms[0].sel_nbfc_deposit.value=varNBFCDeposit;
		}
		else
		{
			document.forms[0].sel_nbfc_deposit.value="0";
		}
		if(varNBFCInfra!=null&&varNBFCInfra!="")
		{
			document.forms[0].sel_nbfc_infrastructure.value=varNBFCInfra;
		}
		else
		{
			document.forms[0].sel_nbfc_infrastructure.value="0";
		}
		if(varNBFCAsset!=null&&varNBFCAsset!="")
		{
			document.forms[0].sel_nbfc_asset.value=varNBFCAsset;
		}
		else
		{
			document.forms[0].sel_nbfc_asset.value="0";
		}
		if(varMFI!=null)
		{
			document.forms[0].sel_mfi.value=varMFI;
		}
		if(varMajority!=null)
		{
			document.forms[0].sel_firm_minority.value=varMajority;
		}
		if(varMajormem!=null)
		{
			document.forms[0].sel_majoritymem.value=varMajormem;
		}
		if(varSHGLoc!=null)
		{
			document.forms[0].sel_shg_location.value=varSHGLoc;
		}
		if(varSHGScheme!=null)
		{
			document.forms[0].sel_shg_promoting_agency.value=varSHGScheme;
		}
		if(varNGOFinance!=null)
		{
			document.forms[0].sel_ngo_finance.value=varNGOFinance;
		}
		if(varSatisfactory!=null)
		{
			document.forms[0].sel_satisfactory_dealing.value=varSatisfactory;
		}
		if(varConstitutionNew!=null)
		{
			document.forms[0].sel_applt_constitutionnew.value=varConstitutionNew;
		}
		if(varIntrotype!="" || varIntrotype!=null)
		{
			document.forms[0].sel_introducer_type.value = varIntrotype;
		}
		else
		{
			document.forms[0].sel_introducer_type.value = "0";
		}
		if(PERAPP_PARTNERSHIP_DET!="")
		{
			document.forms[0].sel_partnership.value = PERAPP_PARTNERSHIP_DET;
		}
		else
		{
			document.forms[0].sel_partnership.value = "S";
		}
		chngePartner('load');
		if(PERAPP_COM_MOAVERIFIED!="")
		{
			document.forms[0].sel_MOA_verified.value = PERAPP_COM_MOAVERIFIED;
		}
		else
		{
			document.forms[0].sel_MOA_verified.value = "S";
		}
		chngeMOAverif('load');
		if(PERAPP_TRUST_REGTYPE!="")
		{
			document.forms[0].sel_trustType.value = PERAPP_TRUST_REGTYPE;
		}
		else
		{
			document.forms[0].sel_trustType.value = "S";
		}
		
		if(varstrlending!="" || varstrlending!=null)
		{
			document.forms[0].sel_lending.value=varstrlending;
		}
		else
		{
			document.forms[0].sel_lending.value="";
		}
		if(PERAPP_CRITERIA_SALES_TURNOVER!=null&&PERAPP_CRITERIA_SALES_TURNOVER!="")
		{
			document.forms[0].sel_sales_turnover.value = PERAPP_CRITERIA_SALES_TURNOVER;
		}
		else
		{
			document.forms[0].sel_sales_turnover.value="0";
		}
		if(varmsmeclassification!=null&&varmsmeclassification!="")
		{
			document.forms[0].sel_msme_classification.value = varmsmeclassification;
		}
		else
		{
			document.forms[0].sel_msme_classification.value="0";
		}
		/*if(varminorityindustry!=null&&varminorityindustry!="")
		{
			document.forms[0].sel_minIndustry.value = varminorityindustry;
		}
		else
		{
			document.forms[0].sel_minIndustry.value="0";
		}*/
		
		//disableControls(false,true,true,true,false);
		callDisable(true);
		disableCbsFields(true);
	}
	/*if(document.forms[0].readFlag.value=="r")
	{
		disableControls(true,true,true,true,false);
		document.forms[0].cmdmodify.disabled=true;
	}
	else
	{
		if(appstatus=="true")
		{
			alert("Cannot Change the Applicant Data, It is used in Approved Applications")
			disableControls(true,true,true,true,false);
			document.forms[0].cmdmodify.disabled=false;
		}
		else
		{
			document.forms[0].cmdmodify.disabled=true;
		}
	}*/
	showCorporate();
	showSpouseDetails();
	showBankingDetails();
	showStaffRelationDetails();
	showisStaffDetails();
	showExServiceMenDetails();
	showGaurdianDetails();
	showSHGDetails();
	showNBFCDetails();
	showMinorityDetails();
	showTradeFinanceDetails();
	showCountry();
	showSalaryRouted();
	disablelineofAction();
	showJusificationDetails();
	showFamilyIncome();
	showPhotos();
	showcbsidfield();
	 var varappconstitution=document.forms[0].sel_applt_constitutionnew.value;
		
	if((parseFloat(varappconstitution) >=183) && (parseFloat(varappconstitution) <=191))
	{
		document.all.TL1.style.visibility="visible";
		document.all.TL1.style.position="relative";
		document.all.TL2.style.visibility="visible";
		document.all.TL2.style.position="relative";
	}
	else
	{
		document.all.TL1.style.visibility="hidden";
		document.all.TL1.style.position="absolute";
		document.all.TL2.style.visibility="hidden";
		document.all.TL2.style.position="absolute";
	}
	if(bankarrage!="")
	{
		document.forms[0].sel_bankarrange.value = bankarrage;
	}
	else
	{
		document.forms[0].sel_bankarrange.value = "0";
	}
	if(banksector!="")
	{
		document.forms[0].sel_sector.value = banksector;
	}
	else
	{
		document.forms[0].sel_sector.value = "0";
	}
	if(selGSTIN!="")
	{
		document.forms[0].txt_GSTIN_reg.value = selGSTIN;
	}
	else
	{
		document.forms[0].txt_GSTIN_reg.value = "S";
	}
	funenableTypeofliab();
	showdirectorlabel();
	Totalvalue();	
	
	if(!(document.forms[0].sel_relative_bank.value=="001" || document.forms[0].sel_relative_bank.value=="005" || document.forms[0].sel_relative_bank.value=="006"))
	{
		if(varRelationName!="")
		{
			document.forms[0].txt_staff_name1.value = varRelationName;
		}
		else
		{
			document.forms[0].txt_staff_name1.value = "";
		}
	}
	if(parseFloat(varappconstitution)!=01 &&(!((parseFloat(varappconstitution) >=183) && (parseFloat(varappconstitution) <=191))))
	{
		
		document.all.Con1.style.visibility="visible";
		document.all.Con1.style.position="relative";
		document.all.Con2.style.visibility="visible";
		document.all.Con2.style.position="relative";
		
		if(varHeldWomen!="")
		{
			document.forms[0].sel_heldwomen.value = varHeldWomen;
		}
		else
		{
			document.forms[0].sel_heldwomen.value = "S";
		}
	}
	else
	{
		document.all.Con1.style.visibility="hidden";
		document.all.Con1.style.position="absolute";
		document.all.Con2.style.visibility="hidden";
		document.all.Con2.style.position="absolute";	
	
	}
	document.getElementById("const_partnership").style.display="none";
	document.getElementById("const_company").style.display="none";
	document.getElementById("const_huf").style.display="none";
	document.getElementById("const_assetslist").style.display="none";

	if(Staticdata_constitution=="P")
	{
		document.getElementById("const_partnership").style.display="table-row";
	}
	else if(Staticdata_constitution=="C")
	{
		document.getElementById("const_company").style.display="table-cell";
		document.getElementById("const_assetslist").style.display="table-row";
	}
	else if(Staticdata_constitution=="T")
	{
		document.getElementById("const_huf").style.display="tabl-row";
	}
	callGSTINChange();
	
}

function showcbsidfield()
{	
	if(document.forms[0].sel_introducer_type.value=="1")
	{
		document.getElementById("staff").style.display="table-row";
		document.getElementById("cbsid").style.display="none";
		document.forms[0].txt_introcbs_id.value="";
	}
	else if(document.forms[0].sel_introducer_type.value=="2")
	{
		document.getElementById("staff").style.display="none";
		document.getElementById("cbsid").style.display="table-row";
		document.forms[0].txt_introstaff_id.value="";
	}	
	else if(document.forms[0].sel_introducer_type.value=="3")
	{
		document.getElementById("staff").style.display="none";
		document.getElementById("cbsid").style.display="none";	
		document.forms[0].txt_introstaff_id.value="";
		document.forms[0].txt_introcbs_id.value="";
	}	
}

function showPhotos()
{
	if(imageEnable=='Y' || imageEnable=='y')
	{
		document.all.id_photo.style.display="table";
	}
	else
	{
		document.all.id_photo.style.display="none";
	}
}
function callDisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=one;
		  	if(document.forms[0].elements[i].name.indexOf("txt_laps_app_id")!=-1)
			{
				document.forms[0].elements[i].readOnly=true;
			}
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one" || document.forms[0].elements[i].type=="radio")
		document.forms[0].elements[i].disabled=one;
	}
}
/*function disableControls(bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}*/
function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=='checkbox')
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
	document.forms[0].txt_laps_app_id.readOnly=true;
	document.forms[0].txt_applt_org.readOnly=true;
	document.forms[0].txt_relat_staff_id.readOnly=true;
}
function callCalender(name)
{
/*if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,name);
	}*/
}
function callCalender1(name)
{
/*if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,name);
	}*/
}
function checkpanno(field)
{
	var panvaluetemp=field.value;
	var panvalue=panvaluetemp.toUpperCase();
	field.value=panvalue;
	var regExp = /^[A-Z]$/;	
	var regExpnum = /^[0-9]$/;	

	if(panvalue!="")
	{
		if(panvalue.length==5 && panvalue=="NOPAN")
		{
			return;
		}
		else if(panvalue.length!=10)
		{
			alert('Enter NOPAN, if PANNO not available or else enter correct PANNO');
			field.value="";
			field.focus();
			return;
		}
		
		else
		{
			for(var si=0;si<5;si++)
			{
				if (!panvalue.charAt(si).match(regExp))
				{
					alert('FIRST FIVE Characters should be ALPHABETS');
					field.value="";
					field.focus();
					break;
				}
				
			}
			for(var si=5;si<9;si++)
			{
				if (!panvalue.charAt(si).match(regExpnum))
				{
					alert('SIXTH TO NINTH CHARACTER MUST BE NUMBER');
					field.value="";
					field.focus();
					break;
				}
			}
			
			if(panvalue.length==10 && !(panvalue.charAt(9).match(regExp)))
			{
				alert('LAST character must be ALPHABET');
				field.value="";
				field.focus();
				return;
			}
	    	if(panvalue.length >= 5 && panvalue.substring(0,5)=='NOPAN')
			{
			  alert('Enter NOPAN only');
			  field.value="";
			  field.focus();
			  return;
			}
		}
	}
}

function showPhoto()
{
	var varperapp_id = document.forms[0].txt_laps_app_id.value;
	//document.all.idfrm1.src = appURL+"action/createfile.jsp?txtperapp_id="+varperapp_id+"&hidBeanGetMethod=getCreateFile";
}
function getPhoto()
{
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
	    var varCustomerId = document.forms[0].hidDemoId.value;
	    var hidType = "photo";
	    if(varCustomerId!="")
	    {
			var hid_comappid1= document.forms[0].hid_comappid1.value;
			var purl = appURL+"action/ifrmapplicantphoto.jsp?&hidApplicantId="+varCustomerId+"&hidType="+hidType;
		    var prop = 'scrollbars=no,width=300,height=250,menubar=no';	
			var xpos = (screen.width - 800) / 2;
			var ypos = (screen.height - 800) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,'AttachPhoto',prop);
		}
		else
		{
			alert("Please Create the customer");
		}
	}	
}
function callDescHelp(page)
{	
	/*if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}*/
}
function doNRIDetails()
{
	var hid_comappid1= document.forms[0].hid_comappid1.value;
	var purl = appURL+"action/nridetails.jsp?hidBeanGetMethod=getnriData&hidBeanId=refdetails&hid_comappid1="+hid_comappid1;
	var prop = 'scrollbars=yes,width=800,height=500';	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function doPartners()
{
	var hid_comappid2= document.forms[0].hid_comappid2.value;
	var purl = appURL+"action/perdirectors.jsp?hidBeanId=refdetails&hidBeanGetMethod=getPartnerDetailsData&hid_comappid2="+hid_comappid2+"&hidapp_name="+document.forms[0].txt_applt_fullname.value;
	var prop = 'scrollbars=yes,width=850,height=525';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 1000) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function doReferences()
{
	var hid_comappid1= document.forms[0].hid_comappid1.value;
	var purl = appURL+"action/perreferences.jsp?hidBeanGetMethod= getrefData&hidBeanId=refdetails&hid_comappid1="+hid_comappid1+"&hidapp_name="+document.forms[0].txt_applt_fullname.value;
	var prop = 'scrollbars=no,width=800,height=400,menubar=yes';	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function openGroup()
{
	/*if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=450,height=300,top=100,left=250";
		var url="/laps/action/grouphelp.jsp";
		window.open(url,"grouphelp",prop);
	}*/
}
function callRelationship()
{
	var varQryString = appURL+"action/perrelationship.jsp?hidBeanGetMethod=getreldetails&hidBeanId=commappmaster&comapp_id="+document.forms[0].hid_comappid1.value;
	var title = "RelationshipDetails";
	var prop = "scrollbars=yes,width=900,height=550,menubar=no";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);		
}
function disableCbsFields(boolval)
{
	document.forms[0].txt_applt_title.disabled=boolval;
	document.forms[0].txt_applt_fullname.readOnly=boolval;
	document.forms[0].txt_applt_shortname.readOnly=boolval;
	document.forms[0].txt_applt_fatname.readOnly=boolval;
	document.forms[0].sel_applt_constitutionnew.disabled=boolval;
	document.forms[0].txt_applt_panno.readOnly=boolval;
	document.forms[0].sel_applt_sex.disabled=boolval;
	document.forms[0].txt_applt_dob.readOnly=boolval;
	document.forms[0].sel_applt_martial_status.disabled=boolval;
	document.forms[0].sel_istatus.disabled=boolval;
	document.forms[0].sel_tax_slab.disabled=boolval;
	document.forms[0].txt_introducer_name.readOnly=boolval;
	document.forms[0].sel_introducer_status.disabled=boolval;
	document.forms[0].sel_trade.disabled=boolval;
	document.forms[0].sel_inland.disabled=boolval;
	document.forms[0].sel_resident_status.disabled=boolval;
	document.forms[0].txt_country.readOnly=boolval;
	document.forms[0].sel_istaff.disabled=boolval;
	document.forms[0].txt_staff_id.readOnly=boolval;
	document.forms[0].sel_religion.disabled=boolval;
	document.forms[0].sel_caste.disabled=boolval;
	document.forms[0].sel_edu_qual.disabled=boolval;
	document.forms[0].sel_minor.disabled=boolval;
	var varIsminor=document.forms[0].sel_minor.value;
	if(varIsminor=="Y")
	{
		document.forms[0].txt_guardian_name.readOnly=boolval;
		document.forms[0].txt_gaurdian_addr.readOnly=boolval;
		document.forms[0].sel_gaurdian_relationship.disabled=boolval;
	}

	document.forms[0].txt_spouse_name.readOnly=boolval;
	document.forms[0].txt_spouse_occupation.disabled=boolval;
	document.forms[0].sel_spouse_qualification.disabled=boolval;
	document.forms[0].txtar_spouse_addr.readOnly=boolval;
}
function disablelineofAction()
{
	/*if(document.forms[0].sel_applt_occupation.value=="0" || document.forms[0].sel_applt_occupation.value==""||
			document.forms[0].sel_applt_occupation.value=="1" || document.forms[0].sel_applt_occupation.value=="9")
	{*/
		document.all.id_line_of_activity.style.visibility="hidden";
		document.all.id_line_of_activity1.style.visibility="hidden";
		document.all.id_since.style.visibility="hidden";
	/*}
	else
	{
		document.all.id_line_of_activity.style.visibility="visible";
		document.all.id_line_of_activity.style.position="relative";
		document.all.id_line_of_activity1.style.visibility="visible";
		document.all.id_line_of_activity1.style.position="relative";
		document.all.id_since.style.visibility="visible";
		document.all.id_since.style.position="relative";


	}*/
}
function showFatherName(val)
{
	if(val=="01"||val=="02")
	{
		document.all.id_fatherlbl.style.display="table-cell";
		document.all.id_fathertxt.style.display="table-cell";
	}
	else
	{
		document.all.id_fatherlbl.style.display="none";
		document.all.id_fathertxt.style.display="none";
	}
}
function showJusificationDetails(){
	
	if(document.forms[0].sel_banking_with.value=="1" && document.forms[0].sel_satisfactory_dealing.value=="N")
	{
	document.all.justdetails.style.visibility="visible";
	document.all.justdetails.style.position="relative";
	document.all.justdetails1.style.visibility="visible";
	document.all.justdetails1.style.position="relative";

	}else{
		document.all.justdetails.style.visibility="hidden";
		document.all.justdetails.style.position="absolute";
		document.all.justdetails1.style.visibility="hidden";
		document.all.justdetails1.style.position="absolute";
	}

}
function showFamilyIncome(){

	if(eval(document.forms[0].txt_earning_member.value)>=1 && document.forms[0].sel_applt_constitutionnew.value=="01")
	{
	document.all.fmlyincome.style.visibility="visible";
	document.all.fmlyincome.style.position="relative";
	document.all.fmlyincome1.style.visibility="visible";
	document.all.fmlyincome1.style.position="relative";

	}else{
		document.all.fmlyincome.style.visibility="hidden";
		document.all.fmlyincome.style.position="absolute";
		document.all.fmlyincome1.style.visibility="hidden";
		document.all.fmlyincome1.style.position="absolute";
	}
}
function disableRelativeName()
{
	if(document.forms[0].sel_relative_bank.value=="005"||
			document.forms[0].sel_relative_bank.value=="006")
	{
		document.forms[0].txt_staff_name.readOnly=true;
	}
	else
	{
		document.forms[0].txt_staff_name.readOnly=false;
	}
}
function checkBorrowerSince(obj)
{
	
}
function funenableTypeofliab()
{
	if(document.forms[0].sel_ownership_type.value == "004")
	{
		document.all.typeofliab1.style.display="table-cell";
		document.all.typeofliab2.style.display="table-cell";
	}else{
		document.all.typeofliab1.style.display="none";
		document.all.typeofliab2.style.display="none";
	}
}
function showdirectorlabel()
{
	var rel_val = document.forms[0].sel_relative_bank.value;
	
	if(rel_val == "002" || rel_val == "003" || rel_val == "004")
	{
		document.all.direc1.innerHTML = "Name of Bank's Director";
		document.all.direc2.innerHTML = "Relation to the borrower";
		document.forms[0].txt_relat_staff_id.value="";
	}
	else
	{
		document.all.direc1.innerHTML = "Name";
		document.all.direc2.innerHTML = "Relation to the borrower";
	}
	
	if(rel_val == "002" || rel_val == "003" || rel_val == "004")
	{
		document.all.direc_master.style.display = "table-cell";
		document.all.direc_name.style.display = "none";
	}
	else
	{
		document.all.direc_master.style.display = "none";
		document.all.direc_name.style.display = "table-cell";
	}
}

function chngePartner(val)
{
	if(document.forms[0].sel_partnership.value=="R")
	{
		document.all.id_part_regno1.style.visibility="visible";
		document.all.id_part_regno2.style.visibility="visible";
		if(val=='valchange')
			document.forms[0].txt_regno.value="";
	}
	else
	{
		document.all.id_part_regno1.style.visibility="hidden";
		document.all.id_part_regno2.style.visibility="hidden";
		if(val=='valchange')
			document.forms[0].txt_regno.value="";
	}
}


function chngeMOAverif(val)
{
	
	if(document.forms[0].sel_MOA_verified.value=="N")
	{
		document.all.id_amendedMOA1.style.visibility="visible";
		document.all.id_amendedMOA2.style.visibility="visible";
		if(val=='valchange')
			document.forms[0].amendedMOA_comments.value="";
	}
	else
	{
		document.all.id_amendedMOA1.style.visibility="hidden";
		document.all.id_amendedMOA2.style.visibility="hidden";
		if(val=='valchange')
			document.forms[0].amendedMOA_comments.value="";
	}
	
}


function callCalender_mul(name,rowindex) 
{
	alert(rowindex);
	if(rowindex=="0")
	{
		var tab  = document.getElementById("tabid_assetslist");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
		else
		{
			name=name+"["+(rowindex)+"]";
			if (document.forms[0].cmdsave.disabled == false) 
			{

				showCal(appURL, name);
			}
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
		}
	}
}

function Addvaluer()
{
	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_assetslist");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.childNodes[j].disabled=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
}
}

function deleteRow(tableid)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var table=document.getElementById(tableid);
		var rowCount=table.rows.length; 
		
		if(rowCount==1){
	       alert("Atleast one data is needed");
	       return;
		}
		else{
			 table.deleteRow(rowCount-1);
		}
	}
}

function callGSTINChange()
{
	
	if(document.forms[0].txt_GSTIN_reg.value =="Y"){
	   document.all.GSTIN_name.style.display="table-cell";
	   document.all.GSTIN_name1.style.display="table-cell";
	   
		
	}else{
		 document.all.GSTIN_name1.style.display="none";
	     document.all.GSTIN_name.style.display="none";
	     clrGSTINTab();
	}
	
}
function clrGSTINTab(){
	 var tab  = document.getElementById("idGSTName");
		var rowsLength = tab.rows.length;
		if(rowsLength>1){
			for(var i=1;i<rowsLength;i++){
				document.forms[0].chks[i].checked=true;
			}
			deleteRow1("idGSTName",'0');
		}
		document.forms[0].txt_GstIn.value='';
}
function Totalvalue()
{
	
	var a="";
	if(varGSTIN!="")
	{
		var temp= varGSTIN.split("@");
		var valuerlen=temp.length;
		for(var i=0;i<valuerlen;i++)
		{
			 Addvaluer1();
			 if(temp[i]==undefined){temp[i]="";}
			 if(valuerlen==1)
			 {
				 document.forms[0].txt_GstIn[i].value=temp[i];
		    	 
			 }else
			 {
				 document.forms[0].txt_GstIn[i].value=temp[i];
		    }
		 }
	}
	
	else
	{
		 Addvaluer1();
	}
deleteRow("idGSTName");
}
function Addvaluer1(){

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("idGSTName");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.childNodes[j].readOnly=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
}
}