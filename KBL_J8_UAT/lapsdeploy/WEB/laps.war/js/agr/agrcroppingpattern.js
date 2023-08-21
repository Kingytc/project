function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
	}
}

function callonLoad()
{
if (document.forms[0].app_status.value!="")
	{
		if (document.forms[0].app_status.value=="pa")
		{	
			 document.forms[0].cmdnew.disabled = true;
			 document.forms[0].cmdedit.disabled = true;
			 alert("unable to modify APPROVED APPLICATION !!!")
		}
	}
disablefields(true);
disablebutton(false,true,true,true,false);
}


function disablebutton(cmdedit,cmdapply,cmdcan,cmddel,cmdclose)
{
document.forms[0].cmdedit.disabled=cmdedit;
document.forms[0].cmdapply.disabled=cmdapply;
document.forms[0].cmdcan.disabled=cmdcan;
document.forms[0].cmddel.disabled=cmddel;
document.forms[0].cmdclose.disabled=cmdclose;
}

function doSave()
{
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidBeanMethod.value="updateCroppingPatterns";
	document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
	document.forms[0].hidSourceUrl.value="/action/agrcroppingpattern.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	disablefields(true);
	disablebutton(false,true,true,true,false);
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"perresult.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{
	document.forms[0].hidAction.value="update";
	disablefields(false);
	disablebutton(true,false,false,false,true);
}

function callCancel()
{
if( ConfirmMsg(102))
	{
		disablefields(true);
		disablebutton(false,true,true,true,false);
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanMethod.value="updateCroppingPatterns";
		document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
		document.forms[0].action=appURL+"action/"+"agrcroppingpattern.jsp";
		document.forms[0].submit();
	}
}

function callDelete()
{
if( ConfirmMsg(101))
	{
		disablefields(true);
		disablebutton(false,true,true,true,false);
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateCroppingPatterns";
		document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
		document.forms[0].action=appURL+"action/"+"agrcroppingpattern.jsp";
		document.forms[0].submit();
	}

}

function callLink(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}
