
function placevalues()
{
	document.forms[0].choglp_orglevel.value = choglp_orglevel;
	document.forms[0].txtglp_orgname1.value = txtglp_orgname1;
	document.forms[0].txtglp_orgname2.value = txtglp_orgname2;
	document.forms[0].txtglp_orgname3.value = txtglp_orgname3;
	document.forms[0].txtglp_orgname4.value = txtglp_orgname4;
	document.forms[0].txtglp_orgname5.value = txtglp_orgname5;
}

function chgorglevel()
{
	var level = document.forms[0].choglp_orglevel.value;

	if(level == "2")
	{
		document.forms[0].txtglp_orgname1.readOnly = false;
		document.forms[0].txtglp_orgname2.readOnly = false;
		document.forms[0].txtglp_orgname3.readOnly = true;
		document.forms[0].txtglp_orgname4.readOnly = true;
		document.forms[0].txtglp_orgname5.readOnly = true;

		document.forms[0].txtglp_orgname3.value="";
		document.forms[0].txtglp_orgname4.value="";
		document.forms[0].txtglp_orgname5.value="";
	}
	else if(level == "3")
	{
		document.forms[0].txtglp_orgname1.readOnly = false;
		document.forms[0].txtglp_orgname2.readOnly = false;
		document.forms[0].txtglp_orgname3.readOnly = false;
		document.forms[0].txtglp_orgname4.readOnly = true;
		document.forms[0].txtglp_orgname5.readOnly = true;

		
		document.forms[0].txtglp_orgname4.value="";
		document.forms[0].txtglp_orgname5.value="";


	}
	else if(level == "4")
	{
		
		document.forms[0].txtglp_orgname1.readOnly = false;
		document.forms[0].txtglp_orgname2.readOnly = false;
		document.forms[0].txtglp_orgname3.readOnly = false;
		document.forms[0].txtglp_orgname4.readOnly = false;
		document.forms[0].txtglp_orgname5.readOnly = true;

		document.forms[0].txtglp_orgname5.value="";

	}
	else
	{
		document.forms[0].txtglp_orgname1.readOnly = false;
		document.forms[0].txtglp_orgname2.readOnly = false;
		document.forms[0].txtglp_orgname3.readOnly = false;
		document.forms[0].txtglp_orgname4.readOnly = false;
		document.forms[0].txtglp_orgname5.readOnly = false;

	}
}
function doEdit()
{
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].readOnly = false;
		
    }
	document.forms[0].choglp_orglevel.disabled = false;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdclose.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdcancel.disabled = false;	
	chgorglevel();
}
function makedisable()
{
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type != "button")
		{
			document.forms[0].elements[i].readOnly = true;
		}
    }
	document.forms[0].choglp_orglevel.disabled = true;
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].cmdcancel.disabled = true;	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].cmdcancel.disabled = true;
		document.forms[0].cmdedit.disabled = false;
		document.forms[0].cmdclose.disabled = false;
		placevalues();
		makedisable();
	}
}
function doSave()
{
	var level = document.forms[0].choglp_orglevel.value;
	var bstate = true;
	if(level == 2)
	{
		var secLevel1 = checktrim(document.forms[0].txtglp_orgname1.value);
		var secLevel2 =	checktrim(document.forms[0].txtglp_orgname2.value);
		if(secLevel1 == "" || secLevel2 == "")
		{
			bstate = false;
			ShowAlert('126','2');
		}

	}
	if(level == 3)
	{
		var secLevel1 = checktrim(document.forms[0].txtglp_orgname1.value);
		var secLevel2 =	checktrim(document.forms[0].txtglp_orgname2.value);
		var secLevel3 =	checktrim(document.forms[0].txtglp_orgname3.value);

		if(secLevel1 == "" || secLevel2 == "" || secLevel3 == "")
		{
			bstate = false;
			ShowAlert('126','3');
		}
	}
	if(level == 4)
	{
		var secLevel1 = checktrim(document.forms[0].txtglp_orgname1.value);
		var secLevel2 =	checktrim(document.forms[0].txtglp_orgname2.value);
		var secLevel3 = checktrim(document.forms[0].txtglp_orgname3.value);
		var secLevel4 =	checktrim(document.forms[0].txtglp_orgname4.value);

		if( (secLevel1 == "" || secLevel2 == "") || (secLevel3 == "" || secLevel4 == "") )
		{
			bstate = false;
			ShowAlert('126','4');
		}
	}
	if(level == 5)
	{
		var secLevel1 = checktrim(document.forms[0].txtglp_orgname1.value);
		var secLevel2 =	checktrim(document.forms[0].txtglp_orgname2.value);
		var secLevel3 = checktrim(document.forms[0].txtglp_orgname3.value);
		var secLevel4 =	checktrim(document.forms[0].txtglp_orgname4.value);
		var secLevel5 =	checktrim(document.forms[0].txtglp_orgname5.value);

		if( (secLevel1 == "" || secLevel2 == "") || (secLevel3 == "" || secLevel4 == "") || secLevel5=="")
		{
			bstate = false;
			ShowAlert('126','5');
		}
	}
	if(parseInt(level) < parseInt(choglp_level) )
	{
		bstate = false;
		ShowAlert('127',"Reduce level");
	}
	if(bstate == true)
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidSourceUrl.value="/action/setglp.jsp";
		document.forms[0].hidAction.value ="Update";
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidBeanId.value="setglpoptions";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";	
		document.forms[0].action=appurl+"controllerservlet";
		document.forms[0].submit();
	}	
}
function checktrim(strValues)
{
	var strval = strValues;
	var bool = false;
	while(bool == false)
    {
 			if(strval.substring(0,1) ==" ")
		    {
				strval = strval.substring(1,strval.length);
		    }
			else
		   {
				bool =true;
		   }
	}
	return strval;
}
function callDeletePage()
{
	document.forms[0].action=appurl+"action/undelapp.jsp?optformtype=p";
	document.forms[0].submit();
}
function callRBI()
{
	document.forms[0].action=appurl+"action/xml.jsp";
	document.forms[0].submit();
}
function doClose()
{
	 if(ConfirmMsg(100))
	 {
		document.forms[0].action=appurl+"action/setupnav.jsp";
		document.forms[0].submit();
	 }
}