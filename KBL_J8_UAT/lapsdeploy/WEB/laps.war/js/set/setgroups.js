

function populateValues()
{
	if(document.forms[0].grouplist.selectedIndex==-1)
	{
		return;
	}
	var strName=document.forms[0].grouplist[document.forms[0].grouplist.selectedIndex].text;
	var strValue=document.forms[0].grouplist[document.forms[0].grouplist.selectedIndex].value;
	
	var strindex=strValue.split("^");
	var strId=strindex[0];
	var strRights=strindex[1];
	var strDiscreteID=strindex[2];
	var strLimit=strindex[3];
	var vargrpaccessfor=strindex[4];
	
	document.forms[0].grp_name.value=strName;
	document.forms[0].grp_id.value=strId;
	if(strLimit=="")
	{
	document.forms[0].grouplimitslist.value="0";
	
	}
	else
	{
	document.forms[0].grouplimitslist.value=strLimit;
	}
	
	if(vargrpaccessfor == "S" || vargrpaccessfor == "")
	{
	document.forms[0].sel_accessfor.value="S";
	
	}
	else
	{
	document.forms[0].sel_accessfor.value=vargrpaccessfor;
	}
	 
	if(strRights.charAt(0)=="1")
	{
	 	document.forms[0].chk_setupvital.checked=true;
	}
	else
	{
	 	document.forms[0].chk_setupvital.checked=false;
	}
	 
	if(strRights.charAt(1)=="1")
	{
	 	document.forms[0].chk_setupnonvital.checked=true;
	}
	else
	{
	 	document.forms[0].chk_setupnonvital.checked=false;
	}
	 
	//if(strRights.charAt(2)=="1")
	//{
		//document.forms[0].chk_riskmanagement.checked=true;
	//}
	//else
	//{
	 	//document.forms[0].chk_riskmanagement.checked=false;
	//}
	 if(strRights.charAt(2)=="1")
	{
		document.forms[0].chk_masters.checked=true;
	}
	else
	{
	 	document.forms[0].chk_masters.checked=false;
	}
	if(strRights.charAt(3)=="1")
	{
		document.forms[0].chk_defaulterslist.checked=true;
	}
	else
	{
	 	document.forms[0].chk_defaulterslist.checked=false;
	}
	if(strRights.charAt(5)=="1")
	{
	 	document.forms[0].chk_branchapplication.checked=true;
	}
	else
	{
	 	document.forms[0].chk_branchapplication.checked=false;
	}
	if(strRights.charAt(6)=="1")
	{
	 	document.forms[0].chk_appraisal.checked=true;
	}
	else
	{
	 	document.forms[0].chk_appraisal.checked=false;
	} 
	if(strRights.charAt(9)=="1")
	{
		document.forms[0].chk_TLR.checked=true;
	}
	else
	{
	 	document.forms[0].chk_TLR.checked=false;
	}
	 
	if(strRights.charAt(11)=="1")
	{
		document.forms[0].chk_application.checked=true;
	}
	else
	{
	 	document.forms[0].chk_application.checked=false;
	}
	 if(strRights.charAt(12)=="1")
	{
		document.forms[0].chk_Proposal.checked=true;
	}
	else
	{
	 	document.forms[0].chk_Proposal.checked=false;
	}
	if(strRights.charAt(13)=="1")
	{
		document.forms[0].chk_PIR.checked=true;
	}
	else
	{
	 	document.forms[0].chk_PIR.checked=false;
	}
	
	if(strRights.charAt(14)=="1")
	{
		document.forms[0].chk_monitoringregister.checked=true;
	}
	else
	{
	 	document.forms[0].chk_monitoringregister.checked=false;
	}
	 if(strRights.charAt(15)=="1")
	{
		document.forms[0].chk_monitoringreport.checked=true;
	}
	else
	{
	 	document.forms[0].chk_monitoringreport.checked=false;
	}
	
	if(strRights.charAt(16)=="1")
	{
		document.forms[0].chk_NPA.checked=true;
	}
	else
	{
	 	document.forms[0].chk_NPA.checked=false;
	}
	if(strRights.charAt(17)=="1")
	{
		document.forms[0].chk_Reports.checked=true;
	}
	else
	{
	 	document.forms[0].chk_Reports.checked=false;
	}
	if(strRights.charAt(18)=="w")
	{
		document.forms[0].dscurrent[1].checked=true;
	}
	else if(strRights.charAt(18)=="r")
	{
	 	document.forms[0].dscurrent[0].checked=true;
	}
	
	if(strRights.charAt(20)=="1")
	{
		document.forms[0].chk_agrapplication.checked=true;
	}
	else
	{
	 	document.forms[0].chk_agrapplication.checked=false;
	}
	if(strRights.charAt(21)=="1")
	{
		document.forms[0].chk_agrappraisal.checked=true;
	}
	else 
	{
	 	document.forms[0].chk_agrappraisal.checked=false;
	}
	
	if(strRights.charAt(22)=="1")
	{
		document.forms[0].chk_allcustomerprofile.checked=true;
	}
	else 
	{
	 	document.forms[0].chk_allcustomerprofile.checked=false;
	}if(strRights.charAt(23)=="1")
	{
		document.forms[0].chk_securities.checked=true;
	}
	else 
	{
	 	document.forms[0].chk_securities.checked=false;
	}
	if(strRights.charAt(24)=="1")
	{
	 	document.forms[0].chk_golddepapplication.checked=true;
	}
	else
	{
	 	document.forms[0].chk_golddepapplication.checked=false;
	}
	if(strRights.charAt(25)=="1")
	{
		document.forms[0].chk_golddepappraisal.checked=true;
	}
	else
	{
		document.forms[0].chk_golddepappraisal.checked=false;
	}
	if(strRights.charAt(26)=="1")
	{
		document.forms[0].chk_LODGE.checked=true;
	}
	else 
	{
	 	document.forms[0].chk_LODGE.checked=false;
	}
	if(strRights.charAt(27)=="1")
	{
		document.forms[0].chk_onlinemailbox.checked=true;
	}
	else 
	{
	 	document.forms[0].chk_onlinemailbox.checked=false;
	}
	if(strRights.charAt(28)=="1")
	{
		document.forms[0].chk_nsdlappmailbox.checked=true;
	}
	else 
	{
	 	document.forms[0].chk_nsdlappmailbox.checked=false;
	}
	
	if(strRights.charAt(29)=="1")
	{
		document.forms[0].chk_print.checked=true;
	}
	else 
	{
	 	document.forms[0].chk_print.checked=false;
	}
	if(strRights.charAt(30)=="1")
	{
		document.forms[0].chk_branchinbox.checked=true;
	}
	else 
	{
		document.forms[0].chk_branchinbox.checked=false;
	}
	
	document.forms[0].grp_discreteid.value = strDiscreteID;
	
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmdcreate.disabled=false;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdclose.disabled=false;
	document.forms[0].cmdsave.disabled=true;
}

function doEdit()
{
	if(document.forms[0].grp_name.value=="")
	{
		alert("Select the Group Rights");
		document.forms[0].grouplist.focus();
		return;
	}
	document.forms[0].sel_accessfor.value="OL";
	disabledfields(false);
	enablebuttons(true, true, false, false, false, true);	
	document.forms[0].hidAction.value="update";
}

function doCancel()
{
	if(!ConfirmMsg(102))
	{
		return;
	}
	if(document.forms[0].hidAction.value=="insert")
	{
		document.forms[0].reset();
		document.forms[0].hidAction.value="insert";
	}
	else
	{
		populateValues();
	}
	enablebuttons(false, false, true, true, true, false);
	disabledfields(true);
}

function doSave()
{
	if(document.forms[0].hidAction.value=="insert" && trim(document.forms[0].grp_name.value)=="")
	{
		ShowAlert(112,"group name");
		//document.forms[0].grp_name.focus();
		document.forms[0].grp_name.value="";
		return;
	}
	if(document.forms[0].hidAction.value=="insert")
	{
		for(var k=0;k<document.forms[0].grouplist.length;k++)
		{
			if(document.forms[0].grp_name.value.toUpperCase()==document.forms[0].grouplist.options[k].text.toUpperCase())
			{
				alert('Group already exists');
				//document.forms[0].grp_name.focus();
				return;
			}
		}
	}
	
	/*if(trim(document.forms[0].sel_accessfor.value)=="S" || document.forms[0].sel_accessfor.value ==""){
		ShowAlert(111,"Access For");
		return;
	}*/
	
	selecoption();
	//end
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidSourceUrl.value="/action/setgroups.jsp";
	document.forms[0].hidBeanId.value="setgroups";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";	
document.forms[0].action=appURL+"controllerservlet";
 	document.forms[0].submit();
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete";
			selecoption();
			enablebuttons(false, false, true, true, true, false);
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanGetMethod.value="getData";	
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/setgroups.jsp";
			document.forms[0].hidBeanId.value="setgroups";
			document.forms[0].hidAction.value="delete";
			
			document.forms[0].submit();
		}
	}
	else
	{		
		ShowAlert(158);
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

function doCreate()
{
	varRecordFlag="N";
	document.forms[0].hidAction.value="insert"; 
	disabledfields(false);
	document.forms[0].grp_name.value="";
	document.forms[0].grouplimitslist.value="0";
	document.forms[0].sel_accessfor.value="OL";
	enablebuttons(true, true, false, false, true, true);
	document.forms[0].grp_name.focus();
}

function enablebuttons(bool1, bool2, bool3, bool4, bool5, bool6)
 
 { 
	document.forms[0].cmdcreate.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function disabledfields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=='checkbox')
		{
			
			document.forms[0].elements[i].disabled=one;
		}				  
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
	document.forms[0].grouplist.disabled=false;
}

function menuOptionDivMouseDown (url) 
{
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

function dohlp()     
{
  	var hlpvar = appURL+"phlp/setup_groups.htm";
  	var title = "Groups";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}

function setChildren()
{
	document.forms[0].dschild[0].checked=true;
  	document.forms[0].dschild[1].disabled=true;
}

function releaseChildren()
{
	document.forms[0].dschild[1].disabled=false;
   	document.forms[0].dschild[2].disabled=false;
}

function selecoption()
{
	if(document.forms[0].chk_setupvital.checked==true)
	{
		document.forms[0].chk_setupvital.value="1";
	}
	else
	{
		document.forms[0].chk_setupvital.value="0";
	}
	
	if(document.forms[0].chk_setupnonvital.checked==true)
	{
		document.forms[0].chk_setupnonvital.value="1";
	}
	else
	{
		document.forms[0].chk_setupnonvital.value="0";
	}
	
	if(document.forms[0].chk_masters.checked==true)
	{
		document.forms[0].chk_masters.value="1";
	}
	else
	{
		document.forms[0].chk_masters.value="0";
	}
	
	if(document.forms[0].chk_defaulterslist.checked==true)
	{
		document.forms[0].chk_defaulterslist.value="1";
	}
	else
	{
		document.forms[0].chk_defaulterslist.value="0";
	}
	
	if(document.forms[0].chk_golddepapplication.checked==true)
	{
		document.forms[0].chk_golddepapplication.value="1";
	}
	else
	{
		document.forms[0].chk_golddepapplication.value="0";
	}
	if(document.forms[0].chk_golddepappraisal.checked==true)
	{
		document.forms[0].chk_golddepappraisal.value="1";
	}
	else
	{
		document.forms[0].chk_golddepappraisal.value="0";
	}
	if(document.forms[0].chk_branchapplication.checked==true)
	{
		document.forms[0].chk_branchapplication.value="1";
	}
	else
	{
		document.forms[0].chk_branchapplication.value="0";
	}
	if(document.forms[0].chk_appraisal.checked==true)
	{
		document.forms[0].chk_appraisal.value="1";
	}
	else
	{
		document.forms[0].chk_appraisal.value="0";
	}
	if(document.forms[0].chk_TLR.checked==true)
	{
		document.forms[0].chk_TLR.value="1";
	}
	else
	{
		document.forms[0].chk_TLR.value="0";
	}
	
	if(document.forms[0].chk_application.checked==true)
	{
		document.forms[0].chk_application.value="1";
	}
	else
	{
		document.forms[0].chk_application.value="0";
	}
	if(document.forms[0].chk_Proposal.checked==true)
	{
		document.forms[0].chk_Proposal.value="1";
	}
	else
	{
		document.forms[0].chk_Proposal.value="0";
	}
	if(document.forms[0].chk_PIR.checked==true)
	{
		document.forms[0].chk_PIR.value="1";
	}
	else
	{
		document.forms[0].chk_PIR.value="0";
	}
	if(document.forms[0].chk_monitoringregister.checked==true)
	{
		document.forms[0].chk_monitoringregister.value="1";
	}
	else
	{
		document.forms[0].chk_monitoringregister.value="0";
	}
	if(document.forms[0].chk_monitoringreport.checked==true)
	{
		document.forms[0].chk_monitoringreport.value="1";
	}
	else
	{
		document.forms[0].chk_monitoringreport.value="0";
	}
	if(document.forms[0].chk_NPA.checked==true)
	{
		document.forms[0].chk_NPA.value="1";
	}
	else
	{
		document.forms[0].chk_NPA.value="0";
	}
	if(document.forms[0].chk_Reports.checked==true)
	{
		document.forms[0].chk_Reports.value="1";
	}
	else
	{
		document.forms[0].chk_Reports.value="0";
	}
	
	if(document.forms[0].chk_agrapplication.checked==true)
	{
		document.forms[0].chk_agrapplication.value="1";
	}
	else
	{
		document.forms[0].chk_agrapplication.value="0";
	}
	
	if(document.forms[0].chk_agrappraisal.checked==true)
	{
		document.forms[0].chk_agrappraisal.value="1";
	}
	else
	{
		document.forms[0].chk_agrappraisal.value="0";
	}
	
	if(document.forms[0].chk_allcustomerprofile.checked==true)
	{
		document.forms[0].chk_allcustomerprofile.value="1";
	}
	else
	{
		document.forms[0].chk_allcustomerprofile.value="0";
	}
	if(document.forms[0].chk_securities.checked==true)
	{
		document.forms[0].chk_securities.value="1";
	}
	else
	{
		document.forms[0].chk_securities.value="0";
	}
	if(document.forms[0].chk_LODGE.checked==true)
	{
		document.forms[0].chk_LODGE.value="1";
	}
	else
	{
		document.forms[0].chk_LODGE.value="0";
	}
	if(document.forms[0].chk_onlinemailbox.checked==true)
	{
		document.forms[0].chk_onlinemailbox.value="1";
	}
	else
	{
		document.forms[0].chk_onlinemailbox.value="0";
	}
	if(document.forms[0].chk_nsdlappmailbox.checked==true)
	{
		document.forms[0].chk_nsdlappmailbox.value="1";
	}
	else
	{
		document.forms[0].chk_nsdlappmailbox.value="0";
	}
	if(document.forms[0].chk_print.checked==true)
	{
		document.forms[0].chk_print.value="1";
	}
	else
	{
		document.forms[0].chk_print.value="0";
	}
	if(document.forms[0].chk_branchinbox.checked==true)
	{
		document.forms[0].chk_branchinbox.value="1";
	}
	else
	{
		document.forms[0].chk_branchinbox.value="0";
	}
}