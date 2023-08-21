function callConduct(){
	if(document.forms[0].cmdsave.disabled)
	{	
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getConduct";
		document.forms[0].action=appURL+"action/proposalterms.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callInspection(){
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getInspection";
		document.forms[0].action=appURL+"action/inspectioncomments.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callCersai(){
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getCersaiCibil";
		document.forms[0].action=appURL+"action/cersaicibildetails.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 
	}
}
function disableCommandButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdclose.disabled=cmdClose;
}  
function doEdit(){
	
	disableFields(false);
	disableCommandButtons(true,false,false,false,true); 
	document.forms[0].hidAction.value="update";
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].action=appURL+"action/rbiguidelines.jsp";	
		document.forms[0].submit();
	}
}
function doSave()
{		
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanMethod.value="updateRBIGuidelines";
	document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
	document.forms[0].hidBeanId.value="proposalterms";
	document.forms[0].hidSourceUrl.value="/action/rbiguidelines.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{		
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateRBIGuidelines";
	    document.forms[0].hidBeanGetMethod.value="getRBIGuidelines";
		document.forms[0].hidBeanId.value="proposalterms";
		document.forms[0].hidSourceUrl.value="/action/rbiguidelines.jsp";
	    document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].method="post";	
		document.forms[0].submit();
	}
}
function callNpa(){
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getNpaScheme";
		document.forms[0].action=appURL+"action/npascheme.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}