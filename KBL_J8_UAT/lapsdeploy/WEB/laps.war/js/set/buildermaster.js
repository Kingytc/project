function callonLoad()
{		
	disablefields(true);
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
		document.frmbuildermast.txt_action.value=action;
	}
	else
	{
		document.frmbuildermast.txt_action.value="1";
	}
	if(reputedstatus!="")
	{
		document.frmbuildermast.txt_reputedstatus.value=reputedstatus;
	}
	else
	{
		document.frmbuildermast.txt_reputedstatus.value="1";
	}
	if(blacklist!="")
	{
		document.frmbuildermast.sel_blacklist.value=blacklist;
	}
	//document.forms[0].cmdaudittrail.disabled=true;
}
function showCountry()
{
	if(document.forms[0].txt_city.value!=null && document.forms[0].txt_city.value!="")
		{
			document.forms[0].txt_country.value="INDIA";
		}
}
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.frmbuildermast.cmdnew.disabled=bool1;
	document.frmbuildermast.cmdedit.disabled=bool2;
	document.frmbuildermast.cmdsave.disabled=bool3;
	document.frmbuildermast.cmdcancel.disabled=bool4;
	document.frmbuildermast.cmdclose.disabled=bool5;
}

function callsupnam()
{
	var action=document.frmbuildermast.hidAction.value;
	if(document.frmbuildermast.cmdsave.disabled==true)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/builderslist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getBuilderMasterList&hidAction=search&strfrom=BuilderMaster";
		window.open(url,"",prop);
		//document.forms[0].cmdaudittrail.disabled=false;
	}
}


function ClearFields()
{
	for(var i=0;i<document.frmbuildermast.elements.length;i++)
	{
		if(document.frmbuildermast.elements[i].type=="text")
		{
			  document.frmbuildermast.elements[i].value="";		  
		}		
		else if(document.frmbuildermast.elements[i].type=="textarea")
		{
			document.frmbuildermast.elements[i].value="";		  
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.frmbuildermast.length;i++)
	{
		if(document.frmbuildermast.elements[i].type=='text')
		{
			document.frmbuildermast.elements[i].readOnly=one;
		}	  
		if(document.frmbuildermast.elements[i].type=='select-one')
		{
			document.frmbuildermast.elements[i].disabled=one;
		}
		if(document.frmbuildermast.elements[i].type=="textarea")
		{
			document.frmbuildermast.elements[i].readOnly=one;		  
		}		
	}
	//document.frmbuildermast.txt_desig1.readOnly=true;
	document.frmbuildermast.txt_blacklistdate.readOnly=true;
	document.frmbuildermast.txt_city.readOnly=true;
	document.frmbuildermast.txt_state.readOnly=true;
	document.frmbuildermast.txt_country.readOnly=true;
}

function doSave()
{	
	if(trim(document.frmbuildermast.txt_name.value) == "")
	{
		ShowAlert('121','Builder Name');
		document.frmbuildermast.txt_name.focus();
		return;
	}
	if(trim(document.frmbuildermast.txt_address1.value) == "")
	{
		ShowAlert('121','Builder Address');
		document.frmbuildermast.txt_address1.focus();
		return;
	}
	if(trim(document.frmbuildermast.txt_city.value) == "")
	{
		ShowAlert('121','Builder city');
		document.frmbuildermast.txt_city.focus();
		return;
	}
	if(trim(document.frmbuildermast.txt_state.value) == "")
	{
		ShowAlert('121','Builder state');
		document.frmbuildermast.txt_state.focus(); 
		return;
	}
	if(trim(document.frmbuildermast.txt_zip.value) == "")
	{
		ShowAlert('121','Pincode');
		document.frmbuildermast.txt_zip.value="";
		document.frmbuildermast.txt_zip.focus();
		return;
	}
		
	if(trim(document.frmbuildermast.txt_contactperson.value)=="")
		{
		ShowAlert('121','Contact Person Name');
		document.frmbuildermast.txt_contactperson.focus();
		return;
		}
	if(trim(document.frmbuildermast.txt_desig1.value) == "")
		{
		ShowAlert('121','Contact Person Designation');
		document.frmbuildermast.txt_desig1.focus();
		return;
		}
	if(document.frmbuildermast.sel_blacklist.value=="Y")
	{
		if(document.frmbuildermast.txt_blacklistdate.value=="")
		{
			alert("Enter the Black Listed Date");
			document.frmbuildermast.txt_blacklistdate.value="";
			document.frmbuildermast.txt_blacklistdate.focus();
			return;
		}
	}
	if(document.frmbuildermast.org_code.value=="")
	{
		ShowAlert('121','Branch Name');
		document.frmbuildermast.org_code.focus();
		return;
	}
	if(document.frmbuildermast.txt_projectName.value=="")
	{
		ShowAlert('121','Project Name');
		document.frmbuildermast.txt_projectName.focus();
		return;
	}
	if(document.frmbuildermast.sel_blacklist.value=="")
	{
	document.frmbuildermast.sel_blacklist.value="N";
	}
	document.forms[0].cmdsave.disabled=true;
	document.frmbuildermast.hidBeanId.value="staticdata";
	document.frmbuildermast.hidBeanMethod.value="updateBuilderMasterData";
	document.frmbuildermast.hidBeanGetMethod.value="getBuilderMasterList";
	document.frmbuildermast.hidSourceUrl.value="/action/buildermaster.jsp";
	document.frmbuildermast.action=appURL+"controllerservlet";
	document.frmbuildermast.submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.frmbuildermast.action=appURL+"action/mainnav.jsp";
		document.frmbuildermast.submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.frmbuildermast.hidAction.value="Cancel";
		document.frmbuildermast.hidBeanId.value="staticdata";
		document.frmbuildermast.hidBeanGetMethod.value="getBuilderMasterList";
		document.frmbuildermast.hidSourceUrl.value="/action/buildermaster.jsp";		
		document.frmbuildermast.submit();
	}
}

function doNew() 
{
	ClearFields();
	document.frmbuildermast.hidAction.value="insert";
	document.frmbuildermast.hidsno.value="";
	document.frmbuildermast.sel_blacklist.value="N";
	document.all.t1.style.visibility="hidden";	
	document.all.t2.style.visibility="hidden";
   	enableButtons(true, true, false, false,true);
   	disablefields(false); 
}

function doEdit() 
{
   	document.frmbuildermast.hidAction.value="update"
	enableButtons(true, true, false, false, true);
	disablefields(false);
}
   


function callCalender(fname)
{
	var action  =document.frmbuildermast.hidAction.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,fname);
	}
}

function getdate()
{
	if(document.frmbuildermast.sel_blacklist.value=="Y")
	{
		document.all.t1.style.visibility="Visible";
		document.all.t2.style.visibility="Visible";	
		if(document.frmbuildermast.txt_blacklistdate.value=="01/01/1900")
			{
			document.frmbuildermast.txt_blacklistdate.value="";
			}	
	}
	else if(document.frmbuildermast.sel_blacklist.value=="N")
	{
		document.all.t1.style.visibility="hidden";	
		document.all.t2.style.visibility="hidden";			
	}
}

function callCalender()
{
	if(document.frmbuildermast.cmdedit.disabled==true)
	{
		showCal(appURL,'txt_blacklistdate');
	}
}

function callDesignation()
{
	var action=document.frmbuildermast.hidAction.value;
	if(document.frmbuildermast.cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/designationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getDesignationMasterList&strfrom=ValuerMaster";
		window.open(url,"",prop);
	}
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.frmbuildermast.cmdsave.disabled==false)
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
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.frmbuildermast.cmdsave.disabled==false )
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
	}
	
}