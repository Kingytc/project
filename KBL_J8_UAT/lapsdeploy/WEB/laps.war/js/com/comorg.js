function placeValues()
{
		disableFields(true);
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
				 document.forms[0].elements[i].readOnly=val
		}
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getOrgData";
		document.forms[0].action=appURL+"action/comorg.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
	   if(ConfirmMsg(101))
	  {
			document.forms[0].hidAction.value="delete"
			document.forms[0].hidBeanId.value="combanking"
			document.forms[0].hidBeanMethod.value="updateOrg";
			document.forms[0].hidBeanGetMethod.value="getOrgData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/comorg.jsp";
			document.forms[0].submit();
	   }
    }
	else
	{
		ShowAlert(158);
	}
}

function  validate()
{ 
	if(trim(document.forms[0].technical.value) == "")
	{
		ShowAlert('121','Management Personal Name');	
		document.forms[0].technical.focus();
		return false;
	}
	if(trim(document.forms[0].functions.value)=="")
	{
		ShowAlert('121','Functions, responsibilities ');
		document.forms[0].functions.focus();
		return false;
	}
	if(trim(document.forms[0].working.value)=="")
	{
		ShowAlert('121','Working Since');
		document.forms[0].working.focus();
		return false;
	}
	if(trim(document.forms[0].experience.value)=="")
	{
		ShowAlert('121','Experience in Years');
		document.forms[0].experience.focus();
		return false;
	}
	if(trim(document.forms[0].reporting.value)=="")
	{
		ShowAlert('121','Reporting to');
		document.forms[0].reporting.focus();
		return false;
	}
	return true;
}


function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value="update";
	document.forms[0].hideditflag.value="Y";	
	enableButtons(true,true,false,false,true,true)
}

function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value="insert";
	document.forms[0].hideditflag.value="Y";
	enableButtons(true,true,false,false,true,true)
}

function doSave()
{
	var flag=validate();		
	if(flag)
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="combanking";
		document.forms[0].hidBeanMethod.value="updateOrg";
		document.forms[0].hidBeanGetMethod.value="getOrgData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comorg.jsp";
		document.forms[0].submit();
	}	
}


function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{
	if(document.forms[0].hideditflag.value=="N")
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function SelectValues(sno,name,func,since,exp,repto)
{
	document.forms[0].hidsno.value=sno;
	document.forms[0].technical.value=name;
	document.forms[0].functions.value=func;
	document.forms[0].working.value=since;
	document.forms[0].experience.value=exp;
	document.forms[0].reporting.value=repto;
	if(document.forms[0].btnenable.value=="Y")
	{
		enableButtons(true,false,true,false,false,true)
	}
}