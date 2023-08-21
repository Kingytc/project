function callOnload()
{  
	if(cmbauto_category=="1")
	{
	    document.all.b1.style.visibility="hidden";
		document.all.b1.style.position="absolute";
	    
	    document.all.b2.style.visibility="visible";
		document.all.b2.style.position="relative";   
	
	    document.all.a1.style.visibility="hidden";
		document.all.a1.style.position="absolute";
		
		document.all.a2.style.visibility="hidden";
		document.all.a2.style.position="absolute";
		
		document.all.a3.style.visibility="visible";
		document.all.a3.style.position="relative";
		
		document.all.a4.style.visibility="hidden";
		document.all.a4.style.position="absolute";
		
		document.all.a5.style.visibility="visible";
		document.all.a5.style.position="relative";
		
		document.all.a6.style.visibility="visible";
		document.all.a6.style.position="relative";
		
		document.all.a7.style.visibility="hidden";
		document.all.a7.style.position="absolute";
		
		document.all.a8.style.visibility="visible";
		document.all.a8.style.position="relative";
		
		document.all.registration.style.visibility="hidden";
	    document.all.registration.style.position="absolute";
		document.all.registration1.style.visibility="hidden";
		document.all.registration1.style.position="absolute";
		document.all.registration2.style.visibility="hidden";
		document.all.registration2.style.position="absolute";
		
	}
	else if(cmbauto_category=="2")
	{
	    
	    document.all.b2.style.visibility="hidden";
		document.all.b2.style.position="absolute";
		document.all.b1.style.visibility="visible";
		document.all.b1.style.position="relative";
	
	    document.all.a1.style.visibility="visible";
		document.all.a1.style.position="relative";
		
		document.all.a2.style.visibility="visible";
		document.all.a2.style.position="relative";
		
		document.all.a3.style.visibility="hidden";
		document.all.a3.style.position="absolute";
		
		document.all.a4.style.visibility="visible";
		document.all.a4.style.position="relative";
		
		document.all.a5.style.visibility="hidden";
		document.all.a5.style.position="absolute";
		
		document.all.a6.style.visibility="hidden";
		document.all.a6.style.position="absolute";
		
		document.all.a7.style.visibility="visible";
		document.all.a7.style.position="relative";
		
		document.all.a8.style.visibility="hidden";
		document.all.a8.style.position="absolute";
		
		document.all.registration.style.visibility="visible";
		document.all.registration.style.position="relative";
		document.all.registration1.style.visibility="visible";
		document.all.registration1.style.position="relative";
		document.all.registration2.style.visibility="visible";
		document.all.registration2.style.position="relative";
	}
	else 
	{
	    document.all.b2.style.visibility="hidden";
		document.all.b2.style.position="absolute";
		
		document.all.b1.style.visibility="hidden";
		document.all.b1.style.position="absolute";
	
	    document.all.a1.style.visibility="hidden";
		document.all.a1.style.position="absolute";
		
		document.all.a2.style.visibility="hidden";
		document.all.a2.style.position="absolute";
		
		document.all.a3.style.visibility="hidden";
		document.all.a3.style.position="absolute";
		
		document.all.a4.style.visibility="hidden";
		document.all.a4.style.position="absolute";
		
		document.all.a5.style.visibility="hidden";
		document.all.a5.style.position="absolute";
		
		document.all.a6.style.visibility="hidden";
		document.all.a6.style.position="absolute";
		
		document.all.a7.style.visibility="hidden";
		document.all.a7.style.position="absolute";
		
		document.all.a8.style.visibility="hidden";
		document.all.a8.style.position="absolute";
		
		document.all.registration.style.visibility="hidden";
	    document.all.registration.style.position="absolute";
		document.all.registration1.style.visibility="hidden";
		document.all.registration1.style.position="absolute";
		document.all.registration2.style.visibility="hidden";
		document.all.registration2.style.position="absolute";
	
	}
	
	 
	if(radio_applicantdrivenvehicle=="Y" || radio_applicantdrivenvehicle=="")
    {
     	document.forms[0].radio_applicantdrivenvehicle[0].checked=true;
     	document.forms[0].radio_applicantdrivenvehicle[1].checked = false;
    }
    else if( radio_applicantdrivenvehicle== "N")
    {
      	document.forms[0].radio_applicantdrivenvehicle[0].checked=false;
      	document.forms[0].radio_applicantdrivenvehicle[1].checked = true;
    }
	if(selectpurdurable!="")
	{
		document.forms[0].selectpurdurable.value=selectpurdurable;
	}
	else
	{
		document.forms[0].selectpurdurable.value="0";
	}
		
	if(selauthdealer!="")
	{
		document.forms[0].selauthdealer.value=selauthdealer;
	}
	else
	{
		document.forms[0].selauthdealer.value="0";
	}
	
	if(AUTO_SALTOSB!="")
	{
		document.forms[0].sel_salrytoSB.value=AUTO_SALTOSB;
	}
	else
	{
		document.forms[0].sel_salrytoSB.value="0";
	}
	
	if(AUTO_UNDERTKNGLETTER!="")
	{
		document.forms[0].sel_undrtkngletter.value=AUTO_UNDERTKNGLETTER;
	}
	else
	{
		document.forms[0].sel_undrtkngletter.value="0";
	}
	
	if(chkboxdealer == "Y")
	{
		document.forms[0].chkboxdealer[0].checked = true;
		document.forms[0].chkboxdealer[1].checked = false;
	}
	else if(chkboxdealer == "N")
	{
		document.forms[0].chkboxdealer[0].checked = false;
		document.forms[0].chkboxdealer[1].checked = true;
	}
	
	if(varprd_type=="pU" && varProAvailableFor=="V")
	{
		if(cmbauto_category!="")
		{
		document.forms[0].cmbauto_category.value = cmbauto_category;
		}
		else
		{
		document.forms[0].cmbauto_category.value="0";
		}
		if(vehicletype!="")
		{
		document.forms[0].sel_vehicletype.value = vehicletype;
		}
		else
		{
			document.forms[0].sel_vehicletype.value="0";
		}
		
	}
	else if(vehicletype!="")
	{
		if(vehicletype == "T")
		{
			document.forms[0].sel_vehicletype.value = "1";
			document.forms[0].cmbauto_category.value = "1";			
		}
		else if(vehicletype == "N")
		{
			document.forms[0].sel_vehicletype.value = "3";
			document.forms[0].cmbauto_category.value = "1";		
		}
		else if(vehicletype == "U")
		{
			document.forms[0].sel_vehicletype.value = "3";
			document.forms[0].cmbauto_category.value = "2";		
		}
		else if(vehicletype == "A")
		{
			document.forms[0].sel_vehicletype.value = "2";
			document.forms[0].cmbauto_category.value = "1";		
		}
		
	}
	else
	{	
		document.forms[0].sel_vehicletype.value="0";
		document.forms[0].cmbauto_category.value="0";
	}
	if(fuelused!="")
	{
		document.forms[0].txt_fuelused.value=fuelused;
	}
	else
	{
		document.forms[0].txt_fuelused.value="0";
	}
	if(document.forms[0].sel_take_over.value=="" || document.forms[0].sel_take_over.value=="0")
	{
		//document.forms[0].sel_take_over.value=auto_take_over;
		document.forms[0].sel_take_over.value=vartakeover;
	}
	if(natureCharge!="")
	{
		document.forms[0].sel_natureCharge.value=natureCharge;
	}
	else
	{
		document.forms[0].sel_natureCharge.value="0";
	}
	Showopervia();
	disableCategory();
	callEnableFields(true);
	clearFields();
	if(varprd_type=="pA" || (varprd_type=="pU" && varProAvailableFor=="V")){
		document.forms[0].cmdnew.disabled=true;
	}
	//document.forms[0].radiobutton.disabled=false;
	//if(varstrFreeze=='Y')
	//{
		//document.forms[0].cmdedit.disabled=true;
		//document.forms[0].cmdsave.disabled=true;
	//}
	//security creation removed while saving proposed offered asset tab
	//if(document.forms[0].hidSecValue.value!="")
	//{
		//document.forms[0].sel_jointholder.value = document.forms[0].hidSecValue.value;
	//}
	//else
	//{
		//document.forms[0].sel_jointholder.value = "";
	//}
	
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
	//jointownerdelall();
	//jointownerdisp(securityowners);
	if(staffCond == "staff")
	{
		funoldVehType();
		
		if(varoldvehtype!="")
		{
			document.forms[0].sel_oldcar_type.value=varoldvehtype;
		}
		else
		{
			document.forms[0].sel_oldcar_type.value="0";
		}
	}
	document.all.City_pop.style.visibility="hidden";
}


function funoldVehType()
{
	if(staffCond=="staff")
	{
	if(document.forms[0].cmbauto_category.value=="2" && document.forms[0].sel_vehicletype.value=="3")
	{
		document.all.old1.style.display="table-cell";
		document.all.old2.style.display="table-cell";
	}
	else
	{
		document.all.old1.style.display="none";
		document.all.old2.style.display="none";
	}
	}
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

function callDisableControls(cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function doNew() 
{	
	document.forms[0].hidAction.value="insert";
	//disableCommandButtons(true, false, false, false, true);	
	callEnableFields(false);
	clearFields();
	enableButtons(true, true, false, false, true,true);
	document.forms[0].hideditflag.value="Y";
	/*//document.forms[0].txtauto_age.readOnly=true;
	if(var_vehAge!="")
		document.forms[0].txtauto_age.value=var_vehAge;
	else
		document.forms[0].txtauto_age.value="0";*/
}

function doEdit()
{  
	
	if(varcustrelease=="V" && varsessionmodtype=="DIGI")
	{
		alert("Security is not verified, Kindly verify and proceed");
		return false;
	}
	
	document.forms[0].hideditflag.value="Y";
    document.forms[0].hidAction.value="update";	
    var varsecID=document.forms[0].hidsecID.value;
    enableButtons(true, true, false, false, true,true);
    if(varsecID==null||varsecID==""){
    	callEnableFields(false);
    }else{
    	callEnableFields(true);
    	document.forms[0].selectpurdurable.disabled=false;
    	document.forms[0].txtauto_valuation.readOnly=false;
    	document.forms[0].txtauto_accessories.readOnly=false;
    	document.forms[0].txtauto_tax.readOnly=false;
    	document.forms[0].txtauto_insurance.readOnly=false;
    	document.forms[0].txtauto_charges.readOnly=false;
    	document.forms[0].txt_discount.readOnly=false;
    	document.forms[0].txt_fuelused.disabled=false;
    	document.forms[0].radio_applicantdrivenvehicle.disabled=false;
    	document.forms[0].txtauto_vehicles.readOnly=false;
    	document.forms[0].txtauto_valuation.readOnly=false;
		document.forms[0].txtauto_accessories.readOnly=false;
		document.forms[0].txtauto_tax.readOnly=false;
		document.forms[0].txtauto_insurance.readOnly=false;
		document.forms[0].txtauto_charges.readOnly=false;
		document.forms[0].txtauto_totcost.readOnly=false;
		document.forms[0].selauthdealer.disabled=false;
		document.forms[0].txtdealersince.readOnly=false;
		document.forms[0].sel_salrytoSB.disabled=false;
		document.forms[0].sel_undrtkngletter.disabled=false;
		document.forms[0].txa_remarks.disabled=false;
		document.forms[0].cmbauto_category.disabled=false;
    }
      // document.forms[0].txt_userid.readOnly=true;
  
    if(document.forms[0].cmbauto_category.value=="1")
	{
		document.forms[0].txtauto_engine.value.readOnly=true;
		document.forms[0].txtauto_chasis.readOnly=true;
		document.forms[0].txtauto_registration.value.readOnly=true;
		}
    	if(document.forms[0].cmbauto_category.value=="2")
		{
			document.forms[0].txtauto_age.readOnly=true;
			document.forms[0].txt_originalcost.readOnly=false;
			document.forms[0].txtauto_valuation1.readOnly=false;
			document.forms[0].txt_actualconsideration.readOnly=false;
			document.forms[0].txt_leastvalue.readOnly=true;
			document.forms[0].txtauto_ownername.readOnly=false;
			document.forms[0].txt_dateofmanufac.readOnly=false;
			document.forms[0].txt_registration.readOnly=false;
		}
		//security creation removed while saving proposed offered asset tab
    //document.forms[0].add1.disabled=false;
	//document.forms[0].remove.disabled=false;  
    document.forms[0].txtauto_totcost.readOnly=true;
   document.forms[0].txtsup_city.readOnly=true;
   document.forms[0].txtsup_state.readOnly=true;
   //disableCategory();
   document.forms[0].cmbauto_category.disabled = true;
   if(varprd_type=="pU" && varProAvailableFor=="V")
   {
	   document.forms[0].sel_vehicletype.disabled = false;
   }
   else
   {
	   document.forms[0].sel_vehicletype.disabled = true;
   }
   document.forms[0].txtauto_age.readOnly=true;
   
  }
  
function doSave()
{	
	document.forms[0].hidRecordflag.value=varRecordFlag;
	var totalPrice_veh=document.forms[0].hidTotCost_veh.value;
	var varsecID=document.forms[0].hidsecID.value;
    if(document.forms[0].sel_vehicletype.value=="0")
	{
		ShowAlert('111','Vehicle Type');
		document.forms[0].sel_vehicletype.focus();
		return;
	}
   /* if(trim(document.forms[0].txtauto_article.value)=="")
    {
    	ShowAlert('121','Brand Name');
    	document.forms[0].txtauto_article.focus();
    	return;
    }*/
    if(document.forms[0].selectpurdurable.value=="0"  )
	{
		ShowAlert('111',"purchase of vehicle");
		document.forms[0].selectpurdurable.focus();
		
		return false;
	}	
	if(document.forms[0].cmbauto_category[document.forms[0].cmbauto_category.selectedIndex].value=="0")
	{
		ShowAlert('111',"Category");
		document.forms[0].cmbauto_category.focus();
		return false;
	}
	if(document.forms[0].txtauto_make.value=="")
	{
		ShowAlert('121',"Make");
		document.forms[0].txtauto_make.focus();
		return false;
	}
	if(checktrim(document.forms[0].txtauto_model.value)=="")
	{
		ShowAlert('121',"Model");
		document.forms[0].txtauto_model.focus();
		return false;
	}
	
	if(staffCond == "staff" && document.forms[0].cmbauto_category.value=="2" && document.forms[0].sel_vehicletype.value=="3")
	{
		if(document.forms[0].sel_oldcar_type.value=="0")
		{
			document.forms[0].sel_oldcar_type.focus();
			ShowAlert('111',"Type of Vehicle");
			return false;
		}
	}
	if(document.forms[0].sel_natureCharge.value=="0")
	{
		ShowAlert('111',"Nature of Charge");
		document.forms[0].sel_natureCharge.focus();
		return false;
	}
	if(document.forms[0].sel_take_over.value=="0")
	{
		ShowAlert('111',"Whether Take-Over");
		document.forms[0].sel_take_over.focus();
		return false;
	}
	if(trim(document.forms[0].txtauto_dealer.value)=="")
	{
		ShowAlert('121','Name of the Supplier');
		document.forms[0].txtauto_dealer.focus();
		return;
	}
	
	if(trim(document.forms[0].txtsup_address1.value)=="")
	{
		ShowAlert('121','Supplier Address');
		document.forms[0].txtsup_address1.focus();
		return;
	}
	if(trim(document.forms[0].txtsup_city.value) == "")
	{
		ShowAlert('121','Supplier City');
		document.forms[0].txtsup_city.focus();
		return;
	}
	if(trim(document.forms[0].txtsup_state.value)== "")
	{
		ShowAlert('121','Supplier State');
		document.forms[0].txtsup_state.focus();
		return;
	}
	if(trim(document.forms[0].txtsup_zip.value) == "")
	{
		ShowAlert('121','Supplier Pincode');
		document.forms[0].txtsup_zip.focus();
		return;
	}

	if((document.forms[0].sel_vehicletype.value=="1" || document.forms[0].sel_vehicletype.value=="3") && document.forms[0].cmbauto_category.value=="1"){
		
		if(trim(document.forms[0].txtauto_valuation.value) == "" || trim(document.forms[0].txtauto_valuation.value) == "0.00")
		{
			ShowAlert('121','Cost Price of the Vehicle');
			document.forms[0].txtauto_valuation.focus();
			return;
		}
		
		if(trim(document.forms[0].txtauto_tax.value) == "" || trim(document.forms[0].txtauto_tax.value) == "0.00")
		{
			ShowAlert('121','Tax');
			document.forms[0].txtauto_tax.focus();
			return;
		}
		/*if(trim(document.forms[0].txtauto_insurance.value) == ""||trim(document.forms[0].txtauto_insurance.value) == "0.00")
		{
			ShowAlert('121','Insurance');
			document.forms[0].txtauto_insurance.focus();
			return;
		}*/
	}
	
	
if((document.forms[0].sel_vehicletype.value=="1" || document.forms[0].sel_vehicletype.value=="3") && document.forms[0].cmbauto_category.value=="2"){
		
	
		if(trim(document.forms[0].txtauto_valuation1.value) == "0.00" || trim(document.forms[0].txtauto_valuation1.value) == "")
		{
			ShowAlert('121','Valuation of the Vehicle');
			document.forms[0].txtauto_valuation1.focus();
			return;
		}
		
	}

if((document.forms[0].sel_vehicletype.value=="1" || document.forms[0].sel_vehicletype.value=="3") && document.forms[0].cmbauto_category.value=="2"){
	
	if(trim(document.forms[0].txt_registration.value) == "")
	{
		ShowAlert('121','Date of registration');
		document.forms[0].txt_registration.focus();
		return;
	}
}
if(varsecID!=""){
	if(document.forms[0].cmbauto_category.value!="2"){
	if(eval(document.forms[0].txtauto_totcost.value)!=eval(totalPrice_veh))
	{
		alert("Total Cost should be equal to Purchase Price/Invoice Price"+eval(totalPrice_veh));
		document.forms[0].txtauto_totcost.focus();
		return false;
	}
	}
}
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=false;	
		}
	}
	  
	//security creation removed while saving proposed offered asset tab
	//var rowCount=document.all.id_jointsec.rows.length;
	//document.forms[0].hidOwners.value=rowCount;
	document.forms[0].cmdsave.disabled=true;
	//document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanGetMethod.value="updateBoatAutoprim";
	document.forms[0].hidBeanId.value="percollateral";
	document.forms[0].action=appURL+"action/perappvehicle.jsp";	
	document.forms[0].submit();
}

function callEnableFields(one)
	{
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
		if(document.forms[0].elements[i].type=="text")
			{
			document.forms[0].elements[i].readOnly=one;	
			}
		if(document.forms[0].elements[i].type=="select-one")
			{
			document.forms[0].elements[i].disabled=one;	
			}
		if(document.forms[0].elements[i].type=="checkbox")
			{
			document.forms[0].elements[i].disabled=one;	
			}
		if(document.forms[0].elements[i].type=="textarea")
			{
			document.forms[0].elements[i].disabled=one;	
			}
		/*if(document.forms[0].elements[i].type=="radio")
			{
			document.forms[0].elements[i].disabled=one;	
			}*/
	}
	 document.forms[0].txtauto_totcost.readOnly=true;
	 document.forms[0].txtsup_city.readOnly=true;
  	 document.forms[0].txtsup_state.readOnly=true;
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

function doCancel()
	{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
		{
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].hidBeanGetMethod.value="getBoatAuto";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].action=appURL+"action/perappvehicle.jsp";	
		document.forms[0].submit();
		}
	}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
		//security creation removed while saving proposed offered asset tab
			//var rowCount=document.all.id_jointsec.rows.length;
			//document.forms[0].hidOwners.value=rowCount;
	     	document.forms[0].hidAction.value="delete";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="percollateral";
			document.forms[0].hidBeanMethod.value="updateBoatAutoprim";
		    document.forms[0].hidBeanGetMethod.value="getBoatAuto";
			document.forms[0].hidSourceUrl.value="/action/perappvehicle.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
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

function callMakeNull()
	{
	document.forms[0].txtauto_age.value="";
	document.forms[0].txt_originalcost.value="";
	document.forms[0].txtauto_valuation1.value="";
	document.forms[0].txt_actualconsideration.value="";
	document.forms[0].txt_leastvalue.value="";
	document.forms[0].txtauto_chasis.value="";
	document.forms[0].txtauto_engine.value="";
	document.forms[0].txtauto_ownername.value="";
	document.forms[0].txtauto_vehicles.value="";
	document.forms[0].txtauto_valuation.value="";
	document.forms[0].txtauto_accessories.value="";
	document.forms[0].txtauto_tax.value="";
	document.forms[0].txtauto_insurance.value="";
	document.forms[0].txtauto_charges.value="";
	document.forms[0].txtauto_totcost.value="";
	document.forms[0].txtauto_registration.value="";
	document.forms[0].txt_discount.value="";
	return false;
	}

function Showopervia()
	{
	if(document.forms[0].selectpurdurable.value=="3")
		{
		document.all.opervia.style.visibility="visible";
		document.all.opervia.style.position="relative";
		}
	else
		{
		document.all.opervia.style.visibility="hidden";
		document.all.opervia.style.position="absolute";
		}
	}
	
var xmlHttp=null;
function GetXmlHttpObject()
{
	
	try
	{
		xmlHttp=new XMLHttpRequest();
	}
	catch(e)	
	{
		try
		{
			xmlHttp= new ActiveXObject("Msxml12.XMLHTTP");
		}
		catch(e)
		{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	return xmlHttp;
	
}

function checkStaffCondition()	
{
	var vehimanudate=document.forms[0].txt_dateofmanufac.value;
	var appno=document.forms[0].appno.value;
	if(staffCond=="staff")
	{
		if(document.getElementById("sel_vehicletype").value!="" && vehimanudate!="")
		{
			var xmlHttp;
			var uri;
			
			xmlHttp=GetXmlHttpObject();
			if(xmlHttp==null)
			{
				alert("Browser Do Not Support Using Ajax....");
			}
			uri=appURL+"action/iframevechicleyear.jsp?hidBeanGetMethod=getStaffvechicle&hidBeanId=percollateral&vehimanudate="+vehimanudate+"&appno="+appno;
			uri = uri +"&sid="+Math.random();
			xmlHttp.onreadystatechange=loadsummary;
			xmlHttp.open("GET",uri,true);
			xmlHttp.send(null);
		}
	}
}

function loadsummary()
{
	if(xmlHttp.readyState==4)
	{	
		var val=xmlHttp.responseText;
		
		if(document.getElementById("sel_vehicletype").value=="1")
		{
			if(eval(val)>60)
			{
				alert("Secondhand Two Wheeler Cannot Exceeds More than 5 Years");
				document.forms[0].txt_dateofmanufac.value="";
			}
		}
		if(document.getElementById("sel_vehicletype").value=="3")
		{
			if(eval(val)>120)
			{
				alert("Secondhand Four Wheeler Cannot Exceeds More than 10 Years");
				document.forms[0].txt_dateofmanufac.value="";
			}
		}
	}
}
function disableCategory()
{
	if(document.forms[0].sel_vehicletype.value=="1")
	{
		//document.forms[0].cmbauto_category.value="1";
		enablevalues();
		//document.forms[0].cmbauto_category.disabled=true;
	} else {
		//document.forms[0].cmbauto_category.value="1";
		enablevalues();
		//document.forms[0].cmbauto_category.disabled=true;
	}
}
function calltakeover()
{	
	var appno = document.forms[0].appno.value;
    var varQryString = appURL+"action/per_takeover.jsp?hidBeanId=pertakeover&hidBeanGetMethod=getData&appno="+ appno+"&btnenable="+document.forms[0].btnenable.value+"&pagefrom=vehicle";
	var title = "Cost and Source";
	var prop = "scrollbars=yes,width=800,height=550";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);	
}

function clearFields(){
	
	document.forms[0].selectpurdurable.value="";
	document.forms[0].cmbauto_category.value="";
	document.forms[0].txtauto_make.value="";
	document.forms[0].txtauto_model.value="";
	document.forms[0].txtauto_article.value="";
	document.forms[0].txtauto_dealer.value="";
	document.forms[0].txtsup_address1.value="";
	document.forms[0].txtsup_address2.value="";
	document.forms[0].hidcity.value="";
	document.forms[0].hidstate.value="";
	document.forms[0].txtsup_zip.value="";
	document.forms[0].txtsup_city.value="";
	document.forms[0].txtsup_state.value="";
	document.forms[0].txtdealersince.value="";
	document.forms[0].txtsup_phone.value="";
	document.forms[0].selauthdealer.value="";
	/*document.forms[0].txtestablished.value="";
	document.forms[0].txtverf_doneby.value="";
	document.forms[0].txtverf_doneon.value="";
	document.forms[0].srcofverf.value="";
	document.forms[0].refmade.value="";
	document.forms[0].checkboxapp.value="";
	document.forms[0].chkboxdealer.value="";*/
	
	document.forms[0].radio_applicantdrivenvehicle.value="";
	document.forms[0].txt_fuelused.value="";
	document.forms[0].txa_remarks.value="";
	document.forms[0].sel_vehicletype.value="";
	document.forms[0].sel_take_over.value="";
	document.forms[0].txt_registration.value="";
	document.forms[0].sel_salrytoSB.value="0";
	document.forms[0].sel_undrtkngletter.value="0";
	document.forms[0].sel_natureCharge.value="0";
	if(staffCond=="staff"){
	document.forms[0].sel_oldcar_type.value="0";
	}
	document.forms[0].txtauto_age.value="";
	document.forms[0].txt_originalcost.value="";
	document.forms[0].txtauto_valuation1.value="";
	document.forms[0].txt_actualconsideration.value="";
	document.forms[0].txt_leastvalue.value="";
	document.forms[0].txtauto_chasis.value="";
	document.forms[0].txtauto_engine.value="";
	document.forms[0].txtauto_ownername.value="";
	document.forms[0].txtauto_vehicles.value="";
	document.forms[0].txtauto_valuation.value="";
	document.forms[0].txtauto_accessories.value="";
	document.forms[0].txtauto_tax.value="";
	document.forms[0].txtauto_insurance.value="";
	document.forms[0].txtauto_charges.value="";
	//document.forms[0].txtauto_totcost.value="";
	document.forms[0].txtauto_registration.value="";
	document.forms[0].txt_discount.value="";
}

function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val31,val32,val33,val34,val35,val36,val37,val38,val39,val40,val41,val42,val43,val44,val45,val46,val47,val48,val49,val50,val51,val52)
{	
	document.forms[0].selectpurdurable.value=val1;
	document.forms[0].cmbauto_category.value=val38;
	document.forms[0].txtauto_make.value=val3;
	document.forms[0].txtauto_model.value=val4;
	document.forms[0].txtauto_article.value=val5;
	document.forms[0].txtauto_dealer.value=val9;
	document.forms[0].txtsup_address1.value=val10;
	document.forms[0].txtsup_address2.value=val11;
	document.forms[0].hidcity.value=val12;
	document.forms[0].hidstate.value=val13;
	document.forms[0].txtsup_zip.value=val16;
	document.forms[0].txtsup_city.value=val14;
	document.forms[0].txtsup_state.value=val15;
	document.forms[0].txtauto_age.value=val8;
	document.forms[0].txt_originalcost.value=val39;
	document.forms[0].txtauto_valuation1.value=val23;
	document.forms[0].txt_actualconsideration.value=val40;
	document.forms[0].txt_leastvalue.value=val41;
	document.forms[0].txtauto_chasis.value=val25;
	document.forms[0].txtauto_engine.value=val26;
	document.forms[0].txtauto_ownername.value=val34;
	document.forms[0].txtauto_vehicles.value=val33;
	document.forms[0].txtauto_valuation.value=val7;
	document.forms[0].txtauto_accessories.value=val6;
	document.forms[0].txtauto_tax.value=val27;
	document.forms[0].txtauto_insurance.value=val28;
	document.forms[0].txtauto_charges.value=val29;
	document.forms[0].txtauto_totcost.value=val52;
	document.forms[0].txtauto_registration.value=val24;
	document.forms[0].txt_discount.value=val30;
	document.forms[0].txtdealersince.value=val20;
	document.forms[0].txtsup_phone.value=val17;
	document.forms[0].selauthdealer.value=val18;
	//document.forms[0].txtestablished.value=val19;
	
	/*document.forms[0].txtverf_doneby.value="";
	document.forms[0].txtverf_doneon.value="";
	document.forms[0].srcofverf.value="";
	document.forms[0].refmade.value="";
	document.forms[0].checkboxapp.value="";
	document.forms[0].chkboxdealer.value="";*/
	
	document.forms[0].radio_applicantdrivenvehicle.value=val31;
	document.forms[0].txt_fuelused.value=val32;
	document.forms[0].txa_remarks.value=val35;
	document.forms[0].sel_vehicletype.value=val2;
	document.forms[0].sel_take_over.value=val43;
	document.forms[0].txt_registration.value=val44;
	document.forms[0].sel_salrytoSB.value=val45;
	document.forms[0].sel_undrtkngletter.value=val46;
	document.forms[0].sel_natureCharge.value=val47;
	if(staffCond=="staff"){
		document.forms[0].sel_oldcar_type.value=val48;
		}
	document.forms[0].hidsnmbr.value=val49;
	document.forms[0].hidsecID.value=val50;
	document.forms[0].hidSecurityId.value=val50;
	document.forms[0].hidTotCost_veh.value=eval(val39);
	enablevalues();
	callEnableFields(true);
	document.all.City_pop.style.visibility="hidden";
	caculatetot();
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		enableButtons(true,false,true,false,false,false);
	}
}


