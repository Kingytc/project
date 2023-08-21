function callonLoad()
{		
	disablefields(true);
	
	if(varelitepanel!=""){
		document.forms[0].sel_elitepanel.value=varelitepanel;
	}
	else{
		document.forms[0].sel_elitepanel.value="S";
	}
	
	if(vartrapedit=="E")
		{
		enableButtons(false, false, true, true, false);	
		}
	else
		{
		enableButtons(false, true, true, true, false);	
		}
	if(action!="")
	{
		document.frmlawyermast.txt_action.value=action;
	}
	else
	{
		document.frmlawyermast.txt_action.value="1";
	}
	if(blacklist!="")
	{
		document.frmlawyermast.sel_blacklist.value=blacklist;
	}
	//document.forms[0].cmdaudittrail.disabled=true;
}

function callsupnam()
{
	var action=document.frmlawyermast.hidAction.value;
	//enableButtons(true, false, true, true, false);
	if(document.frmlawyermast.cmdsave.disabled==true)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/lawyermasterlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getLawyerMasterList&hidAction=search&strfrom=LawyerMaster";
		window.open(url,"",prop);
		//document.forms[0].cmdaudittrail.disabled=false;
	}
}

function ClearFields()
{
	for(var i=0;i<document.frmlawyermast.elements.length;i++)
	{
		if(document.frmlawyermast.elements[i].type=="text")
		{
			document.frmlawyermast.elements[i].value="";		  
		}
		else if(document.frmlawyermast.elements[i].type=="textarea")
		{
			document.frmlawyermast.elements[i].value="";		  
		}
	}
}
function showCountry()
{
	if(document.forms[0].txt_city.value!=null && document.forms[0].txt_city.value!="")
		{
			document.forms[0].txt_country.value="INDIA";
		}
}
function disablefields(one)
{
	for(var i=0;i<document.frmlawyermast.length;i++)
	{
		if(document.frmlawyermast.elements[i].type=='text')
		{
			document.frmlawyermast.elements[i].readOnly=one;
		}	  
		if(document.frmlawyermast.elements[i].type=='select-one')
		{
			document.frmlawyermast.elements[i].disabled=one;
		}
		if(document.frmlawyermast.elements[i].type=="textarea")
		{
			document.frmlawyermast.elements[i].readOnly=one;		  
		}		
	}
	
	document.frmlawyermast.txt_desig.readOnly=true;
	//document.frmlawyermast.txt_desig1.readOnly=true;
	document.frmlawyermast.txt_blacklistdate.readOnly=true;
	document.frmlawyermast.txt_city.readOnly=true;
	document.frmlawyermast.txt_state.readOnly=true;
	document.frmlawyermast.txt_empaneledon.readOnly=true;
}

function doSave()
{	
	
	if(document.forms[0].sel_elitepanel.selectedIndex<1)
	{
		alert("Select Whether Elite Panel");
		document.forms[0].sel_elitepanel.focus();
		return;
		
	}
		if(trim(document.frmlawyermast.txt_name.value) == "")
	{
		ShowAlert('121','Lawyer Name');
		document.frmlawyermast.txt_name.focus();
		return;
	}
	if(trim(document.frmlawyermast.txt_address1.value) == "")
	{
		ShowAlert('121','Lawyer Address');
		document.frmlawyermast.txt_address1.focus();
		return;
	}
	if(trim(document.frmlawyermast.txt_city.value) == "")
	{
		ShowAlert('121','Lawyer city');
		document.frmlawyermast.txt_city.focus();
		return;
	}
	if(trim(document.frmlawyermast.txt_state.value) == "")
	{
		ShowAlert('121','Lawyer state');
		document.frmlawyermast.txt_state.focus();
		return;
	}
	if(trim(document.frmlawyermast.txt_contactperson.value)=="")
		{
		ShowAlert('121','Contact Person Name');
		document.frmlawyermast.txt_contactperson.focus();
		return;
		}
	if(trim(document.frmlawyermast.txt_desig1.value) == "")
		{
		ShowAlert('121','Contact Person Designation');
		document.frmlawyermast.txt_desig1.focus();
		return;
		}
	if(trim(document.frmlawyermast.txt_zip.value) == "")
	{
		ShowAlert('121','Pincode');
		document.frmlawyermast.txt_zip.value="";
		document.frmlawyermast.txt_zip.focus();
		return;
	}
	if(document.frmlawyermast.txt_empaneledon.value=="")
	{
		ShowAlert('121','Empanelled on');
		return;
	}
	if(document.frmlawyermast.org_code.value=="")
	{
		ShowAlert('121','Branch Name');
		document.frmlawyermast.org_code.focus();
		return;
	}
	if(document.frmlawyermast.sel_blacklist.value=="Y")
	{
		if(document.frmlawyermast.txt_blacklistdate.value=="")
		{
			alert("Enter the Black Listed Date");
			document.frmlawyermast.txt_blacklistdate.value="";
			document.frmlawyermast.txt_blacklistdate.focus();
			return;
		}
	}
	document.frmlawyermast.hidBeanId.value="staticdata";
	document.frmlawyermast.hidBeanMethod.value="updateLawyerMasterData";
	document.frmlawyermast.hidBeanGetMethod.value="getLawyerMasterList";
	document.frmlawyermast.hidSourceUrl.value="/action/lawyermaster.jsp";
	document.frmlawyermast.action=appURL+"controllerservlet";
	document.frmlawyermast.submit();
	enableButtons(true, true, false, false, true);
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.frmlawyermast.action=appURL+"action/mainnav.jsp";
		document.frmlawyermast.submit();
	}
}

function doCancel()
	{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
		{
		document.frmlawyermast.hidAction.value="Cancel";
		document.frmlawyermast.action=appURL+"controllerservlet";
		document.frmlawyermast.hidBeanId.value="staticdata";
		document.frmlawyermast.hidBeanGetMethod.value="getLawyerMasterList";
		document.frmlawyermast.hidBeanMethod.value="getLawyerMasterList";
		document.frmlawyermast.hidSourceUrl.value="/action/lawyermaster.jsp";		
		document.frmlawyermast.submit();
		}
	}

function doNew() 
{
	ClearFields();
	document.frmlawyermast.hidAction.value="insert";
	document.frmlawyermast.hidsno.value="";
	document.frmlawyermast.sel_blacklist.value="N";
	document.all.t1.style.visibility="hidden";	
	document.all.t2.style.visibility="hidden";
   	enableButtons(true, true, false, false, true);
   	disablefields(false);   	
}

function doEdit() 
{
   	document.frmlawyermast.hidAction.value="update"
	enableButtons(true, true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.frmlawyermast.cmdnew.disabled=bool1;
	document.frmlawyermast.cmdedit.disabled=bool2;
	document.frmlawyermast.cmdsave.disabled=bool3;
	document.frmlawyermast.cmdcancel.disabled=bool4;
	document.frmlawyermast.cmdclose.disabled=bool5;
}

function callCalender(fname)
{
	var action  =document.frmlawyermast.hidAction.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,fname);
	}
}

function getdate()
{
	if(document.frmlawyermast.sel_blacklist.value=="Y")
	{
		document.all.t1.style.visibility="Visible";
		document.all.t2.style.visibility="Visible";	
		if(document.frmlawyermast.txt_blacklistdate.value=="01/01/1900")
			{
			document.frmlawyermast.txt_blacklistdate.value="";
			}
	}
	else if(document.frmlawyermast.sel_blacklist.value=="N")
	{
		document.all.t1.style.visibility="hidden";	
		document.all.t2.style.visibility="hidden";			
	}
}

function callDesignation1()
{
	var action=document.frmlawyermast.hidAction.value;
	if(document.frmlawyermast.cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/designationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getDesignationMasterList&strfrom=ValuerMaster";
		window.open(url,"",prop);
	}
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.frmlawyermast.cmdsave.disabled==false)
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