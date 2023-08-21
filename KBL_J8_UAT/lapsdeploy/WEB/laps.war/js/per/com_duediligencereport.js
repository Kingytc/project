function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hid_slno.value='';
	document.forms[0].txt_inspect.value='';
	document.forms[0].txt_name.value='';
	document.forms[0].txt_designation.value='';
	document.forms[0].txt_docs.value='';
	document.forms[0].txt_address.value='';
	document.forms[0].txt_property.value='';
	document.forms[0].txt_plot.value='';
	document.forms[0].txt_door.value='';
	document.forms[0].txt_TSNo.value='';
	document.forms[0].txt_ward.value='';
	document.forms[0].txt_mandal.value='';
	document.forms[0].txt_others.value='';
	document.forms[0].txt_residential.value='';
	document.forms[0].txt_corporation.value='';
	document.forms[0].txt_state.value='';
	document.forms[0].txt_plotsize.value='';
	document.forms[0].txt_owners.value='';
	document.forms[0].txt_sincewhen.value='';
	document.forms[0].txt_civic.value='';
	document.forms[0].txt_boundaries.value='';
	document.forms[0].txt_surrounding.value='';
	document.forms[0].txt_certificate.value='';
	document.forms[0].txt_mortrelation.value='';
	document.forms[0].txt_enquiry.value='';
	document.forms[0].txt_propertyvalue.value='';
	document.forms[0].txt_market.value='';
	enableButtons(true,true,false,false,true,true);
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
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
		if(document.forms[0].elements[i].type=='textarea') {
		
			document.forms[0].elements[i].readOnly=val;
		} 	  
	}
}
function doSave()
{
	if(trim(document.forms[0].txt_inspect.value)=="")
	{
		alert('Enter Inspected Date');
		document.forms[0].txt_inspect.focus();
		return;
	}
	if(trim(document.forms[0].txt_name.value)=="")
	{
		alert("Visited Officer Name");
		document.forms[0].txt_name.focus();
		return;
	}
	if(trim(document.forms[0].txt_designation.value)=="")
	{
		alert("Visited Officer Designation");
		document.forms[0].txt_designation.focus();
		return;
	}
	if(trim(document.forms[0].txt_docs.value)=="")
	{
		alert("Enter List of documents submitted");
		document.forms[0].txt_docs.focus();
		return;
	}
	if(trim(document.forms[0].txt_plot.value)=="")
	{
		alert("Enter Plot No. / Survery No");
		document.forms[0].txt_plot.focus();
		return;
	}
	if(trim(document.forms[0].txt_residential.value)=="")
	{
		alert("Enter Whether residential / commercial or industrial / Agriculture");
		document.forms[0].txt_residential.focus();
		return;
	}
	if(trim(document.forms[0].txt_mortrelation.value)=="")
	{
		alert("Enter Relationship of the borrower with the mortgager");
		document.forms[0].txt_mortrelation.focus();
		return;
	}
	if(trim(document.forms[0].txt_market.value)=="")
	{
		alert("Enter Comments on the marketablity of the property");
		document.forms[0].txt_market.focus();
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateComDueDiligenceReport";
	document.forms[0].hidBeanGetMethod.value="getComDueDiligenceReport";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_duediligencereport.jsp";
	document.forms[0].submit();
}
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="update";
	 disableCommandButtons(true,false,false,false,true);	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getComDueDiligenceReport";
		document.forms[0].action=appURL +"action/com_duediligencereport.jsp";
	    document.forms[0].submit();	
	}	
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateComDueDiligenceReport";
		document.forms[0].hidBeanGetMethod.value="getComDueDiligenceReport";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidSourceUrl.value="action/com_duediligencereport.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}
function disableCommandButtons(cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdsave.disabled=cmdsave;
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