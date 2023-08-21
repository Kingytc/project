function callonLoad()
{		
	disablefields(true);
	if(vartrapedit=="E")
		{
		enableButtons(false,false,true,true,false);	
		}
	else
		{
		enableButtons(false,true,true,true,false);
		}
	if(chkapprovedflag=="Y")
	{
		document.forms[0].chk_approved.checked=true;
		document.forms[0].hid_chk.value=chkapprovedflag;
	}
	else
	{
		document.forms[0].chk_approved.checked=false;
		document.forms[0].hid_chk.value=chkapprovedflag;
	}
	if(blacklist!="")
	{
		document.forms[0].sel_blacklist.value=blacklist;
	}
}

function callsupnam()
{
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==true)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/coopsocietymastlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getCoopSocietyMasterList&hidAction=search&strfrom=CoopSocietyMaster";
		window.open(url,"",prop);
	}
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
			{
			document.forms[0].elements[i].readOnly=one;
			}		  
		if(document.forms[0].elements[i].type=='select-one')
			{
			document.forms[0].elements[i].disabled=one;
			}
		if(document.forms[0].elements[i].type=="textarea")
			{
			document.forms[0].elements[i].readOnly=one;		  
			}	
		if(document.forms[0].elements[i].type=="checkbox")
			{
			document.forms[0].elements[i].disabled=one;
			}	
	}
	document.forms[0].txt_blacklistdate.readOnly=true;
	document.forms[0].txt_city.readOnly=true;
	document.forms[0].txt_state.readOnly=true;
}

function doSave()
{	
	if(trim(document.forms[0].txt_code.value) == "")
	{
		ShowAlert('121','Co-Op Housing Society code');
		document.forms[0].txt_code.focus();
		return;
	}
	if(trim(document.forms[0].txt_name.value) == "")
	{
		ShowAlert('121','Co-Op Housing Society Name');
		document.forms[0].txt_name.focus();
		return;
	}
	if(trim(document.forms[0].txt_address1.value) == "")
	{
		ShowAlert('121','Co-Op Housing Society Address');
		document.forms[0].txt_address1.focus();
		return;
	}
	if(trim(document.forms[0].txt_city.value) == "")
	{
		ShowAlert('121','Co-Op Housing Society city');
		document.forms[0].txt_city.focus();
		return;
	}
	if(trim(document.forms[0].txt_state.value) == "")
	{
		ShowAlert('121','Co-Op Housing Society state');
		document.forms[0].txt_state.focus();
		return;
	}
	if(trim(document.forms[0].txt_zip.value) == "")
	{
		ShowAlert('121','Pincode');
		document.forms[0].txt_zip.value="";
		document.forms[0].txt_zip.focus();
		return;
	}
	
	
	if(trim(document.forms[0].txt_contactperson.value)=="")
		{
		ShowAlert('121','Contact Person Name');
		document.forms[0].txt_contactperson.focus();
		return;
		}
	if(document.forms[0].sel_blacklist.value=="Y")
	{
		if(document.forms[0].txt_blacklistdate.value=="")
		{
			alert("Enter the Black Listed Date");
			document.forms[0].txt_blacklistdate.value="";
			document.forms[0].txt_blacklistdate.focus();
			return;
		}
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateCoopSocietyMasterData";
	document.forms[0].hidBeanGetMethod.value="getCoopSocietyMasterList";
	document.forms[0].hidSourceUrl.value="/action/co_opsocietymaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function showCountry()
{
	if(document.forms[0].txt_city.value!=null && document.forms[0].txt_city.value!="")
		{
			document.forms[0].txt_country.value="INDIA";
		}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidAction.value="cancel";
		document.forms[0].hidBeanGetMethod.value="getCoopSocietyMasterList";
		document.forms[0].hidBeanMethod.value="getCoopSocietyMasterList";
		document.forms[0].hidSourceUrl.value="/action/co_opsocietymaster.jsp";		
		document.forms[0].submit();
	}
}

function callCalender()
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,'txt_blacklistdate');
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidsno.value="";
	document.forms[0].sel_blacklist.value="N";
	document.all.t1.style.visibility="hidden";	
	document.all.t2.style.visibility="hidden";
   	enableButtons(true, true, false, false, true);
   	disablefields(false);   	
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update"
	enableButtons(true, true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function ongetvalue()
{
	if(document.forms[0].chk_approved.checked==true)
	{
		document.forms[0].hid_chk.value="Y";
	}
	else
	{
		document.forms[0].hid_chk.value="N";
	}
}

function getdate()
{
	if(document.forms[0].sel_blacklist.value=="Y")
	{
		document.all.t1.style.visibility="Visible";
		document.all.t2.style.visibility="Visible";	
		if(document.forms[0].txt_blacklistdate.value=="01/01/1900")
			{
			document.forms[0].txt_blacklistdate.value="";
			}
	}
	else if(document.forms[0].sel_blacklist.value=="N")
	{
		document.all.t1.style.visibility="hidden";	
		document.all.t2.style.visibility="hidden";			
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