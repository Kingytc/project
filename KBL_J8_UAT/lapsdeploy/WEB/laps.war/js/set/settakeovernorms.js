function callOnLoad()
{
	if(varModule!="")
	{
		document.forms[0].sel_Module.value=varModule;
	}
	else
	{
		document.forms[0].sel_Module.value="S";		
	}
	disableFields(true);
	document.forms[0].sel_Module.disabled=false;
	disableButtons(false, true, true, true, true, false);
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	disableFields(false);
	disableButtons(true, true, false, false, true, true);
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	disableFields(false);
	document.forms[0].sel_Module.disabled=true;
	disableButtons(true, true, false, false, true, true);
}
function doSave()
{
	if(document.forms[0].sel_Module.value=="S")
	{
		ShowAlert('111','Take Over Norms');
		document.forms[0].sel_Module.focus();
		return;
	}
	if(document.all.txt_TakeOverNorm.value=="")
	{
		ShowAlert('121','Take Over Norms Description');
		document.all.txt_TakeOverNorm.focus();
		return;
	}
	if(document.forms[0].sel_active.value=="")
	{
		ShowAlert('111','Active');
		document.forms[0].sel_active.focus();
		return;
	}
	document.forms[0].sel_Module.disabled=false;
	document.forms[0].sel_active.disabled=false;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="setmodtermscond";
	document.forms[0].hidBeanMethod.value="updateTakeOverNorms";
	document.forms[0].hidBeanGetMethod.value="getTakeOverNorms";
	document.forms[0].hidSourceUrl.value="/action/settakeovernorms.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanGetMethod.value="getTakeOverNorms";
		document.forms[0].action=appURL+"action/settakeovernorms.jsp";
		disableButtons(true, true, true, true, true, true);
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].sel_Module.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanMethod.value="updateTakeOverNorms";
		document.forms[0].hidBeanGetMethod.value="getTakeOverNorms";
		document.forms[0].hidSourceUrl.value="/action/settakeovernorms.jsp";
		disableButtons(true, true, true, true, true, true);
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function placeValues(sno,norm,selectvalue)
{
	document.forms[0].hidSNo.value=sno;
	document.forms[0].txt_TakeOverNorm.value=norm;
	document.forms[0].sel_active.value=selectvalue;
	disableButtons(true, false, true, true, false, true);
}
function disableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function getTakeOverNorms()
{
	if(document.forms[0].sel_Module.value!="" && document.forms[0].sel_Module.value!="S")
	{
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanGetMethod.value="getTakeOverNorms";
		document.forms[0].action=appURL+"action/settakeovernorms.jsp";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;
		}
	}
}