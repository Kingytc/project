function callOnload()
{
	callDisableControls(true,true,true,true,false);
	callEnableFields(true);
}

function callDisableControls(cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdapply.disabled=cmdApply;
	document.forms[0].cmddel.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function callEnableFields(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].readOnly=one;	
	}
}

function callliquidity()
{
	document.forms[0].hidBeanGetMethod.value="getRiskLiquidity";
	document.forms[0].action=appURL+"action/perriskanalysisliqdy.jsp";
	document.forms[0].submit();
}
function callcollateral()
{
	document.forms[0].hidBeanGetMethod.value="getRiskCollateral";
	document.forms[0].action=appURL+"action/perriskanalysiscoll.jsp";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}

function callMethod2()
{
	document.forms[0].action=appURL+"action/perriskanalysis.jsp";
	document.forms[0].submit();
}

function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
	
