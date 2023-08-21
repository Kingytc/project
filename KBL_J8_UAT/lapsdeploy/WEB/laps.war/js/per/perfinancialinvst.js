function callOnload()
{
	document.forms[0].selapptype.value=varApptype;
	callEnableFields(true);
}

function callDisableControls(cmdNew,cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdNew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdApply;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function doDelete()
{
	var con=ConfirmMsg('101');
	if(con)
	{
		var len = document.forms[0].selapptype.length;	
		for(i=0;i<len;i++)
		{
			if(document.forms[0].selapptype.options[i].selected==true)
		 	{
				document.forms[0].chostoc_applnt1.value = document.forms[0].selapptype.options[i].text; 
				break;
		 	}
		}
		document.forms[0].hidstoc_iscoll.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="insertInvestMent";
		document.forms[0].hidBeanGetMethod.value="getInvestMent";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].hidSourceUrl.value="action/perfinancialinvst.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doSave()
{
	document.forms[0].hidRecordflag.value=varRecordFlag;
	if(trimtxt(document.forms[0].txtstoc_desc.value)=="")
	{
		ShowAlert('121','Receipt No');
		document.forms[0].txtstoc_desc.focus();
		return;
	}
	if(trimtxt(document.forms[0].txt_issusing.value)=="")
	{
		ShowAlert('121','Issused By');
		document.forms[0].txt_issusing.focus();
		return;
	}
	if(trimtxt(document.forms[0].txtstoc_txt_DI.value)=="")
	{
		ShowAlert('121','Date of Issue');
		document.forms[0].txtstoc_txt_DI.focus();
		return;
	}
	if(trimtxt(document.forms[0].txtstoc_txt_DM.value)=="")
	{
		ShowAlert('121','Date of Maturity');
		document.forms[0].txtstoc_txt_DM.focus();
		return;
	}
	if(trimtxt(document.forms[0].txtstoc_amount.value)=="0.00" || trimtxt(document.forms[0].txtstoc_amount.value)=="")
	{
		ShowAlert('121','Amount Invested');
		document.forms[0].txtstoc_amount.focus();
		return;
	}
	if(trimtxt(document.forms[0].txtstoc_shareval.value)=="0.00" || trimtxt(document.forms[0].txtstoc_shareval.value)=="")
	{
		ShowAlert('121','Current Value');
		document.forms[0].txtstoc_shareval.focus();
		return;
	}
	if(trimtxt(document.forms[0].hidstoc_iscoll.value)=="s")
	{
		ShowAlert('121',' Collateral');
		document.forms[0].hidstoc_iscoll.focus();
		return;
	}
	
	var len = document.forms[0].selapptype.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selapptype.options[i].selected==true)
		 {
			 document.forms[0].chostoc_applnt1.value = document.forms[0].selapptype.options[i].text; 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanMethod.value="insertInvestMent";
	document.forms[0].hidBeanGetMethod.value="getInvestMent";
	document.forms[0].hidBeanId.value="perfinancial";
	document.forms[0].hidSourceUrl.value="action/perfinancialinvst.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function callEnableFields(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{		
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=one;	
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;	
		}
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=one;	
		}
	}
	document.forms[0].selapptype.disabled=false;
	
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/retailpge.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getInvestMent";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].action=appURL+"action/perfinancialinvst.jsp";	
		document.forms[0].submit();
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="perfinancial";
	document.forms[0].hidBeanGetMethod.value="getInvestMent";
	document.forms[0].action=appURL+"action/perfinancialinvst.jsp";	
	document.forms[0].submit();
}

function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	callEnableFields(false);
	document.forms[0].hidAction.value="update";
	callDisableControls(true,true,false,false,false,true);
}

function doNew()
{
	if(document.forms[0].selapptype.value!="")
	{
		document.forms[0].hideditflag.value="Y";
		callEnableFields(false);
		document.forms[0].hidAction.value="insert";
		callDisableControls(true,true,false,false,false,true);
	}
	else
	{
		ShowAlert('111','Applicant Type');
		document.forms[0].selapptype.focus();
		return;
	}
}


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

function callLifeStyle()
{	
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{	document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/perlifestyle.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
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

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}

function SelectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txtstoc_desc.value=val2;
	document.forms[0].txt_issusing.value=val3;
	document.forms[0].txtstoc_txt_DI.value=val4;
	document.forms[0].txtstoc_txt_DM.value=val5;
	document.forms[0].txtstoc_amount.value=val6;
	document.forms[0].txtstoc_shareval.value=val7;
	document.forms[0].hidstoc_iscoll.value=val8;
	if(document.forms[0].btnenable.value=="Y")
	{
		callDisableControls(true,false,true,false,false,true);
	}
}