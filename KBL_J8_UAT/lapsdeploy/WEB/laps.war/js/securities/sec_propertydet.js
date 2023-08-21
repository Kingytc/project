function callOnLoad()
{
	document.forms[0].cmdedit.disabled=true;
	Totalvalue();
	disableFields(true);
	disableButtons(false,true,true,true,false);
	if(varPropertyType!="")
	{
		document.forms[0].sel_PropertyType.value=varPropertyType;
		document.forms[0].old_sel_PropertyTypeText.value = document.forms[0].sel_PropertyType.options[document.forms[0].sel_PropertyType.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_PropertyType.value="";
		document.forms[0].old_sel_PropertyTypeText.value = ""; 
	}
	if(varMeasurement!="")
	{
		document.forms[0].sel_Measurement.value=varMeasurement;
		document.forms[0].old_sel_MeasurementText.value = document.forms[0].sel_Measurement.options[document.forms[0].sel_Measurement.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_Measurement.value="";
		document.forms[0].old_sel_MeasurementText.value = ""; 
	}
	
	if(varAcquired!="")
	{
		document.forms[0].sel_Acquired.value=varAcquired;
		document.forms[0].old_sel_AcquiredText.value = document.forms[0].sel_Acquired.options[document.forms[0].sel_Acquired.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_Acquired.value="";
		document.forms[0].old_sel_AcquiredText.value = ""; 
	}
	if(varExtnMeasurement!="")
	{
		document.forms[0].sel_extofbuildMeas.value=varExtnMeasurement;
		document.forms[0].old_sel_extofbuildMeasText.value = document.forms[0].sel_extofbuildMeas.options[document.forms[0].sel_extofbuildMeas.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_extofbuildMeas.value="";
		document.forms[0].old_sel_extofbuildMeasText.value =""; 
	}
	if(varCoveredMeasurement!="")
	{
		document.forms[0].sel_extofgroundMeas.value=varCoveredMeasurement;
		document.forms[0].old_sel_extofgroundMeasText.value = document.forms[0].sel_extofgroundMeas.options[document.forms[0].sel_extofgroundMeas.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_extofgroundMeas.value="";
		document.forms[0].old_sel_extofgroundMeasText.value =""; 
	}
	if(varNotCoveredMeasurement!="")
	{
		document.forms[0].sel_extnotcoveredMeas.value=varNotCoveredMeasurement;
		document.forms[0].old_sel_extnotcoveredMeasText.value = document.forms[0].sel_extnotcoveredMeas.options[document.forms[0].sel_extnotcoveredMeas.selectedIndex].text; 
	}
	else 
	{
		document.forms[0].sel_extnotcoveredMeas.value="";
		document.forms[0].old_sel_extnotcoveredMeasText.value = ""; 
	}
	if(varsecboundaries!="")
	{
		document.forms[0].sel_boundaries.value=varsecboundaries;
		document.forms[0].old_sel_boundariesText.value = document.forms[0].sel_boundaries.options[document.forms[0].sel_boundaries.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_boundaries.value="";
		document.forms[0].old_sel_boundariesText.value = ""; 
	}
	if(varselpropacquisition!="")
	{
		document.forms[0].sel_propacquisition.value=varselpropacquisition;
		document.forms[0].old_sel_propacquisitionText.value = document.forms[0].sel_propacquisition.options[document.forms[0].sel_propacquisition.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_propacquisition.value="";
		document.forms[0].old_sel_propacquisitionText.value="";
	}
	if(varselpropnewtype!="")
	{
		document.forms[0].sel_prop.value=varselpropnewtype;
		document.forms[0].old_sel_propText.value = document.forms[0].sel_prop.options[document.forms[0].sel_prop.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_prop.value="";
		document.forms[0].old_sel_propText.value="";
	}
	if(varWHT_PROJECTAPPROVED!="")
	{
		document.forms[0].sel_whtprojapr.value=varWHT_PROJECTAPPROVED;
		document.forms[0].old_sel_whtprojaprText.value = document.forms[0].sel_whtprojapr.options[document.forms[0].sel_whtprojapr.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_whtprojapr.value="";
		document.forms[0].old_sel_whtprojaprText.value="";
	}
	if(document.forms[0].sel_PropertyType.value=="F" || document.forms[0].sel_PropertyType.value=="H" ){
		document.all.ext_build.style.visibility = "visible";
	}
	else{
		document.all.ext_build.style.visibility = "hidden";
	}
	//callShowMeasurement();
	
	/*document.forms[0].sel_whtalrmortobnk.value=VARSECPROPOBSERVED;   
	document.forms[0].sel_whtbnkchrgreflct.value=VARCHARGREFLECT;   
	document.forms[0].sel_anychrgonprop.value=VARPROPOBSERVED;  */
	
	if(VARSECPROPOBSERVED!="")
	{
		document.forms[0].sel_whtalrmortobnk.value=VARSECPROPOBSERVED;
		document.forms[0].old_sel_whtalrmortobnktext.value = document.forms[0].sel_whtalrmortobnk.options[document.forms[0].sel_whtalrmortobnk.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_whtalrmortobnk.value="";
		document.forms[0].old_sel_whtalrmortobnktext.value="";
	}
	
	if(VARCHARGREFLECT!="")
	{
		document.forms[0].sel_whtbnkchrgreflct.value=VARCHARGREFLECT;
		document.forms[0].old_sel_whtbnkchrgreflcttext.value = document.forms[0].sel_whtbnkchrgreflct.options[document.forms[0].sel_whtbnkchrgreflct.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_whtbnkchrgreflct.value="";
		document.forms[0].old_sel_whtbnkchrgreflcttext.value="";
	}
	
	if(VARPROPOBSERVED!="")
	{
		document.forms[0].sel_anychrgonprop.value=VARPROPOBSERVED;
		document.forms[0].old_sel_anychrgonproptext.value = document.forms[0].sel_anychrgonprop.options[document.forms[0].sel_anychrgonprop.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_anychrgonprop.value="";
		document.forms[0].old_sel_anychrgonproptext.value="";
	}
	
	if(VARCROPTYPE!="")
	{
		document.forms[0].sel_corpType.value=VARCROPTYPE;
		document.forms[0].old_sel_corpTypetext.value = document.forms[0].sel_corpType.options[document.forms[0].sel_corpType.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_corpType.value="";
		document.forms[0].old_sel_corpTypetext.value="";
	}
}
function doEdit()
{
	if(varleasehold=="0")
		{
		alert("Please Enter the Property Leasehold 'Yes' or 'No' in Security Details page");
		return;
		}
	
	disableFields(false);
	disableButtons(true,false,false,false,true);
	document.forms[0].txt_District.readOnly=true;
	
	var temp_whtproj=document.forms[0].sel_whtprojapr.value;
	if(temp_whtproj=="Y")
	{
		document.forms[0].txt_BuilderName.readOnly=true;
		document.forms[0].txt_ProjectName.readOnly=true;
	}
	else
	{
		document.forms[0].txt_BuilderName.readOnly=false;
		document.forms[0].txt_ProjectName.readOnly=false;
	}
}
function callCalender(name) {

	if (document.forms[0].cmdsave.disabled == false) {

		showCal(appURL, name);
	}
}
function doSave()
{
    var s="",s1="",s2="",s3="",s4="";
    var ser_no="";
    var cersai_id="";
    var cer_date="";
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	
	if(rowsLength==1)
	{
		if(document.forms[0].txt_SurveyNo.value=="")
		{
			alert("Enter Survey No");
			document.forms[0].txt_SurveyNo.focus();
			return;
		}
		else if(document.forms[0].txt_CersaId.value=="" && document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "Y")
		{
			if(varcussectype == "14"){
				if(document.forms[0].hid_croptypefromstat.value=="Y"){
				alert("Enter Cersai Asset ID");
				document.forms[0].txt_CersaId.focus();
				return;
				}
			}else{
				alert("Enter Cersai Asset ID");
				document.forms[0].txt_CersaId.focus();
				return;
			}
		}
		else if(document.forms[0].txt_CersaiDate.value=="" && document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "Y")
		{
			if(varcussectype == "14" ){
				if(document.forms[0].hid_croptypefromstat.value=="Y"){
				alert("Select Date of creation of Cersai Asset Date");
				document.forms[0].txt_CersaiDate.focus();
				return;
				}
			}else{
				alert("Select Date of creation of Cersai Asset Date");
				document.forms[0].txt_CersaiDate.focus();
				return;
			}
		}
		else if(document.forms[0].txt_CersaId.value=="" && document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "YO")
		{
			if(varcussectype == "14"){ 
				if(document.forms[0].hid_croptypefromstat.value=="Y"){
				alert("Enter Cersai Asset ID");
				document.forms[0].txt_CersaId.focus();
				return;
				}
			}else{
				alert("Enter Cersai Asset ID");
				document.forms[0].txt_CersaId.focus();
				return;
			}
		}
		else if(document.forms[0].txt_CersaiDate.value=="" && document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "YO")
		{
			if(varcussectype == "14"){
				if(document.forms[0].hid_croptypefromstat.value=="Y"){
			alert("Select Date of creation of Cersai Asset Date");
			document.forms[0].txt_CersaiDate.focus();
			return;
			}
		}else{
			alert("Select Date of creation of Cersai Asset Date");
			document.forms[0].txt_CersaiDate.focus();
			return;
		}
		}
		if(varcussectype == "10" || varcussectype == "11"  || varcussectype == "12"  || varcussectype == "13" || varcussectype == "15"  || varcussectype == "16"  || varcussectype == "17")
		{	 
			if(document.forms[0].txt_CERSAIrefnum.value=="" || document.forms[0].txt_CERSAIrefnum.value=="undefined")
			{
				ShowAlert('121',"CERSAI Search Ref. No");
				document.forms[0].txt_CERSAIrefnum.focus();
				return false;
			}
			
			if(document.forms[0].txt_CersaIDate1.value=="" || document.forms[0].txt_CersaIDate1.value=="undefined")
			{
				ShowAlert('121',"CERSAI search Date");
				document.forms[0].txt_CersaIDate1.focus();
				return false;
			}
		} else if(varcussectype == "14" && document.forms[0].hid_croptypefromstat.value=="Y"){
			
			if(document.forms[0].txt_CERSAIrefnum.value=="" || document.forms[0].txt_CERSAIrefnum.value=="undefined")
			{
				ShowAlert('121',"CERSAI Search Ref. No");
				document.forms[0].txt_CERSAIrefnum.focus();
				return false;
			}
			
			if(document.forms[0].txt_CersaIDate1.value=="" || document.forms[0].txt_CersaIDate1.value=="undefined")
			{
				if(varcussectype == "14" && document.forms[0].hid_croptypefromstat.value=="Y"){
				ShowAlert('121',"CERSAI search Date");
				document.forms[0].txt_CersaIDate1.focus();
				return false;
				}
			}
			
		}
		if(document.forms[0].txt_SurveyNo.value!=undefined)
		{
			s = document.forms[0].txt_SurveyNo.value;
			s3=document.forms[0].txt_CERSAIrefnum.value;
			s4=document.forms[0].txt_CersaIDate1.value;
			s1=	document.forms[0].txt_CersaId.value;
			s2=document.forms[0].txt_CersaiDate.value;
		}
		else
		{
			s = document.forms[0].txt_SurveyNo[0].value; 
			s3=document.forms[0].txt_CERSAIrefnum[0].value;
			s4=document.forms[0].txt_CersaIDate1.value;
			s1=	document.forms[0].txt_CersaId[0].value;
			s2=document.forms[0].txt_CersaiDate[0].value;
			
		}
    }
	else if(rowsLength>=1)
	{
		for(var i=0;i<rowsLength;i++)
		{
			if(document.forms[0].txt_SurveyNo[i].value=="")
			{
				alert("Enter Survey No");
				document.forms[0].txt_SurveyNo[i].focus();
				return;
			}else if(document.forms[0].txt_CersaId[i].value=="" && document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "Y")
			{
				if(varcussectype == "14"){
					if(document.forms[0].hid_croptypefromstat.value=="Y"){
					alert("Enter Cersai Asset ID");
					document.forms[0].txt_CersaId[i].focus();
					return;
				}
			}else{
				alert("Enter Cersai Asset ID");
				document.forms[0].txt_CersaId[i].focus();
				return;
			}
			}
			else if(document.forms[0].txt_CersaiDate[i].value=="" && document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "Y")
			{
				if(varcussectype == "14"){
					if(document.forms[0].hid_croptypefromstat.value=="Y"){
				alert("Select Date of creation of Cersai Asset Date");
				document.forms[0].txt_CersaiDate[i].focus();
				return;}
			}else{
				alert("Select Date of creation of Cersai Asset Date");
				document.forms[0].txt_CersaiDate[i].focus();
				return;
			}
			}
			else if(document.forms[0].txt_CersaId[i].value=="" && document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "YO")
			{
				if(varcussectype == "14"){
						if(document.forms[0].hid_croptypefromstat.value=="Y"){
			alert("Enter Cersai Asset ID");
				document.forms[0].txt_CersaId[i].focus();
				return;}
				}else{
				alert("Enter Cersai Asset ID");
					document.forms[0].txt_CersaId[i].focus();
					return;
				}
			}
			else if(document.forms[0].txt_CersaiDate[i].value=="" && document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "YO")
			{
				if(varcussectype == "14"){
					if(document.forms[0].hid_croptypefromstat.value=="Y"){
				alert("Select Date of creation of Cersai Asset Date");
				document.forms[0].txt_CersaiDate[i].focus();
				return;}}else{
					alert("Select Date of creation of Cersai Asset Date");
					document.forms[0].txt_CersaiDate[i].focus();
					return;
				}
			}
				if(document.forms[0].txt_CERSAIrefnum[i].value=="" || document.forms[0].txt_CERSAIrefnum[i].value=="undefined")
				{
					if(varcussectype == "14"){
						if(document.forms[0].hid_croptypefromstat.value=="Y"){
					ShowAlert('121',"CERSAI Search Ref. No");
					document.forms[0].txt_CERSAIrefnum[i].focus();
					return false;
				}
				}else{
					ShowAlert('121',"CERSAI Search Ref. No");
					document.forms[0].txt_CERSAIrefnum[i].focus();
					return false;
				}
				}
				if(document.forms[0].txt_CersaIDate1[i].value=="" || document.forms[0].txt_CersaIDate1[i].value=="undefined")
				{
					if(varcussectype == "14"){
						if(document.forms[0].hid_croptypefromstat.value=="Y"){
					ShowAlert('121',"CERSAI search Date");
					document.forms[0].txt_CersaIDate1[i].focus();
					return false;
				}
				}else{
						ShowAlert('121',"CERSAI search Date");
						document.forms[0].txt_CersaIDate1[i].focus();
						return false;
				}
				}
			
			/*else if(document.forms[0].txt_CersaId[i].value=="")
			{
				alert("Enter CERSAI ID");
				document.forms[0].txt_CersaId[i].focus();
				return;
			}
			else if(document.forms[0].txt_CersaiDate[i].value=="")
			{
				alert("Select CERSAI ID creation Date");
				document.forms[0].txt_CersaiDate[i].focus();
				return;
			}*/
			
			if(s=="")
			{
				s = document.forms[0].txt_SurveyNo[i].value; 
				s3=document.forms[0].txt_CERSAIrefnum[i].value;
				s4=document.forms[0].txt_CersaIDate1[i].value;
				s1=	document.forms[0].txt_CersaId[i].value;
				s2=document.forms[0].txt_CersaiDate[i].value;
				
	        }
	        else
	        {
				s =s+"@"+ document.forms[0].txt_SurveyNo[i].value;
				s3=s3+"@"+document.forms[0].txt_CERSAIrefnum[i].value;
				s4=s4+"@"+document.forms[0].txt_CersaIDate1[i].value;
				s1=	s1+"@"+document.forms[0].txt_CersaId[i].value;
				s2=s2+"@"+document.forms[0].txt_CersaiDate[i].value;
				
	        }

		}
    }
	document.forms[0].hid_SurveyNo.value = s;
	document.forms[0].hid_CersaiID.value = s1;
	document.forms[0].hid_CersaiDate.value = s2;
	document.forms[0].hid_CERSAIrefnum.value = s3;
	document.forms[0].hid_CersaiDate1.value = s4;
	
	
	
	   var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;
		if(rowsLength>1)
		{
			cersailIDCorp=s1.split("@");
			
			for(var i=0;i<cersailIDCorp.length;i++)
			{
				for (var j=i+1;j<cersailIDCorp.length;j++)
				{
					if(cersailIDCorp[i]!="" && cersailIDCorp[i]==cersailIDCorp[j])
					{
							alert(cersailIDCorp[j]+" Cersail Id Already used,we can't modify!!!!");
							document.forms[0].hid_CersaiID[j].focus();
							return;
					}
				}
			}
		}
	
	
	
	
	
	if(document.forms[0].sel_PropertyType.value=="")
	{
		ShowAlert('111',"Property Type");
		document.forms[0].sel_PropertyType.focus();
		return false;
	}
	if(document.forms[0].txt_PlotNo.value==""){
		
		ShowAlert('121',"Plot No");	
		document.forms[0].txt_PlotNo.focus();
		return false;
	}
	if(document.forms[0].txt_TotalArea.value=="" || document.forms[0].txt_TotalArea.value=="0.00")
	{
		ShowAlert('121',"Total Area");
		document.forms[0].txt_TotalArea.focus();
		return false;
	}
	if(document.forms[0].sel_Measurement.value=="")
	{
		ShowAlert('111',"Total Area Measurement");
		document.forms[0].sel_Measurement.focus();
		return false;
	}
	if(document.forms[0].sel_PropertyType.value=="F" || document.forms[0].sel_PropertyType.value=="H" ){
		if(document.forms[0].txt_ExtOfBuilding.value==""||document.forms[0].txt_ExtOfBuilding.value=="0.00"){
			
			ShowAlert('121',"Extent of Building");	
			document.forms[0].txt_ExtOfBuilding.focus();
			return false;
		}
		if(document.forms[0].sel_extofbuildMeas.value==""){
			
			ShowAlert('111',"Extent of Building Measurement Type");
			document.forms[0].sel_extofbuildMeas.focus();
			return false;
		}
		
	}
	if(document.forms[0].txt_Valuation.value=="")
	{
		ShowAlert('121',"Value as per valuation");
		document.forms[0].txt_Valuation.focus();
		return false;
	}
	if(document.forms[0].txt_ForcedSale.value=="")
	{
		ShowAlert('121',"Forced sale value");
		document.forms[0].txt_ForcedSale.focus();
		return false;
	}
	if(document.forms[0].txt_Address1.value=="")
	{
		ShowAlert('121',"Address");
		document.forms[0].txt_Address1.focus();
		return false;
	}
	if(document.forms[0].txt_Address2.value=="")
	{
		ShowAlert('121',"Address 2");
		document.forms[0].txt_Address2.focus();
		return false;
	}
	if(document.forms[0].txt_City.value=="")
	{
		ShowAlert('111',"City");
		document.forms[0].txt_City.focus();
		return false;
	}
	if(document.forms[0].txt_District.value=="")
	{
		ShowAlert('111',"District");
		document.forms[0].txt_District.focus();
		return false;
	}
	if(document.forms[0].txt_State.value=="")
	{
		ShowAlert('111',"State");
		document.forms[0].txt_State.focus();
		return false;
	}
	if(document.forms[0].txt_PinCode.value=="")
	{
		ShowAlert('121',"Pin Code");
		document.forms[0].txt_PinCode.focus();
		return false;
	}
	if(document.forms[0].select_loc.value=="")
	{
		ShowAlert('111',"Branch where title deeds deposited");
		document.forms[0].txt_Branch.focus();
		return false;
	}
	var propdistrict=document.forms[0].hid_District.value;
	var propstate=document.forms[0].hidstate.value;
	var varBflag="false";
	if(VALUER_VALUEDLOC!="")
	{
		var varSplit=VALUER_VALUEDLOC.split("@");
		if(varSplit.length>=1)
		{
			for(var i=0;i<varSplit.length;i++)
			{
				var varSplit1=varSplit[i].split("~");
				if(varSplit1.length>1)
				{
					if(varSplit1[0]==propstate && varSplit1[1]==propdistrict && varBflag=="false")
					{
						varBflag="true";
					}
				}
			}
		}
	}
	if(varBflag=="false" && varValuerCode!="601")
	{
		alert("The valuer attached to this security not eligible to valuate this Property. Please reattach valuer");
		return false;
	}
	/*if(document.forms[0].txt_titledeeddepposit_date.value=="")
	{
		ShowAlert('121',"Date of Title Deed deposited");
		document.forms[0].txt_titledeeddepposit_date.focus();
		return false;
	}*/
	
	if(document.forms[0].sel_propacquisition.value=="")
	{
		ShowAlert('111',"property acquisition");
		document.forms[0].sel_propacquisition.focus();
		return false;
	}
	if(document.forms[0].txt_StreetNo.value=="")
	{
		alert("Enter Street No ");
		//ShowAlert('121',"Street No");
		document.forms[0].txt_StreetNo.focus();
		return false;
	}
	if(document.forms[0].txt_WardNo.value=="")
	{
		ShowAlert('121',"Ward No");
		document.forms[0].txt_WardNo.focus();
		return false;
	}
	if(document.forms[0].txt_Valuation.value=="" || document.forms[0].txt_Valuation.value=="0.00")
	{
		ShowAlert('121',"Value as per Valuation");
		document.forms[0].txt_Valuation.focus();
		return false;
	}
	if(document.forms[0].txt_ForcedSale.value=="" || document.forms[0].txt_ForcedSale.value=="0.00")
	{
		ShowAlert('121',"Forced sale value");
		document.forms[0].txt_ForcedSale.focus();
		return false;
	}
	if(document.forms[0].sel_PropertyType.value=="F" || document.forms[0].sel_PropertyType.value=="H" ){
		if(document.forms[0].sel_prop.value==""){
			
			ShowAlert('111',"Property Type");
			document.forms[0].sel_prop.focus();
			return false;
		}
	}
	if((document.forms[0].sel_PropertyType.value=="F"||document.forms[0].sel_PropertyType.value=="H") && (document.forms[0].sel_prop.value=="C") && (document.forms[0].txt_AgeOfBuilding.value==""))
	{
		alert("Enter the Age of the building");
		document.forms[0].txt_AgeOfBuilding.focus();
		return false;
		
	}
	
	if(document.forms[0].sel_propacquisition.value=="T"){
	if(document.forms[0].txt_propothers.value==""){
	
		ShowAlert('121',"Comments");
		document.forms[0].txt_propothers.focus();
		return false;
	}
	}
	if(varSec_Classify=='61'){
	if(document.forms[0].sel_whtprojapr.value=="")
	{
		ShowAlert('111',"Whether Project approved by our Bank");
		document.forms[0].sel_whtprojapr.focus();
		return false;
	}
	
	var selwhtproj=document.forms[0].sel_whtprojapr.value;
	if(selwhtproj=="Y" || selwhtproj=="N")
	{
		if(document.forms[0].txt_BuilderName.value=="")
		{
			ShowAlert('121',"Builder Name");
			document.forms[0].txt_BuilderName.focus();
			return false;
		}
		if(document.forms[0].txt_ProjectName.value=="")
		{
			ShowAlert('121',"Project Name");
			document.forms[0].txt_ProjectName.focus();
			return false;
		}
	}
	}
		 
	if(document.forms[0].sel_whtalrmortobnk.value == "")
	{
		ShowAlert('111',"Whether property offered is already mortgaged to our Bank");
		document.forms[0].sel_whtbnkchrgreflct.focus();
		return false;
	}
	
		if(document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "")
		{
			ShowAlert('111',"Whether our bank charge reflected");
			document.forms[0].sel_whtbnkchrgreflct.focus();
			return false;
		}else if(document.forms[0].sel_whtalrmortobnk.value == "N" && document.forms[0].sel_anychrgonprop.value == "")
		{
			ShowAlert('111',"Any charge on the property observed");
			document.forms[0].txt_remarks.focus();
			return false;
		}else if(document.forms[0].sel_whtalrmortobnk.value == "N"){
			document.forms[0].sel_whtbnkchrgreflct.value="";
			document.forms[0].txt_remarkschrgonprop.value="";
			document.forms[0].txt_remarkschrgnotref.value="";
		}
		 
		if(document.forms[0].sel_whtalrmortobnk.value == "N" && document.forms[0].sel_anychrgonprop.value == "Y" && document.forms[0].txt_remarks.value == "")
		{
			ShowAlert('121',"Reason/Remarks For Any charge on the property observed");
			document.forms[0].txt_remarks.focus();
			return false;
		}else if(document.forms[0].sel_whtalrmortobnk.value == "N" && document.forms[0].sel_anychrgonprop.value == "N")
		{
			document.forms[0].txt_remarks.value="";
		}

		if(document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "YO" && document.forms[0].txt_remarkschrgonprop.value == "" )
		{
			ShowAlert('121',"Reason for other bank charge being reflected");
			document.forms[0].txt_remarkschrgonprop.focus();
			return false;
			document.forms[0].txt_remarkschrgnotref.value="";
		}
		
		if(document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "N" && document.forms[0].txt_remarkschrgnotref.value == "")
		{
			ShowAlert('121',"Reason for our bank charge not reflecting");
			document.forms[0].txt_remarkschrgnotref.focus();
			return false;
			document.forms[0].txt_remarkschrgonprop.value="";

		}
		
		if(document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "YO")
		{
			document.forms[0].txt_remarkschrgnotref.value="";
		}	
		if(document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "N")
		{
			document.forms[0].txt_remarkschrgonprop.value="";
		}
		if(document.forms[0].sel_whtalrmortobnk.value == "Y" && document.forms[0].sel_whtbnkchrgreflct.value == "Y")
		{
			document.forms[0].txt_remarkschrgonprop.value="";
			document.forms[0].txt_remarkschrgnotref.value="";
		}
		
		if(document.forms[0].sel_whtalrmortobnk.value == "Y")
		{
			document.forms[0].sel_anychrgonprop.value="";
			document.forms[0].txt_remarks.value="";

		}
	
		if(varcussectype == "14" && document.forms[0].sel_corpType.value == "")
		{
			ShowAlert('111',"Crop Type");
			document.forms[0].sel_corpType.focus();
			return false;
		}	
	
	modifyCheck();
	if((document.forms[0].txt_Valuation.value!=document.forms[0].old_txt_Valuation.value) ||
			   (document.forms[0].txt_ForcedSale.value!=document.forms[0].old_txt_ForcedSale.value)
			   ) 
		{
			var con = confirm("Security Value / Valuation Details/Value as per valuation report/Forced sale value as per report has been changed,needs to be send for Verification. Do you want to Proceed?");
			if(!con)
			{
				return;
			}
		}
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updatePropertyDetData";
	document.forms[0].hidBeanGetMethod.value="getPropertyDetData";
	document.forms[0].hidSourceUrl.value="/action/sec_propertydet.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modifyCheck()
{
	
	var temp="";
	var tempname="";

	//sel_Acquired
	if(document.forms[0].sel_Acquired.value=="")
		document.forms[0].sel_AcquiredText.value="";
	else
		document.forms[0].sel_AcquiredText.value=document.forms[0].sel_Acquired.options[document.forms[0].sel_Acquired.selectedIndex].text;
	//sel_boundaries
	if(document.forms[0].sel_boundaries.value=="")
		document.forms[0].sel_boundariesText.value="";
	else	
		document.forms[0].sel_boundariesText.value=document.forms[0].sel_boundaries.options[document.forms[0].sel_boundaries.selectedIndex].text;
	//sel_PropertyTypeText
	if(document.forms[0].sel_PropertyType.value=="")
		document.forms[0].sel_PropertyTypeText.value="";
	else	
		document.forms[0].sel_PropertyTypeText.value=document.forms[0].sel_PropertyType.options[document.forms[0].sel_PropertyType.selectedIndex].text;
	//sel_Measurement
	if(document.forms[0].sel_Measurement.value=="")
		document.forms[0].sel_MeasurementText.value="";
	else	
		document.forms[0].sel_MeasurementText.value=document.forms[0].sel_Measurement.options[document.forms[0].sel_Measurement.selectedIndex].text;
	//sel_extnotcoveredMeasText
	if(document.forms[0].sel_extnotcoveredMeas.value=="")
		document.forms[0].sel_extnotcoveredMeasText.value="";
	else	
		document.forms[0].sel_extnotcoveredMeasText.value=document.forms[0].sel_extnotcoveredMeas.options[document.forms[0].sel_extnotcoveredMeas.selectedIndex].text;
	//sel_extofgroundMeasText
	if(document.forms[0].sel_extofgroundMeas.value=="")
		document.forms[0].sel_extofgroundMeasText.value="";
	else	
		document.forms[0].sel_extofgroundMeasText.value=document.forms[0].sel_extofgroundMeas.options[document.forms[0].sel_extofgroundMeas.selectedIndex].text;
	//sel_extofbuildMeas
	if(document.forms[0].sel_extofbuildMeas.value=="")
		document.forms[0].sel_extofbuildMeasText.value="";
	else	
		document.forms[0].sel_extofbuildMeasText.value=document.forms[0].sel_extofbuildMeas.options[document.forms[0].sel_extofbuildMeas.selectedIndex].text;
	if(document.forms[0].sel_propacquisition.value=="")
		document.forms[0].sel_propacquisitionText.value="";
	else	
		document.forms[0].sel_propacquisitionText.value=document.forms[0].sel_propacquisition.options[document.forms[0].sel_propacquisition.selectedIndex].text;
	if(document.forms[0].sel_prop.value=="")
		document.forms[0].sel_propText.value="";
	else	
		document.forms[0].sel_propText.value=document.forms[0].sel_prop.options[document.forms[0].sel_prop.selectedIndex].text;
	if(document.forms[0].sel_whtprojapr.value=="")
		document.forms[0].sel_whtprojaprText.value="";
	else	
		document.forms[0].sel_whtprojaprText.value=document.forms[0].sel_whtprojapr.options[document.forms[0].sel_whtprojapr.selectedIndex].text;

	if(document.forms[0].sel_whtalrmortobnk.value=="")
		document.forms[0].sel_whtalrmortobnktext.value="";
	else
		document.forms[0].sel_whtalrmortobnktext.value=document.forms[0].sel_whtalrmortobnk.options[document.forms[0].sel_whtalrmortobnk.selectedIndex].text;

	
	if(document.forms[0].sel_whtbnkchrgreflct.value=="")
		document.forms[0].sel_whtbnkchrgreflcttext.value="";
	else
		document.forms[0].sel_whtbnkchrgreflcttext.value=document.forms[0].sel_whtbnkchrgreflct.options[document.forms[0].sel_whtbnkchrgreflct.selectedIndex].text;

	
	if(document.forms[0].sel_anychrgonprop.value=="")
		document.forms[0].sel_anychrgonproptext.value="";
	else
		document.forms[0].sel_anychrgonproptext.value=document.forms[0].sel_anychrgonprop.options[document.forms[0].sel_anychrgonprop.selectedIndex].text;

	if(document.forms[0].sel_corpType.value=="")
		document.forms[0].sel_corpTypetext.value="";
	else
		document.forms[0].sel_corpTypetext.value=document.forms[0].sel_corpType.options[document.forms[0].sel_corpType.selectedIndex].text;
	

	
	if(document.forms[0].sel_AcquiredText.value!=document.forms[0].old_sel_AcquiredText.value)
	{
		temp=temp+"old_sel_AcquiredText"+"@"; 	tempname=tempname+"Property acquired from"+"@";
	}
	if(document.forms[0].sel_boundariesText.value!=document.forms[0].old_sel_boundariesText.value)
	{
		temp=temp+"old_sel_boundariesText"+"@"; 	tempname=tempname+"Whether actual boundaries tallies"+"@";
	}
	if(document.forms[0].sel_PropertyTypeText.value!=document.forms[0].old_sel_PropertyTypeText.value)
	{
		temp=temp+"old_sel_PropertyTypeText"+"@"; 	tempname=tempname+"Property Type"+"@";
	}
	if(document.forms[0].sel_MeasurementText.value!=document.forms[0].old_sel_MeasurementText.value)
	{
		temp=temp+"old_sel_MeasurementText"+"@"; 	tempname=tempname+"Total Area Measurement "+"@";
	}
	if(document.forms[0].sel_extnotcoveredMeasText.value!=document.forms[0].old_sel_extnotcoveredMeasText.value)
	{
		temp=temp+"old_sel_extnotcoveredMeasText"+"@"; 	tempname=tempname+"Extent of Ground floor covered Measurement"+"@";
	}
	if(document.forms[0].sel_extofgroundMeasText.value!=document.forms[0].old_sel_extofgroundMeasText.value)
	{
		temp=temp+"old_sel_extofgroundMeasText"+"@"; 	tempname=tempname+"Extent of land not covered Measurement"+"@";
	}
	if(document.forms[0].sel_extofbuildMeasText.value!=document.forms[0].old_sel_extofbuildMeasText.value)
	{
		temp=temp+"old_sel_extofbuildMeasText"+"@"; 	tempname=tempname+"Extent of Building Measurement"+"@";
	}
	if(document.forms[0].txt_Address1.value!=document.forms[0].old_txt_Address1.value)
	{
		temp=temp+"old_txt_Address1"+"@"; 		tempname=tempname+"Address 1"+"@";
	}
	if(document.forms[0].txt_PlotNo.value!=document.forms[0].old_txt_PlotNo.value)
	{
		temp=temp+"old_txt_PlotNo"+"@"; 		tempname=tempname+"Plot No"+"@";
	}
	if(document.forms[0].txt_Address2.value!=document.forms[0].old_txt_Address2.value)
	{
		temp=temp+"old_txt_Address2"+"@"; 		tempname=tempname+"Address 2"+"@";
	}
	if(document.forms[0].txt_TotalArea.value!=document.forms[0].old_txt_TotalArea.value)
	{
		temp=temp+"old_txt_TotalArea"+"@"; 		tempname=tempname+"Total Area "+"@";
	}
	if(document.forms[0].txt_City.value!=document.forms[0].old_txt_City.value)
	{
		temp=temp+"old_txt_City"+"@"; 		tempname=tempname+"City/Town "+"@";
	}
	if(document.forms[0].txt_ExtOfBuilding.value!=document.forms[0].old_txt_ExtOfBuilding.value)
	{
		temp=temp+"old_txt_ExtOfBuilding"+"@"; 		tempname=tempname+"Extent of Building"+"@";
	}
	if(document.forms[0].txt_District.value!=document.forms[0].old_txt_District.value)
	{
		temp=temp+"old_txt_District"+"@"; 		tempname=tempname+"District "+"@";
	}
	if(document.forms[0].txt_ExtOfGround.value!=document.forms[0].old_txt_ExtOfGround.value)
	{
		temp=temp+"old_txt_ExtOfGround"+"@"; 		tempname=tempname+"Extent of Ground floor covered "+"@";
	}
	if(document.forms[0].txt_State.value!=document.forms[0].old_txt_State.value)
	{
		temp=temp+"old_txt_State"+"@"; 		tempname=tempname+"State "+"@";
	}
	if(document.forms[0].txt_ExtOfNotCovered.value!=document.forms[0].old_txt_ExtOfNotCovered.value)
	{
		temp=temp+"old_txt_ExtOfNotCovered"+"@"; 		tempname=tempname+"Extent of land not covered "+"@";
	}
	if(document.forms[0].txt_PinCode.value!=document.forms[0].old_txt_PinCode.value)
	{
		temp=temp+"old_txt_PinCode"+"@"; 		tempname=tempname+"Pin Code "+"@";
	}
	if(document.forms[0].txt_YearBuilt.value!=document.forms[0].old_txt_YearBuilt.value)
	{
		temp=temp+"old_txt_YearBuilt"+"@"; 		tempname=tempname+"Year Built"+"@";
	}
	if(document.forms[0].txt_Valuation.value!=document.forms[0].old_txt_Valuation.value)
	{
		temp=temp+"old_txt_Valuation"+"@"; 		tempname=tempname+"Value as per valuation"+"@";
	}
	if(document.forms[0].txt_ForcedSale.value!=document.forms[0].old_txt_ForcedSale.value)
	{
		temp=temp+"old_txt_ForcedSale"+"@"; 		tempname=tempname+"Forced sale value"+"@";
	}
	if(document.forms[0].txt_Branch.value!=document.forms[0].old_txt_Branch.value)
	{
		temp=temp+"old_txt_Branch"+"@"; 		tempname=tempname+"Branch where title deeds deposited"+"@";
	}
	if(document.forms[0].txt_BoundWest.value!=document.forms[0].old_txt_BoundWest.value)
	{
		temp=temp+"old_txt_BoundWest"+"@"; 		tempname=tempname+"West"+"@";
	}
	if(document.forms[0].txt_BoundEast.value!=document.forms[0].old_txt_BoundEast.value)
	{
		temp=temp+"old_txt_BoundEast"+"@"; 		tempname=tempname+"East"+"@";
	}
	if(document.forms[0].txt_BoundNorth.value!=document.forms[0].old_txt_BoundNorth.value)
	{
		temp=temp+"old_txt_BoundNorth"+"@"; 		tempname=tempname+"North"+"@";
	}
	if(document.forms[0].txt_BoundSouth.value!=document.forms[0].old_txt_BoundSouth.value)
	{
		temp=temp+"old_txt_BoundSouth"+"@"; 		tempname=tempname+"South"+"@";
	}
	if(document.forms[0].txt_OtherInf.value!=document.forms[0].old_txt_OtherInf.value)
	{
		temp=temp+"old_txt_OtherInf"+"@"; 		tempname=tempname+"Other Information"+"@";
	}
	
	if(document.forms[0].txt_SaleAmount.value!=document.forms[0].old_txt_SaleAmount.value)
	{
		temp=temp+"old_txt_SaleAmount"+"@"; 		tempname=tempname+"Sale Amount"+"@";
	}
	if(document.forms[0].txt_BuilderName.value!=document.forms[0].old_txt_BuilderName.value)
	{
		temp=temp+"old_txt_BuilderName"+"@"; 		tempname=tempname+"Name of the builder"+"@";
	}if(document.forms[0].txt_RefnoApprov.value!=document.forms[0].old_txt_RefnoApprov.value)
	{
		temp=temp+"old_txt_RefnoApprov"+"@"; 		tempname=tempname+"Reference no. of the approval approving the project"+"@";
	}if(document.forms[0].txt_NoFloor.value!=document.forms[0].old_txt_NoFloor.value)
	{
		temp=temp+"old_txt_NoFloor"+"@"; 		tempname=tempname+"No. of floors"+"@";
	}if(document.forms[0].txt_AgeOfBuilding.value!=document.forms[0].old_txt_AgeOfBuilding.value)
	{
		temp=temp+"old_txt_AgeOfBuilding"+"@"; 		tempname=tempname+"Age of the building"+"@";
	}
	if(document.forms[0].sel_propacquisitionText.value!=document.forms[0].old_sel_propacquisitionText.value)
	{
		temp=temp+"old_sel_propacquisitionText"+"@"; 	tempname=tempname+"Details of property acquisition"+"@";
	}
	if(document.forms[0].sel_propText.value!=document.forms[0].old_sel_propText.value)
	{
		temp=temp+"old_sel_propText"+"@"; 	tempname=tempname+"Status of the flat/House"+"@";
	}
	if(document.forms[0].txt_StreetNo.value!=document.forms[0].old_txt_StreetNo.value)
	{
		temp=temp+"old_txt_StreetNo"+"@"; 	tempname=tempname+"Street No"+"@";
	}
	if(document.forms[0].txt_WardNo.value!=document.forms[0].old_txt_WardNo.value)
	{
		temp=temp+"old_txt_WardNo"+"@"; 	tempname=tempname+"Ward No"+"@";
	}
	if(document.forms[0].txt_propothers.value!=document.forms[0].old_txt_propothers.value)
	{
		//temp=temp+"old_txt_propothers"+"@"; 	tempname=tempname+"Details about acquisition"+"@";
	}
	if(document.forms[0].hid_SurveyNo.value!=document.forms[0].old_hid_SurveyNo.value)
	{
		temp=temp+"old_hid_SurveyNo"+"@"; 		tempname=tempname+"Survey No"+"@";
	}
	if(document.forms[0].hid_CersaiID.value!=document.forms[0].old_hid_CersaiID.value)
	{
		temp=temp+"old_hid_CersaiID"+"@"; 		tempname=tempname+"CERSAI ASSET ID"+"@";
	}
	if(document.forms[0].hid_CersaiDate.value!=document.forms[0].old_hid_CersaiDate.value)
	{
		temp=temp+"old_hid_CersaiDate"+"@"; 		tempname=tempname+"CERSAI ASSET ID Creation Date"+"@";
	}
	if(document.forms[0].txt_ProjectName.value!=document.forms[0].old_txt_ProjectName.value)
	{
		temp=temp+"old_txt_ProjectName"+"@"; 		tempname=tempname+"Name of the project"+"@";
	}
	if(document.forms[0].sel_whtprojaprText.value!=document.forms[0].old_sel_whtprojaprText.value)
	{
		temp=temp+"old_sel_whtprojaprText"+"@"; 	tempname=tempname+"Whether Project approved by our Bank"+"@";
	}
	
	if(document.forms[0].txt_remarks.value!=document.forms[0].old_txt_remarks.value)
	{
		temp=temp+"old_txt_remarks"+"@"; 	tempname=tempname+"CERSAI Search Remarks"+"@";
	}
	
	if(document.forms[0].hid_CersaiDate1.value!=document.forms[0].old_hid_CersaiDate1.value)
	{
		temp=temp+"old_hid_CersaiDate1"+"@"; 	tempname=tempname+"CERSAI search Date"+"@";
	}
	
	if(document.forms[0].hid_CERSAIrefnum.value!=document.forms[0].old_hid_CERSAIrefnum.value)
	{
		temp=temp+"old_hid_CERSAIrefnum"+"@"; 	tempname=tempname+"Reason/Remarks For Any charge on the property observed"+"@";
	}
	
	
	if(document.forms[0].sel_whtalrmortobnktext.value!=document.forms[0].old_sel_whtalrmortobnktext.value)
	{
		temp=temp+"old_sel_whtalrmortobnktext"+"@"; 	tempname=tempname+"Whether property offered is already mortgaged to our Bank"+"@";
	}
	if(document.forms[0].sel_whtbnkchrgreflcttext.value!=document.forms[0].old_sel_whtbnkchrgreflcttext.value)
	{
		temp=temp+"old_sel_whtbnkchrgreflcttext"+"@"; 	tempname=tempname+"Whether our bank charge reflected"+"@";
	}
	if(document.forms[0].txt_remarkschrgonprop.value!=document.forms[0].old_txt_remarkschrgonprop.value)
	{
		temp=temp+"old_txt_remarkschrgonprop"+"@"; 	tempname=tempname+"Reason for other bank charge being reflected"+"@";
	}
	if(document.forms[0].txt_remarkschrgnotref.value!=document.forms[0].old_txt_remarkschrgnotref.value)
	{
		temp=temp+"old_txt_remarkschrgnotref"+"@"; 	tempname=tempname+"Reason for our bank charge not reflecting"+"@";
	}
	if(document.forms[0].sel_anychrgonproptext.value!=document.forms[0].old_sel_anychrgonproptext.value)
	{
		temp=temp+"old_sel_anychrgonproptext"+"@"; 	tempname=tempname+"Any charge on the property observed"+"@";
	}
	if(document.forms[0].sel_corpTypetext.value!=document.forms[0].old_sel_corpTypetext.value)
	{
		temp=temp+"old_sel_corpTypetext"+"@"; 	tempname=tempname+"Crop Type"+"@";
	}
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
	
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=appURL+"action/sec_propertydet.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
	  	document.forms[0].hidBeanGetMethod.value="getPropertyDetData";
	  	document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="getPropertyDetData";
		document.forms[0].hidBeanMethod.value="updatePropertyDetData";
		document.forms[0].hidSourceUrl.value="/action/sec_propertydet.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function disableFields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=bool;		  
		}	
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=bool;	
		}
	}
	document.forms[0].txt_ExtOfNotCovered.readOnly=true;
	document.forms[0].txt_Branch.readOnly=true;
	document.forms[0].txt_City.readOnly=true;
	document.forms[0].txt_State.readOnly=true;
}
function callNotCovered()
{
	var varTotalArea=document.forms[0].txt_TotalArea.value;
	var varExtOfGrnd=document.forms[0].txt_ExtOfGround.value;
	document.forms[0].txt_ExtOfNotCovered.value=varTotalArea-varExtOfGrnd;
	document.forms[0].txt_ExtOfNotCovered.value=roundtxt(document.forms[0].txt_ExtOfNotCovered);
}

function chkProjApproved(type)
{
	var temp_whtproj=document.forms[0].sel_whtprojapr.value;
	
	if(temp_whtproj=="Y")
	{
		document.all.id_buildsearch.style.visibility="visible";
		document.forms[0].txt_BuilderName.readOnly=true;
		document.forms[0].txt_ProjectName.readOnly=true;
		if(type=="edit")
		{
			document.forms[0].txt_BuilderName.value="";
			document.forms[0].txt_ProjectName.value="";
			document.forms[0].hid_buildercode.value="";
		}
	}
	else
	{
		document.all.id_buildsearch.style.visibility="hidden";
		document.forms[0].txt_BuilderName.readOnly=false;
		document.forms[0].txt_ProjectName.readOnly=false;
		if(type=="edit")
		{
			document.forms[0].txt_BuilderName.value="";
			document.forms[0].txt_ProjectName.value="";
			document.forms[0].hid_buildercode.value="";
		}
	}
	if(temp_whtproj=="Y" ||temp_whtproj=="N" )
	{
		document.all.pro.style.visibility="visible";
		document.all.pro1.style.visibility="visible";
	}else{
		document.all.pro.style.visibility="hidden";
		document.all.pro1.style.visibility="hidden";
	}
}

function callsupnam()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/builderslist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getBuilderMasterList&hidAction=search&strfrom=sec_property";
		window.open(url,"",prop);
	}
}

