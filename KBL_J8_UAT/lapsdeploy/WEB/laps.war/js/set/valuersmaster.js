
function showCountry()
{
	if(document.forms[0].txt_city.value!=null && document.forms[0].txt_city.value!="")
		{
			document.forms[0].txt_country.value="INDIA";
		}
}
function callsupnam()
{
	if(strAppVar=="")
	{
		alert("Please select Appraiser or Valuer Details");
		return;
	}
	
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==true)
	{
		var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
		var url=appURL+"action/valuerslist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getValuerMasterList&hidAction=search&strfrom=ValuersMaster1&hidAppVal="+strAppVar;
		//var url=appURL+"action/valuerslist.jsp?strfrom=ValuersMaster&hidAppVal="+strAppVar;
		window.open(url,"",prop);
	}
}

function callDesignation1()
{
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/designationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getDesignationMasterList&strfrom=ValuerMaster";
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
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
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

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAppVal.value=strAppVar;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidAction.value="cancel";
		document.forms[0].hidBeanGetMethod.value="getValuerMasterList";
		document.forms[0].hidBeanMethod.value="getValuerMasterList";
		document.forms[0].hidSourceUrl.value="/action/valuersmaster.jsp";		
		document.forms[0].submit();
	}
}
function doNew() 
{
	if(strAppVar=="")
	{
		ShowAlert(111,'Valuer or Appraiser');
		return;
	}
	ClearFields();
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidsno.vakue="";
	document.forms[0].sel_blacklist.value="N";
	document.all.t1.style.visibility="hidden";	
	document.all.t2.style.visibility="hidden";
   	enableButtons(true, true, false, false, true);
   	disablefields(false); 
   	disableAppraiserDetails();
   	
   	if(document.forms[0].rad[2].checked==true)
	{
   		document.all.idsearch.style.display="inline";
	}
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update"
	enableButtons(true, true, false, false, true);
	disablefields(false);
	disableAppraiserDetails();
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function callCalender(pname)
{
	var action  =document.forms[0].hidAction.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,pname);
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

function callAppVal()
{
	if(document.forms[0].rad[0].checked==true)
	{
		strAppVar="V";
		ClearFields();
		enableButtons(false,true,true,true,false);
	}
	else if(document.forms[0].rad[1].checked==true)
	{
		strAppVar="A";
		ClearFields();
		enableButtons(false,true,true,true,false);
	}
	else if(document.forms[0].rad[2].checked==true)
	{
		strAppVar="J";
		ClearFields();
		enableButtons(false,true,true,true,false);
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
function disableAppraiserDetails()
{
	if(document.forms[0].rad[2].checked==true)
	{
		document.forms[0].txt_cbscustid.readOnly=true;
		document.forms[0].txt_name.readOnly=true;
		document.forms[0].txt_address1.readOnly=true;	
		document.forms[0].txt_address2.readOnly=true;
		document.forms[0].txt_address3.readOnly=true;
		document.forms[0].txt_city.readOnly=true;
		document.forms[0].txt_state.readOnly=true;
		document.forms[0].txt_zip.readOnly=true;	
		document.forms[0].txt_resphone.readOnly=true;
		document.forms[0].txt_resmobileno.readOnly=true;
		document.forms[0].txt_emailid.readOnly=true;
		document.forms[0].txt_offphone.readOnly=true;
		document.forms[0].txt_country.readOnly=true;
		
		document.all.idsearch1.style.display="none";
		document.all.idsearch2.style.display="none";
		document.all.idsearch3.style.display="none";
		document.all.idsearch.style.display="table-cell";
		
	}
	else
	{
		document.all.idsearch1.style.display="table-cell";
		document.all.idsearch2.style.display="table-cell";
		document.all.idsearch3.style.display="table-cell";
		document.all.idsearch.style.display="none";
	}
}

function showDistrict(rowindex)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		return  false;
	}
	if(document.forms[0].sel_state.value=="s")
	{
		alert('Select the State');
		return;
	}
	var val="ValuerMaster";
	var table=document.getElementById("tabid_locvalued");
	var rowCount=table.rows.length; 
	
	var varstat="";
	if(rowCount=="1")
		varstate = document.forms[0].sel_state.value;
	else
		varstate = document.forms[0].sel_state[rowindex-1].value;
	
	
 	var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val+"&rowCount="+rowCount+"&rowindex="+(rowindex-1);
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
}


function changeState(rowindex)
{
	var table=document.getElementById("tabid_locvalued");
	var rowCount=table.rows.length; 
	
	if(rowCount==1)
		document.forms[0].txt_district.value = "";
	else
		document.forms[0].txt_district[rowindex-1].value = "";
}

