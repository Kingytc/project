function callOnload()
{
	callEnableFields(true);
	callfillValues();	
}

function callfillValues()
{
	for(var i=0;i<varAcctype.length;i++)
	{
		if(varAcctype[i].toUpperCase()=="AI")
		{
			document.forms[0].chobank_accnttype[i].options.selectedIndex=1;
		}
		/*else if(varAcctype[i].toUpperCase()=="AD")
		{
			document.forms[0].chobank_accnttype[i].options.selectedIndex=2;
		}
		else if(varAcctype[i].toUpperCase()=="AC")
		{
			document.forms[0].chobank_accnttype[i].options.selectedIndex=3;
		}*/
		else if(varAcctype[i].toUpperCase()=="AS")
		{
			document.forms[0].chobank_accnttype[i].options.selectedIndex=2;
		}
		/*else if(varAcctype[i].toUpperCase()=="AM")
		{
			document.forms[0].chobank_accnttype[i].options.selectedIndex=5;
		}*/
		else 
		{
			document.forms[0].chobank_accnttype[i].options.selectedIndex=0;
		}
		document.forms[0].chobank_apptype[i].value=varApptype[i]; 
		if(varchkClick[i].toUpperCase()=="Y")
		{
			document.forms[0].chkbank_iscoll[i].checked=true;
		}
	}
}

function callDisableControls(cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdapply.disabled=cmdApply;
	document.forms[0].cmddel.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function doSave()
{
	var varsubmit;
	var i=0;
	assignData();
	
	if(trimtxt(document.forms[0].txtbank_name[i].value)=="")
	{
		ShowAlert('121','Bank Name');
		document.forms[0].txtbank_name[i].focus();
		return;
	}
	for(;i<8;i++)
		{
		if(trimtxt(document.forms[0].txtbank_name[i].value)!="")
			{
			if(trimtxt(document.forms[0].chobank_accnttype[i].value)=="s")
				{
				ShowAlert('111',' Type of Account');
				document.forms[0].chobank_accnttype[i].focus();
				return;
				}
			if(trimtxt(document.forms[0].txtbank_accntno[i].value)=="")
				{
				ShowAlert('121','Account no');
				document.forms[0].txtbank_accntno[i].focus();
				return;
				}
			if(trimtxt(document.forms[0].txtbank_balance[i].value)=="0.00" || trimtxt(document.forms[0].txtbank_balance[i].value)=="")
				{
				ShowAlert('121','Account Balance');
				document.forms[0].txtbank_balance[i].focus();
				return;
				}
			if(trimtxt(document.forms[0].chobank_apptype[i].value)=="s1")
				{
				ShowAlert('111',' Applicant Type');
				document.forms[0].chobank_apptype[i].focus();
				return;
				}
			}
		else
			{
			if(trimtxt(document.forms[0].txtbank_branchname[i].value)!="")
				{
				ShowAlert('121','Bank Name');
				document.forms[0].txtbank_name[i].focus();
				return;
				}
			if(document.forms[0].chobank_accnttype[i].value!="s")
				{
				ShowAlert('121','Bank Name');
				document.forms[0].txtbank_name[i].focus();
				return;
				}
			if(trimtxt(document.forms[0].txtbank_accntno[i].value)!="")
				{
				ShowAlert('121','Bank Name');
				document.forms[0].txtbank_name[i].focus();
				return;
				}
			if(trimtxt(document.forms[0].txtbank_balance[i].value)!="0.00" && trimtxt(document.forms[0].txtbank_balance[i].value)!="")
				{
				ShowAlert('121','Bank Name');
				document.forms[0].txtbank_name[i].focus();
				return;
				}
			if(trimtxt(document.forms[0].chobank_apptype[i].value)!="s1")
				{
				ShowAlert('121','Bank Name');
				document.forms[0].txtbank_name[i].focus();
				return;
				}
			
			}
		}
		varsubmit=callinapply();
		if(varsubmit)
		{
			document.forms[0].cmdapply.disabled=true;
			document.forms[0].hidAction.value="update";
			document.forms[0].hidBeanGetMethod.value="insertData";
			document.forms[0].hidBeanId.value="perfinancial";
			document.forms[0].action=appURL+"action/perfinancialbnkacc.jsp";	
			document.forms[0].submit();
		}
	
}

function callEnableFields(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{		
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=one;	
		}
		if(document.forms[0].elements[i].type=="textarea")
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
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].action=appURL+"action/perfinancialbnkacc.jsp";	
		document.forms[0].submit();
	}
}

function doEdit()
{
    assignData();
	document.forms[0].hidAction.value="update";
	callEnableFields(false);
	callDisableControls(true,false,false,false,true);
}

function doDelete()
{
	if(varRecordFlag=="Y")
		{
		var con=ConfirmMsg('152');
		if(con)
			{
			assignData();
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanGetMethod.value="insertData";
			document.forms[0].hidBeanId.value="perfinancial";
			document.forms[0].action=appURL+"action/perfinancialbnkacc.jsp";	
			document.forms[0].submit();
			}
		}
	else
		{
		ShowAlert(158);
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

function callLifeStyle()
{	
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{	
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/perlifestyle.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function checkValues(i)
{
	var varbnkname=trimtxt(document.forms[0].txtbank_name[i].value);
	var varaccnttype=trimtxt(document.forms[0].chobank_accnttype[i].value);
	var varaccntno=trimtxt(document.forms[0].txtbank_accntno[i].value);
	var varbalance=parseFloat(document.forms[0].txtbank_balance[i].value);
	var varapptype=trimtxt(document.forms[0].chobank_apptype[i].value);
	var varremarks=trimtxt(document.forms[0].remarks[i].value);
	
	if(varbnkname=="")
	{
		ShowAlert('121','Bank Name');
		document.forms[0].txtbank_name[i].focus();
		return false;		
	}
	else if(varaccnttype=="")
	{
		ShowAlert('111','Account Type');
		return false;
	}
	else if(varaccntno=="")
	{
		ShowAlert('121','Account No');
		document.forms[0].txtbank_accntno[i].focus();
		return false;
	}
	else if(varremarks=="")
	{
		ShowAlert('121','remarks');
		document.forms[0].remarks[i].focus();
		return false;
	}
	else if(varbalance=="0.00")
	{
		ShowAlert('121','Account Balance');
		document.forms[0].txtbank_balance[i].focus();
		return false;
	}
	else if(varapptype=="")
	{
		ShowAlert('111','Applicant Type');
		document.forms[0].chobank_apptype[i].focus();
		return false;
	}
}

function callinapply()
{
	var applyboolean=true;
	for(var i=0;i<document.forms[0].txtbank_name.length;i++)
	{
		if(applyboolean)
		{
			if(document.forms[0].chkbank_iscoll[i].checked==true)
			{
				document.forms[0].hidbank_iscoll[i].value="Y"
			}
			else
			{
				document.forms[0].hidbank_iscoll[i].value="n"
			}
			var varbnkname=trimtxt(document.forms[0].txtbank_name[i].value);
			var varaccnttype=trimtxt(document.forms[0].chobank_accnttype[i].value);
			var varaccntno=trimtxt(document.forms[0].txtbank_accntno[i].value);
			var varbalance=parseFloat(document.forms[0].txtbank_balance[i].value);
			var varapptype=trimtxt(document.forms[0].chobank_apptype[i].value);
			var varramarks=trimtxt(document.forms[0].remarks[i].value);
			if(varbnkname!="")
			{
				if(varbnkname=="" || varaccnttype=="" || varaccntno=="" || varbalance==0.0 || varapptype=="")
				{
					//applyboolean=checkValues(i);	
				}
			}			
		}
	}
	return applyboolean;	
}

function checkApplicant(i)
{

}

function callCalender(val)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		 showCal(appURL,val);
	}
}

function chkCollateral(obj0,obj1)
{
 	if ((obj0.value == "AI")||(obj0.value == "AS"))
	{		
		obj1.disabled = false;
	}
 	else
	{		
		obj1.disabled = false;
	}
}

function doHelp()     
{
  	var hlpvar = appURL+"phlp/loan_appretail_fin_bankacc.htm";
 	var title = "BankAccounts";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}