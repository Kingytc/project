function checkNavigate()
{	
	var checkstate = true;
	if(document.forms[0].cmdapply.disabled == false)
	{	
		checkstate = false;
		ShowAlert('103');
	}
	return checkstate;
}

function moveLink(pagelink,desc)
{ 
	if( checkNavigate())
	{
		document.forms[0].hiddesc.value=desc;
		document.forms[0].action=pagelink;
		document.forms[0].submit();	
	}
}
