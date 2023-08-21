function load()
{
	if (document.forms[0].listsel.length ==0)
	{
		enable(true);
	}
	else
	{
		enable(false);
	}
	document.forms[0].txtfromamt.value=txtfromamt;
    document.forms[0].txttoamt.value=txttoamt;
	
}
function deleteProfile()
{
	

    if (document.forms[0].listsel.length > 0 && document.forms[0].listsel.selectedIndex != -1)
	{
		if (ConfirmMsg("101"))
		{
		val = document.forms[0].listsel.options[document.forms[0].listsel.selectedIndex].text;
		document.forms[0].txtprofile_name.value=trim(val);
		document.forms[0].hidAction.value="Delete";
		document.forms[0].userid.value=userid;
		document.forms[0].repname.value=repname;
		document.forms[0].hidBeanId.value="repData";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/browsereport.jsp";
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].submit();

		}
	}
	else if (document.forms[0].listsel.length > 0 && document.forms[0].listsel.selectedIndex == -1)
	{
		ShowAlert("111","Profile Name");
		return false;
	}

}

function runrep()
{
	if (document.forms[0].listsel.length > 0 && document.forms[0].listsel.selectedIndex != -1)
	{
	 val = trim(document.forms[0].listsel.options[document.forms[0].listsel.selectedIndex].text);
	beanid = trim(beanid);
		
	window.open(path+"action/"+pagename+"?hidBeanId="+beanid+"&hidBeanMethod=getData&hidMethod=getParamList1&txtfromamt="+txtfromamt+"&txttoamt="+txttoamt+"&userid="+userid+"&txtprofile_name="+val+"&repname="+repname,"Prod","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	window.parent.close();
	
	}
	else if (document.forms[0].listsel.length > 0 && document.forms[0].listsel.selectedIndex == -1)
	{
		ShowAlert("111","Profile Name");
		return false;
	}
	
}

function enable(boo)
{
	document.forms[0].del.disabled = boo;
	document.forms[0].show.disabled = boo;
	document.forms[0].run.disabled = boo;
}


function showProfile()
{
	if (document.forms[0].listsel.length > 0 && document.forms[0].listsel.selectedIndex != -1)
	{
		val = document.forms[0].listsel.options[document.forms[0].listsel.selectedIndex].text;
		var xpos = (screen.width - 400) / 2;
		var ypos = (screen.height - 320) / 2;	
//		alert("beanid ="+beanid+":value="+val+"---repname"+repname)
		document.forms[0].txtprofile_name.value=trim(val);
		document.forms[0].userid.value=userid;
		document.forms[0].repname.value=repname;
		document.forms[0].hidBeanId.value=trim(beanid);
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidMethod.value="showProfile";
		document.forms[0].hidSourceUrl.value="/action/showrepprofile.jsp";
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].submit();
		//window.open(path+"controllerservlet?hidSourceUrl=/action/showrepprofile.jsp&hidBeanId="+trim(beanid)+"&hidBeanMethod=getData&hidMethod=showProfile&userid="+userid+"&txtprofile_name="+trim(val)+"&repname="+repname,"Prod","scrollbars=No,toolbars=No,menubar=no ,width=400 , height=300,top="+ypos+",left="+xpos+"");
	}
	else if (document.forms[0].listsel.length > 0 && document.forms[0].listsel.selectedIndex == -1)
	{
		ShowAlert("111","Profile Name");
		return false;
	}

}