function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function enableButtons(valedit,valapply,valcancel,valdel)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,false,false,false,true);
	document.forms[0].due_comments.focus();
}
function doSave()
{
	if(document.forms[0].txt_date.value=='')
	{
	ShowAlert(112,'Date');
	document.forms[0].txt_date.focus();
	return;
	}
	if(document.forms[0].txt_officername.value=='')
	{
	ShowAlert(112,'Name of Officers');
	document.forms[0].txt_officername.focus();
	return;
	}
	if(document.forms[0].txt_designation.value=='')
	{
	ShowAlert(112,'Designation');
	document.forms[0].txt_designation.focus();
	return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="lapsReport";		
	document.forms[0].hidSourceUrl.value="/action/com_duediligencecertificate.jsp";
	document.forms[0].hidBeanMethod.value="updateComDueDiligenceCertificate";
	document.forms[0].hidBeanGetMethod.value="getComDueDiligenceCertificate";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updateComDueDiligenceCertificate";
		document.forms[0].hidBeanGetMethod.value="getComDueDiligenceCertificate";
		document.forms[0].hidBeanId.value="lapsReport";		
		document.forms[0].hidSourceUrl.value="action/com_duediligencecertificate.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	}	
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getComDueDiligenceCertificate";
		document.forms[0].action=appURL+"action/com_duediligencecertificate.jsp";
		document.forms[0].submit();
	}
}
function disableCommandButtons(cmdedit,cmdsave,cmddelete,cmdcancel,cmdclose)
{  
  document.forms[0].cmdedit.disabled=cmdedit;	  
  document.forms[0].cmdsave.disabled=cmdsave;
  document.forms[0].cmddelete.disabled=cmddelete;
  document.forms[0].cmdcancel.disabled=cmdcancel;
  document.forms[0].cmdclose.disabled=cmdclose;
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
	 		showCal(appURL,fname);
	 	}
}