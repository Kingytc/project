function hideFields() {
	var _purpose_of_loan = document.forms[0].sel_purpose_of_loan;
	var _already_mortgaged = document.forms[0].sel_already_mortgaged;
	var _property_type = document.forms[0].sel_property_type;
	document.all.mand.style.display = "none";	
	document.all.notmand.style.display = "table-cell";	
	if (_purpose_of_loan.value == "G") {
		// Area of Site
		document.all.id_sitearea_lbl.style.visibility = "visible";
		document.all.id_sitearea_lbl.style.position = "relative";
		document.all.id_sitearea_val.style.visibility = "visible";
		document.all.id_sitearea_val.style.position = "relative";

		// FloorSpace Area
		document.all.id_builtuparea_lbl.style.visibility = "hidden";
		document.all.id_builtuparea_lbl.style.position = "absolute";
		document.all.id_builtuparea_val.style.visibility = "hidden";
		document.all.id_builtuparea_val.style.position = "absolute";

		// Market & Purchase Price of Site
		document.all.id_sitevalue_row.style.visibility = "visible";
		document.all.id_sitevalue_row.style.position = "relative";

		// Market & Purchase Price of Building
		document.all.id_bldgvalue_row.style.visibility = "hidden";
		document.all.id_bldgvalue_row.style.position = "absolute";

		// Estimated Cost of Construction
		document.all.id_conscost_lbl.style.visibility = "hidden";
		document.all.id_conscost_lbl.style.position = "absolute";
		document.all.id_conscost_val.style.visibility = "hidden";
		document.all.id_conscost_val.style.position = "absolute";

		// Cost of Rennovation
		document.all.id_rennovation_lbl.style.visibility = "hidden";
		document.all.id_rennovation_lbl.style.position = "absolute";
		document.all.id_rennovation_val.style.visibility = "hidden";
		document.all.id_rennovation_val.style.position = "absolute";

		// Valuation Price of Site
		document.all.id_sitevalprice_lbl.style.visibility = "visible";
		document.all.id_sitevalprice_lbl.style.position = "relative";
		document.all.id_sitevalprice_val.style.visibility = "visible";
		document.all.id_sitevalprice_val.style.position = "relative";

		// Valuation Price of Building
		document.all.id_bldgvalprice_lbl.style.visibility = "hidden";
		document.all.id_bldgvalprice_lbl.style.position = "absolute";
		document.all.id_bldgvalprice_val.style.visibility = "hidden";
		document.all.id_bldgvalprice_val.style.position = "absolute";

		// Project Details
		document.all.id_projdet_header.style.visibility = "hidden";
		document.all.id_projdet_header.style.position = "absolute";
		document.all.id_projdet_row1.style.visibility = "hidden";
		document.all.id_projdet_row1.style.position = "absolute";
		document.all.id_projdet_row2.style.visibility = "hidden";
		document.all.id_projdet_row2.style.position = "absolute";
		document.all.id_projdet_row3.style.visibility = "hidden";
		document.all.id_projdet_row3.style.position = "absolute";
		
		//Already Mortgaged
		document.all.id_mortgage_already.style.visibility="hidden";
		document.all.id_mortgage_already.style.position="absolute";


	} else if (_purpose_of_loan.value == "C") {

		// Area of Site
		document.all.id_sitearea_lbl.style.visibility = "hidden";
		document.all.id_sitearea_lbl.style.position = "absolute";
		document.all.id_sitearea_val.style.visibility = "hidden";
		document.all.id_sitearea_val.style.position = "absolute";

		// FloorSpace Area
		document.all.id_builtuparea_lbl.style.visibility = "visible";
		document.all.id_builtuparea_lbl.style.position = "relative";
		document.all.id_builtuparea_val.style.visibility = "visible";
		document.all.id_builtuparea_val.style.position = "relative";

		// Market & Purchase Price of Site
		document.all.id_sitevalue_row.style.visibility = "hidden";
		document.all.id_sitevalue_row.style.position = "absolute";

		// Market & Purchase Price of Building
		document.all.id_bldgvalue_row.style.visibility = "hidden";
		document.all.id_bldgvalue_row.style.position = "absolute";

		// Estimated Cost of Construction
		document.all.id_conscost_lbl.style.visibility = "hidden";
		document.all.id_conscost_lbl.style.position = "absolute";
		document.all.id_conscost_val.style.visibility = "hidden";
		document.all.id_conscost_val.style.position = "absolute";

		// Cost of Rennovation
		document.all.id_rennovation_lbl.style.visibility = "visible";
		document.all.id_rennovation_lbl.style.position = "relative";
		document.all.id_rennovation_val.style.visibility = "visible";
		document.all.id_rennovation_val.style.position = "relative";

		// Valuation Price of Site
		document.all.id_sitevalprice_lbl.style.visibility = "hidden";
		document.all.id_sitevalprice_lbl.style.position = "absolute";
		document.all.id_sitevalprice_val.style.visibility = "hidden";
		document.all.id_sitevalprice_val.style.position = "absolute";

		// Valuation Price of Building
		document.all.id_bldgvalprice_lbl.style.visibility = "hidden";
		document.all.id_bldgvalprice_lbl.style.position = "absolute";
		document.all.id_bldgvalprice_val.style.visibility = "hidden";
		document.all.id_bldgvalprice_val.style.position = "absolute";

		// Project Details
		document.all.id_projdet_header.style.visibility = "hidden";
		document.all.id_projdet_header.style.position = "absolute";
		document.all.id_projdet_row1.style.visibility = "hidden";
		document.all.id_projdet_row1.style.position = "absolute";
		document.all.id_projdet_row2.style.visibility = "hidden";
		document.all.id_projdet_row2.style.position = "absolute";
		document.all.id_projdet_row3.style.visibility = "hidden";
		document.all.id_projdet_row3.style.position = "absolute";
		
		//Already Mortgaged
		document.all.id_mortgage_already.style.visibility="hidden";
		document.all.id_mortgage_already.style.position="absolute";
		
		document.all.id_renovation_row.style.visibility = "visible";
		document.all.id_renovation_row.style.position = "relative";


	} else if (_purpose_of_loan.value == "S") {

		// Area of Site
		document.all.id_sitearea_lbl.style.visibility = "visible";
		document.all.id_sitearea_lbl.style.position = "relative";
		document.all.id_sitearea_val.style.visibility = "visible";
		document.all.id_sitearea_val.style.position = "relative";

		// FloorSpace Area
		document.all.id_builtuparea_lbl.style.visibility = "visible";
		document.all.id_builtuparea_lbl.style.position = "relative";
		document.all.id_builtuparea_val.style.visibility = "visible";
		document.all.id_builtuparea_val.style.position = "relative";

		// Market & Purchase Price of Site
		document.all.id_sitevalue_row.style.visibility = "visible";
		document.all.id_sitevalue_row.style.position = "relative";

		// Market & Purchase Price of Building
		document.all.id_bldgvalue_row.style.visibility = "hidden";
		document.all.id_bldgvalue_row.style.position = "absolute";

		// Estimated Cost of Construction
		document.all.id_conscost_lbl.style.visibility = "visible";
		document.all.id_conscost_lbl.style.position = "relative";
		document.all.id_conscost_val.style.visibility = "visible";
		document.all.id_conscost_val.style.position = "relative";

		// Cost of Rennovation
		document.all.id_rennovation_lbl.style.visibility = "hidden";
		document.all.id_rennovation_lbl.style.position = "absolute";
		document.all.id_rennovation_val.style.visibility = "hidden";
		document.all.id_rennovation_val.style.position = "absolute";

		// Valuation Price of Site
		document.all.id_sitevalprice_lbl.style.visibility = "hidden";
		document.all.id_sitevalprice_lbl.style.position = "absolute";
		document.all.id_sitevalprice_val.style.visibility = "hidden";
		document.all.id_sitevalprice_val.style.position = "absolute";

		// Valuation Price of Building
		document.all.id_bldgvalprice_lbl.style.visibility = "hidden";
		document.all.id_bldgvalprice_lbl.style.position = "absolute";
		document.all.id_bldgvalprice_val.style.visibility = "hidden";
		document.all.id_bldgvalprice_val.style.position = "absolute";

		// Project Details
		document.all.id_projdet_header.style.visibility = "hidden";
		document.all.id_projdet_header.style.position = "absolute";
		document.all.id_projdet_row1.style.visibility = "hidden";
		document.all.id_projdet_row1.style.position = "absolute";
		document.all.id_projdet_row2.style.visibility = "hidden";
		document.all.id_projdet_row2.style.position = "absolute";
		document.all.id_projdet_row3.style.visibility = "hidden";
		document.all.id_projdet_row3.style.position = "absolute";
		
		//Already Mortgaged
		document.all.id_mortgage_already.style.visibility="hidden";
		document.all.id_mortgage_already.style.position="absolute";


	} else if (_purpose_of_loan.value == "H") {

		// Area of Site
		document.all.id_sitearea_lbl.style.visibility = "hidden";
		document.all.id_sitearea_lbl.style.position = "absolute";
		document.all.id_sitearea_val.style.visibility = "hidden";
		document.all.id_sitearea_val.style.position = "absolute";

		// FloorSpace Area
		document.all.id_builtuparea_lbl.style.visibility = "visible";
		document.all.id_builtuparea_lbl.style.position = "relative";
		document.all.id_builtuparea_val.style.visibility = "visible";
		document.all.id_builtuparea_val.style.position = "relative";

		// Market & Purchase Price of Site
		document.all.id_sitevalue_row.style.visibility = "hidden";
		document.all.id_sitevalue_row.style.position = "absolute";

		// Market & Purchase Price of Building
		document.all.id_bldgvalue_row.style.visibility = "visible";
		document.all.id_bldgvalue_row.style.position = "relative";

		// Estimated Cost of Construction
		document.all.id_conscost_lbl.style.visibility = "hidden";
		document.all.id_conscost_lbl.style.position = "absolute";
		document.all.id_conscost_val.style.visibility = "hidden";
		document.all.id_conscost_val.style.position = "absolute";

		// Cost of Rennovation
		document.all.id_rennovation_lbl.style.visibility = "hidden";
		document.all.id_rennovation_lbl.style.position = "absolute";
		document.all.id_rennovation_val.style.visibility = "hidden";
		document.all.id_rennovation_val.style.position = "absolute";

		// Valuation Price of Site
		document.all.id_sitevalprice_lbl.style.visibility = "hidden";
		document.all.id_sitevalprice_lbl.style.position = "absolute";
		document.all.id_sitevalprice_val.style.visibility = "hidden";
		document.all.id_sitevalprice_val.style.position = "absolute";

		// Valuation Price of Building
		document.all.id_bldgvalprice_lbl.style.visibility = "visible";
		document.all.id_bldgvalprice_lbl.style.position = "relative";
		document.all.id_bldgvalprice_val.style.visibility = "visible";
		document.all.id_bldgvalprice_val.style.position = "relative";

		// Project Details
		document.all.id_projdet_header.style.visibility = "visible";
		document.all.id_projdet_header.style.position = "relative";
		document.all.id_projdet_row1.style.visibility = "visible";
		document.all.id_projdet_row1.style.position = "relative";
		document.all.id_projdet_row2.style.visibility = "visible";
		document.all.id_projdet_row2.style.position = "relative";
		document.all.id_projdet_row3.style.visibility = "visible";
		document.all.id_projdet_row3.style.position = "relative";
		
		//Already Mortgaged
		document.all.id_mortgage_already.style.visibility="hidden";
		document.all.id_mortgage_already.style.position="absolute";


	} else if (_purpose_of_loan.value == "R") {

		// Area of Site
		document.all.id_sitearea_lbl.style.visibility = "hidden";
		document.all.id_sitearea_lbl.style.position = "absolute";
		document.all.id_sitearea_val.style.visibility = "hidden";
		document.all.id_sitearea_val.style.position = "absolute";

		// FloorSpace Area
		document.all.id_builtuparea_lbl.style.visibility = "visible";
		document.all.id_builtuparea_lbl.style.position = "relative";
		document.all.id_builtuparea_val.style.visibility = "visible";
		document.all.id_builtuparea_val.style.position = "relative";

		// Market & Purchase Price of Site
		document.all.id_sitevalue_row.style.visibility = "hidden";
		document.all.id_sitevalue_row.style.position = "absolute";

		// Market & Purchase Price of Building
		document.all.id_bldgvalue_row.style.visibility = "hidden";
		document.all.id_bldgvalue_row.style.position = "absolute";

		// Estimated Cost of Construction
		document.all.id_conscost_lbl.style.visibility = "hidden";
		document.all.id_conscost_lbl.style.position = "absolute";
		document.all.id_conscost_val.style.visibility = "hidden";
		document.all.id_conscost_val.style.position = "absolute";

		// Cost of Rennovation
		document.all.id_rennovation_lbl.style.visibility = "visible";
		document.all.id_rennovation_lbl.style.position = "relative";
		document.all.id_rennovation_val.style.visibility = "visible";
		document.all.id_rennovation_val.style.position = "relative";

		// Valuation Price of Site
		document.all.id_sitevalprice_lbl.style.visibility = "hidden";
		document.all.id_sitevalprice_lbl.style.position = "absolute";
		document.all.id_sitevalprice_val.style.visibility = "hidden";
		document.all.id_sitevalprice_val.style.position = "absolute";

		// Valuation Price of Building
		document.all.id_bldgvalprice_lbl.style.visibility = "hidden";
		document.all.id_bldgvalprice_lbl.style.position = "absolute";
		document.all.id_bldgvalprice_val.style.visibility = "hidden";
		document.all.id_bldgvalprice_val.style.position = "absolute";

		// Project Details
		document.all.id_projdet_header.style.visibility = "hidden";
		document.all.id_projdet_header.style.position = "absolute";
		document.all.id_projdet_row1.style.visibility = "hidden";
		document.all.id_projdet_row1.style.position = "absolute";
		document.all.id_projdet_row2.style.visibility = "hidden";
		document.all.id_projdet_row2.style.position = "absolute";
		document.all.id_projdet_row3.style.visibility = "hidden";
		document.all.id_projdet_row3.style.position = "absolute";
		
		//Already Mortgaged
		document.all.id_mortgage_already.style.visibility="hidden";
		document.all.id_mortgage_already.style.position="absolute";
		
		document.all.id_renovation_row.style.visibility = "visible";
		document.all.id_renovation_row.style.position = "relative";


	} else if (_purpose_of_loan.value == "M") {

		// Project Details
		document.all.id_projdet_header.style.visibility = "hidden";
		document.all.id_projdet_header.style.position = "absolute";
		document.all.id_projdet_row1.style.visibility = "hidden";
		document.all.id_projdet_row1.style.position = "absolute";
		document.all.id_projdet_row2.style.visibility = "hidden";
		document.all.id_projdet_row2.style.position = "absolute";
		document.all.id_projdet_row3.style.visibility = "hidden";
		document.all.id_projdet_row3.style.position = "absolute";
		
		//Already Mortgaged
		document.all.id_mortgage_already.style.visibility="visible";
		document.all.id_mortgage_already.style.position="relative";
		
		//Type of property Mandatory
		document.all.mand.style.display = "table-cell";
		document.all.notmand.style.display = "none";
		
		if(_property_type.value=="L")
		{
			// Area of Site
			document.all.id_sitearea_lbl.style.visibility = "visible";
			document.all.id_sitearea_lbl.style.position = "relative";
			document.all.id_sitearea_val.style.visibility = "visible";
			document.all.id_sitearea_val.style.position = "relative";

			// FloorSpace Area
			document.all.id_builtuparea_lbl.style.visibility = "hidden";
			document.all.id_builtuparea_lbl.style.position = "absolute";
			document.all.id_builtuparea_val.style.visibility = "hidden";
			document.all.id_builtuparea_val.style.position = "absolute";

			// Market & Purchase Price of Site
			document.all.id_sitevalue_row.style.visibility = "visible";
			document.all.id_sitevalue_row.style.position = "relative";

			// Market & Purchase Price of Building
			document.all.id_bldgvalue_row.style.visibility = "hidden";
			document.all.id_bldgvalue_row.style.position = "absolute";

			// Estimated Cost of Construction
			document.all.id_conscost_lbl.style.visibility = "hidden";
			document.all.id_conscost_lbl.style.position = "absolute";
			document.all.id_conscost_val.style.visibility = "hidden";
			document.all.id_conscost_val.style.position = "absolute";

			// Cost of Rennovation
			document.all.id_rennovation_lbl.style.visibility = "hidden";
			document.all.id_rennovation_lbl.style.position = "absolute";
			document.all.id_rennovation_val.style.visibility = "hidden";
			document.all.id_rennovation_val.style.position = "absolute";

			// Valuation Price of Site
			document.all.id_sitevalprice_lbl.style.visibility = "visible";
			document.all.id_sitevalprice_lbl.style.position = "relative";
			document.all.id_sitevalprice_val.style.visibility = "visible";
			document.all.id_sitevalprice_val.style.position = "relative";

			// Valuation Price of Building
			document.all.id_bldgvalprice_lbl.style.visibility = "hidden";
			document.all.id_bldgvalprice_lbl.style.position = "absolute";
			document.all.id_bldgvalprice_val.style.visibility = "hidden";
			document.all.id_bldgvalprice_val.style.position = "absolute";
			
		} else {
			
			// Area of Site
			document.all.id_sitearea_lbl.style.visibility = "hidden";
			document.all.id_sitearea_lbl.style.position = "absolute";
			document.all.id_sitearea_val.style.visibility = "hidden";
			document.all.id_sitearea_val.style.position = "absolute";

			// FloorSpace Area
			document.all.id_builtuparea_lbl.style.visibility = "visible";
			document.all.id_builtuparea_lbl.style.position = "relative";
			document.all.id_builtuparea_val.style.visibility = "visible";
			document.all.id_builtuparea_val.style.position = "relative";

			// Market & Purchase Price of Site
			document.all.id_sitevalue_row.style.visibility = "hidden";
			document.all.id_sitevalue_row.style.position = "absolute";

			// Market & Purchase Price of Building
			document.all.id_bldgvalue_row.style.visibility = "visible";
			document.all.id_bldgvalue_row.style.position = "relative";

			// Estimated Cost of Construction
			document.all.id_conscost_lbl.style.visibility = "hidden";
			document.all.id_conscost_lbl.style.position = "absolute";
			document.all.id_conscost_val.style.visibility = "hidden";
			document.all.id_conscost_val.style.position = "absolute";

			// Cost of Rennovation
			document.all.id_rennovation_lbl.style.visibility = "hidden";
			document.all.id_rennovation_lbl.style.position = "absolute";
			document.all.id_rennovation_val.style.visibility = "hidden";
			document.all.id_rennovation_val.style.position = "absolute";

			// Valuation Price of Site
			document.all.id_sitevalprice_lbl.style.visibility = "hidden";
			document.all.id_sitevalprice_lbl.style.position = "absolute";
			document.all.id_sitevalprice_val.style.visibility = "hidden";
			document.all.id_sitevalprice_val.style.position = "absolute";

			// Valuation Price of Building
			document.all.id_bldgvalprice_lbl.style.visibility = "visible";
			document.all.id_bldgvalprice_lbl.style.position = "relative";
			document.all.id_bldgvalprice_val.style.visibility = "visible";
			document.all.id_bldgvalprice_val.style.position = "relative";
		}
	}
	document.all.City_pop.style.visibility = "hidden";
	document.all.Town_pop.style.visibility="hidden";
	document.all.Dist_pop.style.visibility="hidden";
}
function disableFields(flag) {
	for ( var i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].type == "text") {
			document.forms[0].elements[i].readOnly = flag;
		}
		if (document.forms[0].elements[i].type == "select-one") {
			document.forms[0].elements[i].disabled = flag;
		}
		if (document.forms[0].elements[i].type == "textarea") {
			document.forms[0].elements[i].readOnly = flag;
		}
		/*if (document.forms[0].elements[i].type == "radio") {
			document.forms[0].elements[i].disabled = flag;
		}*/
		if (document.forms[0].elements[i].type == "checkbox") {
			document.forms[0].elements[i].disabled = flag;
		}
	}
}
function disableCommandButtons(valedit, valapply, valcancel, valdel, valclose) {
	document.forms[0].cmdedit.disabled = valedit;
	document.forms[0].cmdsave.disabled = valapply;
	document.forms[0].cmdcancel.disabled = valcancel;
	document.forms[0].cmddelete.disabled = valdel;
	document.forms[0].cmdclose.disabled = valclose;
}
function doEdit() {
	document.forms[0].hideditflag.value = "Y";
	var _purpose_of_loan = document.forms[0].sel_purpose_of_loan.value;
	var secID=document.forms[0].hidsecID.value;
	if(secID==null || secID==""){
		disableFields(false);
	}else{
		disableFields(true);
		document.forms[0].txt_property_for.disabled=false;
		document.forms[0].txt_branch_distance.readOnly =false;
		document.forms[0].sel_house_type.disabled=false;
		document.forms[0].sel_property_location.disabled=false;
		document.forms[0].txt_addr_town.readOnly =false;
		document.forms[0].chk_mainroad.disabled=false;
		document.forms[0].chk_eduinstitution.disabled=false;
		document.forms[0].chk_public.disabled=false;
		document.forms[0].chk_prime.disabled=false;
		document.forms[0].chk_accessible.disabled=false;
		document.forms[0].chk_assured.disabled=false;
		document.forms[0].chk_drainages.disabled=false;
		document.forms[0].chk_currentconnection.disabled=false;
		document.forms[0].txt_premises_age.readOnly = false;
		document.forms[0].txt_residual_life.readOnly = false;
		document.forms[0].txt_addr_taluk.readOnly = false;
		document.forms[0].txt_purchasevalue_site.readOnly = false;
		document.forms[0].txt_construction_estimate.readOnly = false;
		document.forms[0].sel_property_nature.disabled=false;
		document.forms[0].txt_marketvalue_site.readOnly = false;
		if(_purpose_of_loan=="H"){
			document.forms[0].txt_purchasevalue_flat.readOnly = false;
			document.forms[0].txt_project_name.readOnly = false;
			document.forms[0].txt_builder_name.readOnly = false;
			document.forms[0].txtar_project_details.readOnly = false;
			document.forms[0].txtar_builder_background.readOnly = false;
			document.forms[0].sel_projfin_sanc.disabled=false;
			//document.forms[0].txt_marketvalue_flat.readOnly = false;
			//document.forms[0].txt_purchasevalue_flat.readOnly = false;
		}
		
		if(_purpose_of_loan=="G"||_purpose_of_loan=="S"){
			document.forms[0].txt_marketvalue_site.readOnly = true;
		}
		if(_purpose_of_loan=="C"||_purpose_of_loan=="R"){
			document.forms[0].txt_cost_renovation.readOnly = false;
		}
	}
	document.forms[0].hidAction.value = "update";
	//disableCommandButtons(true, false, false, false, true);	
	enableButtons(true, true, false, false, true,true);
	document.forms[0].sel_purpose_of_loan.disabled = true;
	//security creation removed while saving proposed offered asset tab
	//document.forms[0].add1.disabled=false;
	//document.forms[0].remove.disabled=false;
	document.forms[0].sel_take_over.disabled=true;
	if(_purpose_of_loan.value == "R" || _purpose_of_loan.value=="C" )
	{
		//document.forms[0].txt_rennovation_bldg.readOnly = true;
		document.forms[0].txt_cost_renovation.readOnly = true;
		
	}
	document.forms[0].txt_addr_city.readOnly = true;
	document.forms[0].txt_addr_district.readOnly = true;
	document.forms[0].txt_addr_state.readOnly = true;
	document.forms[0].txt_addr_town.readOnly = true;

	var varPSterms = document.forms[0].hidPSparams.value.split("@");
	if(varPSterms!="")
	{
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "MODGSS")
			{
				disableFields(true);
			}
		}
		return;
	}
}
function doNew() 
{	
	document.forms[0].hidAction.value="insert";
	//disableCommandButtons(true, false, false, false, true);	
	enableButtons(true, true, false, false, true,true);
	disableFields(false);
	ClearFields();
	document.forms[0].hideditflag.value="Y";
	var _purpose_of_loan = document.forms[0].sel_purpose_of_loan;
	if(_purpose_of_loan.value == "R" || _purpose_of_loan.value=="C" )
	{
		document.forms[0].txt_cost_renovation.readOnly = true;
		if(loan_costproj!="")
			document.forms[0].txt_cost_renovation.value=loan_costproj;	
		else
			document.forms[0].txt_cost_renovation.value="0.00";	
	}
	//document.forms[0].txt_premises_age.readOnly = true;
	document.forms[0].txt_metloanpremium.readOnly = true;
/*	if(var_premises_age!="")
		document.forms[0].txt_premises_age.value=var_premises_age;
	else
		document.forms[0].txt_premises_age.value="0";*/
	if(var_metlife!="")
		document.forms[0].txt_metloanpremium.value=var_metlife;
	else
		document.forms[0].txt_metloanpremium.value="0.00";
	
}
function ClearFields()
{
	document.forms[0].sel_purpose_of_loan.value="";
	document.forms[0].sel_take_over.value="";
	document.forms[0].sel_property_type.value="";
	document.forms[0].sel_property_nature.value = "";
	document.forms[0].txt_property_for.value = "";
	document.forms[0].txt_branch_distance.value = "";
	document.forms[0].txt_residual_life.value = "";
	document.forms[0].txt_premises_age.value = "";
	document.forms[0].sel_securitytype.value = "";
	document.forms[0].sel_securityclassifcation.value = "";
	document.forms[0].sel_natureCharge.value = "";
	document.forms[0].sel_house_type.value = "";
	document.forms[0].sel_already_mortgaged.value = "";
	document.forms[0].sel_property_location.value = "";
	document.forms[0].txt_survey_no.value = "";
	document.forms[0].txt_plot_no.value = "";
	document.forms[0].txt_addr_street.value = "";
	document.forms[0].txt_addr_taluk.value = "";
	document.forms[0].txt_addr_city.value = "";
	document.forms[0].hidcity.value = "";
	document.forms[0].txt_addr_district.value = "";
	document.forms[0].hid_dist.value = "";
	document.forms[0].txt_addr_state.value = "";
	document.forms[0].hidstate.value = "";
	document.forms[0].txt_addr_town.value = "";
	document.forms[0].hidtown.value = "";
	document.forms[0].txt_addr_pincode.value = "";
	document.forms[0].txt_area_site.value = "";
	document.forms[0].txt_area_floorspace.value = "";
	document.forms[0].txt_marketvalue_site.value = "";
	document.forms[0].txt_purchasevalue_site.value = "";
	document.forms[0].txt_marketvalue_flat.value = "";
	document.forms[0].txt_purchasevalue_flat.value = "";
	document.forms[0].txt_cost_renovation.value = "";
	document.forms[0].txt_metloanpremium.value = "";
	document.forms[0].txt_marketVal.value = "";
	document.forms[0].txt_construction_estimate.value = "";
	document.forms[0].txt_rennovation_bldg.value = "";
	document.forms[0].txt_valuation_site.value = "";
	document.forms[0].txt_valuation_flat.value = "";
	document.forms[0].txt_project_name.value = "";
	document.forms[0].txt_builder_name.value = "";
	document.forms[0].txtar_project_details.value = "";
	document.forms[0].txtar_builder_background.value = "";
	document.forms[0].sel_projfin_sanc.value = "";
	document.forms[0].chk_mainroad.value = "";
	document.forms[0].chk_eduinstitution.value = "";
	document.forms[0].chk_public.value = "";
	document.forms[0].chk_prime.value = "";
	document.forms[0].chk_accessible.value = "";
	document.forms[0].chk_assured.value = "";
	document.forms[0].chk_drainages.value = "";
	document.forms[0].chk_currentconnection.value = "";
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function doSave() {
	var _purpose_of_loan = document.forms[0].sel_purpose_of_loan;
	var _dist_from_branch = document.forms[0].txt_branch_distance;
	var _take_over = document.forms[0].sel_take_over;
	var _age_premises = document.forms[0].txt_premises_age;
	var _residual_age = document.forms[0].txt_residual_life;
	var _proj_name = document.forms[0].txt_project_name;
	var _proj_finance = document.forms[0].sel_projfin_sanc;
	var _prop_location = document.forms[0].sel_property_location;
	var _prop_survey_no = document.forms[0].txt_survey_no;
	var _prop_plot_no = document.forms[0].txt_plot_no;
	var _prop_street = document.forms[0].txt_addr_street;
	var _prop_taluk = document.forms[0].txt_addr_taluk;
	var _prop_city = document.forms[0].txt_addr_city;
	var _prop_district = document.forms[0].txt_addr_district;
	var _prop_state = document.forms[0].txt_addr_state;
	var _prop_town = document.forms[0].txt_addr_town;
	var _prop_pincode = document.forms[0].txt_addr_pincode;
	var _prop_site_area = document.forms[0].txt_area_site;
	var _prop_builtup_area = document.forms[0].txt_area_floorspace;
	var _already_mortgaged = document.forms[0].sel_already_mortgaged;
	var _property_type = document.forms[0].sel_property_type;
	var _prop_site_purchase = document.forms[0].txt_purchasevalue_site;
	var _prop_site_market = document.forms[0].txt_marketvalue_site;
	var _prop_site_valuation = document.forms[0].txt_valuation_site;
	var _prop_flat_purchase = document.forms[0].txt_purchasevalue_flat;
	var _prop_flat_market = document.forms[0].txt_marketvalue_flat;
	var _prop_flat_valuation = document.forms[0].txt_valuation_flat;
	//var _prop_bldg_estimate = document.forms[0].txt_construction_estimate;
	var _prop_bldg_txt_marketVal = document.forms[0].txt_marketVal;
	
	var _natureCharge = document.forms[0].sel_natureCharge;
	var _securitype = document.forms[0].sel_securitytype;
	
	var _securityclassifcation = document.forms[0].sel_securityclassifcation;
	var varPSterms = document.forms[0].hidPSparams.value.split("@");
	if(varPSterms!="")
	{
		if(vargovtscheme=="078" || vargovtscheme=="079")
		{
			if (trim(_prop_town.value) == '') {
				_prop_town.focus();
				ShowAlert('111', "Town");
				return false;
			}
		}
		disableFields(false);
	}
	else
	{
	if (document.forms[0].sel_securitytype.value == '0') {
		document.forms[0].sel_securitytype.focus();
		ShowAlert('111', "Security Type");
		return false;
	}
	if (document.forms[0].sel_securityclassifcation.value == '0') {
		document.forms[0].sel_securityclassifcation.focus();
		ShowAlert('111', "Security Classification");
		return false;
	}
	if (document.forms[0].sel_natureCharge.value == '0') {
		document.forms[0].sel_natureCharge.focus();
		ShowAlert('111', "Nature of Charge");
		return false;
	}
		
	if (document.forms[0].sel_house_type.value == '')
	{
		document.forms[0].sel_house_type.focus();
		ShowAlert('111', "Type of house");
		return false;
	}

	if (_purpose_of_loan.value == '0') {
		_purpose_of_loan.focus();
		ShowAlert('111', "Purpose of Loan");
		return false;
	}
	if (_take_over.value == '0') {
		_take_over.focus();
		ShowAlert('111', "Whether Take-Over");
		return false;
	}
	
	if (_purpose_of_loan.value == "M") {
		if(_property_type.value=="0")
		{
			_property_type.focus();
			ShowAlert('111', "Type of Property");
			return false;
		}
	}	
	
	/*if (trim(_age_premises.value) == '') {
		_age_premises.focus();
		ShowAlert('121', "age of the premises");
		return false;
	}*/
	if(var_loan_purpose=='H' ||var_loan_purpose=='R')
	{
	if (trim(_residual_age.value) == '') {
		_residual_age.focus();
		ShowAlert('121', "Residual life of premises");
		return false;
	}
	}
	if (_dist_from_branch.value == '0' || trim(_dist_from_branch.value) == '') {
		_dist_from_branch.focus();
		ShowAlert('121', "Distance from Branch");
		return false;
	}
	
	if (_purpose_of_loan.value == "M") {
		if(_already_mortgaged.value=="0")
		{
			_already_mortgaged.focus();
			ShowAlert('111', "Whether Property Already Mortgaged?");
			return false;
		}
	}
	
	if (_prop_location.value == '0') {
		_prop_location.focus();
		ShowAlert('111', "Location of Property");
		return false;
	}
	if (trim(_prop_survey_no.value) == '') {
		_prop_survey_no.focus();
		ShowAlert('121', "Survey No.");
		return false;
	}
	if (trim(_prop_plot_no.value) == '') {
		_prop_plot_no.focus();
		ShowAlert('121', "House/Plot No.");
		return false;
	}
	if (trim(_prop_street.value) == '') {
		_prop_street.focus();
		ShowAlert('121', "Street");
		return false;
	}
	if (trim(_prop_taluk.value) == '') {
		_prop_taluk.focus();
		ShowAlert('121', "Taluk");
		return false;
	}
	if (trim(_prop_city.value) == '') {
		_prop_city.focus();
		ShowAlert('121', "City");
		return false;
	}
	if (trim(_prop_district.value) == '') {
		_prop_district.focus();
		ShowAlert('121', "District");
		return false;
	}
	if (trim(_prop_state.value) == '') {
		_prop_state.focus();
		ShowAlert('121', "State");
		return false;
	}
	if(vargovtscheme=="078" || vargovtscheme=="079")
	{
		if (trim(_prop_town.value) == '') {
			_prop_town.focus();
			ShowAlert('111', "Town");
			return false;
		}
	}
	
	if (trim(_prop_pincode.value) == '') {
		_prop_pincode.focus();
		ShowAlert('121', "Pincode");
		return false;
	}

	if (_purpose_of_loan.value == "C") {

		if (_prop_builtup_area.value == '0.00' || _prop_builtup_area.value == '0'
				|| trim(_prop_builtup_area.value) == '') {
			_prop_builtup_area.focus();
			ShowAlert('121', "Floor Space/Builtup Area");
			return false;
		}
		//if (_prop_bldg_estimate.value == '0.00' || trim(_prop_bldg_estimate.value) == '') {
		//	_prop_bldg_estimate.focus();
		//	ShowAlert('121', "Estimated Cost of Construction");
		//	return false;
		//}

	} else if (_purpose_of_loan.value == "H") {

		if (_prop_builtup_area.value == '0.00' || _prop_builtup_area.value == '0'
				|| trim(_prop_builtup_area.value) == '') {
			_prop_builtup_area.focus();
			ShowAlert('121', "Floor Space/Builtup Area");
			return false;
		}
		if (_prop_flat_market.value == '0.00' || trim(_prop_flat_market.value) == '') {
			_prop_flat_market.focus();
			ShowAlert('121', "Market Value of Building/Flat");
			return false;
		}
		if (_prop_flat_purchase.value == '0.00' || trim(_prop_flat_purchase.value) == '') {
			_prop_flat_purchase.focus();
			ShowAlert('121', "Purchase Value of Building/Flat");
			return false;
		}
		if (_prop_flat_valuation.value == '0.00' || trim(_prop_flat_valuation.value) == '') {
			_prop_flat_valuation.focus();
			ShowAlert('121', "Valuation Value of Building/Flat");
			return false;
		}
		if (_proj_name.value == '') {
			ShowAlert('121', "Project Name");
			_proj_name.focus();
			return false;
		}

		if (_proj_finance.value == '0') {
			_proj_finance.focus();
			ShowAlert('111',
					"Whether the project finance is sanctioned in our bank");
			return false;
		}

	} else if (_purpose_of_loan.value == "S") {

		if (_prop_site_area.value == '0.00' || _prop_site_area.value == '0' || trim(_prop_site_area.value) == '') {
			_prop_site_area.focus();
			ShowAlert('121', "Area of Site");
			return false;
		}
		if (_prop_builtup_area.value == '0.00' || _prop_builtup_area.value == '0'
				|| trim(_prop_builtup_area.value) == '') {
			_prop_builtup_area.focus();
			ShowAlert('121', "Floor Space/Builtup Area");
			return false;
		}
		if (_prop_site_market.value == '0.00' || trim(_prop_site_market.value) == '') {
			_prop_site_market.focus();
			ShowAlert('121', "Market Value of Site");
			return false;
		}
		if (_prop_site_purchase.value == '0.00' || trim(_prop_site_purchase.value) == '') {
			_prop_site_purchase.focus();
			ShowAlert('121', "Purchase Value of Site");
			return false;
		}
			//	if (_prop_bldg_estimate.value == '0.00' || trim(_prop_bldg_estimate.value) == '') {
			//_prop_bldg_estimate.focus();
			///ShowAlert('121', "Estimated Cost of Construction");
			//return false;
		//}
	} else if (_purpose_of_loan.value == "R") {

		if (_prop_builtup_area.value == '0.00' || _prop_builtup_area.value == '0'
				|| trim(_prop_builtup_area.value) == '') {
			_prop_builtup_area.focus();
			ShowAlert('121', "Floor Space/Builtup Area");
			return false;
		}
		if (_prop_bldg_txt_marketVal.value == '0.00' || trim(_prop_bldg_txt_marketVal.value) == '') {
			_prop_bldg_txt_marketVal.focus();
			ShowAlert('121', "Market Value of the Property");
			return false;
		}

	} else if (_purpose_of_loan.value == "G") {

		if (_prop_site_area.value == '0.00' || _prop_site_area.value == '0' || trim(_prop_site_area.value) == '') {
			_prop_site_area.focus();
			ShowAlert('121', "Area of Site");
			return false;
		}
		if (_prop_site_market.value == '0.00' || trim(_prop_site_market.value) == '') {
			_prop_site_market.focus();
			ShowAlert('121', "Market Value of Plot");
			return false;
		}
		if (_prop_site_purchase.value == '0.00' || trim(_prop_site_purchase.value) == '') {
			_prop_site_purchase.focus();
			ShowAlert('121', "Purchase Value of Plot");
			return false;
		}
		if (_prop_site_valuation.value == '0.00' || trim(_prop_site_valuation.value) == '') {
			_prop_site_valuation.focus();
			ShowAlert('121', "Valuation Value of Plot");
			return false;
		}

	} else if (_purpose_of_loan.value == "M") {
		if(_property_type.value=="0")
		{
			_property_type.focus();
			ShowAlert('111', "Type of Property");
			return false;
		}
		if(_already_mortgaged.value=="0")
		{
			_already_mortgaged.focus();
			ShowAlert('111', "Whether Property Already Mortgaged?");
			return false;
		}
		if(_property_type.value=="L")
		{
			if (_prop_site_area.value == '0.00' || _prop_site_area.value == '0' || trim(_prop_site_area.value) == '') {
				_prop_site_area.focus();
				ShowAlert('121', "Area of Site");
				return false;
			}
			if (_prop_site_market.value == '0.00' || trim(_prop_site_market.value) == '') {
				_prop_site_market.focus();
				ShowAlert('121', "Market Value of Site");
				return false;
			}
			if (_prop_site_purchase.value == '0.00' || trim(_prop_site_purchase.value) == '') {
				_prop_site_purchase.focus();
				ShowAlert('121', "Purchase Value of Site");
				return false;
			}
			if (_prop_site_valuation.value == '0.00' || trim(_prop_site_valuation.value) == '') {
				_prop_site_valuation.focus();
				ShowAlert('121', "Valuation Value of Site");
				return false;
			}
		} else {
		if (_prop_builtup_area.value == '0.00' || _prop_builtup_area.value == '0'
				|| trim(_prop_builtup_area.value) == '') {
			_prop_builtup_area.focus();
			ShowAlert('121', "Floor Space/Builtup Area");
			return false;
		}
		if (_prop_flat_market.value == '0.00' || trim(_prop_flat_market.value) == '') {
			_prop_flat_market.focus();
			ShowAlert('121', "Market Value of Building/Flat");
			return false;
		}
		if (_prop_flat_purchase.value == '0.00' || trim(_prop_flat_purchase.value) == '') {
			_prop_flat_purchase.focus();
			ShowAlert('121', "Purchase Value of Building/Flat");
			return false;
		}
		if (_prop_flat_valuation.value == '0.00' || trim(_prop_flat_valuation.value) == '') {
			_prop_flat_valuation.focus();
			ShowAlert('121', "Valuation Value of Building/Flat");
			return false;
		}
		}
	}
	if(document.forms[0].chk_mainroad.value=="")
	{
		ShowAlert('111', "Near by Main Road");
		document.forms[0].chk_mainroad.focus();
		return false;
	}
	else if(document.forms[0].chk_eduinstitution.value=="")
	{
		ShowAlert('111', "Near by Market/ Educational Institution");
		document.forms[0].chk_eduinstitution.focus();
		return false;
	}
	else if(document.forms[0].chk_public.value=="")
	{
		ShowAlert('111', "Near by Other Public Utilities");
		document.forms[0].chk_public.focus();
		return false;
	}
	else if(document.forms[0].chk_prime.value=="")
	{
		ShowAlert('111', "Neighbourhood - Prime/ Suburb");
		document.forms[0].chk_prime.focus();
		return false;
	}
	else if(document.forms[0].chk_accessible.value=="")
	{
		ShowAlert('111', "Accessible to Road");
		document.forms[0].chk_accessible.focus();
		return false;
	}
	else if(document.forms[0].chk_assured.value=="")
	{
		ShowAlert('111', "Assured water supply");
		document.forms[0].chk_assured.focus();
		return false;
	}
	else if(document.forms[0].chk_drainages.value=="")
	{
		ShowAlert('111', "Proper Drainage System/ Not pruned to water logging");
		document.forms[0].chk_drainages.focus();
		return false;
	}
	else if(document.forms[0].chk_currentconnection.value=="")
	{
		ShowAlert('111', "Current Connection available");
		document.forms[0].chk_currentconnection.focus();
		return false;
	}
	
	for ( var i = 0; i < document.forms[0].elements.length; i++)
	{
		if(document.forms[0].elements[i].type == "select-one")
		{
			document.forms[0].elements[i].disabled = false;
		}
	}
	totalval();
	}
	//security creation removed while saving proposed offered asset tab
	//var rowCount=document.all.id_jointsec.rows.length;
	//document.forms[0].hidOwners.value=rowCount;
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].hidBeanId.value = "perpropertydetails";
	document.forms[0].hidBeanMethod.value = "updateHousingLoanData";
	document.forms[0].hidBeanGetMethod.value = "getHousingLoanData";
	//document.forms[0].hidAction.value = "insert";
	document.forms[0].hidSourceUrl.value = "/action/per_house_proposed_asset.jsp";
	//disableCommandButtons(true, true, true, true, true);
	document.forms[0].submit();
}
function doCancel() {
	if (ConfirmMsg('102')) {
		document.forms[0].action = appURL+ "action/per_house_proposed_asset.jsp";
		document.forms[0].hidBeanId.value = "perpropertydetails";
		document.forms[0].hidBeanGetMethod.value = "getHousingLoanData";
		document.forms[0].submit();
	}
}
function doDelete() {
//security creation removed while saving proposed offered asset tab
	//if (varRecordflag == "Y") {
		if (ConfirmMsg(101)) {
			//var rowCount=document.all.id_jointsec.rows.length;
			//document.forms[0].hidOwners.value=rowCount;
			document.forms[0].action = appURL + "controllerservlet";
			document.forms[0].hidBeanId.value = "perpropertydetails";
			document.forms[0].hidAction.value = "delete";
			document.forms[0].hidBeanMethod.value = "updateHousingLoanData";
			document.forms[0].hidBeanGetMethod.value = "getHousingLoanData";
			document.forms[0].hidSourceUrl.value = "/action/per_house_proposed_asset.jsp";
			document.forms[0].submit();
		}
//	} else {
		//ShowAlert('158');
	//}
}
function doClose() {
	var con = ConfirmMsg('100');
	if (con) {
		document.forms[0].action = appURL + "action/persearch.jsp";
		document.forms[0].submit();
	}
}
function onLoad() {
	/*document.all.mand.style.display = "none";	
	document.all.notmand.style.display = "block";	
	hideFields();
	ClearFields();
	disableFields(true);
	document.all.radiobutton.disabled=false;*/
//	enableButtons(false, true, true, false, true,true);
	
	document.all.mand.style.display = "none";	
	document.all.notmand.style.display = "table-cell";	
/*	var _loan_purpose = document.forms[0].sel_purpose_of_loan;
	document.forms[0].sel_take_over.value=vartakecare;
	//var _take_over = document.forms[0].sel_take_over;
	var _prop_type = document.forms[0].sel_property_type;
	var _prop_nature = document.forms[0].sel_property_nature;
	var _prop_usedfor = document.forms[0].txt_property_for;
	var _prop_location = document.forms[0].sel_property_location;
	var _project_finance = document.forms[0].sel_projfin_sanc;
	var _loc_road = document.forms[0].chk_mainroad;
	var _loc_market = document.forms[0].chk_eduinstitution;
	var _loc_public = document.forms[0].chk_public;
	var _loc_neighbourhood = document.forms[0].chk_prime;
	var _ame_road = document.forms[0].chk_accessible;
	var _ame_water = document.forms[0].chk_assured;
	var _ame_drainage = document.forms[0].chk_drainages;
	var _ame_electricity = document.forms[0].chk_currentconnection;
	var _already_mortgage = document.forms[0].sel_already_mortgaged;
    var _securitype = document.forms[0].sel_securitytype;
    var _natureCharge = document.forms[0].sel_natureCharge;
    
    if(var_natureCharge!="" && var_natureCharge!=null)
	{
    	_natureCharge.value = var_natureCharge;
	} else {
		_natureCharge.value ="0";
	}
	if(var_loan_purpose!="" && var_loan_purpose!=null)
	{
		_loan_purpose.value = var_loan_purpose;
	} else {
		_loan_purpose.value ="0";
	}
	//if(var_take_over!="" && var_take_over!=null)
	//{
	//	_take_over.value = var_take_over;
	//} else {
	//	_take_over.value ="0";
	//}
	if(var_prop_type!="" && var_prop_type!=null)
	{
		_prop_type.value = var_prop_type;
	} else {
		_prop_type.value ="0";
	}
	if(var_prop_nature!="" && var_prop_nature!=null)
	{
		_prop_nature.value = var_prop_nature;
	} else {
		_prop_nature.value ="0";
	}
	if(var_prop_usedfor!="" && var_prop_usedfor!=null)
	{
		_prop_usedfor.value = var_prop_usedfor;
	} else {
		_prop_usedfor.value ="0";
	}
	if(var_prop_location!="" && var_prop_location!=null)
	{
		_prop_location.value = var_prop_location;
	} else {
		_prop_location.value ="0";
	}
	if(var_project_finance!="" && var_project_finance!=null)
	{
		_project_finance.value = var_project_finance;
	} else {
		_project_finance.value ="0";
	}
	
	if (var_loc_road != "") {
		_loc_road.value = var_loc_road;
	} 
	if (var_loc_market != "") {
		_loc_market.value = var_loc_market;
	} 
	if (var_loc_public != "") {
		_loc_public.value = var_loc_public;
	} 
	if (var_loc_neighbourhood != "") {
		_loc_neighbourhood.value = var_loc_neighbourhood;
	} 
	if (var_ame_road != "") {
		_ame_road.value = var_ame_road;
	}
	if (var_ame_water != "") {
		_ame_water.value = var_ame_water;
	}
	if (var_ame_drainage != "") {
		_ame_drainage.value = var_ame_drainage;
	} 
	if (var_ame_electricity != "") {
		_ame_electricity.value = var_ame_electricity;
	} 
	if(var_already_mortgage!="")
	{
		_already_mortgage.value=var_already_mortgage;
	} else {
		_already_mortgage.value="0";
	}
	if(varsecurtype!="")
	{
		_securitype.value=varsecurtype;
		
		//callSecurityType();
		
		if(varsecurclassfic!="")
		{
			document.forms[0].sel_securityclassifcation.value = varsecurclassfic;
		}
	} else 
	{
		_securitype="0";
	}
    if(var_loan_purpose!="" && var_loan_purpose!=null)
	{
		_loan_purpose.value = var_loan_purpose;
	} else {
		_loan_purpose.value ="0";
	}
	if(var_loan_purpose=='H' ||var_loan_purpose=='R')
	{
		document.all.idage.style.visibility = "visible";
		document.all.idage.style.position = "relative";
		document.all.idage2.style.visibility = "visible";
		document.all.idage2.style.position = "relative";
		document.all.Residual.style.visibility = "visible";
		document.all.Residual.style.position = "relative";
		document.all.Residual1.style.visibility = "visible";
		document.all.Residual1.style.position = "relative";
		
	}
	else
	{
		document.all.idage.style.visibility = "hidden";
		document.all.idage.style.position = "absolute";
		document.all.idage2.style.visibility = "hidden";
		document.all.idage2.style.position = "absolute";
		document.all.Residual.style.visibility = "hidden";
		document.all.Residual.style.position = "absolute";
		document.all.Residual1.style.visibility = "hidden";
		document.all.Residual1.style.position = "absolute";
	}
	
	document.forms[0].sel_house_type.value=varhousetype;*/
	//hideFields();
	ClearFields();
	disableFields(true);
	if(varprd_type=="pH"){
		document.forms[0].cmdnew.disabled=true;
	}
	//enableButtons(false, true, true, false, true,true);
	
	//document.all.radiobutton.disabled=false;
	//if(varstrFreeze=='Y')
	//{
		//document.forms[0].cmdedit.disabled=true;
		//document.forms[0].cmdsave.disabled=true;
	//}
	//security creation removed while saving proposed offered asset tab
	//document.all.id_jointsec.style.visibility = "hidden";
	//document.all.id_jointsec.style.position = "absolute";
	//document.all.id_ownerdet.style.visibility = "hidden";
	//document.all.id_ownerdet.style.position = "absolute";
	
	//if(document.forms[0].hidSecValue.value!="")
	//{
		//document.forms[0].sel_jointholder.value = document.forms[0].hidSecValue.value;
	//}
	//else
	//{
		//document.forms[0].sel_jointholder.value = "";
	//}
	//var securityowners=document.forms[0].hidJointOwnValue.value;
	//selJointHolder();
	//jointownerdisp(securityowners);
	
}
function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function calltakeover()
{	
    var varQryString = appURL+"action/per_takeover.jsp?hidBeanId=pertakeover&hidBeanGetMethod=getData&appno="+ appno+"&btnenable="+document.forms[0].btnenable.value+"&pagefrom=per_house";
	var title = "Cost and Source";
	var prop = "scrollbars=yes,width=800,height=550";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);	
}
function openGeneral()
{	
	var varQryString = appURL+"action/propgeninfo.jsp?hidBeanId=perpropertydetails&hidBeanGetMethod=getGeneralInfo&hidBeanMethod=updateGeneralInfo&appno="+ appno+"&app_name="+document.forms[0].appname.value+"&app_status="+varAppStatus+"&btnenable="+document.forms[0].btnenable.value;
	var title = "General Information";
	var prop = "scrollbars=yes,width=600,height=400, menubar=yes";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);
}

function opendisbursement()
{
	var varQryString = appURL+"action/disburdetails.jsp?hidBeanId=perpropertydetails&hidBeanGetMethod=getdisbursementdetails&appno="+ appno+"&btnenable="+document.forms[0].btnenable.value;
	var title = "Cost and Source";
	var prop = "scrollbars=yes,width=700,height=450";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);
}
function checkAgePremises(){
	
	var type = document.forms[0].sel_purpose_of_loan.value;
	var age_premises = document.forms[0].txt_premises_age.value;	
	var repLimit = 12 * varLimit;
	if(type=="H"){
		
		if(age_premises>25 && varRepayment>repLimit){
			alert("Repayment Period cannot be greater than "+varLimit+" Years");

		}
	}	
}
function checkResidualLife(){

	var type = document.forms[0].sel_purpose_of_loan.value;
	var age_premises = document.forms[0].txt_premises_age.value;	
	
	var age_residual = document.forms[0].txt_residual_life.value;
	var repay_yrs = 2*(varRepayment/12);
	if(type=="H"){
		if(age_premises>25 && age_residual<repay_yrs){			
			alert("Residual Life Should be Double than Repayment Period");
			//document.forms[0].txt_residual_life.value="";
		}
	}
	
}
function callSecurityType() {
	var vartype=document.forms[0].hidsecClass.value;
	var varSecurityType = document.forms[0].sel_securitytype.options[document.forms[0].sel_securitytype.selectedIndex].value;
	document.all.ifrmsecurityclassification.src = appURL
			+ "action/ifrmsecurityclassification.jsp?hidBeanGetMethod=getSecurityClassification&hidBeanId=securitymaster&securityclassificationtype="
			+ varSecurityType + "&sectype1=" +vartype;
/*	if(document.forms[0].hidsecClass.value!="")
	{
		alert();
		document.forms[0].sel_securityclassifcation.value =document.forms[0].hidsecClass.value;	
		var varSecurityType = document.forms[0].sel_securitytype.options[document.forms[0].sel_securitytype.selectedIndex].value;
		document.all.ifrmsecurityclassification.src = appURL
				+ "action/ifrmsecurityclassification.jsp?hidBeanGetMethod=getSecurityClassification&hidBeanId=securitymaster&securityclassificationtype="
				+ varSecurityType + "&sectype=" + document.forms[0].hidsecClass.value+ "&pagefrom=house;	
	}*/
}
function selJointHolder()
{
	if (document.forms[0].sel_jointholder.value == "Y") {			
		document.all.ownership.style.visibility = "visible";
		document.all.ownership.style.position = "relative";
		document.all.ownership1.style.visibility = "visible";
		document.all.ownership1.style.position = "relative";
		document.all.id_jointsec.style.visibility="visible";
		document.all.id_jointsec.style.position="relative";
		document.all.id_ownerdet.style.visibility = "visible";
		document.all.id_ownerdet.style.position = "relative";
		
	} else{
		
		document.all.ownership.style.visibility = "hidden";
		document.all.ownership.style.position = "absolute";
		document.all.ownership1.style.visibility = "hidden";
		document.all.ownership1.style.position = "absolute";
		document.all.id_jointsec.style.visibility="hidden";
		document.all.id_jointsec.style.position="absolute";
		document.all.id_ownerdet.style.visibility = "hidden";
		document.all.id_ownerdet.style.position = "absolute";
	}

}
function callAddJointSecurity() 
{
	jointOwnerList();
	var varJointSecurity="JointSecurity";
	var varQryString = appURL + "action/addjointsecurities.jsp?ownerList="+varOwnerList+"&jointSecurity="+varJointSecurity;
	var title = "ADD";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);
	varOwnerList="";
}
	function jointSecurityDel()
	{
	   var table=document.all.id_jointsec;
	   var rowCount=table.rows.length;
	   var varRemove="Y";
	   var varNotSelected="Y";	 
	   var rowCheck=rowCount;
	   
	   
	   for(var i=1;i<rowCount;i++)
	   { if(rowCount==2)
		 {
				 if((varOldAppId==document.getElementById("id_jointsec").rows[i].cells[2].innerHTML)&&(document.forms[0].rad_chk.checked==true))
				   {
					 alert("record can not be deleted");
					 varNotSelected="N"; 
				   }else if((varOldAppId!=document.getElementById("id_jointsec").rows[i].cells[2].innerHTML)&&(document.forms[0].rad_chk.checked==true))
				   {
						table.deleteRow(i); 
						document.forms[0].hidDeleteOwn.value=var_row;
						--rowCount; 
						varNotSelected="N";
						--var_row;
				   } 
		 }else
		 {	   
				   if((varOldAppId==document.getElementById("id_jointsec").rows[i].cells[2].innerHTML)&&(document.forms[0].rad_chk[i-1].checked==true))
				   {
					   alert("record can not be deleted");
					   varNotSelected="N";
				   }else if((varOldAppId!=document.getElementById("id_jointsec").rows[i].cells[2].innerHTML)&&(document.forms[0].rad_chk[i-1].checked==true))
				   {
						table.deleteRow(i); 
						document.forms[0].hidDeleteOwn.value=var_row;
						--rowCount; 
						varNotSelected="N";
						--var_row;
				   }		   
	    }
	  }
	   if((varNotSelected=="Y")&&(rowCheck=="2"))
	   {
		   alert("record can not be deleted");
	   }else if(varNotSelected=="Y")
	   {
		   alert("Please click the button to remove");
	   }		
	}
	
	function callLAPSID(id,row)
	{
		document.forms[0].txt_security_ownership.value=id;	
		var_row=row;
	}

	function jointownerdisp(securityowners)
	{
		var var_arr= securityowners.split("@");
		var length=var_arr.length;
		var k=0;
		for(var i=0;i<length-1;i=i+4)
		{
			var j=i;
			var table=document.all.id_jointsec;
			var rowCount=table.rows.length;
			
			var row=table.insertRow(rowCount);
			var varName=var_arr[j];
			var varLapsID=var_arr[++j];
			var varCBSID=var_arr[++j];
			var varSecID=var_arr[++j];
			
			var cell0=row.insertCell(0);
			cell0.className="datagrid";
			cell0.innerHTML='<input type="radio" style="border-style:none" name="rad_chk" onclick="callLAPSID('+varLapsID+','+(++k)+')">';		
			
			var cell1=row.insertCell(1);
			cell1.className="datagrid";
			cell1.innerHTML=varName;
			
			var cell2=row.insertCell(2);
			cell2.className="datagrid";
			cell2.innerHTML=varLapsID;

			var cell3=row.insertCell(3);
			cell3.className="datagrid";
			cell3.innerHTML=varCBSID;
			
			var cell4=row.insertCell(4);
			cell4.className="datagrid";
			cell4.innerHTML=varSecID;

			var cell5=row.insertCell(5);
			cell5.className="datagrid";
			var element5=document.createElement("input");
			element5.type="hidden";
			element5.name="hid_jointID["+rowCount+"]";
			element5.value=varLapsID;
			cell5.appendChild(element5);			
		}

	}
	
	function totalval()
	{
		if(document.forms[0].sel_purpose_of_loan.value == "R" || document.forms[0].sel_purpose_of_loan.value == "C")
		{
			document.forms[0].txt_rennovation_bldg.value = parseFloat(document.forms[0].txt_cost_renovation.value) + parseFloat(document.forms[0].txt_marketVal.value);
		}		 
	}
	function jointOwnerList()
	{
		var table=document.all.id_jointsec;
		var rowCount=table.rows.length;	
		varOwnerList="@"+varOldAppId;
		for(var i=1;i<rowCount;i++)
		{
		varOwnerList=varOwnerList+"@"+document.getElementById("id_jointsec").rows[i].cells[2].innerHTML;
		}		
	}
	function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val31,val32,val33,val34,val35,val36,val37,val38,val39,val40,val41,val42,val43,val44,val45,val46,val47,val48,val49,val50,val51,val52,val53,val54,val55,val56,val57,val58,val59,val60)
	{	
		document.forms[0].sel_purpose_of_loan.value=val2;
		document.forms[0].sel_take_over.value=val3;
		document.forms[0].sel_property_type.value=val4;
		document.forms[0].sel_property_nature.value = val5;
		document.forms[0].txt_property_for.value = val6;
		document.forms[0].txt_branch_distance.value =val9;
		document.forms[0].txt_residual_life.value =val8;
		document.forms[0].txt_premises_age.value = val7;
		document.forms[0].sel_securitytype.value = val46;
		document.forms[0].sel_securityclassifcation.value = val47;
		document.forms[0].hidsecClass.value = val47;
		document.forms[0].sel_natureCharge.value = val48;
		document.forms[0].sel_house_type.value =val50;
		document.forms[0].sel_already_mortgaged.value = val45;	
		document.forms[0].sel_property_location.value = val10;
		document.forms[0].txt_survey_no.value = val11;
		document.forms[0].txt_plot_no.value = val12;
		document.forms[0].txt_addr_street.value =val13;
		document.forms[0].txt_addr_taluk.value = val14;
		document.forms[0].txt_addr_city.value = val15;
		document.forms[0].hidcity.value = val16;
		document.forms[0].txt_addr_district.value =val17;
		document.forms[0].hid_dist.value = val18;
		document.forms[0].txt_addr_state.value =val19;
		document.forms[0].hidstate.value =val20;
		document.forms[0].txt_addr_town.value =val57;
		document.forms[0].hidtown.value = val51;
		document.forms[0].txt_addr_pincode.value =val21;

		document.forms[0].txt_area_site.value = val22;
		if(val2=="S")
			document.forms[0].txt_area_floorspace.value = val23;
		else 
			document.forms[0].txt_area_floorspace.value = val23;
		
		document.forms[0].txt_marketvalue_site.value = val24;
		document.forms[0].txt_purchasevalue_site.value = val25;
		document.forms[0].txt_marketvalue_flat.value =val58;
		document.forms[0].txt_purchasevalue_flat.value = val28;
		document.forms[0].txt_cost_renovation.value = val60;
		document.forms[0].txt_metloanpremium.value = var_metlife;
		document.forms[0].txt_marketVal.value =  val58;
		document.forms[0].txt_construction_estimate.value = val30;
		document.forms[0].txt_rennovation_bldg.value =val31;
		if(val2=="G")
			document.forms[0].txt_valuation_site.value = val59;
		else 
			document.forms[0].txt_valuation_site.value = val26;
		
		document.forms[0].txt_valuation_flat.value = val59;//forced
		
		document.forms[0].txt_project_name.value = val32;
		document.forms[0].txt_builder_name.value = val34;
		document.forms[0].txtar_project_details.value = val33;
		document.forms[0].txtar_builder_background.value = val35;
		document.forms[0].sel_projfin_sanc.value = val36;
		document.forms[0].chk_mainroad.value = val37;
		document.forms[0].chk_eduinstitution.value = val38;
		document.forms[0].chk_public.value = val39;
		document.forms[0].chk_prime.value = val40;
		document.forms[0].chk_accessible.value =val41 ;
		document.forms[0].chk_assured.value =val42 ;
		document.forms[0].chk_drainages.value = val43;
		document.forms[0].chk_currentconnection.value = val44;
		document.forms[0].hidsnmbr.value = val53;
		document.forms[0].hidsecID.value=val54;
		document.forms[0].hidSecurityId.value=val54;
		
		if(val46!="")
		{
			document.forms[0].sel_securitytype.value = val46;
			callSecurityType();
		} else 
		{
			document.forms[0].sel_securitytype.value ="0";
		}
		var_loan_purpose=val2;
		
		document.all.mand.style.display = "none";	
		document.all.notmand.style.display = "table-cell";
		
		if(var_loan_purpose=='H' ||var_loan_purpose=='R')
		{
			document.all.idage.style.visibility = "visible";
			document.all.idage.style.position = "relative";
			document.all.idage2.style.visibility = "visible";
			document.all.idage2.style.position = "relative";
			document.all.Residual.style.visibility = "visible";
			document.all.Residual.style.position = "relative";
			document.all.Residual1.style.visibility = "visible";
			document.all.Residual1.style.position = "relative";
			
		}
		else
		{
			document.all.idage.style.visibility = "hidden";
			document.all.idage.style.position = "absolute";
			document.all.idage2.style.visibility = "hidden";
			document.all.idage2.style.position = "absolute";
			document.all.Residual.style.visibility = "hidden";
			document.all.Residual.style.position = "absolute";
			document.all.Residual1.style.visibility = "hidden";
			document.all.Residual1.style.position = "absolute";
		}
		hideFields();
		totalval();
		disableFields(true);
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			enableButtons(true,false,true,false,false,false);
			
			var varPSterms = document.forms[0].hidPSparams.value.split("@");
			if(varPSterms!="")
			{
				document.forms[0].cmdedit.disabled=true;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
			
			document.all.Town_pop.style.visibility="visible";
			document.all.Town_pop.style.posistion="relative";
			
			for(var i=0;i<varPSterms.length;i++)
			{
				if(varPSterms[i] == "MODGSS")
				{
					if(vargovtscheme=="078" || vargovtscheme=="079")
					{
						document.all.Town_pop.style.visibility="visible";
						document.all.Town_pop.style.posistion="relative";
						document.forms[0].cmdedit.disabled=false;
						document.forms[0].cmddelete.disabled=false;
						document.forms[0].cmdcancel.disabled=false;
					}
					else
					{
						document.all.Town_pop.style.visibility="hidden";
						document.all.Town_pop.style.posistion="absolute";
					}
				}
			}
		}
		/*if(document.forms[0].sel_branchpanel.value=="Y")
		{	
			document.all.b1.style.visibility="visible";
		}
		else if(document.forms[0].sel_branchpanel.value=="N")
		{
			document.all.b1.style.visibility="hidden";
		}*/
	}
	