function onLoading()
{
	if(varbankarrangement!="")
		{
		document.forms[0].bank_arrangement.value=varbankarrangement;
		}
	disableCommandButtons("load");
	showtabular();
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	
		 disableFields(false);
	}
}


function showtabular()
{
	if(document.forms[0].bank_arrangement.value=="2")
	{
		document.all.row1.style.visibility="visible";
		document.all.row1.style.position="relative";
		for(var i=0;i<5;i++)
		{
			document.all.row2[i].style.visibility="visible";
			document.all.row2[i].style.position="relative";
		}
	}
	else
	{
		document.all.row1.style.visibility="hidden";
		document.all.row1.style.position="absolute";
		for(var i=0;i<5;i++)
		{
			document.all.row2[i].style.visibility="hidden";
			document.all.row2[i].style.position="absolute";
		}
	}
}


function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
	 	}	  
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
	 	}  
		 
	}
}


function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}


function doSave()
{
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].hidSourceUrl.value="/action/prudential_general.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="updateprudentialpage1Data";
	document.forms[0].hidBeanGetMethod.value="getprudentialpage1Data";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}


function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/prudential_general.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getprudentialpage1Data";
		document.forms[0].hidBeanMethod.value="updateprudentialpage1Data";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}


function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"mainnav.jsp";
		document.forms[0].submit();
	}
}
	
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/prudential_general.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateprudentialpage1Data";
		document.forms[0].hidBeanGetMethod.value="getprudentialpage1Data";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}
}



function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

function callCalender(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}
