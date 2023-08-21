function callOnLoad()
{
	disableFields(true);
	disableCommandButtons(false,true,true,true,true,false);
	document.forms[0].txt_NewFarmerDate.value=currdate;
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true);
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true);
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidSourceUrl.value="/action/misfarmercategory.jsp";
	document.forms[0].hidBeanGetMethod.value="getFarmerCategoryData";
	document.forms[0].hidBeanMethod.value="updateFarmerCategoryData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="mis";
		document.forms[0].hidBeanGetMethod.value="getFarmerCategoryData";
		document.forms[0].action=appURL+"action/misfarmercategory.jsp";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
	    document.forms[0].hidAction.value ="delete";
	    document.forms[0].hidBeanId.value="mis";
		document.forms[0].hidSourceUrl.value="/action/misfarmercategory.jsp";
		document.forms[0].hidBeanGetMethod.value="getFarmerCategoryData";
		document.forms[0].hidBeanMethod.value="updateFarmerCategoryData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function onRadioSelect(val0,val1,val2,val3,val4,val5,val6,val7)
{
	document.forms[0].hidSNo.value=val0;
	document.forms[0].sel_Irrigated.value=val1;
	document.forms[0].txt_IrrigatedVal.value=val2;
	document.forms[0].sel_Cultivated.value=val3;
	document.forms[0].txt_CultivatedVal.value=val4;
	document.forms[0].txt_NewFarmerDate.value=val5;
	document.forms[0].sel_FarmCat.value=val6;
	document.forms[0].sel_Visibility.value=val7;
	disableFields(true);
	disableCommandButtons(true,false,true,true,false,false);
}
function callCalender(cmdname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,cmdname);
	}
}
function setDecimal(obj)
{
	obj.value=roundVal(round(obj.value,2));
}
function disableFields(bool)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=bool;
		}	 
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=bool;
		}	 
	}
	document.forms[0].txt_NewFarmerDate.readOnly=true;
}
function disableCommandButtons(cmdnew,cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
	document.forms[0].cmdnew.disabled=cmdnew;
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	//document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdclose.disabled=cmdclose;
}