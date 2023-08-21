

function onloading()
{
	for(i=0;i<document.forms[0].selid.length;i++)
	{
		if(document.forms[0].hidId.value == document.forms[0].selid[i].value)
		{
			document.forms[0].selid.selectedIndex=i;
		}
	}	
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
}

function roundtxt1(obj)
{
	if(obj.value != "")
		roundNegativeVal(obj);
}

function onEdit()
{
	selid = document.forms[0].selid.value;	
	for(i=0;i<document.forms[0].txtpoints.length;i++)
	{
		document.forms[0].txtpoints[i].readOnly = false;
		document.forms[0].txtrangefrom[i].readOnly = false;
		document.forms[0].txtrangeto[i].readOnly = false;
		document.forms[0].txtdesc[i].readOnly = false;
	}
	document.forms[0].selid.disabled = true;

	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
}

function validateVal(obj)
{
	var value = obj.value;
	if( value < 0.00 )
		pos = 4;
	else
		pos = 3;
	if( value.indexOf(".") > pos )
	{
 		ShowAlert(146);
		obj.select();
 	}
}

function doSave()
{ 	
	var bool="true";
	for(i=0;i<document.forms[0].txtpoints.length;i++)
	{
		if(checktrim(document.forms[0].txtpoints[i].value)!="")
		{
			if(checktrim(document.forms[0].txtrangefrom[i].value)=="")
			{
				ShowAlert('121','Range From in Point'+(i+1));
				document.forms[0].txtrangefrom[i].select();
				bool="false";
			}
			else if(checktrim(document.forms[0].txtrangeto[i].value)=="")
			{
				ShowAlert('121','Range To in Point'+(i+1));
				document.forms[0].txtrangeto[i].select();
				bool="false";
			}
			else if(checktrim(document.forms[0].txtdesc[i].value)=="")
			{
				ShowAlert('121','Description in Point'+(i+1));
				document.forms[0].txtdesc[i].select();
				bool="false";
			}
		}
		else
		{
			if( checktrim(document.forms[0].txtrangefrom[i].value)!="" ||
				checktrim(document.forms[0].txtrangeto[i].value)!="" ||
				checktrim(document.forms[0].txtdesc[i].value)!="" )
			{
				ShowAlert('121','Point '+(i+1));
				document.forms[0].txtpoints[i].select();
				bool="false";			
			}
		}
	}

	if(bool=="true")
	{
		document.forms[0].hiddesc.value=varDesc;
		document.forms[0].selid.value=selid;
		document.forms[0].hidId.value = 
			document.forms[0].selid[document.forms[0].selid.selectedIndex].value;	
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="factrules";
		document.forms[0].hidBeanMethod.value="updateSaleTrendData";
		document.forms[0].hidSourceUrl.value="/action/factmanagerailrules.jsp";
		document.forms[0].submit();
	}
}

function onCancel()
{	
	if(ConfirmMsg('102'))
	{	
		document.forms[0].hiddesc.value=varDesc;
		document.forms[0].action=path+"action/factmanagerailrules.jsp";
		document.forms[0].submit();
	}
}

function onClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=path+"action/factrules.jsp";
		document.forms[0].submit();
	}
}

function menuOptionDivMouseDown (url)
{
	if(!document.forms[0].cmdapply.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}

function getValue()
{
	document.forms[0].hiddesc.value = varDesc;	
	document.forms[0].hidId.value = 
		document.forms[0].selid[document.forms[0].selid.selectedIndex].value ;
	document.forms[0].action=path+"action/factmanagerailrules.jsp";
	document.forms[0].submit();
}

