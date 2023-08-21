function callBankAccounts()
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/perfinancialbnkacc.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callInvestment()
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanGetMethod.value="getInvestMent";
		document.forms[0].action=appURL+"action/perfinancialinvst.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callInsurancePolicy()
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanGetMethod.value="getPolicy";
		document.forms[0].action=appURL+"action/perfinancialinspol.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callPersonalProp()
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanGetMethod.value="getProperty";
		document.forms[0].action=appURL+"action/perfinancialperpro.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callLiabilities()
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanGetMethod.value="getLiability";
		document.forms[0].action=appURL+"action/perfinancialliab.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}

}

function getSelectedvalue(selectfield,hidname)
{
	document.forms[0].elements[hidname].value=document.forms[0].elements[selectfield][document.forms[0].elements[selectfield].selectedIndex].value;
}

function doEdit()
{	
	document.forms[0].hideditflag.value = "yes";
	document.forms[0].hidBeanId.value="perlifestyle";
	document.forms[0].hidBeanMethod.value = "getData";
	document.forms[0].action = appURL+"action/perlifestyle.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}


function doSave()
{
	document.forms[0].hidRecordflag.value=varRecordFlag;
	for(i=1;i<=8;i++)
	{
		if(document.forms[0].elements["hidselect"+i].value!="1")
		{
		document.forms[0].elements["hidselect"+i].value = "" ;
		}
	}
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="perlifestyle";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/perlifestyle.jsp";
		document.forms[0].submit();
		
}

function doCancel()
{
if(ConfirmMsg('102'))
{	
	 document.forms[0].action=appURL+"controllerservlet";
	 document.forms[0].hidBeanId.value="perlifestyle";
  	 document.forms[0].hidBeanMethod.value="getData";
	 document.forms[0].hidSourceUrl.value="/action/perlifestyle.jsp";
	 document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{	document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}

function callNetworth()
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanId.value="networth";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/networth.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function onloading()
	{	
	doAfterEdit();
	}

function callDisableControls(cmdEdit,cmdApply,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdapply.disabled=cmdApply;
	//document.forms[0].cmddel.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function doAfterEdit()
{
	if( editcheck == "yes" )
	{
		//if( editlockflag == "y" )
		{	disableFields(false);
			disableCommandButtons("edit");
		}
		/*else
		{	
		disableFields(true);
		ShowAlert(128);
		}*/
	}
	else
	{
		disableFields(true);
	}
}

function disableFields(flag)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=flag;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=flag;
		}
	}
}

function disableCommandButtons(val)
{
  	if(val=="edit")
  	{
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;
		 document.forms[0].cmdclose.disabled=true;
		 //document.forms[0].cmddelete.disabled=false;
  	}
}

function doHelp()     
{
	var hlpvar = appURL+"phlp/loan_appretail_fin_lifestyle.htm";
	var title = "LifeStyle";
	var prop = "scrollbars=yes,width=600,height=450";	
	prop = prop + ",left=50,top=150";
	window.open(hlpvar,title,prop);
}
function callCalender(name)
{
	
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}
