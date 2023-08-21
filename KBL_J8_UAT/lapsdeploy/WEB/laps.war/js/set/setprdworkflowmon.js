function placeValues()
{
	for(var i=0;i<recsize;i++)
	{
		document.forms[0].prd_workid[i].value=workid[i];
		document.forms[0].prd_maxclass[i].value=maxclass[i];
		document.forms[0].prd_duration[i].value=duration[i];
		document.forms[0].wrk_flowname[i].value=workname[i];
	}
	for(var j=recsize;j<document.forms[0].prd_workid.length;j++)
	{
		document.forms[0].prd_workid[j].value="";
		document.forms[0].prd_maxclass[j].value="";
		document.forms[0].prd_duration[j].value="";
		document.forms[0].wrk_flowname[j].value="";
	}
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmdclose.disabled=false;
	disableFields(true);
}

function doEdit()
{
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	disableFields(false);
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		placeValues();
	}
}
function callWorkflowlist(idx)
{
	if(document.forms[0].cmdedit.disabled)
	{
		var prop = "scrollbars=no,width=500,height=400,top=50,left=50";
		var url=appUrl+"action/workflowlist.jsp?wrk_flowtype="+strWrkflowtype+"&idx="+idx;
		window.open(url,"Workflow",prop);
	}
}
function doDelete(idx)
{
	var key=window.event.keyCode;
	if( !(key==46 || key==8))
	{
		window.event.returnValue = false;
	}
	else if(document.forms[0].cmdedit.disabled)
	{
		document.forms[0].prd_workid[idx].value="";
		document.forms[0].prd_maxclass[idx].value="";
		document.forms[0].prd_duration[idx].value="";
		document.forms[0].wrk_flowname[idx].value="";
		window.event.returnValue = false;
	}
	else
	{
		window.event.returnValue = false;
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/setupnav.jsp";
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].hidBeanId.value="";
		document.forms[0].hidBeanMethod.value="";
		document.forms[0].submit();
	}
}

function doSave()
{
	for(var i=0;i<=7;i++)
		  document.forms[0].hid_prd_maxclass[i].value=document.forms[0].prd_maxclass[i].options[document.forms[0].prd_maxclass[i].selectedIndex].text;
	if(document.forms[0].prdCode.value=="")
	{
		alert("select a Limit To view its details");
		return;
	}
	for(var i=0;i<document.forms[0].wrk_flowname.length;i++)
	{
		if(document.forms[0].wrk_flowname[i].value!="")
		{
			if(document.forms[0].prd_maxclass[i].value=="" || eval(document.forms[0].prd_maxclass[i].value)<=0)
			{
				ShowAlert(106,"maximum class");
				document.forms[0].prd_maxclass[i].value="";
				document.forms[0].prd_maxclass[i].focus();
				return;
			}
			if(document.forms[0].prd_duration[i].value=="" || eval(document.forms[0].prd_duration[i].value)<=0)
			{
				ShowAlert(106,"duration");
				document.forms[0].prd_duration[i].value="";
				document.forms[0].prd_duration[i].focus();
				return;
			}
		}
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].wrk_flowtype.value=strWrkflowtype;
if(document.forms[0].prdCode.value!="S")
		{
	document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].hidBeanMethod.value="updateMONWorkflowData";
			document.forms[0].hidBeanGetMethod.value="getWorkflowmonitoring";
		}
		else
		{
			alert("Select the MONITORING module");
			return;
		}
document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidSourceUrl.value="/action/setprdworkflowcommon.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function callFlowtype(type)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.forms[0].wrk_flowtype.value=type;
	document.forms[0].hidBeanGetMethod.value="getWorkflowData";
	document.forms[0].action=appUrl+"action/setprdworkflow.jsp";
	document.forms[0].submit();
}

function checkFlowname(idx)
{
	if(document.forms[0].wrk_flowname[idx].value=="")
	{
		ShowAlert(109);
		document.forms[0].wrk_flowname[idx].focus();
	}
}

function disableFields(flag)
{
	for(var i=0;i<document.forms[0].prd_workid.length;i++)
	{
		document.forms[0].prd_workid[i].disabled=flag;
		document.forms[0].prd_maxclass[i].disabled=flag;
		document.forms[0].prd_duration[i].disabled=flag;
		document.forms[0].wrk_flowname[i].disabled=flag;
	}
}
function callOtherTab(url)
{
	if(!document.forms[0].cmdsave.disabled)
	 {
		 ShowAlert(103);
		 return;
	 }
	 if(url=="setproducts.jsp" || url=="produsedby.jsp" || url=="prodinterest.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getData";
	 }
	 if(url=="setprdauth.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getAuthorityData";
	 }
	 
	 if(url=="setprddoc.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getDocData";
	 }
	 document.forms[0].action=appUrl+"action/"+url;
	 document.forms[0].submit();
 }
 
 function menuOptionDivMouseDown (url)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.forms[0].hidBeanId.value="";
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}

function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		
		if(val=="existing")
		{
		ShowAlert(144);
		}
	}
}