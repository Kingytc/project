
function check()
{
	var key=window.event.keyCode;
	if(key == 13)
	{
		window.event.returnValue = false;
	}
}
function onloading()
{   
	for(i=0;i<document.forms[0].selectlimit.length;i++)
	{	if(document.forms[0].hidId.value == document.forms[0].selectlimit[i].value)
		{
			document.forms[0].selectlimit.selectedIndex=i;
		}
	}	
	selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
	if(selindex=='')
	{
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddel.disabled=true;
	}
	else
	{
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmddel.disabled=false;
	}
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
}

function getValue()
{		
	
	selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
	
		if(selindex=='')		
		{	
			document.forms[0].txtlimit_from.value="";
			document.forms[0].txtlimit_to.value="";
			document.forms[0].txtlimit_class.value="";
			document.forms[0].txtlimit_amount.value="";

			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmdapply.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
		}
		else if(selindex==0)
		{
			document.forms[0].hidId.value="";
			document.forms[0].txtlimit_from.value="";
			document.forms[0].txtlimit_to.value="";
			document.forms[0].txtlimit_class.value="";
			document.forms[0].txtlimit_amount.value="";
			onNew();
		}
		else
		{
		document.forms[0].hidId.value = selindex;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="limitmaster";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/com_limitmaster.jsp";
		document.forms[0].submit();
		}
}

function onNew()
{	
	isnew="true";
	document.forms[0].txtlimit_from.readOnly=false;
	document.forms[0].txtlimit_to.readOnly=false;
	document.forms[0].txtlimit_class.readOnly=false;
	document.forms[0].txtlimit_amount.readOnly=false;

	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddel.disabled=true;
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
	
}
function onEdit()
{
//	strtermid = document.forms[0].selectlimit.value;
	document.forms[0].txtlimit_from.readOnly=false;
	document.forms[0].txtlimit_to.readOnly=false;
	document.forms[0].txtlimit_class.readOnly=false;
	document.forms[0].txtlimit_amount.readOnly=false;

	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddel.disabled=true;
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
}



function doSave()
{
			if(isnew=="true")
			{
			document.forms[0].hidAction.value="insert";
			}
			else
			{
			document.forms[0].hidAction.value="update";
			}
			document.forms[0].cmdapply.disabled=true;
			document.forms[0].hidId.value =
			document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
			document.forms[0].action=path+"controllerservlet";
			
			document.forms[0].hidBeanId.value="limitmaster";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/com_limitmaster.jsp";
			document.forms[0].submit();
}

function onDelete()
{
	if(ConfirmMsg('101'))
	{

			document.forms[0].hidAction.value="delete";
			document.forms[0].hidId.value =
			document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
			document.forms[0].action=path+"controllerservlet";		
			document.forms[0].hidBeanId.value="limitmaster";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/com_limitmaster.jsp";
			document.forms[0].submit();
	}
}

function onCancel()
{
	if(ConfirmMsg('102'))
	{
		selindex=document.forms[0].selectlimit[document.forms[0].selectlimit.selectedIndex].value;
		document.forms[0].hidId.value = selindex;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="limitmaster";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/com_limitmaster.jsp";
		document.forms[0].submit();

		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=false;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}

function onHelp()
{
}

function onClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function menuOptionDivMouseDown (url) {
		
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

