
function placevalues()
{
	document.forms[0].setorghelp1.value = varstrorgcode1;
	document.forms[0].setorghelp2.value = varstrorgcode2;
	if(varglp_orgname3 != "")
	{
		if(varstrorgcode3 == "")
		{
			document.forms[0].setorghelp3.value = "";
		}
		else
		{
			document.forms[0].setorghelp3.value = varstrorgcode3;
		}
		document.forms[0].setorghelp3.disabled = true;
	}
	if(varglp_orgname4 != "")
	{
		if(varstrorgcode4 == "")
		{
			document.forms[0].setorghelp4.value = "";
		}
		else
		{
			document.forms[0].setorghelp4.value = varstrorgcode4;
		}
		document.forms[0].setorghelp4.disabled = true;
	}
	if(varglp_orgname5 != "")
	{
		if(varstrorgcode5 == "")
		{
			document.forms[0].setorghelp5.value = "";
		}
		else
		{
			document.forms[0].setorghelp5.value = varstrorgcode5;
		}
		document.forms[0].setorghelp5.disabled = true;
	}
	document.forms[0].txtorg_code.value = varorg_code;
	document.forms[0].txtorg_name.value = varorg_name;
	document.forms[0].txtorg_scode.value = varorg_scode;
	document.forms[0].txtorg_taxid.value = varorg_taxid;
	var taxid = varorg_taxid.split('-');
	if(taxid[0]!=null)
	document.forms[0].bsr1.value = taxid[0];
	if(taxid[1]!=null)
	document.forms[0].bsr2.value = taxid[1];
	document.forms[0].txtorg_trasitid.value = varorg_trasitid;
	document.forms[0].txtorg_add1.value = varorg_add1;
	document.forms[0].txtorg_add2.value = varorg_add2;
	document.forms[0].txtorg_city.value = varorg_city;
	document.forms[0].txtorg_district.value = varorg_district;
	document.forms[0].txtorg_state.value = varorg_state;
	document.forms[0].txtorg_zip.value = varorg_zip;
	document.forms[0].txtorg_phone.value = varorg_phone;
	document.forms[0].txtorg_fax.value = varorg_fax;
	document.forms[0].txtorg_url.value = varorg_url;
	document.forms[0].txtorg_micr.value = varorg_micr;

	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = true;
		}
		else if(document.forms[0].elements[i].type == "select-one" )
		{
			if(document.forms[0].elements[i].name.indexOf("userlist")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("branchType")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("branchIn")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("region")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("saaBranch")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("solid")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("selissaral")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("saralhead")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("selisinternet")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("txt_centrename")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("sel_excelupload")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name.indexOf("user_abm")!=-1) 
			{
				document.forms[0].elements[i].disabled = true;
			}
		}
	}

	document.forms[0].cmdadd.disabled = true;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].cmddelete.disabled = true;
	document.forms[0].cmdcancel.disabled = true;
	
	/*if(varorg_level == "") {
		
		document.all.issaral.style.visibility="hidden";
		document.all.issaral.style.position="absolute";
		document.all.ts1.style.visibility="hidden";
		document.all.ts1.style.position="absolute";
		document.all.ts2.style.visibility="hidden";
		document.all.ts2.style.position="absolute";
		
		document.all.isinternet.style.visibility="hidden";
		document.all.isinternet.style.position="absolute";
		document.all.ts3.style.visibility="hidden";
		document.all.ts3.style.position="absolute";
		document.all.ts4.style.visibility="hidden";
		document.all.ts4.style.position="absolute";
	}*/
	
	if(varorg_level != "")
	{
		document.forms[0].cmdadd.disabled = false;
		document.forms[0].cmdedit.disabled = false;
		document.forms[0].cmddelete.disabled = true;
		
	}
	/*if(varorg_level.toUpperCase() == 'C')
	{
		document.forms[0].setorghelp2.disabled = false;
		document.all.issaral.style.visibility="hidden";
		document.all.issaral.style.position="absolute";
		document.all.ts1.style.visibility="hidden";
		document.all.ts1.style.position="absolute";
		document.all.ts2.style.visibility="hidden";
		document.all.ts2.style.position="absolute";
		
		document.all.isinternet.style.visibility="hidden";
		document.all.isinternet.style.position="absolute";
		document.all.ts3.style.visibility="hidden";
		document.all.ts3.style.position="absolute";
		document.all.ts4.style.visibility="hidden";
		document.all.ts4.style.position="absolute";
	}*/

	if(varorg_level.toUpperCase() == 'R')
	{
		if(varglp_orgname3 != "")
		{
			document.forms[0].setorghelp2.disabled = false;
			document.forms[0].setorghelp3.disabled = false;
		}
		/*document.all.issaral.style.visibility="hidden";
		document.all.issaral.style.position="absolute";
		document.all.ts1.style.visibility="hidden";
		document.all.ts1.style.position="absolute";
		document.all.ts2.style.visibility="hidden";
		document.all.ts2.style.position="absolute";
		
		document.all.isinternet.style.visibility="hidden";
		document.all.isinternet.style.position="absolute";
		document.all.ts3.style.visibility="hidden";
		document.all.ts3.style.position="absolute";
		document.all.ts4.style.visibility="hidden";
		document.all.ts4.style.position="absolute";*/
	}
	if(varorg_level.toUpperCase() == 'D')
	{
		
		document.forms[0].setorghelp2.disabled = false;
		document.forms[0].setorghelp3.disabled = false;
		if(varglp_orgname4 != "")
		{
			document.forms[0].setorghelp4.disabled = false;
		}		
		/*document.all.issaral.style.visibility="visible";
		document.all.issaral.style.position="relative";
		document.all.ts1.style.visibility="visible";
		document.all.ts1.style.position="relative";
		document.all.ts2.style.visibility="visible";
		document.all.ts2.style.position="relative";
		
		document.all.isinternet.style.visibility="hidden";
		document.all.isinternet.style.position="absolute";
		document.all.ts3.style.visibility="hidden";
		document.all.ts3.style.position="absolute";
		document.all.ts4.style.visibility="hidden";
		document.all.ts4.style.position="absolute";*/
	}
	if(varorg_level.toUpperCase() == 'A')
	{		
		document.forms[0].setorghelp2.disabled = false;
		document.forms[0].setorghelp3.disabled = false;
		document.forms[0].setorghelp4.disabled = false;
		if(varglp_orgname5 != "")
		{
			document.forms[0].setorghelp5.disabled = false;
		}
		/*document.all.issaral.style.visibility="hidden";
		document.all.issaral.style.position="absolute";
		document.all.ts1.style.visibility="hidden";
		document.all.ts1.style.position="absolute";
		document.all.ts2.style.visibility="hidden";
		document.all.ts2.style.position="absolute";
		
		document.all.isinternet.style.visibility="visible";
		document.all.isinternet.style.position="relative";
		document.all.ts3.style.visibility="visible";
		document.all.ts3.style.position="relative";
		document.all.ts4.style.visibility="visible";
		document.all.ts4.style.position="relative";*/
	}
	if(varorg_level.toUpperCase() == 'B' )
	{
		document.forms[0].setorghelp2.disabled = false;
		document.forms[0].setorghelp3.disabled = false;
		document.forms[0].setorghelp4.disabled = false;
		document.forms[0].setorghelp5.disabled = false;
		document.forms[0].cmdadd.disabled = true;
		/*document.all.issaral.style.visibility="hidden";
		document.all.issaral.style.position="absolute";
		document.all.ts1.style.visibility="hidden";
		document.all.ts1.style.position="absolute";
		document.all.ts2.style.visibility="hidden";
		document.all.ts2.style.position="absolute";
		
		document.all.isinternet.style.visibility="hidden";
		document.all.isinternet.style.position="absolute";
		document.all.ts3.style.visibility="hidden";
		document.all.ts3.style.position="absolute";
		document.all.ts4.style.visibility="hidden";
		document.all.ts4.style.position="absolute";*/
		
	}
	if(varorg_level.toUpperCase() == 'R' &&  varLevels == "2")
	{
		document.forms[0].cmdadd.disabled = true;
	}
	if(varorg_level.toUpperCase() == 'D' &&  varLevels == "3")
	{
		document.forms[0].cmdadd.disabled = true;
	}
	if(varorg_level.toUpperCase() == 'A' &&  varLevels == "4")
	{
		document.forms[0].cmdadd.disabled = true;
	}
	for(var i=0;i<document.forms[0].userlist.length;i++)
	{
		var val = document.forms[0].userlist.options[i].value;
		if(val!="")
		{
			arr = val.split("^");
			if(arr[0]==varorg_headid)
			{
				document.forms[0].userlist.options[i].selected=true;
				break;
			}
		}
	}	
	for(var i=0;i<document.forms[0].branchType.length;i++)
	{
		var val = document.forms[0].branchType.options[i].value;
		if(val!="")
		{
			if(val==varorg_branchType)
			{
				document.forms[0].branchType[i].selected=true;
				break;
			}
		}
	}
	for(var i=0;i<document.forms[0].branchIn.length;i++)
	{
		var val = document.forms[0].branchIn.options[i].value;
		if(val!="")
		{
			if(val==varorg_branchIn)
			{
				document.forms[0].branchIn[i].selected=true;
				break;
			}
		}
	}	/*
	for(var i=0;i<document.forms[0].region.length;i++)
	{
		var val = document.forms[0].region.options[i].value;
		if(val!="")
		{
			if(val==varorg_region)
			{
				document.forms[0].region[i].selected=true;
				break;
			}
		}
	}	
	for(var i=0;i<document.forms[0].saaBranch.length;i++)
	{
		var val = document.forms[0].saaBranch.options[i].value;
		if(val!="")
		{
			if(val==varorg_saaBranch)
			{
				document.forms[0].saaBranch[i].selected=true;
				break;
			}
		}
	}*/
	for(var i=0;i<document.forms[0].solid.length;i++)
	{
		var val = document.forms[0].solid.options[i].value;
		if(val!="")
		{
			if(val==varorg_solid)
			{
				document.forms[0].solid[i].selected=true;
				break;
			}
		}
	}
	if(varorg_issaral!="")
	{
		document.forms[0].selissaral.value=varorg_issaral;
	}
	/*if(varorg_saralhead!="")
	{
		for(var i=0;i<document.forms[0].saralhead.length;i++)
		{
			var val = document.forms[0].saralhead.options[i].value;
			if(val!="")
			{
				arr = val.split("^");	
				if(arr[0]==varorg_saralhead)
				{
					document.forms[0].saralhead.options[i].selected=true;
					break;
				}
			}
		}
	}*/
	
	/*if(varorg_isinternet!="") {
		
		document.forms[0].selisinternet.value=varorg_isinternet;
	}
	
	if(varorg_centrename!="") {
		
		document.forms[0].txt_centrename.value=varorg_centrename;
	}*/
	
	document.forms[0].setorghelp1.disabled = false;	
	//dosaralchange();
	//dointernetchange();
	
	if(varorgexceluploadflag!="")
	{
		document.forms[0].sel_excelupload.value=varorgexceluploadflag;
	}
	else
	{
		if(document.forms[0].hidlevel.value!="A" && document.forms[0].hidlevel.value!="")
		{
			document.forms[0].sel_excelupload.value="n";
		}
		else
		{
			document.forms[0].sel_excelupload.value="";
		}
	}
	/*if(varorgabmid!="")
	{
		document.forms[0].user_abm.value=varorgabmid;
	}*/
	for(var i=0;i<document.forms[0].user_abm.length;i++)
	{
		var val = document.forms[0].user_abm.options[i].value;
		if(val!="")
		{
			arr = val.split("^");
			if(arr[0]==varorgabmid)
			{
				document.forms[0].user_abm.options[i].selected=true;
				break;
			}
		}
	}	
}

function submitHelp1()
{
	var varorghelp1 = document.forms[0].setorghelp1.value;
	document.forms[0].hidsetorghelp1.value = varorghelp1;
	document.forms[0].hidsetorghelpvalue1.value = varorghelp1;
	document.forms[0].hidBeanId.value="setorg";
	document.forms[0].hidBeanGetMethod.value="getData";	
	document.forms[0].action=appURL+"action/setorg.jsp";
	document.forms[0].submit();
}

function submitHelp2()
{
	if(varglp_orgname2 != "")
	{
		var varorghelp2 = document.forms[0].setorghelp2.value;
		if(varorghelp2 != "")
		{
			document.forms[0].hidsetorghelp1.value = document.forms[0].setorghelp1.value;
			document.forms[0].hidsetorghelpvalue1.value = "";
			document.forms[0].hidsetorghelp2.value = varorghelp2;
			document.forms[0].hidsetorghelpvalue2.value = varorghelp2;
			document.forms[0].hidBeanId.value="setorg";
			document.forms[0].hidBeanGetMethod.value="getData";	
			document.forms[0].action=appURL+"action/setorg.jsp";
			document.forms[0].submit();
		}
		else
		{
			if(varglp_orgname3 != "")
			{
				document.forms[0].setorghelp3.value ="";
				document.forms[0].setorghelp3.disabled = true;
			}
			if(varglp_orgname4 != "")
			{
				document.forms[0].setorghelp4.value ="";
				document.forms[0].setorghelp4.disabled = true;
			}
			if(varglp_orgname5 != "")
			{
				document.forms[0].setorghelp5.value ="";
				document.forms[0].setorghelp5.disabled = true;
			}
		}
	}
}

function submitHelp3()
{
	if(varglp_orgname3 != "")
	{
		var varorghelp3 = document.forms[0].setorghelp3.value;
		if(varorghelp3 != "")
		{
			document.forms[0].hidsetorghelp1.value = document.forms[0].setorghelp1.value;
			document.forms[0].hidsetorghelp2.value = document.forms[0].setorghelp2.value;
			document.forms[0].hidsetorghelpvalue1.value = "";
			document.forms[0].hidsetorghelpvalue2.value = "";
			document.forms[0].hidsetorghelp3.value = varorghelp3;
			document.forms[0].hidsetorghelpvalue3.value = varorghelp3;
			document.forms[0].hidBeanId.value="setorg";
			document.forms[0].hidBeanGetMethod.value="getData";	
			document.forms[0].action=appURL+"action/setorg.jsp";
			document.forms[0].submit();
		}
		else
		{
			if(varglp_orgname4 != "")
			{
				document.forms[0].setorghelp4.value ="";
				document.forms[0].setorghelp4.disabled = true;
			}
			if(varglp_orgname5 != "")
			{
				document.forms[0].setorghelp5.value ="";
				document.forms[0].setorghelp5.disabled = true;
			}
		}
	}
}

function submitHelp4()
{
	if(varglp_orgname4 != "")
	{
		var varorghelp4 = document.forms[0].setorghelp4.value;
		if(varorghelp4 != "")
		{
			document.forms[0].hidsetorghelp1.value = document.forms[0].setorghelp1.value;
			document.forms[0].hidsetorghelp2.value = document.forms[0].setorghelp2.value;
			document.forms[0].hidsetorghelp3.value = document.forms[0].setorghelp3.value;
			document.forms[0].hidsetorghelpvalue1.value = "";
			document.forms[0].hidsetorghelpvalue2.value = "";
			document.forms[0].hidsetorghelpvalue3.value = "";
			document.forms[0].hidsetorghelp4.value = varorghelp4;
			document.forms[0].hidsetorghelpvalue4.value = varorghelp4;
			document.forms[0].hidBeanId.value="setorg";
			document.forms[0].hidBeanGetMethod.value="getData";	
			document.forms[0].action=appURL+"action/setorg.jsp";
			document.forms[0].submit();
		}
		else
		{
			if(varglp_orgname5 != "")
			{
				document.forms[0].setorghelp5.value ="";
				document.forms[0].setorghelp5.disabled = true;
			}
		}
	}
}

function submitHelp5()
{
	if(varglp_orgname5 != "")
	{
		var varorghelp5 = document.forms[0].setorghelp5.value;
		if(varorghelp5 != "")
		{
			document.forms[0].hidsetorghelp1.value = document.forms[0].setorghelp1.value;
			document.forms[0].hidsetorghelp2.value = document.forms[0].setorghelp2.value;
			document.forms[0].hidsetorghelp3.value = document.forms[0].setorghelp3.value;
			document.forms[0].hidsetorghelp4.value = document.forms[0].setorghelp4.value;
			document.forms[0].hidsetorghelpvalue1.value = "";
			document.forms[0].hidsetorghelpvalue2.value = "";
			document.forms[0].hidsetorghelpvalue3.value = "";
			document.forms[0].hidsetorghelpvalue4.value = "";
			document.forms[0].hidsetorghelp5.value = varorghelp5;
			document.forms[0].hidsetorghelpvalue5.value = varorghelp5;
			document.forms[0].hidBeanId.value="setorg";
			document.forms[0].hidBeanGetMethod.value="getData";	
			document.forms[0].action=appURL+"action/setorg.jsp";
			document.forms[0].submit();
		}
	}	
}

function doAdd()
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = false;
			document.forms[0].elements[i].value = "";
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{			
			document.forms[0].elements[i].disabled = false;
			
			if(document.forms[0].elements[i].name=="setorghelp5")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="setorghelp4")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="setorghelp3")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="setorghelp2")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="setorghelp1")
			{
				document.forms[0].elements[i].disabled = true;
			}
		}
    }
	document.forms[0].userlist.value="0";
	document.forms[0].txtorg_name.focus();
	document.forms[0].txtorg_code.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdadd.disabled = true;
	document.forms[0].cmddelete.disabled = true;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].hidAction.value = "child";
	document.forms[0].hidlevel.value = varorg_level;
	document.forms[0].hidorgcode.value = varorg_code;
	//document.forms[0].branchType.value="0";
	//document.forms[0].branchIn.value="0";
	//document.forms[0].region.value="0";
	document.forms[0].solid.selectedIndex=0;
	//document.forms[0].saaBranch.selectedIndex=0;
	/*if(document.forms[0].saaBranch.value=="0")
	{
		document.all.tab_branch.style.visibility="hidden";		
	}if(varorg_level.toUpperCase() == 'R')
	{
		document.all.issaral.style.visibility="visible";
		document.all.issaral.style.position="relative";
	}
	else if(varorg_level.toUpperCase() == 'D'){
		
		document.all.isinternet.style.visibility="visible";	
		document.all.isinternet.style.position="relative";
		
	}else {
		
		document.all.issaral.style.visibility="hidden";	
		document.all.issaral.style.position="absolute";
		document.all.ts1.style.visibility="hidden";	
		document.all.ts1.style.position="absolute";
		document.all.ts2.style.visibility="hidden";	
		document.all.ts2.style.position="absolute";
		
		document.all.isinternet.style.visibility="hidden";	
		document.all.isinternet.style.position="absolute";
		document.all.ts3.style.visibility="hidden";	
		document.all.ts3.style.position="absolute";
		document.all.ts4.style.visibility="hidden";	
		document.all.ts4.style.position="absolute";
	}*/
	
	
	document.forms[0].txtorg_city.readOnly=true;
	document.forms[0].txtorg_state.readOnly=true;
	document.forms[0].hidcity.value = "";
	document.forms[0].hidstate.value = "";

}

function doSave()
{
	
	var state = true;
	var scode = trim(document.forms[0].txtorg_scode.value);
	var name = trim(document.forms[0].txtorg_name.value);
	var head = document.forms[0].userlist.value;
	var location=document.forms[0].branchIn.value;
	if(name == "")
	{
		state = false;
		ShowAlert(121,"Organisation Name");
		document.forms[0].txtorg_name.focus();
		return;
	}
	if(scode == "")
	{
		state = false;
		ShowAlert(121,"Organisation short code");
		document.forms[0].txtorg_scode.focus();
		return;
	}
	if(head=="0")
	{
		state = false;
		ShowAlert(111,"Organisation Head");
		document.forms[0].userlist.focus();
		return;
	}
	if(location=="0" || location=="")
	{
		state = false;
		ShowAlert(111,"Location");
		document.forms[0].branchIn.focus();
		return;
	}
	/*if(document.forms[0].solid.value=="0")
	{
		state = false;
		ShowAlert(111,"SolId");
		document.forms[0].solid.focus();
		return;
	}		
	if(document.forms[0].saaBranch.value== "1")
	{
		if(document.forms[0].txtSAA_branch.value=="")
		{
			state = false;
			ShowAlert(121,"Number of Villages");
			document.forms[0].txtSAA_branch.focus();
			return;
		}
	}*/
	
	//Added By Zahoorunnisa.s as for replicating for adding a new child org, the prev org code is retain and this is incremented in update bean
	var org_level = varorg_level;
	
	if(document.forms[0].hidAction.value == "child"){
		if(org_level == 'R'){
			org_level = 'D';
		}
		else if(org_level == 'D'){
			org_level = 'A';
		}
	}
	//end
	
	/*if(org_level.toUpperCase() == 'D')
	{
		if(document.forms[0].selissaral.value=="0")
		{
			state = false;
			ShowAlert(111,"Whether Saral");
			document.forms[0].selissaral.focus();
			return;
		}
	}
	if(org_level.toUpperCase() == 'D')
	{
		if(document.forms[0].selissaral.value=="Y")
		{
			if(document.forms[0].saralhead.value=="0")
			{
				state = false;
				ShowAlert(111,"Saral Head");
				document.forms[0].saralhead.focus();
				return;
			}
		}
	}*/
	
	/*if(org_level.toUpperCase() == 'A')
	{
		if(document.forms[0].selisinternet.value=="0")
		{
			state = false;
			ShowAlert(111,"Whether Internet Application Centre");
			document.forms[0].selisinternet.focus();
			return;
		}
	}
	if(org_level.toUpperCase() == 'A')
	{
		if(document.forms[0].selisinternet.value=="Y")
		{
			if(document.forms[0].txt_centrename.value=="")
			{
				state = false;
				ShowAlert(111,"Centre Name");
				document.forms[0].txt_centrename.focus();
				return;
			}
		}
	}*/
	if(document.forms[0].hidlevel.value=="A" || org_level=="A")
	{
		if(document.forms[0].sel_excelupload.value=="")
		{
			ShowAlert(111,"Whether excel upload can be done?");
			document.forms[0].sel_excelupload.focus();
			return;
		}
	}
	else
	{
		document.forms[0].sel_excelupload.value="n";
	}
	if(document.forms[0].hidlevel.value=="A" || org_level=="A")
	{
		if(document.forms[0].txt_ifsccode.value=="")
		{
			ShowAlert(121,"IFSC Code");
			document.forms[0].txt_ifsccode.focus();
			return;
		}
	}
	if((document.forms[0].hidlevel.value=="A" || org_level=="A") && document.forms[0].txtorg_abmno.value!="")
	{
		if(document.forms[0].txtorg_abmno.value == document.forms[0].txtorg_mgrphn.value)
		{
			alert("Manager and ABM mobile number can't be same");
			document.forms[0].txtorg_abmno.focus();
			return;
		}
	}
	if((document.forms[0].hidlevel.value=="A" || org_level=="A") && document.forms[0].user_abm.value!="0")
	{
		if(document.forms[0].user_abm.value == document.forms[0].userlist.value)
		{
			alert("Manager and ABM ID can't be same");
			document.forms[0].txtorg_abmno.focus();
			return;
		}
	}
	if(state == true)
	{
		if(document.forms[0].hidAction.value == "")
		{
			document.forms[0].hidAction.value = "update";				
		}
		for(i=0;i<document.forms[0].elements.length;i++)
		{
			document.forms[0].elements[i].disabled = false;
		}			
		document.forms[0].txtorg_taxid.value = document.forms[0].bsr1.value + "-" + document.forms[0].bsr2.value
		
		//document.forms[0].hidbranchin.value=document.forms[0].branchIn[document.forms[0].branchIn.selectedIndex].text;
		//document.forms[0].hidbranchtype.value=document.forms[0].branchType[document.forms[0].branchType.selectedIndex].text;
		//document.forms[0].hidregion.value=document.forms[0].region[document.forms[0].region.selectedIndex].text;
		//document.forms[0].hidsaabranch.value=document.forms[0].saaBranch[document.forms[0].saaBranch.selectedIndex].text;
		//document.forms[0].hidsolid.value=document.forms[0].solid[document.forms[0].solid.selectedIndex].text;
		//document.forms[0].hidsaral.value=document.forms[0].selissaral[document.forms[0].selissaral.selectedIndex].text;
		//document.forms[0].hidsaralhead.value=document.forms[0].saralhead[document.forms[0].saralhead.selectedIndex].text;
		document.forms[0].hidsolid.value=document.forms[0].txtorg_scode.value;//Since solid and branch code is same
		document.forms[0].hidorghead.value=document.forms[0].userlist[document.forms[0].userlist.selectedIndex].text;
		
		document.forms[0].hidlevel.value = varorg_level;
		document.forms[0].hidorgcode.value = varorg_code;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidSourceUrl.value="/action/setorg.jsp";
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidBeanId.value="setorg";
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

function menuOptionDivMouseDown (url) {
	
	if(!document.forms[0].cmdsave.disabled)
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

function doEdit()
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = false;
		}
		else if(document.forms[0].elements[i].type == "select-one" )
		{
			if(document.forms[0].elements[i].name=="userlist")
			{
				document.forms[0].elements[i].disabled = false;
			}
			if(document.forms[0].elements[i].name=="branchType")
			{
				document.forms[0].elements[i].disabled = false;
			}
			if(document.forms[0].elements[i].name=="branchIn")
			{
				document.forms[0].elements[i].disabled = false;
			}
			if(document.forms[0].elements[i].name=="region")
			{
				document.forms[0].elements[i].disabled = false;
			}
			if(document.forms[0].elements[i].name=="saaBranch")
			{
				document.forms[0].elements[i].disabled = false;
			}
			if(document.forms[0].elements[i].name=="solid")
			{
				document.forms[0].elements[i].disabled = false;
			}
			if(document.forms[0].elements[i].name=="selissaral")
			{
				document.forms[0].elements[i].disabled = false;
			}
			if(document.forms[0].elements[i].name=="saralhead")
			{
				document.forms[0].elements[i].disabled = false;
			}			
			if(document.forms[0].elements[i].name=="setorghelp5")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="setorghelp4")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="setorghelp3")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="setorghelp2")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="setorghelp1")
			{
				document.forms[0].elements[i].disabled = true;
			}
			if(document.forms[0].elements[i].name=="selisinternet")
			{
				document.forms[0].elements[i].disabled = false;
			}
			if(document.forms[0].elements[i].name=="txt_centrename")
			{
				document.forms[0].elements[i].disabled = false;
			}	
		}
    }
	
	if(document.forms[0].hidlevel.value=="A")
	{
		document.forms[0].sel_excelupload.disabled=false;
		document.forms[0].user_abm.disabled=false;
		document.forms[0].txtorg_abmno.readOnly=false;
	}
	document.forms[0].txtorg_scode.disabled = true;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdadd.disabled = true;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdclose.disabled = true;
	document.forms[0].txtorg_code.disabled = true;	
	document.forms[0].txtorg_city.readOnly=true;
	document.forms[0].txtorg_state.readOnly=true;
	document.forms[0].hidAction.value ="Update";
}

function doDelete()
{	
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value = "delete";
		if(varorg_level.toUpperCase() == 'C' )
		{
			ShowAlert("127","delete Corporate");
		}
		else if(varorg_level.toUpperCase() == 'R' )
		{
			document.forms[0].hidorgcodedel.value = varorg_code.substring(0,6);
			document.forms[0].hidleveldel.value = "D";
			doSave();
		}
		else if(varorg_level.toUpperCase() == 'D' )
		{
			document.forms[0].hidorgcodedel.value = varorg_code.substring(0,9);
			document.forms[0].hidleveldel.value = "A";
			doSave();
		}
		else if(varorg_level.toUpperCase() == 'A' )
		{
			document.forms[0].hidorgcodedel.value = varorg_code.substring(0,12);
			document.forms[0].hidleveldel.value = "B";
			doSave();
		}
		else if(varorg_level.toUpperCase() == 'B' )
		{
			document.forms[0].hidorgcodedel.value = varorg_code.substring(0,15);
			document.forms[0].hidleveldel.value = "B";
			doSave();
		}
	}	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].cmdcancel.disabled = true;
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].cmddelete.disabled = true;
		document.forms[0].cmdedit.disabled = false;
		document.forms[0].cmdclose.disabled = false;
		document.forms[0].cmdadd.disabled = false;
		placevalues();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}


/*function showBranch()
{
	if(document.forms[0].saaBranch.value=="1")
	{
		document.all.tab_branch.style.visibility="visible";
	}
    if(document.forms[0].saaBranch.value=="2")
	{
		document.all.tab_branch.style.visibility="hidden";		
	}
	if(document.forms[0].saaBranch.value=="0")
	{
		document.all.tab_branch.style.visibility="hidden";		
	}
}*/

function target()
{
	var varQryString = appURL+"action/TargetMaster.jsp";
	var title = "TargetMaster";
	var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);	
}

var xmlHttp=null;
function GetXmlHttpObject()
{	
	try
	{
		xmlHttp=new XMLHttpRequest();
	}
	catch(e)	
	{
		try
		{
			xmlHttp= new ActiveXObject("Msxml12.XMLHTTP");
		}
		catch(e)
		{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}	
	return xmlHttp;
}

function checkSolidandBranchCode()	
{
	var xmlHttp;
	var uri;
	var branchcode=document.forms[0].txtorg_scode.value;
	var solid=document.forms[0].solid.value;
	var orgcode=document.forms[0].txtorg_code.value;
	xmlHttp=GetXmlHttpObject();
	if(xmlHttp==null)
	{
		alert("Browser Do Not Support Using Ajax....");
	}
	uri=appURL+"action/iframeorg.jsp?hidBeanGetMethod=getDuplicateCheck&hidBeanId=setorg&branchcode="+branchcode+"&solid="+solid+"&orgcode="+orgcode;
	uri = uri +"&sid="+Math.random();
	xmlHttp.onreadystatechange=loadsummary;
	xmlHttp.open("GET",uri,true);
	xmlHttp.send(null);
}

function loadsummary()
{
	if(xmlHttp.readyState==4)
	{	
		var val=xmlHttp.responseText;
		
		if(document.getElementById("txtorg_scode").value!="")
		{
			val=val.indexOf("Already Used Number");
			var val1=xmlHttp.responseText.split("#");
			if(val > -1)
			{
				alert("Already IBR Code Used for " + val1[1]);
				document.forms[0].cmdedit.disabled=true;
				return;
			}
			else
			{
				document.forms[0].cmdedit.disabled=false;
			}
		}
		if(document.getElementById("solid").value!="0")
		{
			val=xmlHttp.responseText;
			var val1=xmlHttp.responseText.split("#");
			val=val.indexOf("Already Given Branch");
			if(val > -1)
			{
				alert("Already Assigned to Branch " + val1[1]);
				document.getElementById("solid").value="0";
				document.forms[0].cmdedit.disabled=true;
				return;
			}
			else
			{
				document.forms[0].cmdedit.disabled=false;
			}
		}
	}
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	

}
function doMoveOrganisation()
{
	var varQryString = appURL+"action/SelectOrg.jsp?glp_orgname1="+varglp_orgname1+"&glp_orgname2="+varglp_orgname2+"&glp_orgname3="+varglp_orgname3+"&strorgcode1="+varstrorgcode1+"&strorgcode2="+varstrorgcode2+"&strorgcode3="+varstrorgcode3+"&strorgcode4="+varstrorgcode4+"&hidOrgCode="+varorg_code+"&hidOrgLevel="+varorg_level;
	var title = "Organisation";
	var prop = "scrollbars=yes,width=400,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);

}

function showDistSearch(val)
{  
	var varstate = document.forms[0].hidstate.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
	if(document.forms[0].hidstate.value=="")
	{
		alert("Please Reselect the City");
		document.forms[0].txtorg_city.focus();
		return;
	}
	if(document.forms[0].txtorg_city.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].txtorg_city.focus();
		return;
	}	
	else		
	{
    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
	}
	}	
	
}