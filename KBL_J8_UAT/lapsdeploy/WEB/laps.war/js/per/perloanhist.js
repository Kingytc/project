function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/retailpge.jsp";
		document.forms[0].submit();
	}
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


function callNew()
{

	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].action = appURL + "action/perloandetails.jsp?page=nr&appno=new";//new or renew 
	document.forms[0].submit();
}

function callOld()
{
	document.forms[0].radSearch[0].disabled = false;
	document.forms[0].radSearch[1].disabled = false;
}

function searchByAppno()
{
	document.forms[0].txtSearch.disabled = false;
	document.forms[0].txtSearch.maxLength = 20;
	displayChkBox(false)
}

function searchByPanno()
{
	document.forms[0].txtSearch.disabled = false;
	document.forms[0].txtSearch.maxLength = 50;
	displayChkBox(false)
}

function displayChkBox(bool)
{
	//document.forms[0].chkApp.disabled = bool;
	//document.forms[0].chkCoApp.disabled = bool;
	document.forms[0].chkColl.disabled = bool;
	document.forms[0].chkFin.disabled = bool;
	document.forms[0].cmdOK.disabled = bool;
	document.forms[0].cmdCancel.disabled = bool;
}

function callCancel()
{
	if(ConfirmMsg('102'))
	{
	document.forms[0].radLoan[0].checked = false;
	document.forms[0].radSearch[0].checked = false;
	document.forms[0].radSearch[1].checked = false;
	document.forms[0].radSearch[0].disabled = true;
	document.forms[0].radSearch[1].disabled = true;
	document.forms[0].txtSearch.value = "";
	document.forms[0].txtSearch.disabled = true;
	//document.forms[0].chkApp.checked = false;
	//document.forms[0].chkCoApp.checked = false;
	document.forms[0].chkColl.checked = false;
	document.forms[0].chkFin.checked = false;
	displayChkBox(true)
	}
}

function callApply(strPage)
{
	var strValue = "";
	if(document.forms[0].radSearch[0].checked == true)
	{
		strValue = "Application No";
	}
	else if(document.forms[0].radSearch[1].checked == true)
	{
		strValue = "Pan No.";
	}
	

	if(document.forms[0].txtSearch.value == "")
	{
		ShowAlert(121,strValue);
		return false;
	}
	else
	{
		checkVal(strPage);
		
	}
}

function allowEntry()
{
	var key = window.event.keyCode;
	if(key==34 || key == 39)
	{
		window.event.returnValue = false;
	}
}

function showMessage(strMessage,strSearch)
{
	var strValue = "";
	var strApp;
	var strCoApp;
	var strFin;
	var strColl;
	if(parent.document.forms[0].chkApp.checked == true)
	{
		strApp = 'Y';
	}
	else
	{
		strApp = 'N';
	}
	
	if(parent.document.forms[0].chkCoApp.checked == true)
	{
		strCoApp = 'Y'
	}
	else
	{
		strCoApp = 'N'
	}
	
	if(parent.document.forms[0].chkFin.checked == true)
	{
		strFin = 'Y';
	}
	else
	{
		strFin = 'N';
	}
	if(parent.document.forms[0].chkColl.checked == true)
	{
	    strColl = 'Y';
	}
	else
	{
		strColl = 'N';
	}
	var strVal = "strApp="+strApp+"&strCoApp="+strCoApp+"&strFin="+strFin+"&strColl="+strColl+"&appno="+strAppno+"&page=nr";
	if(strMessage == "false")
	{
		if(strSearch == "A")
		{
		strValue = "Application No";
		}
		else
		{
		strValue = "Pan No.";
		}
		ShowAlert(105,strValue);
	}
	
	else
	{
	  document.forms[0].action="perloandetails.jsp?"+strVal;
	  document.forms[0].target="mainFrame"
	  document.forms[0].submit();
	}
	
}

function checkVal(strPage)
{
	var strOption;
	var strCoApp;
	var strFin;
	var strColl;
	var strLoan;
	if(document.forms[0].radSearch[0].checked == true)
	{
		strOption = "A";
	}
	else if(document.forms[0].radSearch[1].checked == true)
	{
		strOption = "P";
	}

	if(document.forms[0].radLoan[0].checked == true)
	{
		strLoan = "Y";
	}
	else if(document.forms[0].radLoan[1].checked == true)
	{
		strLoan = "N";
	}
	var strText = document.forms[0].txtSearch.value;
	var strApp = "Y";
	//if(document.forms[0].txtSearch.chkCoApp

	if(strPage == "New")
	{
		document.all.hidframe.src=appURL+"action/perhidloanhist.jsp?radSearch="+strOption+"&txtSearch="+strText+"&hidBeanGetMethod=getSearchApplication&radLoan="+strLoan;
	}
	else
	{
		document.all.hidframe.src=appURL+"action/perloanhidrenew.jsp?radSearch="+strOption+"&txtSearch="+strText+"&hidBeanGetMethod=getSearchRenew&radLoan="+strLoan;
	}
}



function callClose()
{
	if(ConfirmMsg(100))
	{
	document.forms[0].action=appURL+"action/navigation.jsp";
	document.forms[0].submit();
	}
}

function callRenew()
{
	var strApp;
	var strCoApp;
	var strFin;
	var strColl;
	
	if(parent.document.forms[0].chkApp.checked == true)
	{
		strApp = 'Y';
	}
	else
	{
		strApp = 'N';
	}
	
	if(parent.document.forms[0].chkCoApp.checked == true)
	{
		strCoApp = 'Y'
	}
	else
	{
		strCoApp = 'N'
	}
	
	if(parent.document.forms[0].chkFin.checked == true)
	{
		strFin = 'Y';
	}
	else
	{
		strFin = 'N';
	}
	if(parent.document.forms[0].chkColl.checked == true)
	{
	    strColl = 'Y';
	}
	else
	{
		strColl = 'N';
	}
	//alert(strApp + strCoApp + strFin + strColl);
	var strVal = "strApp="+strApp+"&strCoApp="+strCoApp+"&strFin="+strFin+"&strColl="+strColl+"&page=nr";//new or renewal0 
	//alert(strVal);
	document.forms[0].target="mainFrame";

	document.forms[0].action = appURL+"action/perloandetails.jsp?"+strVal; 
	document.forms[0].submit();
}

function onRenewLoading()
{
	var strValue;
	if(parent.document.forms[0].radSearch[0].checked == true)
	{
		strValue = "Application No";
	}
	else if(parent.document.forms[0].radSearch[1].checked == true)
	{
		strValue = "Pan No.";
	}
	
	if(strValue != null)
	{
	if(arrSize < 1)
	{
		ShowAlert(105,strValue);
	}
	}
	
}
