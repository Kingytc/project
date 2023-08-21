
function disablecontrols(edit,save,cancel,cdelete,close)
{
	document.forms[0].cmdedit.disabled = edit;
	document.forms[0].cmdsave.disabled = save;
	document.forms[0].cmdcancel.disabled = cancel;
	document.forms[0].cmddelete.disabled = cdelete;
	document.forms[0].cmdclose.disabled = close;
}
function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";	
		document.forms[0].submit();
	}
}
function doEdit()
{
	calldisable(false);
	disablecontrols(true,false,false,false,false);
	document.forms[0].hideditflag.value="Y";
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateDefaulter";
	document.forms[0].hidBeanGetMethod.value="getDefaulter";
	document.forms[0].hidSourceUrl.value="/action/customerDefaulter.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getDefaulter";
		document.forms[0].action=appURL+"action/customerDefaulter.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateDefaulter";
		document.forms[0].hidBeanGetMethod.value="getDefaulter";
		document.forms[0].hidSourceUrl.value="/action/customerDefaulter.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(158);
	}			
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{	
		showCal(appURL,name);
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
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}
function hidDate()
{
if(document.forms[0].sel_RBIDefaulter.value=="Y"){
	document.all.hid1.style.visibility="visible";
	document.all.hid1.style.position="relative";
	document.all.hid2.style.visibility="visible";
	document.all.hid2.style.position="relative";
	document.all.hid3.style.visibility="visible";
	document.all.hid3.style.position="relative";
	document.all.hid4.style.visibility="visible";
	document.all.hid4.style.position="relative";
	document.all.hid5.style.visibility="visible";
	document.all.hid5.style.position="relative";
	document.all.hid6.style.visibility="visible";
	document.all.hid6.style.position="relative";
	document.all.hid19.style.visibility="visible";
	document.all.hid19.style.position="relative";
}
else
{
	document.all.hid1.style.visibility="hidden";
	document.all.hid2.style.visibility="hidden";
	document.all.hid3.style.visibility="hidden";
	document.all.hid4.style.visibility="hidden";
	document.all.hid5.style.visibility="hidden";
	document.all.hid6.style.visibility="hidden";
	document.all.hid19.style.visibility="hidden";
}
if(document.forms[0].sel_ECGCIList.value=="Y"){
	document.all.hid7.style.visibility="visible";
	document.all.hid7.style.position="relative";
	document.all.hid8.style.visibility="visible";
	document.all.hid8.style.position="relative";
	document.all.hid9.style.visibility="visible";
	document.all.hid9.style.position="relative";
	document.all.hid10.style.visibility="visible";
	document.all.hid10.style.position="relative";
	document.all.hid11.style.visibility="visible";
	document.all.hid11.style.position="relative";
	document.all.hid12.style.visibility="visible";
	document.all.hid12.style.position="relative";
	document.all.hid20.style.visibility="visible";
	document.all.hid20.style.position="relative";
}
else{
	document.all.hid7.style.visibility="hidden";
	document.all.hid8.style.visibility="hidden";
	document.all.hid9.style.visibility="hidden";
	document.all.hid10.style.visibility="hidden";
	document.all.hid11.style.visibility="hidden";
	document.all.hid12.style.visibility="hidden";
	document.all.hid20.style.visibility="hidden";
}
if(document.forms[0].sel_Willful.value=="Y"){

	document.all.hid13.style.visibility="visible";
	document.all.hid13.style.position="relative";
	document.all.hid14.style.visibility="visible";
	document.all.hid14.style.position="relative";
	document.all.hid15.style.visibility="visible";
	document.all.hid15.style.position="relative";
	document.all.hid16.style.visibility="visible";
	document.all.hid16.style.position="relative";
	document.all.hid17.style.visibility="visible";
	document.all.hid17.style.position="relative";
	document.all.hid18.style.visibility="visible";
	document.all.hid18.style.position="relative";
	document.all.hid21.style.visibility="visible";
	document.all.hid21.style.position="relative";
}
else{
	document.all.hid13.style.visibility="hidden";
	document.all.hid14.style.visibility="hidden";
	document.all.hid15.style.visibility="hidden";
	document.all.hid16.style.visibility="hidden";
	document.all.hid17.style.visibility="hidden";
	document.all.hid18.style.visibility="hidden";
	document.all.hid21.style.visibility="hidden";
}
if(document.forms[0].sel_Identified.value=="Y"){
	
	document.all.hid22.style.visibility="visible";
	document.all.hid22.style.position="relative";
}
else{
	
	document.all.hid22.style.visibility="hidden";
}
}
function cibildet()
{
	if(document.forms[0].sel_refercibil.value=="Y")
	{
		document.all.hidcibil.style.visibility="visible";
		document.all.hidcibil.style.position="relative";
		document.all.hidcibil1.style.visibility="visible";
		document.all.hidcibil1.style.position="relative";
	}
	else
	{
		document.all.hidcibil.style.visibility="hidden";
		document.all.hidcibil.style.position="absolute";
		document.all.hidcibil1.style.visibility="hidden";
		document.all.hidcibil1.style.position="absolute";
	}
}