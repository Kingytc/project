function callOnload()
{
	/*if(vartaxpd!="")
	{
	document.forms[0].sel_taxpaid.value=vartaxpd;
	}
	else
	{
	document.forms[0].sel_taxpaid.value="n";
	}*/
	
	/*if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
		{
		callDisableControls(true,true,true,true,true,false);
		callEnableFields(true);
		}
	else
		{
		callEnableFields(true);
		callDisableControls(false,true,true,true,true,false);
		}	 */
	document.forms[0].selapptype.value=selappvalue;
	callEnableFields(true);
	/*document.forms[0].selapptype.disabled=false;*/
	showtaxpaid();
}
function showtaxpaid()
{
	if(document.forms[0].sel_taxpaid.value=="y")
	{
		document.all.t1.style.visibility="visible";
		document.all.t1.style.position="relative";
		
	}
	else
	{
		document.all.t1.style.visibility="hidden";
		document.all.t1.style.position="absolute";
		
	}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}



function callDisableControls(cmdnew,cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdnew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function doSave()
{	
	if(document.forms[0].selapptype.value!="")
	{
		if(document.forms[0].cmbauto_category.value=="s")
		{
			alert("Select Category");
			document.forms[0].cmbauto_category.focus();
			return;
		}
		if(document.forms[0].cmbauto_price_type.value=="s1")
		{
			alert("Select Type of Vechicle");
			document.forms[0].cmbauto_price_type.focus();
			return;
		}
		
	}	
	
	var len = document.forms[0].selapptype.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].selapptype.options[i].selected==true)
			 {
				 document.forms[0].selapptype1.value = document.forms[0].selapptype.options[i].text; 
				break;
			 }
		}
		
	len = document.forms[0].cmbauto_category.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].cmbauto_category.options[i].selected==true)
			 {
				 document.forms[0].cmbauto_category1.value = document.forms[0].cmbauto_category.options[i].text; 
				break;
			 }
		}		
		
	len = document.forms[0].cmbauto_price_type.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].cmbauto_price_type.options[i].selected==true)
			 {
				 document.forms[0].cmbauto_price_type1.value = document.forms[0].cmbauto_price_type.options[i].text; 
				break;
			 }
		}	
	len = document.forms[0].cmbauto_age.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].cmbauto_age.options[i].selected==true)
			 {
				 document.forms[0].cmbauto_age1.value = document.forms[0].cmbauto_age.options[i].text; 
				break;
			 }
		}		
	var appname=document.forms[0].selapptype[document.forms[0].selapptype.selectedIndex].text;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanGetMethod.value="getCollVehicleData";
	document.forms[0].hidBeanMethod.value="updateCollVehicle";
	document.forms[0].hidBeanId.value="percollateral";
	document.forms[0].hidSourceUrl.value="/action/percollateralcar.jsp";	
	document.forms[0].action=appURL+"action/ControllerServlet";
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
	}
	
		document.forms[0].selapptype.disabled=false;	
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
		var appname=document.forms[0].selapptype[document.forms[0].selapptype.selectedIndex].text;
		document.forms[0].hidBeanGetMethod.value="getCollVehicleData";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].action=appURL+"action/percollateralcar.jsp";	
		document.forms[0].submit();
	}
}

function doEdit()
{ 
	if(document.forms[0].selapptype.value=="")
	{
		alert("Select Applicant Type");
		return;
	}	
	document.forms[0].hidAction.value="update";
	document.forms[0].hideditflag.value="Y";
	callEnableFields(false);
	callDisableControls(true,true,false,false,false,true);
}
function doNew()
{
	if(document.forms[0].selapptype.value!="")
	{
		callEnableFields(false);
		document.forms[0].hidAction.value="insert";
		callDisableControls(true,true,false,false,false,true);
		document.forms[0].hideditflag.value="Y";
	}
	else
	{
		ShowAlert('111','Applicant');
		return;
	}
}
function doDelete()
	{
	if(varrecordflag=="Y")
		{
		var varconfirm=ConfirmMsg('101');
		if(varconfirm)
		{
				var len = document.forms[0].selapptype.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].selapptype.options[i].selected==true)
			 {
				 document.forms[0].selapptype1.value = document.forms[0].selapptype.options[i].text; 
				break;
			 }
		}
		
	len = document.forms[0].cmbauto_category.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].cmbauto_category.options[i].selected==true)
			 {
				 document.forms[0].cmbauto_category1.value = document.forms[0].cmbauto_category.options[i].text; 
				break;
			 }
		}		
		
	len = document.forms[0].cmbauto_price_type.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].cmbauto_price_type.options[i].selected==true)
			 {
				 document.forms[0].cmbauto_price_type1.value = document.forms[0].cmbauto_price_type.options[i].text; 
				break;
			 }
		}	
	len = document.forms[0].cmbauto_age.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].cmbauto_age.options[i].selected==true)
			 {
				 document.forms[0].cmbauto_age1.value = document.forms[0].cmbauto_age.options[i].text; 
				break;
			 }
		}		
				document.forms[0].hidAction.value="delete";
				var appname=document.forms[0].selapptype[document.forms[0].selapptype.selectedIndex].text;
				document.forms[0].hidBeanGetMethod.value="getCollVehicleData";
				document.forms[0].hidBeanMethod.value="updateCollVehicle";
				document.forms[0].hidBeanId.value="percollateral";
				document.forms[0].hidSourceUrl.value="/action/percollateralcar.jsp";	
				document.forms[0].action=appURL+"action/ControllerServlet";
				document.forms[0].submit();
			}
		}
	else
		{
		ShowAlert('158');
		}
	}


function menuOptionDivMouseDown (url) 
	{
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
	}
	
function getCollData()
{
	var appname=document.forms[0].selapptype[document.forms[0].selapptype.selectedIndex].text;
	
	document.forms[0].hidBeanId.value="percollateral";
	document.forms[0].hidBeanGetMethod.value="getCollVehicleData";
	document.forms[0].action=appURL+"action/percollateralcar.jsp";	
	document.forms[0].submit();
}
	
function callhome()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		//document.forms[0].selapptype.value="";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/percollateralhome.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}	

function callotherassets()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		//document.forms[0].hidauto_type.value="B";
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanGetMethod.value="getagrassets";		
		document.forms[0].action=appURL+"action/collotherassets.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function doHelp()     
{
	var hlpvar = appURL+"phlp/loan_appretail_colsec_vec.htm";
	var title = "Vehicle";
	var prop = "scrollbars=yes,width=600,height=450";	
	prop = prop + ",left=50,top=150";
	window.open(hlpvar,title,prop);
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13)
{
		document.forms[0].cmbauto_category.value=val1;
		document.forms[0].txtauto_make.value=val2;
		document.forms[0].txtauto_model.value=val3;
		document.forms[0].txtauto_dealer.value=val4;
		document.forms[0].txtauto_serialno.value=val5;
		document.forms[0].txtauto_ser_age.value=val6;
		document.forms[0].txtauto_cost.value=val7;
		document.forms[0].txtauto_valuation.value=val8;
		document.forms[0].cmbauto_price_type.value=val9;
		document.forms[0].cmbauto_age.value=val10;
		document.forms[0].sel_taxpaid.value=val11;
		document.forms[0].txtauto_lasttax.value=val12;
		document.forms[0].hid_strsno.value=val13;
		if(document.forms[0].readFlag.value.toUpperCase()=="W" && document.forms[0].btnenable.value=="Y")
		{
			callDisableControls(true,false,true,false,false,true);
		}
		showtaxpaid();
}
	