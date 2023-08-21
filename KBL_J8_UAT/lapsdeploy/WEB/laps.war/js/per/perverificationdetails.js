function doEdit()
{  
	document.forms[0].hideditflag.value="Y";
    document.forms[0].hidAction.value="insert";	
    callDisableControls(true,false,false,false,true);
    callEnableFields(false);
}
function callUsersHelp()
{
	if(document.forms[0].cmdsave.disabled == false)
	{
		var prop="scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL +"action/selectusers.jsp?hidBeanId=appraisal&hidBeanGetMethod=getuserslist";
		window.open(url,"",prop);
	}
}
function doSave()
{	
	if(document.forms[0].txt_userid.value=="")
	{
		ShowAlert('111','Verification done by');
		return;
	}
	var srcofverf = document.forms[0].srcofverf.length;	
	for(i=0;i<srcofverf;i++)
	{
		 if(document.forms[0].srcofverf.options[i].selected==true)
		 {
			if(document.forms[0].srcofverf.options[i].value!="0")
			{
				document.forms[0].hidsrcofverf.value = document.forms[0].srcofverf.options[i].text;
			} 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanMethod.value="updateVerification";
	document.forms[0].hidBeanGetMethod.value="getVerification";
	document.forms[0].hidBeanId.value="percollateral";
	document.forms[0].hidRecordflag.value=varrecordflag;
	document.forms[0].hidSourceUrl.value="/action/perverificationdetails.jsp";
	document.forms[0].submit();
}
function callEnableFields(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=one;	
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;	
		}
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=one;	
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=one;	
		}
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=one;	
		}
	}
	document.forms[0].txt_userid.readOnly=true;
	document.forms[0].txtverf_doneby.readOnly=true;
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getVerification";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].action=appURL+"action/perverificationdetails.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(varrecordflag=="Y"){
	if(ConfirmMsg(101))
	{
     	document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanMethod.value="updateVerification";
	    document.forms[0].hidBeanGetMethod.value="getVerification";
		document.forms[0].hidSourceUrl.value="/action/perverificationdetails.jsp";
		document.forms[0].submit();
	}
	}	
}
function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}   
function callOnload()
{
if(srcofverf!="")
	{
	document.forms[0].srcofverf.value=srcofverf;
	}
else
	{
	document.forms[0].srcofverf.value="0";
	}	
if(refmade!="")
	{
	document.forms[0].refmade.value=refmade;
	}
else
	{
	document.forms[0].refmade.value="0";
	}
if(checkboxapp == "Y")
	{
	document.forms[0].checkboxapp[0].checked = true;
	document.forms[0].checkboxapp[1].checked = false;
	}
else if(checkboxapp == "N")
	{
	document.forms[0].checkboxapp[0].checked = false;
	document.forms[0].checkboxapp[1].checked = true;
	}
if(chkboxdealer == "Y")
	{
	document.forms[0].chkboxdealer[0].checked = true;
	document.forms[0].chkboxdealer[1].checked = false;
	}
else if(chkboxdealer == "N")
	{
	document.forms[0].chkboxdealer[0].checked = false;
	document.forms[0].chkboxdealer[1].checked = true;
	}
callEnableFields(true);
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}	
function callDisableControls(cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
	{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
	}