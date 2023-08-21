function callOnload()
{
	document.forms[0].selapptype.value=varApptype;
	callEnableFields(true);
}

function callDisableControls(cmdNew,cmdEdit,cmdApply,cmdCancel,cmdDelete,cmdClose)
{
	document.frmfininspol.cmdnew.disabled=cmdNew;
	document.frmfininspol.cmdedit.disabled=cmdEdit;
	document.frmfininspol.cmdsave.disabled=cmdApply;
	document.frmfininspol.cmddelete.disabled=cmdDelete;
	document.frmfininspol.cmdcancel.disabled=cmdCancel;
	document.frmfininspol.cmdclose.disabled=cmdClose;
}

function doSave()
{
	document.forms[0].hidRecordflag.value=varRecordFlag;
	if(trimtxt(document.forms[0].txtinsu_policyno.value)=="")
	{
		ShowAlert('121','Policy Number');
		document.forms[0].txtinsu_policyno.focus();
		return false;
	}
	else if(trimtxt(document.forms[0].txtinsu_matdate.value)=="")
	{
		ShowAlert('121','Maturity Date');
		document.forms[0].txtinsu_matdate.focus();
		return false;
	}
	else if(trimtxt(document.forms[0].txtinsu_prepaid.value)=="")
	{
		ShowAlert('121','Last Premium Paid upto');
		document.forms[0].txtinsu_prepaid.focus();
		return false;
	}
	else if(document.forms[0].txtinsu_surrenderval.value=="0.00" || document.forms[0].txtinsu_surrenderval.value=="")
	{
		ShowAlert('121','Surrender/Paidup Value');
		document.forms[0].txtinsu_surrenderval.focus();
		return false;
	}
	else if(trimtxt(document.forms[0].txtinsu_agencyname.value)=="")
	{
		ShowAlert('121','Insurance Company Name');
		document.forms[0].txtinsu_agencyname.focus();
		return false;
	}
	else if(trimtxt(document.forms[0].txtinsu_agencyphone.value)=="")
	{
		ShowAlert('121','Sum Assured');
		document.forms[0].txtinsu_agencyphone.focus();
		return false;
	}
	var len = document.forms[0].selapptype.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selapptype.options[i].selected==true)
		 {
			 document.forms[0].hid_choinsu_applnt.value = document.forms[0].selapptype.options[i].text; 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanGetMethod.value="getPolicy";
	document.forms[0].hidBeanMethod.value="insertPolicy";
	document.forms[0].hidBeanId.value="perfinancial";
	document.forms[0].hidSourceUrl.value="action/perfinancialinspol.jsp";
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
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getPolicy";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].action=appURL+"action/perfinancialinspol.jsp";	
		document.forms[0].submit();
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="perfinancial";
	document.forms[0].hidBeanGetMethod.value="getPolicy";
	document.forms[0].action=appURL+"action/perfinancialinspol.jsp";	
	document.forms[0].submit();
}

function doEdit()
{
	document.forms[0].hidAction.value="update";
	callEnableFields(false);
	document.forms[0].hideditflag.value="Y";
	callDisableControls(true,true,false,false,true,true);
}

function doNew()
{
	if(document.forms[0].selapptype.value!="")
	{
		document.forms[0].hidAction.value="insert";
		callEnableFields(false);
		document.forms[0].hideditflag.value="Y";
		callDisableControls(true,true,false,false,true,true);
	}
	else
	{
		ShowAlert('111','Applicant Type');
		document.forms[0].selapptype.focus();
		return;
	}
}

function doDelete()
{
		var con=ConfirmMsg('152');
		if(con)
		{
			var len = document.forms[0].selapptype.length;	
			for(i=0;i<len;i++)
			{
				 if(document.forms[0].selapptype.options[i].selected==true)
				 {
					 document.forms[0].hid_choinsu_applnt.value = document.forms[0].selapptype.options[i].text; 
					break;
				 }
			}
			document.forms[0].hidinsu_iscoll.disabled=false;
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanGetMethod.value="getPolicy";
			document.forms[0].hidBeanMethod.value="insertPolicy";
			document.forms[0].hidBeanId.value="perfinancial";
			document.forms[0].hidSourceUrl.value="action/perfinancialinspol.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
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
	if(document.forms[0].hideditflag.value=="Y")
	{
		 showCal(appURL,val);
	}
}

function SelectValues(val1,val2,val3,val4,val5,val6,val7,val8)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txtinsu_policyno.value=val2;
	document.forms[0].txtinsu_matdate.value=val3;
	document.forms[0].txtinsu_prepaid.value=val4;
	document.forms[0].txtinsu_surrenderval.value=val5;
	document.forms[0].txtinsu_agencyname.value=val6;
	document.forms[0].txtinsu_agencyphone.value=val7;
	document.forms[0].hidinsu_iscoll.value=val8;
	if(document.forms[0].btnenable.value=="Y")
	{
		callDisableControls(true,false,true,false,false,true);
	}
}
       