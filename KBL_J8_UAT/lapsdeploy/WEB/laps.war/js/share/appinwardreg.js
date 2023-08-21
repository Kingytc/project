function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	  	
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmddetail.disabled=bool6;
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?hidPagename=LAR";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
		else if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
	document.forms[0].txt_inwardno.readOnly=true;
	document.forms[0].txt_comcustcity.readOnly=true;
	document.forms[0].txt_comndist.readOnly=true;
	document.forms[0].txtcomcust_state.readOnly=true;
	document.forms[0].txt_date1.readOnly=true;
	document.forms[0].txt_clpreceivedate.readOnly=true;
	document.forms[0].txtnsdlrefno.readOnly=true;
	document.forms[0].txt_staffid.readOnly=true;
	document.forms[0].txt_staffname.readOnly=true;
	if(document.forms[0].selcusttype.value=="E")
	{
		document.forms[0].txt_cbscustid.readOnly=true;
	}
	document.forms[0].txt_convertedid.readOnly=true;
	document.forms[0].txt_convertedname.readOnly=true;
	document.forms[0].txt_name.readOnly=true;
	
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			if(document.forms[0].elements[i].name!="txtnsdlrefno" && document.forms[0].elements[i].name!="txt_date1")
			{
				document.forms[0].elements[i].value="";
			}
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";		  
		}
	}
	document.forms[0].sel_bankscheme.value="";
	document.forms[0].selectgovtmain.value="";
}

function onload()
{
	if(category == "p" || category == "")
	{
		settype("Retail");
		document.forms[0].choose_type[0].checked="true";
	}
	else if(category == "a")
	{
		settype("Agri");
		document.forms[0].choose_type[1].checked="true";
	}
	else if(category == "t")
	{
		settype("Tertiary");
		document.forms[0].choose_type[2].checked="true";
	}
	else if(category == "c")
	{
		settype("Corp");
		document.forms[0].choose_type[3].checked="true";
	}
	
	if(vardocreceived!="")
	{
		document.forms[0].seldocrecd.value=vardocreceived;
	}
	if(varapplnprocess!="")
	{
		document.forms[0].selappcreation.value=varapplnprocess;
	}
	if(varborrowertype!="")
	{
		document.forms[0].selcusttype.value=varborrowertype;
	}
	if(varappliedfor!="")
	{
		document.forms[0].selapplied.value=varappliedfor;
	}
	if(varproptype!="")
	{
		document.forms[0].prop_type.value=varproptype;
	}
	if(varselgender!="")
	{
		document.forms[0].selgender.value=varselgender;
	}
	if(varselenquiry!="")
	{
		document.forms[0].selpurpose.value=varselenquiry;
	}
	if(varappstatus!="")
	{
		document.forms[0].selapplstatus.value=varappstatus;
	}
	if(varcanvassedbystaff!="")
	{
		document.forms[0].selcanvassedbystaff.value=varcanvassedbystaff;
	}
	if(varINWARD_LEADGENBY!="")
	{
		document.forms[0].sel_leadgenby.value=varINWARD_LEADGENBY;
	}
	if(varborrowerstatus!="")
	{
		document.forms[0].selborrowerstatus.value=varborrowerstatus;
	}
	if(varLeadRegion!="")
	{
		document.forms[0].sel_leadregion.value=varLeadRegion;
	}
	if(varsourcedby!="")
	{
		document.forms[0].sourceby.value=varsourcedby;
	}
	if(varsourcedbyreason!="")
	{
		document.forms[0].sourcebyreason.value=varsourcedbyreason;
	}
	if(varstrnew=="Y")
	{
		enableButtons(true,false,true,true,false,false);
		document.forms[0].hidAction.value="new";
		document.forms[0].cmdprint.disabled=true;
		document.forms[0].txt_staffid.readOnly=true;
		document.forms[0].txt_staffname.readOnly=true;
		document.forms[0].txt_convertedid.readOnly=true;
		document.forms[0].txt_convertedname.readOnly=true;
		document.forms[0].txt_name.readOnly=true;
		
	}
	else
	{
		document.forms[0].txt_leadno.disabled=true;
		var varright = document.forms[0].readFlag.value;	
		if(varstrOrgLevel != "A" &&  varstrOrgLevel != "D"&&  varstrOrgLevel != "C")
		{			
			enableButtons(true,true,true,true,false,true);
		}		
		else if(varstrOrgLevel == "A" || varstrOrgLevel == "D"|| varstrOrgLevel == "C")
		{		
			if(varright=="w")
			{	
				if(varstrAppAtached=="N")
				{
					if(varorgscode==varScode)
					{
						if(varstrOrgLevel == "A"||(varstrOrgLevel == "C"))
						{
							enableButtons(false,true,true,true,false,true);
						}
						else if(varstrOrgLevel == "D" && varRLPFUser=="012")
						{
							enableButtons(false,true,true,true,false,true);
						}
						else
						{
						   enableButtons(true,true,true,true,false,true);
						}
					}
					else
					{
					   enableButtons(true,true,true,true,false,true);
					}
				}
				else
				{
				   enableButtons(true,true,true,true,false,true);
				}
			}
			else if(varright=="r")
			{
				enableButtons(true,true,true,true,false,true);
			}			
		}		
		else
		{
			if(vardataexists=="Y")
			{				
				enableButtons(false,true,true,true,false,true);
			}
			else
			{
				enableButtons(true,true,true,true,false,true);
			}
		}
	}
	showcustid();
	applied();
	if(varstrnew=="Y")
	{
		disableFields(false);
	}
	else
	{
		disableFields(true);
	}
	fncallIdentificationDet();
	checkStatus();
	if(varbankscheme!="")
	{
		document.forms[0].sel_scheme.value=varschemedesc;
	}
	if(varschemedesc!="")
	{
		document.forms[0].sel_bankscheme.value=varbankscheme;
	}
	if(varGovtSubSidy!="")
	{
		document.forms[0].selectgovtmain.value=varGovtSubSidy;
	}
	else
	{
		document.forms[0].selectgovtmain.value="";
	}
	if(varSchemGovtType!="")
	{
		document.forms[0].schemetypemain.value=varSchemGovtType;
	}
	else
	{
		document.forms[0].schemetypemain.value="0"
	}
	if(varSponserAgency!="")
	{
		document.forms[0].sel_sponser_agencymain.value=varSponserAgency;
	}
	else
	{
		document.forms[0].sel_sponser_agencymain.value="0"
	}
	if(varSubsidyType!="")
	{
		document.forms[0].sel_subsidytypemain.value=varSubsidyType;
	}
	else
	{
		document.forms[0].sel_subsidytypemain.value="0"
	}
	if(varTiny!="")
	{
		document.forms[0].sel_tiny.value=varTiny;
	}
	else
	{
		document.forms[0].sel_tiny.value="2";
	}
	if(varssitype!="")
	{
		document.forms[0].sel_SSI.value=varssitype;
	}
	else
	{
		document.forms[0].sel_SSI.value="2";
	}
	if(document.forms[0].txt_clpreceivedate.value!="")
	{
		document.all.id_clpldisp.style.display="inline";
	}
	else
	{
		//Moved to Edit option
	}
	document.forms[0].txtnsdlrefno.readOnly = true;
	if(varPageFrom=="Y")
	{
		document.forms[0].choose_type[1].disabled=true;
		document.forms[0].choose_type[2].disabled=true;
		document.forms[0].choose_type[3].disabled=true;
	}
	if(document.forms[0].seldocrecd.value=="Y")
	{
		document.all.iddocrep.style.display="table-row";
	}
	else
	{
		document.all.iddocrep.style.display="none";
	}
	
	if(varEXTERNALAPP_FLAG=="Y")
	{
		document.all.id_extAppl_cibil.style.visibility="visible";
		document.all.id_extAppl_cibil.style.position="relative";
	
		document.forms[0].txt_cibilSCore.disabled=true;
		document.forms[0].txt_cibilDetails.disabled=true;
	}
	else
	{
		document.all.id_extAppl_cibil.style.visibility="hidden";
		document.all.id_extAppl_cibil.style.position="absolute";
	}
	
	if(document.forms[0].selapplstatus.value=="2")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	
}	
function doPrint()
{
	var varinwardno = document.forms[0].txt_inwardno.value;
	var purl =appURL+"action/appinwardackprint.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getdata&inwardno="+varinwardno;
	var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function doClose()
{
	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
	 	document.forms[0].submit();
	}
}
function callCalender(cmdname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,cmdname);
	}
} 
function settype(cat_type)
{
	if(cat_type == "Retail")
	{
		if(category == "")
		{
			document.forms[0].txt_retschemedesc1.value="";
			document.forms[0].txtret_ftf.value="";
		}
		document.forms[0].hidtype.value="p";
		document.forms[0].txtcomcust_fwc.value="";
		document.forms[0].txtcomcust_ftf.value="";
		document.forms[0].txtcomcust_nf.value="";
		document.all.retail1.style.display="table-row";
		//document.all.retail1.style.position="relative";
		document.all.tercorp1.style.display="none";
		//document.all.tercorp1.style.position="absolute";
		document.all.tercorp2.style.display="none";
		//document.all.tercorp2.style.position="absolute";
		document.all.tercorp3.style.display="none";
		//document.all.tercorp3.style.position="absolute";
		document.all.corp1.style.visibility="hidden";
		document.all.corp1.style.position="absolute";
		document.all.corp2.style.visibility="hidden";
		document.all.corp2.style.position="absolute";
		document.all.corp3.style.visibility="hidden";
		document.all.corp3.style.position="absolute";
		document.all.prop.style.visibility="hidden";
		document.all.prop.style.position="absolute";
		document.all.schemedesc.style.display="table-row";
		//document.all.schemedesc.style.position="relative";
		document.all.bankscheme.style.display="table-row";
		//document.all.bankscheme.style.position="relative";
		document.all.SSItype.style.display="none";
		//document.all.SSItype.style.position="absolute";
		document.all.Tiny.style.display="none";
		//document.all.Tiny.style.position="absolute";
		fncallIdentificationDet();
		document.all.idmobmandatory.style.visibility="hidden";
		document.all.idmobmandatory.style.position="absolute";
		
		document.forms[0].sel_bankscheme.value="";
		document.forms[0].sel_scheme.value="";
		document.forms[0].txt_retschemedesc1.value="";
		
		var table= document.getElementById("table");
		var rowCount=table.rows.length; 
		if(rowCount>0)
		{
			if(rowCount>1)
			{
				for(var i=0;i<rowCount;i++)
				{
					document.forms[0].docname[i].value="";
					document.all.docname[i].style.display="none";
					document.forms[0].doccheckbx[i].checked=false;
					document.all.doccheckbx[i].style.display="none";
				}
			}
			else{
				document.forms[0].docname.value="";
				document.all.docname.style.display="none";
				document.forms[0].doccheckbx.checked=false;
				document.all.doccheckbx.style.display="none";
			}
			document.all.iddoc.style.display="table-row";
		}
	}

	else if(cat_type == "Agri")
	{
		if(category == "")
		{
			document.forms[0].txtcomcust_fwc.value="";
			document.forms[0].txtcomcust_ftf.value="";
			document.forms[0].txtcomcust_nf.value="";
		}
		document.forms[0].hidtype.value="a";
		document.all.retail1.style.display="none";
		//document.all.retail1.style.position="absolute";
		document.all.tercorp1.style.display="table-row";
		//document.all.tercorp1.style.position="relative";
		document.all.tercorp2.style.display="table-row";
		//document.all.tercorp2.style.position="relative";
		document.all.tercorp3.style.display="table-row";
		//document.all.tercorp3.style.position="relative";
		document.all.corp1.style.visibility="visible";
		document.all.corp1.style.position="relative";
		document.all.corp2.style.visibility="visible";
		document.all.corp2.style.position="relative";
		document.all.corp3.style.visibility="visible";
		document.all.corp3.style.position="relative";
		document.all.prop.style.position="absolute";
		document.all.prop.style.visibility="hidden"
		document.all.schemedesc.style.display="none";
		//document.all.schemedesc.style.position="absolute";
		document.all.bankscheme.style.display="none";
		//document.all.bankscheme.style.position="absolute";
		document.all.SSItype.style.display="none";
		//document.all.SSItype.style.position="absolute";
		document.all.Tiny.style.display="none";
		//document.all.Tiny.style.position="absolute";
		fncallIdentificationDet();
		document.all.idmobmandatory.style.visibility="hidden";
		document.all.idmobmandatory.style.position="absolute";
		document.forms[0].sel_bankscheme.value="";
		document.forms[0].sel_scheme.value="";
		document.forms[0].txt_retschemedesc1.value="";
		
		document.all.s5m.style.display="none";
    	document.all.s6m.style.display="none";
    	document.all.s1m.style.display="none";
    	document.all.s2m.style.display="none";
    	document.all.s3m.style.display="none";	
    	document.all.s4m.style.display="none";

	}
	else if(cat_type == "Tertiary")
	{
		if(category == "")
		{
			document.forms[0].txtcomcust_fwc.value="";
			document.forms[0].txtcomcust_ftf.value="";
			document.forms[0].txtcomcust_nf.value="";
		}
		document.forms[0].hidtype.value="t";
		document.forms[0].txtret_ftf.value="";
		document.forms[0].txt_retschemedesc1.value="";
		document.all.retail1.style.display="none";
		//document.all.retail1.style.position="absolute";
		document.all.tercorp1.style.display="table-row";
		//document.all.tercorp1.style.position="relative";
		document.all.tercorp2.style.display="table-row";
		//document.all.tercorp2.style.position="relative";
		document.all.tercorp3.style.display="table-row";
		//document.all.tercorp3.style.position="relative";
		document.all.corp1.style.visibility="hidden";
		document.all.corp1.style.position="absolute";
		document.all.corp2.style.visibility="hidden";
		document.all.corp2.style.position="absolute";
		document.all.corp3.style.visibility="hidden";
		document.all.corp3.style.position="absolute";
		document.all.schemedesc.style.display="none";
		//document.all.schemedesc.style.position="absolute";
		document.all.bankscheme.style.display="none";
		//document.all.bankscheme.style.position="absolute";
		document.all.SSItype.style.display="none";
		//document.all.SSItype.style.position="absolute";
		document.all.Tiny.style.display="none";
		//document.all.Tiny.style.position="absolute";
		fncallIdentificationDet();
		document.all.idmobmandatory.style.visibility="hidden";
		document.all.idmobmandatory.style.position="absolute";
	}
	if(cat_type == "Corp"  || cat_type == "Agri")
	{
		if(category == "")
		{
			document.forms[0].txtcomcust_fwc.value="";
			document.forms[0].txtcomcust_ftf.value="";
			document.forms[0].txtcomcust_nf.value="";
		}
		if(cat_type == "Corp")
		{
			document.forms[0].hidtype.value="c";
			document.all.SSItype.style.display="table-row";
			//document.all.SSItype.style.position="relative";
			document.all.Tiny.style.display="table-row";
			//document.all.Tiny.style.position="relative";
		}
		else if(cat_type == "Agri")
		{
			document.forms[0].hidtype.value="a";
		}
		document.forms[0].txtret_ftf.value="";
		document.forms[0].txt_retschemedesc1.value="";
		document.all.retail1.style.display="none";
		//document.all.retail1.style.position="absolute";
		document.all.tercorp1.style.display="table-row";
		//document.all.tercorp1.style.position="relative";
		document.all.tercorp2.style.display="table-row";
		//document.all.tercorp2.style.position="relative";
		document.all.tercorp3.style.display="table-row";
		//document.all.tercorp3.style.position="relative";
		document.all.corp1.style.visibility="visible";
		document.all.corp1.style.position="relative";
		document.all.corp2.style.visibility="visible";
		document.all.corp2.style.position="relative";
		document.all.corp3.style.visibility="visible";
		document.all.corp3.style.position="relative";
		document.all.prop.style.position="absolute";
		document.all.prop.style.visibility="hidden";
		document.all.schemedesc.style.display="none";
		//document.all.schemedesc.style.position="absolute";
		document.all.bankscheme.style.display="none";
		//document.all.bankscheme.style.position="absolute";
		
		fncallIdentificationDet();
		
		document.forms[0].sel_bankscheme.value="";
		document.forms[0].sel_scheme.value="";
		document.forms[0].txt_retschemedesc1.value="";
		
		document.all.idmobmandatory.style.visibility="visible";
		document.all.idmobmandatory.style.position="relative";
		
		var table= document.getElementById("table");
		var rowCount=table.rows.length; 
		if(rowCount>0)
		{
			if(rowCount>1)
			{
				for(var i=0;i<rowCount;i++)
				{
					document.forms[0].docname[i].value="";
					document.all.docname[i].style.display="none";
					document.forms[0].doccheckbx[i].checked=false;
					document.all.doccheckbx[i].style.display="none";
				}
			}
			else{
				document.forms[0].docname.value="";
				document.all.docname.style.display="none";
				document.forms[0].doccheckbx.checked=false;
				document.all.doccheckbx.style.display="none";
			}
			document.all.iddoc.style.display="table-row";
		}
	}
}
function checkStatus()
{
	if(document.forms[0].selapplstatus.value=="0")
	{
		document.all.rejreason.style.display="none";
		//document.all.rejreason.style.position="absolute";
		document.all.propcreation.style.display="none";
		//document.all.propcreation.style.position="absolute";
		document.all.rejreasonforjansamarth.style.display="none";
	}
	
	if(document.forms[0].selapplstatus.value=="1")
	{
		document.all.propcreation.style.display="table-row";
		//document.all.propcreation.style.position="relative";
		document.all.rejreason.style.display="none";
		//document.all.rejreason.style.position="absolute";
		document.all.rejreasonforjansamarth.style.display="none";
		
	}
	 if(document.forms[0].selapplstatus.value=="2")
	{
		 if(document.forms[0].sourceby.value=="JS")
			{
				document.all.rejreasonforjansamarth.style.display="table-row";
				document.all.rejreason.style.display="none";
				document.forms[0].selappcreation.value="0";
				document.all.propcreation.style.display="none";
				
			}
			else
			{
		document.all.rejreason.style.display="table-row";
		//document.all.rejreason.style.position="relative";
		document.all.propcreation.style.display="none";
		//document.all.propcreation.style.position="absolute";
		document.forms[0].selappcreation.value="0";
		document.all.rejreasonforjansamarth.style.display="none";
		
			}
	}
	
}
function doEdit()
{
	if(document.forms[0].txt_clpreceivedate.value=="" && varstatus=="O" && varstrOrgLevel == "D" && varapplnprocess=="3")
	{	
		document.all.id_clpldisp.style.display="inline";
		document.forms[0].txt_clpreceivedate.value=varCurrentDate;
		alert("Date of receipt of physical loan papers at CLPU has been registered as today's date. If you want to decline it, please click cancel.");
	}
	if(varstrAppAtached!="Y")
	{
		document.forms[0].hidleadflag.value="y";
		leadnumCheck(document.forms[0].txt_leadno,'Y');
	}
	disableFields(false);
	document.forms[0].hidAction.value="edit";
 	enableButtons(true,false,false,false,true,false);
 	document.forms[0].txtnsdlrefno.readOnly = true;	
 	document.forms[0].txt_leadno.disabled=false;
 	if(varstrAppAtached=="Y")
	{
		document.forms[0].txt_leadno.disabled=true;
	}
 	if(varAttachFlag=="Y")
 	{
 		document.forms[0].selapplstatus.disabled=true;
 		//document.forms[0].txt_leadno.disabled=true;
 	}
	else
	{
		document.forms[0].selapplstatus.disabled=false;
	}
 	//discbsvalues();
 	document.forms[0].txt_comncustame.readOnly=true;
	document.forms[0].txt_comDOB.readOnly=true;	
	document.forms[0].txt_comcustadd1.readOnly=true;	
	document.forms[0].txt_comcustcity.readOnly=true;
	document.forms[0].txtcomcust_state.readOnly=true;
	document.forms[0].txtcomcust_zip.readOnly=true;
	document.forms[0].txt_comcustadd2.readOnly=true;
	document.forms[0].txtcomcust_pan.readOnly=true;
	document.forms[0].txtcomcust_phone.readOnly=true;
	document.forms[0].txtcomcust_mobile.readOnly=true;
	document.forms[0].txt_staffid.readOnly=true;
	document.forms[0].txt_staffname.readOnly=true;
	document.forms[0].txt_convertedid.readOnly=true;
	document.forms[0].txt_convertedname.readOnly=true;
	document.forms[0].txt_name.readOnly=true;
	
	if(varAttachFlag=="Y")
	{
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].txt_comcustcity.readOnly = true;
	 	document.forms[0].txt_comndist.readOnly = true;	
	 	document.forms[0].selcusttype.disabled = true;	
	 	document.forms[0].txtcomcust_email.readOnly = true;	
	 	document.forms[0].selappcreation.disabled = true;	
	 	document.forms[0].choose_type[0].disabled = true;	
	 	document.forms[0].choose_type[1].disabled = true;	
	 	document.forms[0].choose_type[3].disabled = true;	
	 	document.all.idsearch.style.display = "none";	
	 	document.all.iddistrict.style.display = "none";	
	 	document.all.idapprecvdate.style.display = "none";	
	 	document.all.iddocreceived.style.display = "none";
	 	
	 	
	 	//document.forms[0].selcanvassedbystaff.disabled = true;	
	 	//document.forms[0].sel_leadgenby.disabled = true;	
	 	//document.forms[0].txt_name.disabled = true;	
	 	//document.forms[0].txt_convertedid.disabled = true;	
	 	//document.forms[0].txt_convertedname.disabled = true;	

	}
	if(varstrAppAtached=="N" && document.forms[0].seldocrecd.value=="N")
	{
		document.all.iddocreceived.style.display = "inline";
	}
 	for(var i=0;i<document.forms[0].choose_type.length;i++)
	{
		document.forms[0].choose_type[i].disabled=true;		
	}
 	
 	if(document.forms[0].choose_type[1].checked==true)
 	{
 		document.forms[0].selectgovtmain.disabled=true;
 	}
 	
	var table= document.getElementById("table");
	var rowCount=table.rows.length; 
	if(rowCount>0)
	{
		if(rowCount>1)
		{
			for(var i=0;i<rowCount;i++)
			{
				document.forms[0].docname[i].readOnly=true;
				document.forms[0].doccheckbx[i].disabled=false;
			}
		}
		else
		{
			document.forms[0].docname.readOnly=true;
			document.forms[0].doccheckbx.disabled=false;
		}
	}
	
}
function doCancel()
{	
 	if(ConfirmMsg(102))
	 {

		document.forms[0].hidBeanId.value="inwardRegister"
		document.forms[0].hidBeanGetMethod.value="getdata";
		document.forms[0].action=appURL+"action/appinwardreg.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="inwardRegister"
		document.forms[0].hidBeanMethod.value="updatedata";
		document.forms[0].hidBeanGetMethod.value="getdata";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/appinwardreg.jsp";
		document.forms[0].submit();
	}
}
function doSave()
{	
	
	if(document.forms[0].sourceby.value=="JS")
	{
		if(document.forms[0].unirefid.value=="")
		{
			ShowAlert(121,'Unique Reference ID');
			//document.forms[0].unirefid.focus();
			return;
		}
		else
		{
			var udyamchar = document.forms[0].unirefid.value;
			
			var capudyamchar=udyamchar.toUpperCase();
			if(capudyamchar.length==19)
			{
				 if(capudyamchar.charAt(0))
				  {
					  var code = capudyamchar.charCodeAt(0);
					  if(!(code>=65 && code<=90))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(1))
				  {
					  var code = capudyamchar.charCodeAt(1);
					  if(!(code>=65 && code<=90))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(2))
				  {
					  var code = capudyamchar.charCodeAt(2);
					  if(!(code>=65 && code<=90))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(3)!='-')
				  {
					 alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
					 
				  }
				 if(capudyamchar.charAt(4))
				  {
					  var code = capudyamchar.charCodeAt(4);
					  if(!(code>=65 && code<=90))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(5))
				  {
					  var code = capudyamchar.charCodeAt(5);
					  if(!(code>=65 && code<=90))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(6))
				  {
					  var code = capudyamchar.charCodeAt(6);
					  if(!(code>=65 && code<=90))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(7))
				  {
					  var code = capudyamchar.charCodeAt(7);
					  if(!(code>=65 && code<=90))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(8)!='-')
				  {
					 alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
					 
				  }
				 if(capudyamchar.charAt(9))
				  {
					 var code = capudyamchar.charCodeAt(9);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(10))
				  {
					 var code = capudyamchar.charCodeAt(10);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(11))
				  {
					 var code = capudyamchar.charCodeAt(11);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(12))
				  {
					 var code = capudyamchar.charCodeAt(12);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(13))
				  {
					 var code = capudyamchar.charCodeAt(13);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(14)!='-')
				  {
					 alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
					  return false;
					 
				  }
				 if(capudyamchar.charAt(15))
				  {
					 var code = capudyamchar.charCodeAt(15);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(16))
				  {
					 var code = capudyamchar.charCodeAt(16);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(17))
				  {
					 var code = capudyamchar.charCodeAt(17);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
				 if(capudyamchar.charAt(18))
				  {
					 var code = capudyamchar.charCodeAt(18);
					  if(!(code>=48 && code<=57))
					  {
						  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
						  return false;
					  }
				  }
			}
			else
			{
				alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				return;
			}
		}
		if(document.forms[0].selcanvassedbystaff.value!="NP")
		{
			alert("Please select Not Applicable in Lead Provided by (Staff Number)(Other than Canvassed enter BM Staff ID)");
			document.forms[0].selcanvassedbystaff.focus();
			return;
		}
	}
	if(document.forms[0].txt_leadno.value=="")
	{
		ShowAlert(121,'Lead number, If Lead number is not applicable enter NA');
		document.forms[0].txt_leadno.focus();
		return;
	}
	
	if(document.forms[0].hidleadflag.value=="y")
		return;
	if(document.forms[0].selcusttype.value=="0")
	{
		ShowAlert(111,'Type of Borrower');
		document.forms[0].selcusttype.focus();
		return;
	}
	if(document.forms[0].txt_comncustame.value=="")
	{
		ShowAlert(121,'Name');
		document.forms[0].txt_comncustame.focus();
		return;
	}
	if(varEduDate=="Y" && document.forms[0].txtnsdlrefno.value=="" && document.forms[0].sel_bankscheme.value=="006")
	{
		alert("Off line Educational loan proposals are not allowed. All the proposals should processed via Vidyalakshmi only");
		return;
	}
	if((varstrnew=="Y")&&(document.forms[0].txtnsdlrefno.value!="")&&(((document.forms[0].hidappname.value.toUpperCase()).substring(0,3)!=(document.forms[0].txt_comncustame.value.toUpperCase()).substring(0,3))||(document.forms[0].txt_comDOB.value!=document.forms[0].hidappDOB.value)))
	{
		alert("Applicant Details differs from NSDL Vidhyalakshmi portal");
		document.forms[0].txt_comncustame.value="";
		document.forms[0].txt_comncustame.focus();
		return;
	}
	if((document.forms[0].txtnsdlrefno.value!="") && (document.forms[0].sel_bankscheme.value!="006" && document.forms[0].sel_bankscheme.value!="999"))
	{
		alert("Bank's Scheme Not Related to Vidhyalakshmi Scheme, Scheme should be either KBL - VIDYANIDHI or Other than schematic");
		document.forms[0].sel_bankscheme.value="";
		document.forms[0].sel_bankscheme.focus();
		return;
	}
	if(document.forms[0].selcusttype.value!="N" && document.forms[0].txt_cbscustid.value=="")
	{
		ShowAlert(121,'CBS Cust ID');
		document.forms[0].txt_cbscustid.focus();
		return;
	}

	if(document.forms[0].txt_comDOB.value=="")
	{
		ShowAlert(121,'Date of Birth /Date of Commencement of Business /Date of Incorporation');
		document.forms[0].txt_comDOB.focus();
		return;
	}
	if(document.forms[0].selcusttype.value!="E")
	{	
		if(document.forms[0].txtcomcust_pan.value=="")
		{
			ShowAlert('121','PAN/TAN No.');
			document.forms[0].txtcomcust_pan.focus();
			return;
		}
	}
	if(document.forms[0].txt_comcustadd1.value=="")
	{
		ShowAlert(121,'Address 1');
		document.forms[0].txt_comcustadd1.focus();
		return;
	}
	if(document.forms[0].txt_comcustadd2.value=="")
	{
		ShowAlert(121,'Address 2');
		document.forms[0].txt_comcustadd2.focus();
		return;
	}
	if(document.forms[0].txt_comcustcity.value=="")
	{
		ShowAlert(111,'City');
		return;
	}
	if(document.forms[0].txt_comndist.value=="")
	{
		if(document.forms[0].selcusttype.value!="E")
		{
			ShowAlert(111,'District');
			document.forms[0].txt_comndist.focus();
			return;
		}
		else
		{
			alert("District Field is Blank, Kindly update all the mandatory field in customer profile and then proceed");
			return;
		}
	}
	if(document.forms[0].txtcomcust_state.value=="")
	{
		ShowAlert(111,'State');
		return;
	}
	if(document.forms[0].txtcomcust_zip.value=="")
	{
		ShowAlert(121,'Pin code');
		document.forms[0].txtcomcust_zip.focus();
		return;
	}	
	if(document.forms[0].txtcomcust_mobile.value=="")
	{
		alert("Mobile number is mandatory for the Applicant. Kindly provide the details in Finacle and pull the same to LAPS and then proceed.");
		document.forms[0].txtcomcust_mobile.focus();
		return;
	}	
	if(document.forms[0].txt_appdate.value=="")
	{
		ShowAlert(121,'Date of receipt of physical application form and initial Documents');
		document.forms[0].txt_appdate.focus();
		return;
	}
	if(document.forms[0].txt_comloanpur.value=="")
	{
		ShowAlert(121,'Purpose of Loan');
		document.forms[0].txt_comloanpur.focus();
		return;
	}
	if(document.forms[0].hidtype.value=="p")
	{
		if(document.forms[0].txtret_ftf.value <= "0.00")
		{
			ShowAlert(121,'Loan Amount Applied');
			document.forms[0].txtret_ftf.focus();
			return;
		}
	}
	else
	{
		if(document.forms[0].txtcomcust_fwc.value <= "0.00" && document.forms[0].txtcomcust_ftf.value <= "0.00" && document.forms[0].txtcomcust_nf.value <= "0.00")
		{
			ShowAlert(121,'Loan Amount Applied');
			document.forms[0].txtcomcust_fwc.focus();
			return;
		}
	}
	if(document.forms[0].seldocrecd.value=="0")
	{
		ShowAlert(111,'Whether Application is received with all required documents?');
		document.forms[0].seldocrecd.focus();
		return;
	}
	if(document.forms[0].seldocrecd.value=="Y")
	{
		if(document.forms[0].txt_receidate.value=="")
		{
			ShowAlert('111','Date of receipt of additional documents');
			document.forms[0].txt_receidate.focus();
			return;
		}
	}
	if(document.forms[0].selapplstatus.value=="0")
	{
		ShowAlert(111,'Status of Application');
		document.forms[0].selapplstatus.focus();
		return;
	}
	
	
	if(document.forms[0].sourceby.value=="0")
	{
		ShowAlert(121,'Source by:');
		return;
	}
	if(document.forms[0].sourceby.value=="JS")
	{
		if(document.forms[0].unirefid.value=="")
		{
			ShowAlert(121,'Unique Reference ID');
			//document.forms[0].unirefid.focus();
			return;
		}
		if(document.forms[0].selcanvassedbystaff.value!="NP")
		{
			alert("Please select Not Applicable in Lead Provided by (Staff Number)(Other than Canvassed enter BM Staff ID)");
			document.forms[0].selcanvassedbystaff.focus();
			return;
		}
	}
	
	
	if(document.forms[0].selapplstatus.value=="1")
	{
		if(document.forms[0].selappcreation.value=="0")
		{
			ShowAlert(111,'The Proposal creation will take place in');
			document.forms[0].selappcreation.focus();
			return;
		}
		else if(document.forms[0].selappcreation.value=="6" && document.forms[0].txt_leadno.value=="")
		{
			ShowAlert(121,'Lead Number');
			document.forms[0].txt_leadno.focus();
			return;
		}
	}
	else
	{
		if(document.forms[0].sourceby.value=="JS")
		{
			if(document.forms[0].sourcebyreason.value=="0")
			{
				ShowAlert(121,'Reason for Rejection');
				document.all.rejreasonforjansamarth.style.display="table-row";
				document.all.rejreason.style.display="none";
				document.forms[0].txt_rejreason.value="";
				document.forms[0].sourcebyreason.focus();
				return;
			}
		}
		else
		{
		if(document.forms[0].txt_rejreason.value=="")
		{
			ShowAlert(121,'Reason for Rejection');
			document.all.rejreasonforjansamarth.style.display="none";
			document.all.rejreason.style.display="table-row";
			document.forms[0].sourcebyreason.value="0";
			document.forms[0].txt_rejreason.focus();
			return;
		}
		}
	}
	if(document.forms[0].choose_type[0].checked)
	{
    if(document.forms[0].sel_scheme.value=="0")
	{
		ShowAlert(111,'Scheme Type');
		document.forms[0].sel_scheme.focus();
		return;
	}
	if(document.forms[0].sel_bankscheme.value=="")
	{
		ShowAlert(111,'Bank Scheme');
		document.forms[0].sel_bankscheme.focus();
		return;
	}
   	}
	
	if((document.forms[0].choose_type[2].checked==true || document.forms[0].choose_type[3].checked==true) && document.forms[0].selcusttype.value=="B")
	{
		if(document.forms[0].selapplied.value=="0")
		{
			ShowAlert('111','Whether Applied for');
			document.forms[0].selapplied.focus();
			return;
		}
	}
	if(document.forms[0].choose_type[3].checked==true)
	{
		if(document.forms[0].txtcomcust_mobile.value=="")
		{
			document.forms[0].txtcomcust_mobile.readOnly=false;
			ShowAlert('121','Mobile Number');
			document.forms[0].txtcomcust_mobile.focus();
			return;
		}
	}
	if(document.forms[0].selcanvassedbystaff.value=="0")
	{
		ShowAlert(111,'Whether the loan canvassed by the staff under R&R program?');
		document.forms[0].selcanvassedbystaff.focus();
		return;
	}
	if(document.forms[0].selcanvassedbystaff.value=="Y" && document.forms[0].txt_staffid.value=="")
	{
		ShowAlert(111,'Canvassed User ID');
		return;
	}
	
	if(varAttachFlag!="Y")
	{
		if(document.forms[0].selcanvassedbystaff.value=="N")
		{
			if(document.forms[0].sel_leadgenby.value=="0")
			{
				ShowAlert(111,'Lead generated by');
				return;
			}
			if(document.forms[0].sel_leadregion.value=="")
			{
				ShowAlert(111,'Lead generated by Region');
				return;
			}
			if(document.forms[0].txt_name.value=="")
			{
				ShowAlert(111,'Agent');
				return;
			}
		}
		if(document.forms[0].selcanvassedbystaff.value=="N"||document.forms[0].selcanvassedbystaff.value=="Y")
		{
			if(document.forms[0].txt_convertedid.value=="")
			{
				ShowAlert(111,'Lead Converted by');
				document.forms[0].txt_convertedid.focus();
				return;
			}	
		}
	}
	
	if(document.forms[0].selborrowerstatus.value=="0")
	{
		ShowAlert(111,'Status of the Borrower');
		document.forms[0].selborrowerstatus.focus();
		return;
	}
	if(document.forms[0].selectgovtmain.value=="")
	{
		ShowAlert(111,'Govt. Sponsor Scheme');
		document.forms[0].selectgovtmain.focus();
		return;
	}
	if(document.forms[0].selectgovtmain.value=="1")
	{
		if(document.forms[0].schemetypemain.value=="0")
		{
			ShowAlert(111,'Scheme Type');
			document.forms[0].schemetypemain.focus();
			return;
		}
		if(document.forms[0].submainamnt.value=="")
		{
			ShowAlert(121,'Subsidy Amount');
			document.forms[0].submainamnt.focus();
			return;
		}
		if(document.forms[0].sel_sponser_agencymain.value=="0")
		{
			ShowAlert(111,'Sponsor Agency');
			document.forms[0].sel_sponser_agencymain.focus();
			return;
		}
		if(document.forms[0].sel_subsidytypemain.value=="0")
		{
			ShowAlert(111,'Subsidy Type');
			document.forms[0].sel_subsidytypemain.focus();
			return;
		}
	}
	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=false;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=false;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=false;		
		}
		else if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=false;		
		}
	}
	document.forms[0].selcanvassedbystaff.disabled = false;	
 	document.forms[0].sel_leadgenby.disabled = false;	
 	document.forms[0].txt_name.disabled = false;	
 	document.forms[0].txt_convertedid.disabled = false;	
 	document.forms[0].txt_convertedname.disabled = false;
 	
 	if(document.forms[0].txtnsdlrefno.value!="" && document.forms[0].seldocrecd.value=="N" && document.forms[0].hidnsdlremarks.value=="")
	{
		alert("Enter the Required details in NSDL Application -> Remarks Field and Submit the page");
		callAppStatusPopUp();
		return;
	}
	if((varAttachFlag=="Y")&&(varstrOrgLevel=='A'||varstrOrgLevel=='D')&&(document.forms[0].choose_type[0].checked==true))
	{
		if(confirm("The Changes will update the LAR Attached Loan Proposal Also, Do you want to continue?"))
		{
			//do nothing
		}
		else
		{
			document.forms[0].hidBeanId.value="inwardRegister"
			document.forms[0].hidBeanGetMethod.value="getdata";
			document.forms[0].action=appURL+"action/appinwardreg.jsp";
			document.forms[0].submit();
			return;
		}
	}
	document.forms[0].area_details.value="";
	fnchklist();
	if(document.forms[0].seldocrecd.value=="N" && document.forms[0].area_details.value=="" && document.forms[0].choose_type[0].checked)
	{
		alert("Select Additional Documents to be Submitted");
		doDetail();
		return;
	}
	
	
	if(document.forms[0].sel_bankscheme.value=="001")
	{
		var hidApp_deduperefno=document.forms[0].hidApp_deduperefno.value;
		var	hidApp_dedupestatus=document.forms[0].hidApp_dedupestatus.value;
			
		if(hidApp_dedupestatus=="NOT FOUND IN DIGI" && (document.forms[0].selcanvassedbystaff.value=="NP" || document.forms[0].selcanvassedbystaff.value=="NR"))
		{
			alert("Kindly try in Digi Application KBL XPRESS CAR");
			return false;
		}
		if(hidApp_dedupestatus=="IN PROGRESS")
		{
			alert("Kindly Complete the process in Digi Application KBL XPRESS CAR");
			return false;
		}
	}
	//vindhya begin	
 if(varpancheck=="Y")
	{
		//if(document.forms[0].hidtype.value!="a")
		{ 
			var checkamount="";
			if(document.forms[0].hidtype.value=="c" || document.forms[0].hidtype.value=="a")
			{
				var amt1=document.forms[0].txtcomcust_fwc.value;
				var amt2=document.forms[0].txtcomcust_ftf.value;
				var amt3=document.forms[0].txtcomcust_nf.value;
				if(amt1=="NaN" ||amt1=="")	{
					amt1="0.00";
				}if(amt2=="NaN" ||amt2=="")
				{
					amt2="0.00";
				}
				if(amt3=="NaN" ||amt3=="")
				{
					amt3="0.00";
				}
				checkamount=parseInt(amt1)+parseInt(amt2)+parseInt(amt3);
			}
			else
				{
				checkamount=parseInt(document.forms[0].txtret_ftf.value);
				}
			
			if(checkamount>=varpanchecklimit)
			{
				alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) "
				+"Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+varpanchecklimit+"/- and above");
			}
			
		}
	} 
	//vindhya end
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].selapplstatus.disabled=false;
	document.forms[0].selectgovtmain.disabled=false;
	document.forms[0].txt_leadno.disabled=false;
	
	document.forms[0].hidpurpose.value=document.forms[0].selpurpose[document.forms[0].selpurpose.selectedIndex].text;
	document.forms[0].hidBeanId.value="inwardRegister"
	document.forms[0].hidBeanMethod.value="updatedata";
	document.forms[0].hidBeanGetMethod.value="getdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/appinwardreg.jsp";
	document.forms[0].submit();
}
function doDetail()
{
	if(document.forms[0].choose_type[0].checked)
	{
		if(document.forms[0].sel_bankscheme.value=="")
		{
			alert("select Bank scheme");
			document.forms[0].sel_bankscheme.focus();
			return;
		}
		var sector = document.forms[0].sel_bankscheme.value;
		var purl =appURL+"action/schemedocdetail.jsp?hidBeanId=setmodtermscond&hidBeanGetMethod=getSectorSchemeDoc&sector="+sector;
		var prop = 'scrollbars=yes,menubar=yes,width=450,height=360';	
		var xpos = (screen.width) / 2;
		var ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
	}
}

function showCitySearch(val1)
{
	if(val1 == "INWARD")
	{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/searchCity.jsp?inward="+val1;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
	}
	
}

function mobchk(mob,obj)
{
    var result = false;
  	if(trim(obj.value)!="")
	{
	  	var theStr = new String(mob);
	  	var index = theStr.charAt(0);
	  	if (index > 0)
	  	{
		  	var mobile=mob.substring(0,6);
		  	if(mobile=="123456" || mobile=="234567" || mobile=="345678" || mobile=="456789" || mobile=="654321"
		  		|| mobile=="765432" || mobile=="876543" || mobile=="987654")
		  	{
		  		ShowAlert('105',' Mobile No.');
				obj.value="";
				obj.focus();
		  	}
		}
	}
  	return result;
}

function phonechk(phone,obj)
{
	    var result = false;
	  	if(trim(obj.value)!="")
		{
		  	var theStr = new String(phone);
		  	var index = theStr.charAt(0);
		  	if (index > 0)
		  	{
			  	var phone=phone.substring(0,6);
				
			  	if(phone=="123456" || phone=="234567" || phone=="345678" || phone=="456789" || phone=="654321"
			  		|| phone=="765432" || phone=="876543" || phone=="987654")
			  	{
			  		ShowAlert('105',' Phone No.');
					obj.value="";
			  	}
			  
			}
				
		    
		}
	  	return result;
}
function showcustid()
{
	var custvalue=document.forms[0].selcusttype.value;
	if(document.forms[0].selcusttype.value=="E" ||document.forms[0].selcusttype.value=="B")
	{
		document.all.custid.style.visibility="visible";
		document.all.custid.style.position="relative";
		document.all.custid1.style.visibility="visible";
		document.all.custid1.style.position="relative";
		document.forms[0].txt_cbscustid.readOnly="true";
	}
	else
	{
		document.all.custid.style.visibility="hidden";
		document.all.custid.style.position="absolute";
		document.all.custid1.style.visibility="hidden";
		document.all.custid1.style.position="absolute";
	}
	document.forms[0].selcusttype.value=custvalue;
}
function applied()
{
	if((document.forms[0].choose_type[2].checked==true || document.forms[0].choose_type[3].checked==true) && document.forms[0].selcusttype.value=="B")
	{
		document.all.applied.style.visibility="visible";
		document.all.applied.style.position="relative";
	}
	else
	{
		document.all.applied.style.visibility="hidden";
		document.all.applied.style.position="absolute";
		document.forms[0].selapplied.value='N';
	}
	if(document.forms[0].selcusttype.value=="N")
	{
		if(varEXTERNALAPP_FLAG!="Y")
		{
			document.forms[0].selapplstatus.value="2";
			document.forms[0].selapplstatus.disabled=true;
		}
		checkStatus();
	}
	else
	{
		if(document.forms[0].selapplstatus.value !="")
		{
			if (varappstatus=="")
				varappstatus="0";
			document.forms[0].selapplstatus.value=varappstatus;
			document.forms[0].selapplstatus.disabled=false;
			checkStatus();
		}
		else
		{
			document.forms[0].selapplstatus.value="0";
			document.forms[0].selapplstatus.disabled=false;
			checkStatus();
		}
	}
}
function check()
{
	if(document.forms[0].hidAction.value=='edit' && document.forms[0].hidoldappcreation.value=='2')
	{
	
		if(document.forms[0].hidoldtype.value != document.forms[0].hidtype.value)
		{	
		alert("This will delete all the contents");
		}
		
		else if(document.forms[0].hidoldapplied.value != document.forms[0].selapplied.value)
		{	
		alert("This will delete all the contents");
		}
		
		else if(document.forms[0].hidoldappcreation.value != document.forms[0].selappcreation.value)
		{	
		alert("This will delete all the contents");
		}
	}
	
	if(document.forms[0].selappcreation.value =="6" && varstrOrgLevel=="D" && varRLPFUser=="012")
	{
		//do Nothing
	}
	else if(document.forms[0].selappcreation.value =="1" && varstrOrgLevel=="D" && varRLPFUser=="012")
	{
		alert("you cannot create LAR for Branch Proposal");
		document.forms[0].selappcreation.value="0";
		return;
	}
	/*else if(document.forms[0].selappcreation.value =="6")
	{
		alert("you cannot create LAR for RLPC Proposal");
		document.forms[0].selappcreation.value="0";
		return;
	}*/
}
function fncallIdentificationDet()
{
		//document.all.id_enquirypurpose.style.visibility="hidden";
		document.all.id_gender.style.visibility = "hidden";
		document.all.id_gender.style.position = "absolute";
		document.all.id_passport.style.visibility = "hidden";
		document.all.id_passport.style.position = "absolute";
		document.all.id_enquirypurpose.style.display = "none";
		//document.all.id_enquirypurpose.style.position = "absolute";
		clearcibilfield();
		document.all.id_passport.style.visibility = "visible";
		document.all.id_passport.style.position = "relative";
}

function clearcibilfield(){
	
	document.forms[0].selgender.value="0";
	document.forms[0].txtcomcust_passno.value="";
	document.forms[0].txtcomcust_voterid.value="";
	document.forms[0].selpurpose.value="0";
}

function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date of receipt of physical application form and initial Documents cannot be lesser than Loan application register Date");
			document.forms[0].txt_appdate.value="";
			document.forms[0].txt_appdate.focus();								
		}			
	}
}
function showDistSearch(val)
{  

	var varstate = document.forms[0].hid_state.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
	if(document.forms[0].hid_state.value=="")
	{
		alert("Please Reselect the City");
		document.forms[0].txt_comcustcity.focus();
		return;
	}
	if(document.forms[0].txt_comcustcity.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].txt_comcustcity.focus();
		return;
	}	
	else		
	{
    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
	}
	}	
	
}
function selsubmain()
{
     if(document.forms[0].selectgovtmain.value == "1")
	 {
	    document.all.s5m.style.display="table-cell";
	   // document.all.s5m.style.position="relative";	
	    	
	    document.all.s6m.style.display="table-cell";
	   // document.all.s6m.style.position="relative";
	    
    	document.all.s1m.style.display="table-cell";
    	//document.all.s1m.style.position="relative";
    		
    	document.all.s2m.style.display="table-cell";
    	//document.all.s2m.style.position="relative";	
    	
    	document.all.s3m.style.display="table-row";
    	//document.all.s3m.style.position="relative";	

    	if(trim(document.forms[0].sel_sponser_agencymain.value)=="OTHERS")
    	{
    		document.all.s4m.style.display="table-row";
        	//document.all.s4m.style.position="relative";	
    	}
    	else
    	{
    		document.all.s4m.style.display="none";
        	//document.all.s4m.style.position="absolute";
        	document.forms[0].txt_agency.value="";
    	}    	
    }
    else
  	{
    	document.forms[0].schemetypemain.value="0";
    	document.forms[0].submainamnt.value="";
    	document.forms[0].txt_agency.value="";
    	document.forms[0].sel_sponser_agencymain.value="0";
    	document.forms[0].sel_subsidytypemain.value="0";
    	
    	document.all.s5m.style.display="none";
    	//document.all.s5m.style.position="absolute";
    	
    	document.all.s6m.style.display="none";
    	//document.all.s6m.style.position="absolute";
    		
    	document.all.s1m.style.display="none";
    	//document.all.s1m.style.position="absolute";
    		
    	document.all.s2m.style.display="none";
    	//document.all.s2m.style.position="absolute";
    		
    	document.all.s3m.style.display="none";	
    	//document.all.s3m.style.position="absolute";

    	document.all.s4m.style.display="none";		
    	//document.all.s4m.style.position="absolute";
   }
}

function showtargetmasteralert()
{
	alert("Please ensure all the details are captured in Target Master");
}

function showAgency()
{
	if(trim(document.forms[0].sel_sponser_agencymain.value)=="OTHERS")
	{
	document.all.s4m.style.display="table-row";
	}
	else
	{
		document.all.s4m.style.display="none";
		document.forms[0].txt_agency.value="";
	}
}
function selcust(){
	var custvalue=document.forms[0].selcusttype.value;
	var LeadNo=document.forms[0].txt_leadno.value;
	if(varstrnew=="Y"){
	if(document.forms[0].selcusttype.value=="E" ||document.forms[0].selcusttype.value=="B")
	{
		disableFields(false);
		ClearFields();
	}
	else
	{
		alert("If New Connection is selected, the Inward will be automatically rejected")
		disableFields(false);
		ClearFields();
		document.forms[0].selapplstatus.value="2";
		document.forms[0].selapplstatus.disabled=true;
	}
	}
	document.forms[0].selcusttype.value=custvalue;
	document.forms[0].txt_leadno.value=LeadNo;
	if(varPageFrom=="Y")
	{
		document.forms[0].choose_type[1].disabled=true;
		document.forms[0].choose_type[2].disabled=true;
		document.forms[0].choose_type[3].disabled=true;
	}
}
function discbsvalues()
{
	var valcbsid=document.forms[0].txt_cbscustid.value;
	if(valcbsid!=""){
		document.forms[0].txt_comncustame.readOnly=true;
		document.forms[0].txt_comDOB.readOnly=true;	
		document.forms[0].txt_comcustadd1.readOnly=true;	
		document.forms[0].txt_comcustcity.readOnly=true;
		document.forms[0].txtcomcust_state.readOnly=true;
		document.forms[0].txtcomcust_zip.readOnly=true;
		document.forms[0].txt_comcustadd2.readOnly=true;
		document.forms[0].txtcomcust_pan.readOnly=true;
		document.forms[0].txtcomcust_phone.readOnly=true;
		document.forms[0].txtcomcust_mobile.readOnly=true;
	}
}
function callUsersHelp(val)
{
	var pagefield="inward"+val;
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom="+pagefield;
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function enablestafffields()
{
	if(document.forms[0].selcanvassedbystaff.value=="Y")
	{
		document.all.idstaff1.style.display="inline";
		document.all.idstaff2.style.display="inline";
		
		document.all.idLeadgen.style.display="none";
		document.all.idLeadgen.style.display="none";
		document.forms[0].hidAgentID.value="";
		document.forms[0].sel_leadgenby.value="0";
		document.forms[0].txt_name.value="";
		document.all.idLeadconv.style.display="inline";
		document.all.idLeadconv.style.display="inline";
	}
	else if(document.forms[0].selcanvassedbystaff.value=="N")
	{
		document.all.idLeadgen.style.display="inline";
		document.all.idLeadgen.style.display="inline";
				
		document.all.idstaff1.style.display="none";
		document.all.idstaff2.style.display="none";
		document.forms[0].txt_staffid.value="";
		document.forms[0].txt_staffname.value="";
		document.all.idLeadconv.style.display="inline";
		document.all.idLeadconv.style.display="inline";
	}
	else
	{
			document.all.idstaff1.style.display="none";
			document.all.idstaff2.style.display="none";
			document.forms[0].txt_staffid.value="";
			document.forms[0].txt_staffname.value="";
			document.forms[0].sel_leadgenby.value="0";
			document.forms[0].sel_leadregion.value="";
			document.forms[0].txt_name.value="";
			
			document.all.idLeadgen.style.display="none";
			document.all.idLeadgen.style.display="none";
			document.forms[0].hidAgentID.value="";
			document.forms[0].txt_name.value="";
			
			document.all.idLeadconv.style.display="none";
			document.all.idLeadconv.style.display="none";
			document.forms[0].txt_convertedid.value="";
			document.forms[0].txt_convertedname.value="";

	}
	
	
	
}