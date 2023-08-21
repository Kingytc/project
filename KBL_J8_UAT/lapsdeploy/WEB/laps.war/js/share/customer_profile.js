function showCorporate()
{
	if(document.forms[0].sel_applt_constitutionnew.value=="01")
	{
		document.all.fmlyincome.style.display="table-cell";
		document.all.fmlyincome1.style.display="table-cell";
	}
	else
	{
		document.all.fmlyincome.style.display="none";
		document.all.fmlyincome1.style.display="none";
		document.forms[0].txt_familyincome.value="";
	}
	
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
		document.forms[0].txt_borr_since.value="";
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
		document.forms[0].txt_staff_name.value="";
		document.forms[0].sel_blood_relation.value="0";
		document.forms[0].txt_relat_staff_id.value="";
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
		   /* document.forms[0].txt_staff_name.value="";
			document.forms[0].sel_blood_relation.value="0";
			document.forms[0].txt_relat_staff_id.value="";	*/		
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
		document.forms[0].txt_yrs_service.value="";
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
		document.forms[0].sel_nbfc_deposit.value="0";
		document.forms[0].sel_nbfc_infrastructure.value="0";
		document.forms[0].sel_nbfc_asset.value="0";
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
		document.forms[0].sel_corp_religion.value="0";
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
function doModify()
{
	showProgress('imgloading');
	document.body.scroll="no";
	document.forms[0].cmdmodify.disabled=true;	
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="renewApplicantData";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/mastersearchper.jsp";
	//"?hidBeanId=mastapplicant&hidBeanGetMethod=getDemographics&cbsdata=true";
	document.forms[0].submit();
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
		disableControls(true,false,true,true,false);
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
			document.forms[0].sel_minority.value="0";
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
		if(PERAPP_CRITERIA_SALES_TURNOVER!=null&&PERAPP_CRITERIA_SALES_TURNOVER!="")
		{
			document.forms[0].sel_sales_turnover.value = PERAPP_CRITERIA_SALES_TURNOVER;
		}
		if(varmsmeclassification!=null&&varmsmeclassification!="")
		{
			document.forms[0].sel_msme_classification.value = varmsmeclassification;
		}
		//if(varminorityindustry!=null&&varminorityindustry!="")
		//{
		//	document.forms[0].sel_minIndustry.value = varminorityindustry;
		//}
		//else
		//{
		//	document.forms[0].sel_minIndustry.value="0";
		//}
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
		disableControls(false,true,true,true,false);
		callDisable(true);
		disableCbsFields(true);
	}
	
	document.forms[0].cmdedit.disabled=true;
	Totalvalue();	
	document.forms[0].cmdedit.disabled=false;
	if(document.forms[0].readFlag.value=="r")
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
	}
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
	if(selGST_EXEMPTED=="Y")
	{
		
		document.forms[0].txt_GSTIN_Exempted.value = selGST_EXEMPTED;
	}
	else if(selGST_EXEMPTED=="N")
	{
		
		document.forms[0].txt_GSTIN_Exempted.value = selGST_EXEMPTED;
	}
	else
	{
		
		document.forms[0].txt_GSTIN_Exempted.value = "S";
	}
	funenableTypeofliab();
	showdirectorlabel();
	
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
	if(parseFloat(varappconstitution)!=01)
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
		document.getElementById("const_huf").style.display="table-row";
	}
	callGSTINChange();
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
	document.forms[0].txt_restructdate.readOnly=true;
}
function disableControls(bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
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
	document.forms[0].txt_restructdate.readOnly=true;
	document.forms[0].txt_laps_app_id.readOnly=true;
	document.forms[0].txt_applt_org.readOnly=true;
	document.forms[0].txt_relat_staff_id.readOnly=true;
}
function callCalender(name)
{
	/*
	 * Date of birth field comes from Finacle and this should not be editable in laps
	 */
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varCBSCode=document.forms[0].txt_cbs_id.value;
		if(varCBSCode=="")
		{
			showCal(appURL,name);
		}
		else
		{
			if(name !="txt_applt_dob")
			{
				showCal(appURL,name);
			}
			else
			{
				//No function
			}
		}
		
	}
}
function callCalender1(name)
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,name);
	}
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
function doEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].txt_laps_app_id.readOnly=true;
	document.forms[0].txt_cbs_id.readOnly=true;
	document.forms[0].txt_applt_org.readOnly=true;
	//document.forms[0].txt_industry_bsr_code.readOnly=true;
	document.forms[0].txt_group.readOnly=true;
	document.forms[0].txt_cin_number.readOnly=true;
	document.forms[0].txt_entity_id.readOnly=true;
	document.forms[0].txt_issue_date.readOnly=true;
	document.forms[0].txt_expirey_date.readOnly=true;
	document.forms[0].txt_applt_title.focus();
	var varCBSCode=document.forms[0].txt_cbs_id.value;
	if(varCBSCode=="")
	{
		disableCbsFields(false);
	}
	else
	{
		disableCbsFields(true);
	}
	disableRelativeName();
}
function doSave()
{
	if(document.forms[0].txt_udyam_regno.value!="")
	{

		if(document.forms[0].txt_certificate_date.value=="")
		{
		alert("Please Enter Udyam Certification Date");
		return false;
		}
		if(document.forms[0].sel_msme_classification.value=="0")
		{
			alert("Please Select MSME Classification as per Udyam Registration Certificate");	
			return false;
		}
		var udyamchar = document.forms[0].txt_udyam_regno.value;
		var capudyamchar=udyamchar.toUpperCase();
		if(capudyamchar.length==19)
		{
		for (var i = 0; i < capudyamchar.length; i++) {
			
			  if(capudyamchar.charAt(0)!='U')
			  {
				 alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				 return false;		 
			  }
			  if(capudyamchar.charAt(1)!='D')
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
				 
			  }
			  if(capudyamchar.charAt(2)!='Y')
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
				 
			  }
			  if(capudyamchar.charAt(3)!='A')
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
				 
			  }
			  if(capudyamchar.charAt(4)!='M')
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
				 
			  }
			  if(capudyamchar.charAt(5)!='-')
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
				 
			  }
			  if(capudyamchar.charAt(6))
			  {
				  var code = capudyamchar.charCodeAt(6);
				  if(!(code>=65 && code<=90))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(7))
			  {
				  var code = capudyamchar.charCodeAt(7);
				  if(!(code>=65 && code<=90))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(8)!='-')
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
				 
			  }
			  if(capudyamchar.charAt(9))
			  {
				 var code = capudyamchar.charCodeAt(9);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(10))
			  {
				  var code = capudyamchar.charCodeAt(10);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(11)!='-')
			  {
				  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
				 
			  }
			  if(capudyamchar.charAt(12))
			  {
				 var code = capudyamchar.charCodeAt(12);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(13))
			  {
				var code = capudyamchar.charCodeAt(13);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(14))
			  {
				var code = capudyamchar.charCodeAt(14);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(15))
			  {
				 var code = capudyamchar.charCodeAt(15);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(16))
			  {
				var code = capudyamchar.charCodeAt(16);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(17))
			  {
				var code = capudyamchar.charCodeAt(17);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			  if(capudyamchar.charAt(18))
			  {
				 var code = capudyamchar.charCodeAt(18);
				  if(!(code>=48 && code<=57))
				  {
					  alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
				  }
			  }
			 
			  
			  
				  
			  
				  
			}
		}
		else
		{
			alert("Kindly enter valid Udyam Registraction Certificate Number in Customer Profile - Demographics Tab - 'UDYAM-XX-00-0000000' X represents Alphabets and 0 represents Numeric Character.");
			return false;
		}
		
	}
	
	
	if(document.forms[0].sel_relative_bank.value=="0"|| document.forms[0].sel_relative_bank.value=="")
	{
		document.forms[0].sel_relative_bank.focus();
		ShowAlert("111","Any Relation to");
		return false;
	}
	if(document.forms[0].sel_relative_bank.value!="001" && document.forms[0].sel_relative_bank.value!="0")
	{
		if(document.forms[0].sel_blood_relation.value=="0"|| document.forms[0].sel_blood_relation.value=="")
		{
		document.forms[0].sel_blood_relation.focus();
		ShowAlert("111","relation to the borrower");
		return false;
		}
	}
	if(document.forms[0].txt_applt_title.value=="0")
	{
		document.forms[0].txt_applt_title.focus();
		ShowAlert("111","Title");
		return false;
	}
	if(trim(document.forms[0].txt_applt_fullname.value)=="")
	{
		document.forms[0].txt_applt_fullname.focus();
		ShowAlert("121","Full Name");
		return false;
	}
	if(trim(document.forms[0].txt_applt_shortname.value)=="")
	{
		document.forms[0].txt_applt_shortname.focus();
		ShowAlert("121","Short Name");
		return false;
	}
	if(document.forms[0].sel_applt_constitutionnew.value=="0")
	{
		document.forms[0].sel_applt_constitutionnew.focus();
		ShowAlert("111","Constitution");
		return false;
	}
	if(document.forms[0].txt_applt_panno.value=="")
	{
		document.forms[0].txt_applt_panno.focus();
		ShowAlert("121","PAN No.");
		return false;
	}
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
		if(document.forms[0].sel_applt_sex.value=="0")
		{
			document.forms[0].sel_applt_sex.focus();
			ShowAlert("111","Gender");
			return false;
		}
		if(document.forms[0].sel_minority.value==""||document.forms[0].sel_minority.value=="0")
		{
			document.forms[0].sel_minority.focus();
			ShowAlert("111","Minority");
			return false;
		}
	}
	else 
	{
		if(document.forms[0].txt_buss_commencement_date.value=="")
		{
			document.forms[0].txt_buss_commencement_date.focus();
			ShowAlert("121","Commencement Date of Business");
			return false;
		}
		if(document.forms[0].sel_firm_minority.value=="0"||document.forms[0].sel_firm_minority.value=="")
		{
			document.forms[0].sel_firm_minority.focus();
			ShowAlert("111","Whether majority of members/owners belong to minority community");
			return false;
		}
		
	}
	if(document.forms[0].sel_applt_constitution.value=="14")
	{
		if(document.forms[0].sel_lending.value=="")
		{
			document.forms[0].sel_lending.focus();
			ShowAlert("111","Type of Lending");
			return false;
		}
	}
	if(document.forms[0].txt_applt_dob.value=="")
	{
		document.forms[0].txt_applt_dob.focus();
		if(document.forms[0].sel_applt_constitution.value=="01")
			ShowAlert("121","Date of Birth");
		else
			ShowAlert("121","Date of Establishment");
		return false;
	}
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
		if(document.forms[0].sel_applt_martial_status.value=="0")
		{
			document.forms[0].sel_applt_martial_status.focus();
			ShowAlert("111","Marital Status");
			return false;
		}
	}
	if(document.forms[0].sel_istatus.value=="0")
	{
		document.forms[0].sel_istatus.focus();
		ShowAlert("111","Status");
		return false;
	}
	if(document.forms[0].sel_borr_status.value=="0" ||
			document.forms[0].sel_borr_status.value=="")
	{
		document.forms[0].sel_borr_status.focus();
		ShowAlert("111","Borrower Status");
		return false;
	}
	if(document.forms[0].txt_applt_org.value=="")
	{
		document.forms[0].txt_applt_org.focus();
		ShowAlert("111","Application Recd. from");
		return false;
	}
	if(document.forms[0].sel_tax_slab.value=="0")
	{
		document.forms[0].sel_tax_slab.focus();
		ShowAlert("111","Tax Slab");
		return false;
	}
	if(document.forms[0].sel_applt_occupation.value=="0"||
			document.forms[0].sel_applt_occupation.value=="")
	{
		document.forms[0].sel_applt_occupation.focus();
		ShowAlert("111","Employment Status");
		return false;
	}
	else
	{
		document.forms[0].sel_applt_loa.value="0";
	}
	
	
	if(document.forms[0].sel_banking_with.value=="0"||
			document.forms[0].sel_banking_with.value=="")
	{
		document.forms[0].sel_banking_with.focus();
		ShowAlert("111","Banking with us");
		return false;
	}
	if(document.forms[0].sel_banking_with.value=="1")
	{
	if(document.forms[0].txt_borr_since.value=="")
	{
		document.forms[0].txt_borr_since.focus();
		ShowAlert("121","Borrower Since");
		return false;
	}
	if(document.forms[0].sel_satisfactory_dealing.value=="0"||
			document.forms[0].sel_satisfactory_dealing.value=="")
	{
		document.forms[0].sel_satisfactory_dealing.focus();
		ShowAlert("111","Satisfactory Dealing");
		return false;
	}
	
	if(document.forms[0].sel_relative_bank.value=="0"|| document.forms[0].sel_relative_bank.value=="")
	{
		document.forms[0].sel_relative_bank.focus();
		ShowAlert("111","Any Relation to");
		return false;
	}
	if(document.forms[0].txt_networth.value!="0" || document.forms[0].txt_networth.value!="")
	{
		if(document.forms[0].txt_networthdate.value=="")
		{
			document.forms[0].txt_networthdate.focus();
			ShowAlert("121","As on Date");
			return false;
		}
	}
	
	if(document.forms[0].sel_satisfactory_dealing.value=="N"){
	if(document.forms[0].txt_justComment.value=="")
	{
		document.forms[0].txt_justComment.focus();
		ShowAlert("121","Justification Dealing");
		return false;
	}
	
	}
	}
	if(document.forms[0].sel_relative_bank.value!="001" &&	document.forms[0].sel_relative_bank.value!="0")
	{
		if(document.forms[0].sel_relative_bank.value=="005" || document.forms[0].sel_relative_bank.value=="006")
		{
			if(trim(document.forms[0].txt_staff_name.value)=="")
			{
				document.forms[0].txt_staff_name.focus();
				ShowAlert("121","the Staff Name");
				return false;
			}
		}
		else
		{
			if(trim(document.forms[0].txt_staff_name1.value)=="")
			{
				document.forms[0].txt_staff_name1.focus();
				ShowAlert("111","the Executive Name");
				return false;
			}
		}
	}
	if(!(document.forms[0].sel_introducer_status.value=="0" || document.forms[0].sel_introducer_status.value=="0"))
	{
		if(document.forms[0].sel_introducer_type.value=="0" ||document.forms[0].sel_introducer_type.value=="")
		{
			document.forms[0].sel_introducer_type.focus();
			ShowAlert("111","Introducer type");
			return false;
		}	
		if(document.forms[0].sel_introducer_type.value=="1")
		{
			if(document.forms[0].txt_introstaff_id.value=="")
			{
				document.forms[0].txt_introstaff_id.focus();
				ShowAlert("111","Introducer staff ID");
				return false;
			}
		}
		
		if(document.forms[0].sel_introducer_type.value=="2")
		{
			if(document.forms[0].txt_introcbs_id.value=="")
			{
				document.forms[0].txt_introcbs_id.focus();
				ShowAlert("111","Introducer CBS ID");
				return false;
			}
		}
	}
	if(document.forms[0].sel_applt_constitution.value=="01")
	{
	if(document.forms[0].sel_resident_status.value=="0")
	{
		document.forms[0].sel_resident_status.focus();
		ShowAlert("111","Resident Status");
		return false;
	}
	if(document.forms[0].sel_istaff.value=="02")
	{
		
		if(document.forms[0].txt_staff_id.value=="")
		{
			document.forms[0].txt_staff_id.focus();
			ShowAlert("121","Staff ID");
			return false;
		}
	}
	if(document.forms[0].sel_religion.value=="0")
	{
		document.forms[0].sel_religion.focus();
		ShowAlert("111","Religion");
		return false;
	}
	if(document.forms[0].sel_caste.value=="0")
	{
		document.forms[0].sel_caste.focus();
		ShowAlert("111","Caste/Tribe");
		return false;
	}
	if(document.forms[0].txt_dep_children.value=="" &&
		document.forms[0].txt_dep_others.value=="")
	{
		document.forms[0].txt_dep_children.focus();
		ShowAlert("121","No. of Dependents");
		return false;
	}
	if(document.forms[0].txt_earning_member.value=="")
	{
		document.forms[0].txt_earning_member.focus();
		ShowAlert("121","Earning Member in family");
		return false;
	}
	if(eval(document.forms[0].txt_earning_member.value)>=1 && document.forms[0].sel_applt_constitutionnew.value=="01")
	{
		if(document.forms[0].txt_familyincome.value =="0.00" || document.forms[0].txt_familyincome.value =="" || document.forms[0].txt_familyincome.value =="0")
		{
			document.forms[0].txt_familyincome.focus();
			ShowAlert("121","Annual Family Income");
			return false;
		}
	}
	if(document.forms[0].txt_earning_member.value=="" || document.forms[0].txt_earning_member.value=="0")
	{
		document.forms[0].txt_familyincome.value="0.00" ;
	}
	
	if(document.forms[0].sel_edu_qual.value=="0")
	{
		document.forms[0].sel_edu_qual.focus();
		ShowAlert("111","Education Qualification");
		return false;
	}
	if(document.forms[0].sel_ex_servicemen.value=="Y")
	{
		if(document.forms[0].txt_yrs_service.value=="")
		{
			document.forms[0].txt_yrs_service.focus();
			ShowAlert("121","Years of Service");
			return false;
		}
	}
	if(document.forms[0].sel_minor.value=="Y")
	{
		if(document.forms[0].txt_guardian_cbsid.value=="")
		{
			document.forms[0].txt_guardian_cbsid.focus();
			ShowAlert("121","Guardian CBS ID");
			return false;
		}
		if(document.forms[0].txt_guardian_name.value=="")
		{
			document.forms[0].txt_guardian_name.focus();
			ShowAlert("121","Guardian Name");
			return false;
		}	
		
		if(document.forms[0].sel_gaurdian_relationship.value=="" && document.forms[0].txt_cbs_id.value=="")
		{
			document.forms[0].sel_gaurdian_relationship.focus();
			ShowAlert("121","Guardian Relationship");
			return false;
		}
		if(document.forms[0].txt_gaurdian_addr.value=="")
		{
			document.forms[0].txt_gaurdian_addr.focus();
			ShowAlert("121","Guardian Address");
			return false;
		}
	}
} else {
		
		if(document.forms[0].sel_applt_constitution.value=="023" ||
				document.forms[0].sel_applt_constitution.value=="024" ||
				document.forms[0].sel_applt_constitution.value=="025")
		{
			if(document.forms[0].sel_shg_location.value=="0")
			{
				document.forms[0].sel_shg_location.focus();
				ShowAlert("111","SHG Formed/Located at");
				return false;
			}
		}
}
	if(parseFloat(document.forms[0].sel_applt_constitutionnew.value)!=01)
	{
		if(document.forms[0].sel_heldwomen.value=="S")
		{
			ShowAlert("111","Whether majority of shareholding & controlling stake held by women");
			document.forms[0].sel_heldwomen.focus();
			return;
		}
		
	}
	var hid_consttype=document.forms[0].hid_consttype.value;
	if(hid_consttype=="P")
	{
		if(document.forms[0].sel_partnership.value=="S")
		{
			ShowAlert("111","Partnership Details");
			document.forms[0].sel_partnership.focus();
			return;
		}
		if(document.forms[0].txt_part_deeddate.value=="")
		{
			ShowAlert("121","latest Partnership Deed Date");
			document.forms[0].txt_part_deeddate.focus();
			return;
		}
		if(document.forms[0].sel_partnership.value=="R")
		{
			if(document.forms[0].txt_regno.value=="")
			{
				ShowAlert("121","Registration No");
				document.forms[0].txt_regno.focus();
				return;
			}
		}
	}
	
	
	if(parseFloat(document.forms[0].sel_applt_constitutionnew.value)!=01)
	{
		if(document.forms[0].sel_majoritymem.value=="0" || document.forms[0].sel_majoritymem.value=="")
		{
			ShowAlert("111","Whether majority of members belongs to SC/ST");
			document.forms[0].sel_majoritymem.focus();
			return;
		}
	}	
	var panNo=document.forms[0].txt_applt_panno.value;
	if(panNo!=""){
	 var pan4 = panNo.substring(3, 4);
	 if(pan4=="C"){
	   if(document.forms[0].txt_cin_number.value=="" )
		{
			ShowAlert("121","CIN number");
			document.forms[0].txt_cin_number.focus();
			return;
		}
		else{
		   if(document.forms[0].txt_cin_number.value.length!="21" )
		  {
		    alert( "CIN number length should  be 21 characters" );
			document.forms[0].txt_cin_number.focus();
			return;
		  }
		
		}
	 }
	}	
	if(hid_consttype=="C")
	{
		if(document.forms[0].txt_cin_number.value=="")
		{
			ShowAlert("121","CIN number");
			document.forms[0].txt_cin_number.focus();
			return;
		}
		if(document.forms[0].txt_comp_repDate.value=="")
		{
			ShowAlert("111","Latest search report dated ");
			document.forms[0].txt_comp_repDate.focus();
			return;
		}
		
		if(document.forms[0].txt_com_authCapital.value=="" || document.forms[0].txt_com_authCapital.value=="0.00")
		{
			ShowAlert("121","Authorised Capital");
			document.forms[0].txt_com_authCapital.focus();
			return;
		}
		if(document.forms[0].txt_com_PaidupCapital.value=="" || document.forms[0].txt_com_PaidupCapital.value=="0.00")
		{
			ShowAlert("121","Paid up Capital");
			document.forms[0].txt_com_PaidupCapital.focus();
			return;
		}
		if(document.forms[0].sel_MOA_verified.value=="S")
		{
			ShowAlert("111","MOA/AOA - Powers to borrow by the company");
			document.forms[0].sel_MOA_verified.focus();
			return;
		}
		if(document.forms[0].sel_MOA_verified.value=="N")
		{
			if(document.forms[0].amendedMOA_comments.value=="")
			{
				ShowAlert("121","Amended MOA/AOA");
				document.forms[0].amendedMOA_comments.focus();
				return;
			}
		}
	}
	if(hid_consttype=="T")
	{
		if(document.forms[0].txt_trust_deeddate.value=="")
		{
			ShowAlert("111"," Trust deed dated");
			document.forms[0].txt_trust_deeddate.focus();
			return;
		}
		if(document.forms[0].sel_trustType.value=="S")
		{
			ShowAlert("111","Trust Type");
			document.forms[0].sel_trustType.focus();
			return;
		}
		if(document.forms[0].txt_trust_refno_openacc.value=="")
		{
			ShowAlert("121","Permission Reference number for opening trust account");
			document.forms[0].txt_trust_refno_openacc.focus();
			return;
		}
		
	}
	
	if(document.forms[0].txt_GSTIN_reg.value =="S" || document.forms[0].txt_GSTIN_reg.value ==""){
		ShowAlert("111","Whether GSTIN Registered?");
		document.forms[0].txt_GSTIN_reg.focus();
		return;
	}
	
	// for GSTIN_REG
	if(document.forms[0].txt_GSTIN_reg.value =="Y"){   
		var tab  = document.getElementById("idGSTName");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			if(document.forms[0].txt_GstIn.value=="")
			{
				alert("Enter GSTIN ");
				document.forms[0].txt_GstIn.focus();
				return;
			}
		}
		else if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
			if(document.forms[0].txt_GstIn[i].value=="")
			{
				alert("Enter GSTIN ");
				document.forms[0].txt_GstIn[i].focus();
				return;
			}
			}
		}
		
		var s="";		
			if(rowsLength==1)
			{
				s = document.forms[0].txt_GstIn.value; 
		    }
			else if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				if(s=="")
				{
					s = document.forms[0].txt_GstIn[i].value; 
		        }
		        else
		        {
					s =s+"@"+ document.forms[0].txt_GstIn[i].value; 
		        }

			}
	    }
		document.forms[0].hid_GSTINNO.value = s;
		document.forms[0].txt_GSTIN_Exempted.value ="";
					
		}
	if(document.forms[0].txt_GSTIN_reg.value =="N"){ 
		
		if(document.forms[0].txt_GSTIN_Exempted.value =="S" || document.forms[0].txt_GSTIN_Exempted.value ==""){
			ShowAlert("111","Whether GSTIN Exempted?");
			document.forms[0].txt_GSTIN_Exempted.focus();
			return;
		}
	}
	if(document.forms[0].sel_applt_constitutionnew.value!="01" && document.forms[0].sel_firm_minority.value=="Y")
	{
		if(document.forms[0].sel_corp_religion.value=="0"||document.forms[0].sel_corp_religion.value==""){
			ShowAlert("121","Religion");
		document.forms[0].sel_corp_religion.focus();
		return false;
		}
	}

	if(document.forms[0].sel_applt_constitutionnew.value=="01" && document.forms[0].sel_minority.value=="Y")
	{
		if(document.forms[0].sel_religion.value=="0"||document.forms[0].sel_religion.value==""){
			ShowAlert("121","Religion");
		document.forms[0].sel_religion.focus();
		return false;
		}
	}
	
	if(document.forms[0].sel_applt_constitutionnew.value=="01" && document.forms[0].sel_religion.value=="1")
	{
		if(document.forms[0].sel_minority.value=="Y"){
		alert("If Religion Selected is Hindu then Minority flag cannot be Yes");
		document.forms[0].sel_minority.focus();
		return false;
		}
	}
	
	if(document.forms[0].sel_applt_constitutionnew.value=="01")
	{
		if(document.forms[0].sel_religion.value!="1" && document.forms[0].sel_religion.value!="4"){
			if(document.forms[0].sel_minority.value=="N"){
			alert("if Religion is other than Hindu then Minority flag should be Yes");
			document.forms[0].sel_minority.focus();
			return false;
			}
		}
	}
	
	if(document.forms[0].sel_applt_constitutionnew.value=="01" && document.forms[0].sel_religion.value=="4" && varcommstate=="PB")
	{	
		if(document.forms[0].sel_minority.value=="Y"){
			alert("If religion selected is Sikh and state of Applicant is punjab(Permanent Address State for NRI and Communication Address state for others) then Minority flag cannot be Yes");
			return;
		}
	}
	
	
	if(document.forms[0].sel_applt_constitutionnew.value!="01" &&document.forms[0].sel_corp_religion.value=="1")
	{
		if(document.forms[0].sel_firm_minority.value=="Y"){
			alert("If Religion Selected is Hindu then Whether majority of members/owners belong to minority community flag cannot be Yes")
		document.forms[0].sel_corp_religion.focus();
		return false;
		}
	}
	/*if(document.forms[0].sel_applt_constitutionnew.value!="01")
	{
		if(document.forms[0].sel_minIndustry.value=="0"||document.forms[0].sel_minIndustry.value==""){
			ShowAlert("121","Whether start up as per definition of Ministry of commerce and Industry");
		document.forms[0].sel_minIndustry.focus();
		return false;
		}
	}*/
	if(document.forms[0].sel_applt_constitutionnew.value=="09"&&varminorityflag=="Y")
	{
		if(document.forms[0].sel_firm_minority.value=="N"){
			alert("If more than 50% of the partners belong to minority community as per Customer Id entered in Group Management People Details tab - concern type - Partners, then Whether majority of members/owners belong to minority community cannot be given as No ");
			document.forms[0].sel_firm_minority.focus();
			return false;
		}
		
	}
	
	if(document.forms[0].sel_applt_constitutionnew.value=="09"&&varminorityflag!="Y")
	{
		if(document.forms[0].sel_firm_minority.value=="Y"){
			alert("As the customer id of partners attached in Group/Management Peoples tab - Concern type - Partners are not belonging to minority community hence Whether majority of members/owners belong to minority community cannot be given as Yes");
			document.forms[0].sel_firm_minority.focus();
			return false;
		}
		
	}
	/*if(orglevel=="A"){
		var vardate=document.forms[0].txt_restructdate.value;
		if(document.forms[0].txt_restructdate.value!=""){
			alert("Date of Restructure Invocation entered is  "+vardate +" once date saved modification is not allowed");
		}
	}*/
	
	if(varinvocdate!="")
	{
		if(document.forms[0].txt_restructdate.value=="")
		{
			alert("Please select New Invoc Date or Select existing date as "+varinvocdate);
			document.forms[0].txt_restructdate.focus();
			return false;
		}
	}
	
	disableCbsFields(false);
	document.forms[0].applnt.value="P";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="updateDemographics";
	document.forms[0].action=appURL+"action/perapplicant.jsp";
	document.forms[0].submit();
	disableControls(false,true,true,true,false);
	
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

function deleteRow1(tarbid,tdcount)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var tab = document.getElementById(tarbid);
		var rowsLength = tab.rows.length;
		var varCheckedFlag=false;
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					if(tarbid=="idGSTName" && rowsLength=="1")
					{
						document.forms[0].txt_GstIn.value="";  
					    chkbox.checked=false; 
					    return;
					}
					else
					{
						tab.deleteRow(i);
						rowsLength--;
						i--;
					}

					if(!varCheckedFlag)
					{
						varCheckedFlag=true;
					}
				}
			}
			if(!varCheckedFlag)
			{
				alert("Please select the check box for deletion");
			}
		}
	}
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


function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
	   	document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].action=appURL+"action/perapplicant.jsp?applnt=P&scode=yyy";
		document.forms[0].submit();
	}
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{	
		document.forms[0].method="post";
		document.forms[0].hidBeanGetMethod.value="deleteDemographics";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}


function showPhoto()
{
	var varperapp_id = document.forms[0].txt_laps_app_id.value;
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
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
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

function doNRIDetails()
{
	var hid_comappid1= document.forms[0].hid_comappid1.value;
	var purl = appURL+"action/nridetails.jsp?hidBeanGetMethod=getnriData&hidBeanId=refdetails&hid_comappid1="+hid_comappid1+"&appstatus="+appstatus;
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
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=450,height=350,top=200,left=460";
		var url="/laps/action/grouphelp.jsp";
		window.open(url,"grouphelp",prop);
	}
}
function callKYCNorms()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txt_laps_app_id.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
			document.forms[0].action=appURL+"action/set_KYCNorms.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callEmployer()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txt_laps_app_id.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action=appURL+"action/peremployer.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callIncomeExpenses()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txt_laps_app_id.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getIncome";
			document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callLandholding()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txt_laps_app_id.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="agrlandholdings";
			document.forms[0].action=appURL+"action/agr_landholding.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
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
	document.forms[0].sel_introducer_type.disabled=boolval;
	document.forms[0].txt_group_name.readOnly=boolval;
	document.forms[0].txt_aadhar.readOnly=boolval;
}
function disablelineofAction()
{
		document.all.id_line_of_activity.style.visibility="hidden";
		document.all.id_line_of_activity1.style.visibility="hidden";
		document.all.id_since.style.visibility="hidden";
}
function checkBorrowerSince(obj)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(document.forms[0].txt_applt_dob.value);
	if(document.forms[0].sel_applt_constitution.value=="01"||document.forms[0].sel_applt_constitution.value=="02")
	{
		if(obj.value!="")
		{
			if(Date.parse(pgdt) < Date.parse(maxdt))
			{
				alert("Borrower cannot be lesser than " + document.forms[0].txt_applt_dob.value );
				obj.value="";
				obj.focus();
			}
		}
	}
}
function showOrganizationSearch(path, forgscode, forgname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname;
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
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
		document.forms[0].txt_justComment.value="";
		document.all.justdetails.style.visibility="hidden";
		document.all.justdetails.style.position="absolute";
		document.all.justdetails1.style.visibility="hidden";
		document.all.justdetails1.style.position="absolute";
	}

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
	else
	{
		document.getElementById("staff").style.display="none";
		document.getElementById("cbsid").style.display="none";	
		document.forms[0].txt_introstaff_id.value="";
		document.forms[0].txt_introcbs_id.value="";
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
function showUsers(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom=custprof&hidField="+val;
		var title = "Organization";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
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

//Added by Guhan.T to Validate CBS Customer ID
function callValidateCBSid(obj)
{
	var varCust_Id=obj.value;
	var varappid=document.forms[0].txt_cbs_id.value;
	if(document.forms[0].sel_introducer_type.value=="2")
	{
		if(varCust_Id!="")
		{
			document.all.ifrmappid.src=appURL+"action/iframeCBScheck.jsp?hidBeanGetMethod=getValidCBSId&hidBeanId=mastapplicant&cbsId="+varCust_Id+"&appID="+varappid;
		}
		
	}
}
function callDate()
{
	if(document.forms[0].txt_networth.value!="0" || document.forms[0].txt_networth.value!="")
	{
		document.all.id_asonDate.style.visibility="visible";
		document.all.id_asonDate.style.position="relative";
	}
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
function callHeldWomen()
{
	if(parseFloat(document.forms[0].sel_applt_constitutionnew.value)!=01)
	{
		
		document.all.Con1.style.visibility="visible";
		document.all.Con1.style.position="relative";
		document.all.Con2.style.visibility="visible";
		document.all.Con2.style.position="relative";
	}
	else
	{
		document.all.Con1.style.visibility="hidden";
		document.all.Con1.style.position="absolute";
		document.all.Con2.style.visibility="hidden";
		document.all.Con2.style.position="absolute";	
	
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
	var tab  = document.getElementById("tabid_assetslist");
	var rowsLength = tab.rows.length-1;
	if(rowsLength==1)
	{
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
		}
	}
	else
	{
		name=name+"["+(rowindex-1)+"]";
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

function callcgt()
{
	var varcgt = document.forms[0].sel_applt_constitutionnew.value;	
	document.all.ifrmcgtmse.src=appURL+"action/iframeCGTMSE.jsp?hidBeanGetMethod=getCGTMSEConstitution&hidBeanId=mastapplicant&varcgt="+varcgt;
}


function callGSTINChange()
{
	
	if(document.forms[0].txt_GSTIN_reg.value =="Y"){		
	   document.all.GSTIN_name.style.display="table-cell";
	   document.all.GSTIN_name1.style.display="table-cell";
	   document.all.GSTIN_Exempted.style.display="none";
	     document.all.GSTIN_Exempted1.style.display="none";
	}
	else if(document.forms[0].txt_GSTIN_reg.value =="N"){
		document.all.GSTIN_name1.style.display="none";
	     document.all.GSTIN_name.style.display="none";
		
		document.all.GSTIN_Exempted.style.display="table-cell";
		document.all.GSTIN_Exempted1.style.display="table-cell";
	}
	else{
		 document.all.GSTIN_name1.style.display="none";
	     document.all.GSTIN_name.style.display="none";
	     document.all.GSTIN_Exempted.style.display="none";
	     document.all.GSTIN_Exempted1.style.display="none";
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
	

function DuplicateCheck(val,rowindex,name){
	var GSTNo=val.value;
	
	if(document.forms[0].cmdsave.disabled==true)
	{
		return;
	}
	if(rowindex=="0")
	{
		var tab  = document.getElementById("idGSTName");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			name=name;
		}
		else
		{
			name=name+"["+(rowindex)+"]";
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
	}
	if(document.forms[0].cmdsave.disabled==false)
	{
		document.forms[0].cmdsave.disabled=true;
		document.all.ifrmcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strGSTNo="+GSTNo
		+ "&strrowindexname="+name+"&strBorrowerId="+document.forms[0].hidDemoId.value+"&strPage=Cust";
	}
	
}