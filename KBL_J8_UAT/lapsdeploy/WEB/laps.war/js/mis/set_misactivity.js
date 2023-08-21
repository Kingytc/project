function callOnLoad()
{
	disableFields(true);
	disableCommandButtons(false,true,true,true,true,false);
}
function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].hidAction.value="insert";
}
function doEdit()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].hidAction.value="update";
}
function doSave()
{
	if(document.forms[0].sel_MainActivity.value=="")
	{
		ShowAlert("111","Main Activity");
		document.forms[0].sel_MainActivity.focus();
		return;
	}
	if(document.forms[0].sel_SubActivity.value=="")
	{
		ShowAlert("111","Sub Activity");
		document.forms[0].sel_SubActivity.focus();
		return;
	}
	if(document.forms[0].sel_Purpose.value=="")
	{
		ShowAlert("111","Purpose");
		document.forms[0].sel_Purpose.focus();
		return;
	}
	if(document.forms[0].txt_ActivityCode.value=="")
	{
		ShowAlert("121","Activity Code");
		document.forms[0].txt_ActivityCode.focus();
		return;
	}
	if(document.forms[0].sel_BSRCode.value=="")
	{
		ShowAlert("111","BSR Code");
		document.forms[0].sel_BSRCode.focus();
		return;
	}
	if(document.forms[0].sel_LBRCode.value=="")
	{
		ShowAlert("111","LBR Code");
		document.forms[0].sel_LBRCode.focus();
		return;
	}
	
	if(document.forms[0].sel_Visibility.value=="")
	{
		ShowAlert("111","Visibility");
		document.forms[0].sel_Visibility.focus();
		return;
	}
	/*if(document.forms[0].sel_ratbasedon.value=="")
	{
		ShowAlert("111","Rating Based on");
		document.forms[0].sel_ratbasedon.focus();
		return;
	}*/
	if(document.forms[0].sel_busruleid.value=="")
	{
		ShowAlert("111","Type of Rating");
		document.forms[0].sel_busruleid.focus();
		return;
	}
	if(document.forms[0].sel_freecode6.value=="0")
	{
		ShowAlert(111,"Freecode 6");
		document.forms[0].sel_freecode6.focus();
		return;
	}
	if(document.forms[0].sel_freecode7.value=="")
	{
		ShowAlert(111,"Freecode 7");
		document.forms[0].sel_freecode7.focus();
		return;
	}
	if(document.forms[0].sel_freecode8.value=="")
	{
		ShowAlert(111,"Freecode 8");
		document.forms[0].sel_freecode8.focus();
		return;
	}
	if(document.forms[0].sel_cg.value=="")
	{
		ShowAlert(111,"Whether CGTMSE applicable ");
		document.forms[0].sel_cg.focus();
		return;
	}
	if(document.forms[0].allied_act_code.value=="")
	{
		ShowAlert(111,"Whether Allied Activity Code");
		document.forms[0].allied_act_code.focus();
		return;
	}
	document.forms[0].hidFreeCode7Desc.value=document.forms[0].sel_freecode7.options[document.forms[0].sel_freecode7.selectedIndex].text;
	document.forms[0].hidFreeCode8Desc.value=document.forms[0].sel_freecode8.options[document.forms[0].sel_freecode8.selectedIndex].text;
	
	document.forms[0].sel_DisplayScreen.value="";
	for(var i=0;i<document.forms[0].txt_displayscreen.options.length;i++)
	{
		if(document.forms[0].txt_displayscreen.options[i].selected)
		{
		
			if(document.forms[0].txt_displayscreen.options[i].value=="agriallied")
			{
				if(document.forms[0].allied_act_code.value=="Y")
				{
					alert("If displayscreen selected as agriallied then allied activity code should be NO ");
					document.forms[0].allied_act_code.value="";
					return;
				}
			}
			
			document.forms[0].sel_DisplayScreen.value=document.forms[0].sel_DisplayScreen.value+document.forms[0].txt_displayscreen.options[i].value+"@";
		}
		
	}
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidBeanGetMethod.value="updateMISActivityCodeDetails";
	document.forms[0].action=appURL+"action/set_misactivity.jsp";
	document.forms[0].submit();
}

function doDisplayScreenVal()
{
	var varDispScreenVal = document.forms[0].sel_DisplayScreen.value.split("@");
	
	for(var j=0;j<varDispScreenVal.length;j++)
	{
		for(var i=0;i<document.forms[0].txt_displayscreen.options.length;i++)
		{
			if(document.forms[0].txt_displayscreen.options[i].value==varDispScreenVal[j])
			{			
				document.forms[0].txt_displayscreen.options[i].selected=true;

				//For design issue in IE 8,9&10 by Guhan
				//document.forms[0].sel_social_infra.options[i].style.background="#C3C3C3";
				break;
			}		
		}
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=appURL+"action/set_misactivity.jsp";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
	    document.forms[0].hidAction.value ="delete";
	    document.forms[0].hidBeanId.value="mis";
		document.forms[0].hidBeanGetMethod.value="updateMISActivityCodeDetails";
		document.forms[0].action=appURL+"action/set_misactivity.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function disableFields(bool)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=bool;
		}	 
		if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].disabled=bool;
		}	 
	}
}
function disableCommandButtons(cmdnew,cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
	document.forms[0].cmdnew.disabled=cmdnew;
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	//document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdclose.disabled=cmdclose;
}
function onMainActChange()
{
	document.all.ifrme.src=appURL+"action/iframemainactcode.jsp?hidBeanGetMethod=getMainActCode&hidBeanId=mis&strMainActCode="
					+document.forms[0].sel_MainActivity.value;
	document.forms[0].sel_SubActivity.options[0].selected=true;
	generateActivityCode();
}
function generateActivityCode()
{
	var varPurpose=document.forms[0].sel_Purpose.value.split("_");
	var varPurposeCode=varPurpose[0];
	document.forms[0].txt_ActivityCode.value=document.forms[0].sel_MainActivity.value+document.forms[0].sel_SubActivity.value
				+varPurposeCode;
}
function callMISActvityHelp()
{
	var varQryString = appURL+"action/set_misactivityhelp.jsp?master=master";
	var title = "MIS_ActivityCodeHelp";
	var prop = "scrollbars=no,width=850,height=400";
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
}
function changeFreeCode7()
{
	if(document.forms[0].sel_freecode6.value == ""){
		document.forms[0].sel_freecode7.value == "";
		document.forms[0].sel_freecode8.value == "";
	}
	var strParentRefNo= document.forms[0].sel_freecode6.value;	
	
	document.all.ifrm.src=appURL+"action/iframeappfreecode7.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=1&strParentRefNo="+strParentRefNo;
	var varfreecode7 = document.forms[0].sel_freecode7.value;
	var varfreecode8 = document.forms[0].sel_freecode8.value;
	changeFreeCode8("");
}
function changeFreeCode8(Refno)
{	
	var strParentRefNo= Refno;
	if(strParentRefNo=="")
	{
		strParentRefNo="0";
	}	
	document.all.ifrm1.src=appURL+"action/iframeappfreecode8.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=2&strParentRefNo="+strParentRefNo;
}
function setText7()
{
	document.forms[0].hidFreeCode7FinVal.value=document.forms[0].sel_freecode7.options[document.forms[0].sel_freecode7.selectedIndex].text;
}
function setText8()
{
	document.forms[0].hidFreeCode8FinVal.value=document.forms[0].sel_freecode8.options[document.forms[0].sel_freecode8.selectedIndex].text;
}
function changeFreeCode7()
{
	if(document.forms[0].sel_freecode6.value == ""){
		document.forms[0].sel_freecode7.value == "";
		document.forms[0].sel_freecode8.value == "";
	}
	var strParentRefNo= document.forms[0].sel_freecode6.value;	
	
	document.all.ifrm.src=appURL+"action/iframeappfreecode7.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=1&strParentRefNo="+strParentRefNo;
	var varfreecode7 = document.forms[0].sel_freecode7.value;
	var varfreecode8 = document.forms[0].sel_freecode8.value;
	changeFreeCode8("");
}
function getFreeCode7(strFreeCode7,strFreeCode8)
{
	var freec7 = strFreeCode7;
	var freec8 = strFreeCode8;
	var strParentRefNo= document.forms[0].sel_freecode6.value;	
	document.all.ifrm.src=appURL+"action/iframeappfreecode7.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=1&strParentRefNo="+strParentRefNo+"&selFreeCodeVal="+freec7;
	var varfreecode7 = document.forms[0].sel_freecode7.value;
	var varfreecode8 = document.forms[0].sel_freecode8.value;
	if(varfreecode7 != "")
	{
		for(var i=0;i<document.forms[0].sel_freecode7.length;i++)
		{
			document.forms[0].sel_freecode7.options[i]=null;
		}	
		document.forms[0].sel_freecode7.options[0].value = "";
		document.forms[0].sel_freecode7.options[0].text = "--Select--";
	}
	getFreeCode8(freec8,freec7);
}
function getFreeCode8(strFreeCode8,strFreeCode7)
{
	var freec8 = strFreeCode8;
	
	var strParentRefNo= document.forms[0].sel_freecode7.value;

	if(strParentRefNo=="")
	{
		strParentRefNo=strFreeCode7;
	}
	
	document.all.ifrm1.src=appURL+"action/iframeappfreecode8.jsp?hidBeanId=FinacleBean&hidBeanGetMethod=getFreeCodeData&strLevel=2&strParentRefNo="+strParentRefNo+"&selFreeCodeVal="+freec8;
}
