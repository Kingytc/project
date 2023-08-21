function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}
function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
	if(comments!="" && comments!="0")
	{
		document.forms[0].chk_apptype.disabled=false;
	}
	document.forms[0].sel_comments.disabled=false;
}
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function callonLoad()
{
	disablefields(true);
	if(comments!="" && comments!="0")
	{
		if(strper_appid!="")
		{
			document.forms[0].chk_apptype.value=strper_appid;
		}
		else
		{
			document.forms[0].chk_apptype.value="";
		}
	}
	if(comments!="" && comments!="0")
	{
		document.forms[0].sel_comments.value=comments;
	}
	else
	{
		document.forms[0].sel_comments.value="0";
	}	
}
function doEdit()
{
	if(document.forms[0].sel_comments.value != "0")
	{
		if(document.forms[0].chk_apptype.value == "")
		{
			alert("Select the Applicant Type");
			return;
		}		
		document.forms[0].hidAction.value="Edit"
		enableButtons(true,false,false,false,true);
		document.forms[0].chk_apptype.readOnly=true;
		document.forms[0].txt_comments.readOnly=false;
	}
	else
	{
	alert("Select the Comments on");
	document.forms[0].sel_comments.focus();
	return;
	}	
}
function doSave()
{
	if(document.forms[0].chk_apptype.value == "")
	{
		alert("Select the Applicant Type");
		return;
	}
	if(document.forms[0].txt_comments.value == "")
	{
		ShowAlert('121','Comments');
		return;
	}
	enableButtons(true, true, false, false, true);
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateAppraisalData";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].hidSourceUrl.value="/action/incomeexpenses.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="getAppraisalData";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].hidSourceUrl.value="/action/incomeexpenses.jsp";
		document.forms[0].submit();
	}
}
function getValues()
{
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].action=appUrl+"action/incomeexpenses.jsp";
	document.forms[0].submit();
}
function getCollData()
{
	if(document.forms[0].selapptype.value!="")
	{
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanGetMethod.value="getData";
	}
	document.forms[0].action=appUrl+"action/percollateralhome.jsp";	
	document.forms[0].submit();
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanMethod.value="updateAppraisalData";
		document.forms[0].hidBeanGetMethod.value="getAppraisalData";
		document.forms[0].hidSourceUrl.value="/action/incomeexpenses.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function getFeilds()
{
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getAppraisalData";
	document.forms[0].action=appUrl+"action/incomeexpenses.jsp";
	document.forms[0].submit();
}