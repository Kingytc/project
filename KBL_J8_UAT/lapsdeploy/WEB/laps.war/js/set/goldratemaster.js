function callOnLoad()
{
	disableFields(true);
	disableButtons(false,true,true,false,false);
	document.forms[0].hidActiveFlag.value="Y";
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10)
{
	document.forms[0].hidSNo.value=val0;
	document.forms[0].hidModDate.value=val1;
	document.forms[0].txt_retglquick.value=val2;
	document.forms[0].txt_agriglquick.value=val3;
	document.forms[0].txt_retglclassic.value=val4;
	document.forms[0].txt_agriglclassic.value=val5;
	document.forms[0].txt_retglcomfort.value=val6;
	document.forms[0].txt_agriglcomfort.value=val7;
	document.forms[0].txt_retglstaff.value=val8;
	document.forms[0].txt_agriglstaff.value=val9;
	document.forms[0].txtarea_comments.value=val10;
	disableButtons(true,true,true,false,false);
}
function doNew() 
{
	disableFields(false);
	doClear();
	disableButtons(true, false, false, true, false);
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateGoldRateData";
	document.forms[0].hidBeanGetMethod.value="getGoldRateData";
	document.forms[0].hidSourceUrl.value="/action/goldratemaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=appURL+"action/goldratemaster.jsp";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getGoldRateData";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function doClear()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		//if(document.forms[0].elements[i].type=="text")
		//{
			//document.forms[0].elements[i].value="";		  
		//}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
	document.forms[0].txt_avgmargin.value="";
	document.forms[0].txt_latestmargin.value="";
	document.forms[0].txt_MaxNetWeight.value="";
	document.forms[0].txt_MaxGoldLoans.value="";
	document.forms[0].txt_recurexpmargin.value="";
	document.forms[0].txt_maragridevelop.value="";
	document.forms[0].txt_avgmargin_agri.value="";
	document.forms[0].txt_latestmargin_agri.value="";
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function disableButtons(cmdnew,cmdsave,cmdcancel,cmdclose,cmdhistory)
{
	document.forms[0].cmdnew.disabled=cmdnew;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmdclose.disabled=cmdclose;
	document.forms[0].cmdhistory.disabled=cmdhistory;
}
function callHistory()
{
	var url=appURL+"action/goldratemasterhistory.jsp?hidBeanId=staticdata&hidBeanGetMethod=getGoldRateData&hidActiveFlag=N"; 
	var title="Gold_Rate_Master_History";
	var prop = "scrollbars=yes,width=950,height=400,menubar=yes";
	var xpos = (screen.width) / 8;
	var ypos = (screen.height) / 6;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}