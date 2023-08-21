function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	disableFields(false);
	document.forms[0].hidAction.value="insert";
	disableCommandButtons(true,false,false,false,true);
}

function doDelete()
{
	if(varRecordflag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="perpropertydetails";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateData";
		    document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].hidSourceUrl.value="/action/perpropertydetails.jsp";
			document.forms[0].submit();		
		}	
	}
	else
	{
		showAlert('158');
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{	      			
		document.forms[0].action=appURL+"action/perpropertydetails.jsp";
		document.forms[0].hidBeanId.value="perpropertydetails";
	  	document.forms[0].hidBeanMethod.value="getData";
	  	document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{		
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}


function disableFields(flag)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text" )
		{
			document.forms[0].elements[i].readOnly=flag;
		}
		if(document.forms[0].elements[i].type=="select-one" )
		{
			document.forms[0].elements[i].disabled=flag;
		}
		if(document.forms[0].elements[i].type=="textarea" )
		{
			 document.forms[0].elements[i].readOnly=flag;
		}
		if(document.forms[0].elements[i].type=="radio" )
		{
			 document.forms[0].elements[i].disabled=flag;
		}
		if(document.forms[0].elements[i].type=="checkbox" )
		{
			 document.forms[0].elements[i].disabled=flag;
		}		
	}	
	document.forms[0].prop_city.readOnly=true;
    document.forms[0].prop_state.readOnly=true;
    document.forms[0].prop_housingaddress.readOnly=true;
    document.forms[0].prop_institutename.readOnly=true;
    document.forms[0].prop_totalcost.readOnly=true;
    document.forms[0].prop_totalfund.readOnly=true;
    document.forms[0].txt_municipaldate.readOnly=true;
    document.forms[0].txt_waterdate.readOnly=true;
}




function calltakeover()
{	
    var varQryString = appURL+"action/per_takeover.jsp?hidBeanId=pertakeover&hidBeanGetMethod=getData&appno="+ appno+"&btnenable="+document.forms[0].btnenable.value;
	var title = "Cost and Source";
	var prop = "scrollbars=yes,width=800,height=550";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);	
}

function callsupnam1()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/coopsocietymastlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getCoopSocietyMasterList&hidAction=search&strfrom=House";
		window.open(url,"",prop);
	}
}

function callsupnam()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/builderslist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getBuilderMasterList&hidAction=search&strfrom=House";
		window.open(url,"",prop);
	}
}

function callCalender(name)
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		showCal(appURL,name);
	}
}

function openGeneral()
{	
	var varQryString = appURL+"action/propgeninfo.jsp?hidBeanId=perpropertydetails&hidBeanGetMethod=getGeneralInfo&hidBeanMethod=updateGeneralInfo&appno="+ appno+"&app_name="+document.forms[0].appname.value+"&app_status="+varAppStatus+"&btnenable="+document.forms[0].btnenable.value;
	var title = "General Information";
	var prop = "scrollbars=yes,width=600,height=350, menubar=yes";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);
}

function caculatetot()
{
	var txtcostofland=document.forms[0].txtcostofland.value;
	if(txtcostofland=="")
	{
		txtcostofland="0.00";
	}
	var prop_cost=document.forms[0].prop_cost.value;
	if(prop_cost=="")
	{
		prop_cost="0.00";
	}	
	var prop_amountinvested=document.forms[0].prop_amountinvested.value;
	if(prop_amountinvested=="")
	{
		prop_amountinvested="0.00";
	}
	var prop_costofconstruct=document.forms[0].prop_costofconstruct.value;
	if(prop_costofconstruct=="")
	{
		prop_costofconstruct="0.00";
	}
	var prop_savingbank=document.forms[0].prop_savingbank.value;
	if(prop_savingbank=="")
	{
		prop_savingbank="0.00";
	}
	var prop_costofamenties=document.forms[0].prop_costofamenties.value;
	var prop_outstandingloan=document.forms[0].prop_outstandingloan.value;
	if(prop_costofamenties=="")
	{
		prop_costofamenties="0.00";
	}
	if(prop_outstandingloan=="")
	{
		prop_outstandingloan="0.00";
	}
	var prop_disposal=document.forms[0].prop_disposal.value;
	if(prop_disposal=="")
	{
		prop_disposal="0.00";
	}
	var prop_registration=document.forms[0].prop_registration.value;
	
	if(prop_registration=="")
	{
		prop_registration="0.00";
	}
	var prop_otheramt=document.forms[0].prop_otheramt.value;
	if(prop_otheramt=="")
	{
		prop_otheramt="0.00";
	}
	var prop_otheramt2=document.forms[0].prop_otheramt2.value;
	if(prop_otheramt2=="")
	{
		prop_otheramt2="0.00";
	}
	var prop_otheramt1=document.forms[0].prop_otheramt1.value;
	if(prop_otheramt1=="")
	{
		prop_otheramt1="0.00";
	}
	if(document.forms[0].prop_totalcost.value=="")
	{
	document.forms[0].prop_totalcost.value="0.00";
	}
	if(document.forms[0].prop_totalfund.value=="")
	{
	document.forms[0].prop_totalfund.value="0.00";
	}
	var totcost=parseFloat(txtcostofland)+parseFloat(prop_outstandingloan)+parseFloat(prop_costofconstruct)+parseFloat(prop_costofamenties)+parseFloat(prop_registration)+parseFloat(prop_otheramt);
	var totfund=parseFloat(prop_amountinvested)+parseFloat(prop_savingbank)+parseFloat(prop_disposal)+parseFloat(prop_otheramt1)+parseFloat(prop_otheramt2);
	document.forms[0].prop_totalcost.value=parseFloat(totcost);
	roundtxt(document.forms[0].prop_totalcost);
	document.forms[0].prop_totalfund.value=parseFloat(totfund);
	roundtxt(document.forms[0].prop_totalfund);
	roundtxt(document.forms[0].prop_totalcost);
	roundtxt(document.forms[0].prop_totalfund);
}

function opendisbursement()
{
	var varQryString = appURL+"action/disburdetails.jsp?hidBeanId=perpropertydetails&hidBeanGetMethod=getdisbursementdetails&appno="+ appno+"&btnenable="+document.forms[0].btnenable.value;
	var title = "Cost and Source";
	var prop = "scrollbars=yes,width=700,height=330";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);
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


function clearfields()
{
	document.forms[0].propertytype1.value="";
	document.forms[0].prop_type.value="";
	document.forms[0].prop_areaofplot.value="";
	document.forms[0].prop_builtup.value="";
	document.forms[0].prop_totalcostloan.value="";
	document.forms[0].prop_mortgage.value="0";
	document.forms[0].marketability.value="0";
	document.forms[0].prop_purchaseprice.value="";
	document.forms[0].prop_allotted.value="0";
	document.forms[0].propertytype2.value="0";
	document.forms[0].prop_age.value="";
	document.forms[0].prop_costofcomplete.value="";
	document.forms[0].prop_floorno.value="";
	document.forms[0].prop_area.value="";
	document.forms[0].prop_state.value="";
	document.forms[0].prop_mar_land.value="";
	document.forms[0].prop_unexpiredlease.value="";
	document.forms[0].prop_agree_date.value="";
	document.forms[0].sel_house.value="0";
	document.forms[0].prop_sellername.value="";
	document.forms[0].txt_selleraddress.value="";
	document.forms[0].txt_completion.value="";
	document.forms[0].prop_cost.value="";
	document.forms[0].txt_certificateissu.value="";
	
	
	document.forms[0].prop_areaofplot.value="";
	document.forms[0].prop_proposedbuildup.value="";
	document.forms[0].sel_own.value="0";
	document.forms[0].qualityconst.value="0";
	
	document.forms[0].presenceamenities.value="0";
	document.forms[0].prop_estimatedprice.value="";
	document.forms[0].sel_dwell.value="0";
	document.forms[0].prop_estimatedprice.value="";
	
	document.forms[0].prop_repairdetails.value="";
	document.forms[0].firstmortgage.value="0";
	document.forms[0].prop_houseno.value="";
	document.forms[0].sel_nature.value="S";
	document.forms[0].prop_city.value="";
	document.forms[0].prop_pin.value="";
	
	document.forms[0].prop_mar_build.value="";
	document.forms[0].prop_lease_expdate.value="";
	document.forms[0].prop_agree_no.value="";
	document.forms[0].prop_exp_rent.value="";
	document.forms[0].prop_intermsecurity.value="";
	document.forms[0].prop_proj_details.value="";
	
	document.forms[0].prop_housingaddress.value="";
	document.forms[0].txt_municipaldate.value="";
	document.forms[0].txt_waterdate.value="";
	document.forms[0].prop_institutename.value="";
	document.forms[0].prop_societypermission.value="0";
	document.forms[0].prop_liensociety.value="0";
	
	document.forms[0].prop_outstandingsociety.value="0";
	document.forms[0].txt_municipaldate.value="";
	document.forms[0].txt_waterdate.value="";
	document.forms[0].prop_institutename.value="";
	//document.forms[0].prop_societypermission.value="";
	//document.forms[0].prop_liensociety.value="";
	document.forms[0].prop_construction.value="";
	document.forms[0].prop_plotprice.value="";
	document.forms[0].prop_costofconstruction.value="";
	
}

function showmarket()
{
		if(document.forms[0].prop_purpose.value!="6")
		{
			if(document.forms[0].propertytype1.value!="Land")
			{
			document.all.buldingvalue12.style.visibility="visible";
			}
			else
			{
			document.all.buldingvalue12.style.visibility="hidden";
			}
        }
}