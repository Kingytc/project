
function check()
{
	var key=window.event.keyCode;
	if(key == 13)
	{
		window.event.returnValue = false;
	}
}
function onloading()
{   
	for(i=0;i<document.forms[0].selectterm.length;i++)
	{	if(document.forms[0].hidId.value == document.forms[0].selectterm[i].value)
		{
			document.forms[0].selectterm.selectedIndex=i;
		}
	}	
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	if(selindex=='')
	{
	document.forms[0].cmdedit.disabled=true;
	}
	else
	{
	document.forms[0].cmdedit.disabled=false;
	}
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
}

function getValue()
{		
	
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	
			if(selindex=='')		
		{	//alert("Choose a Term");

			document.forms[0].txttrmdesc.value="";
			document.forms[0].txttrmcontent.value="";

			document.forms[0].txttrmdesc.readOnly=true;
			document.forms[0].txttrmcontent.readOnly=true;

			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmdapply.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
		}
		else if(selindex==0)
		{
			document.forms[0].txttrmdesc.value="";
			document.forms[0].txttrmcontent.value="";
			onNew();
		}
		else
		{
		document.forms[0].hidId.value = 
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value ;
		document.forms[0].hiddesc.value=selindex;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="settermcond";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/termscond.jsp";
		document.forms[0].submit();
		}
}

function onNew()
{	
	isnew="true";
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].txttrmcontent.readOnly=false;

	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
	
}
function onEdit()
{
	strtermid = document.forms[0].selectterm.value;
	strtermdesc = document.forms[0].txttrmdesc.value;
	strtermcont = document.forms[0].txttrmcontent.value;
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].txttrmcontent.readOnly=false;

	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
}



function doSave()
{
	if(checktrim(document.forms[0].txttrmdesc.value)=="")
	{		
		ShowAlert('121','Terms Description ');
		document.forms[0].txttrmdesc.focus();
		return false;
	}
	if(checktrim(document.forms[0].txttrmcontent.value)=="")
	{		
		ShowAlert('121','Terms and Conditions');
		document.forms[0].txttrmcontent.focus();
		return false;
	}
			if(isnew=="true")
			{
			document.forms[0].hidAction.value="insert";
			}
			else
			{
			document.forms[0].hidAction.value="update";
			}
			document.forms[0].hidId.value =
			document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
			document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
			document.forms[0].cmdapply.disabled=true;
			document.forms[0].action=path+"controllerservlet";
			
			document.forms[0].hidBeanId.value="settermcond";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/termscond.jsp";
			document.forms[0].submit();
}


function onDelete()
{
document.forms[0].hidAction.value="delete";
document.forms[0].hidId.value =
			document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
			document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
			document.forms[0].action=path+"controllerservlet";
			
			document.forms[0].hidBeanId.value="settermcond";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidSourceUrl.value="/action/termscond.jsp";
			document.forms[0].submit();
}

function onCancel()
{
	if(ConfirmMsg('102'))
	{
		//document.forms[0].hidId.value='';
		//document.forms[0].action=path+"action/termscond.jsp";
		//document.forms[0].submit();
		document.forms[0].selectterm.text=strtermid
		document.forms[0].selectterm.VALUE=strtermid
		document.forms[0].txttrmdesc.value = strtermdesc;
		document.forms[0].txttrmcontent.value = strtermcont;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}

function onHelp()
{
}

function onClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function menuOptionDivMouseDown (url) {
		
			if(!document.forms[0].cmdapply.disabled)
			{
				ShowAlert(103);
				return;
			}
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
		}

