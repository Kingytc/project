function loadPage()
{
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = true;
	}
	document.forms[0].selwork.options[0].selected = true;
	document.forms[0].cmdnew.disabled = false;
	document.forms[0].cmdedit.disabled = false;
	//document.forms[0].cmdhelp.disabled = false;
	document.forms[0].cmdclose.disabled = false;
	//document.forms[0].cmdaudittrail.disabled = false;
	document.forms[0].txtwrk_flowname.value="";
	
}

function showProduct()
{
   var value="";
   if (mode =="edit")
	{
	   if (document.forms[0].selwork.selectedIndex == 0)
	   {
			ShowAlert("111","Workflow Type");
			document.forms[0].selwork.focus();
	   }
	   else
	   {
	value=document.forms[0].selwork.options[document.forms[0].selwork.selectedIndex].value;
			show(value);
	   }

	}
	
	
}
function showMsg()
{
	
		if (strAction == "failed" )
		{
			 alert(strMsg);
		}
}

function show(val)
{   
	var purl = path+"jsp/share/prodlist.jsp?hidMethod=getWork&page=workflow&select="+val+"&beanid=workflowmaster&method=getData";
	var title = "ListofCategory";
	var prop = "scrollbars=no,width=450,height=400";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
	document.forms[0].selwork.disabled = false;
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	//document.forms[0].cmdhelp.disabled = false;
	document.forms[0].cmdclose.disabled = true;
	
}

function getValue()
{
   	var len = document.forms[0].selwork.length;
	var temp ="";
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selwork.options[i].selected==true)
		 {
				temp = document.forms[0].selwork.options[i].value; 
				break;
		 }
	}
	document.forms[0].hidwrk_flowtype.value=temp;
    document.forms[0].txtwrk_flowname.value="";
	if (mode =="edit")
	{
		document.forms[0].txtwrk_flowname.disabled=true;
	}
	else if (mode == "new")
	{
		document.forms[0].txtwrk_flowname.focus()
	}
}

function doNew()
{
	mode = "new";
	document.forms[0].txtwrk_flowname.disabled = false;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdcancel.disabled = false;
	//document.forms[0].cmdhelp.disabled = false;
	document.forms[0].cmdclose.disabled = true;
	document.forms[0].selwork.disabled = false;
	document.forms[0].selwork.focus();
}

function doSave()
{
    if (document.forms[0].txtwrk_flowname.value !="" && document.forms[0].selwork.selectedIndex != 0)
	 {
    	submitData();
	 }
	 else if (document.forms[0].selwork.selectedIndex == 0)
	 {
			ShowAlert("111","Workflow Type ");
			document.forms[0].selwork.focus();
	 }
	 else if (document.forms[0].txtwrk_flowname.value =="" )
	 {
		 if(mode =="new")
		 {
		 ShowAlert("112","Workflow Action");
		 document.forms[0].txtwrk_flowname.disabled = false;
		 document.forms[0].txtwrk_flowname.focus();
		 }
		 else if (mode =="edit")
		 {
			 ShowAlert("111","Workflow Action");
		 }
	 } 
		
	 
}

function submitData()
{
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = false;
	}
	document.forms[0].action=path+"controllerservlet";
	if (mode == "new")
	{
		document.forms[0].hidAction.value="INSERT";
		
	}
	else if (mode == "edit")
	{
		document.forms[0].hidAction.value="UPDATE";
	}
	
	document.forms[0].hidBeanId.value="workflowmaster";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/workflow.jsp";
	document.forms[0].submit();
}

function doEdit()
{
	mode ="edit";
	document.forms[0].txtwrk_flowname.disabled = true;
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdclose.disabled = true;
	document.forms[0].selwork.disabled = false;
	document.forms[0].selwork.focus();
}

function doDelete()
{	
		if (document.forms[0].txtwrk_flowname.value != "" && document.forms[0].selwork.selectedIndex != 0)
		{
			if (ConfirmMsg("101"))
			{
				for (i=0;i<document.forms[0].elements.length;i++)
				{
					document.forms[0].elements[i].disabled =false;
				}	
				document.forms[0].hidAction.value="DELETE";
				document.forms[0].hidBeanId.value="workflowmaster";
				document.forms[0].hidBeanMethod.value="updateData";
				document.forms[0].hidSourceUrl.value="/action/workflow.jsp";
				document.forms[0].action=path+"controllerservlet";
				document.forms[0].submit();				
			}
		 }
		 else if (document.forms[0].selwork.selectedIndex == 0)
		 {
			ShowAlert("111","Workflow Type ");
			document.forms[0].selwork.focus();
		 }
		 else if (document.forms[0].txtwrk_flowname.value =="" )
		 {
			ShowAlert("111","Workflow Action");
		 }	
}



function doCancel()
{
   if (ConfirmMsg("102"))
   {
    mode ="load";
//	getValue();
	loadPage();
   }
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
	
}

