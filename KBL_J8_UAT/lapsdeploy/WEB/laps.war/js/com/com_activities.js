function placeValues()
{
     	disableFields(true);
		
}

function disableFields(val)
	{
		for(var i=0;i<document.frmproactivities.elements.length;i++)
		{
			if(document.frmproactivities.elements[i].type=="textarea")
			{
			  document.frmproactivities.elements[i].readOnly=val;		  
			}
		}
	}
	
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.frmproactivities.cmdedit.disabled=bool1;
	document.frmproactivities.cmdsave.disabled=bool2;
	document.frmproactivities.cmdcancel.disabled=bool3;
	document.frmproactivities.cmddelete.disabled=bool4;
	document.frmproactivities.cmdclose.disabled=bool5;

}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)
	
}
function doDelete()
	{
	if(varRecordFlag=="Y")
		{
		if(ConfirmMsg(101))
			 {
			document.frmproactivities.hidAction.value="delete"
			document.frmproactivities.hidBeanId.value="compro"
			document.frmproactivities.hidBeanMethod.value="updateActivity";
			document.frmproactivities.hidBeanGetMethod.value="getActivity";
			document.frmproactivities.action=appURL+"controllerservlet";
			document.frmproactivities.hidSourceUrl.value="/action/comactivities.jsp";
			document.frmproactivities.submit();
			 }
		}
	else
		{
		ShowAlert(158);
		}
	}

function doSave()
{
		var flag = validate();
		var termflag = termvalidate();
		
	
if(flag || termflag){
		document.forms[0].cmdsave.disabled=true;
		document.frmproactivities.hidAction.value="update";
		document.frmproactivities.hidBeanId.value="compro";
		document.frmproactivities.hidBeanMethod.value="updateActivity";
		document.frmproactivities.hidBeanGetMethod.value="getActivity";
		document.frmproactivities.action=appURL+"controllerservlet";
		document.frmproactivities.hidSourceUrl.value="/action/comactivities.jsp";
		document.frmproactivities.submit();
		}
else	{
			alert("Enter values ");
		}

}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.frmproactivities.hidBeanId.value="compro";
		document.frmproactivities.hidBeanMethod.value="getActivity";
		document.frmproactivities.hidBeanGetMethod.value="getActivity";
		document.frmproactivities.action=appURL+"controllerservlet";
		document.frmproactivities.hidSourceUrl.value="/action/comactivities.jsp";
		document.frmproactivities.submit();
	 }
	
}


function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.frmproactivities.action=appURL+"action/"+"comsearch.jsp";
		document.frmproactivities.submit();
	}
}

function  validate()
{ 
	var flag;
	for (var m=0;m<1;m++)
	{
		if(trimtxt(document.frmproactivities.manufacturing.value) != "")
		{
			
				return true ;
			
		}
		else
				flag = false; 
	}
	
return flag;
}

function  termvalidate()
{ 
	var flag;
	for (var m=0;m<1;m++)
	{
		if(trimtxt(document.frmproactivities.trading.value) != "")
		{
			
				return true ;
			
		}
		else
				flag = false; 
	}
	
return flag;

}

function callLink(page,bean,method)
{
	if (document.frmproactivities.cmdsave.disabled)
	{
	  document.frmproactivities.hidBeanGetMethod.value=method;
	 document.frmproactivities.hidBeanId.value=bean;
	 document.frmproactivities.action=appURL+"action/"+page;
	 document.frmproactivities.submit();
	 }
	else
	{
		ShowAlert(103);
	}
}

 
function callApplicantTab(page)
{ 
   	
	if (document.frmproactivities.cmdsave.disabled)
	{
	  if(page=="company")
	  { 
		  document.frmproactivities.hidBeanGetMethod.value="getData";
		  document.frmproactivities.action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.frmproactivities.hidBeanGetMethod.value="getProposal";
		  document.frmproactivities.action=appURL+"action/comproposal.jsp";
	  }
	  if(page=="facilities")
	  {
		  document.frmproactivities.hidBeanMethod.value="getFacilityData";
		  document.frmproactivities.hidBeanId.value="facilities";
		  document.frmproactivities.action=appURL+"controllerservlet";
		  document.frmproactivities.hidSourceUrl.value="/action/facilities.jsp";
	  }
	  document.frmproactivities.submit();
	}
	else
	{
		ShowAlert(103);
	}
	
}

function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_prodact.htm";
  var title = "Activities";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}