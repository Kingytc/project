function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].hidPage.value="secoverageretail";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].hidSourceUrl.value="action/per_commentsonseccovergae.jsp";	
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/controllerservlet";	
		document.forms[0].submit();
	}
}
function doSave()
{ 	
	document.forms[0].cmdsave.disabled=true;
    document.forms[0].hidAction.value="update"
    document.forms[0].hidBeanId.value="facilities";
    document.forms[0].hidPage.value="secoverageretail";
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments"
	document.forms[0].hidSourceUrl.value="/action/per_commentsonseccovergae.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
	disableFields(false);
	disableCommandButtons("edit");
	EditorEnableDisable1("id_div","none","id_editor","block");
	editor_generate('txt_comments');
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
			if(document.forms[0].btnenable.value =='N')
		  	{
			  	document.forms[0].cmdedit.disabled=true;
			  	document.forms[0].cmddelete.disabled=true;
			  	document.forms[0].cmdsave.disabled=true;
			  	document.forms[0].cmdcancel.disabled=true;
			  	document.forms[0].cmdclose.disabled=false;
		 	}
	  	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=false;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
function onLoading()
{
	 disableFields(true);
	 EditorEnableDisable1("id_div","block","id_editor","none");
}

function disableFields(val)
{
  for(var i=0;i<document.forms[0].length;i++)
  {
	  if(document.forms[0].elements[i].type=='textarea')
	  {
		document.forms[0].elements[i].readOnly=val;
	  }
  }
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].hidPage.value="secoverageretail";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/per_commentsonseccovergae.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function EditorEnableDisable1(name1,val1,name2,val2)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
}
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
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
function callalert()
{
	alert("Click Freeze to view Security Coverage");
	return;
}