function enableButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="U";
	disableCommandButtons(true,false,false,false,true);	
	disableFields(false);
}
function disableCommandButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
 	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdclose.disabled=cmdclose;
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="lapsReport";		
		document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
		document.forms[0].action=appURL+"action/Duediligence1.jsp";	
		document.forms[0].submit();
	}		
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" ||appstatus=="Closed/Rejected")
	{
		disableFields(true);
		disableCommandButtons(true,true,true,true,false);
	}	
	else
	{
		disableFields(true);
		disableCommandButtons(false,true,true,true,false);
	}
}
function doDelete()
{	
	if(ConfirmMsg(101))
	{	document.forms[0].hidAction.value ="D";
		document.forms[0].hidSourceUrl.value="/action/Duediligence1.jsp";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanMethod.value="updateDueDiligence1";
		document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}	
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidSourceUrl.value="/action/Duediligence1.jsp";
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateDueDiligence1";
	document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{	
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		 
	}
}
function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{		
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
		{
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].action=appURL+"action/persearch.jsp?&id="+document.forms[0].id.value+"&comapp_compname="+document.forms[0].comapp_compname.value;
			document.forms[0].submit();
		}
	}
}