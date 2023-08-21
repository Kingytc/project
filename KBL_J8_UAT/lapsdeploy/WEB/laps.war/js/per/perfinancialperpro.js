function callOnload()
{	
	callEnableFields(true);
	callfillValues();
}

function callfillValues()
{
	for(var i=0;i<varApptype.length;i++)
	{
		document.forms[0].choprop_applnt[i].value=varApptype[i];
		if(varCharged[i].toUpperCase()=="Y")
		{
			document.forms[0].txtprop_charged[i].options.selectedIndex=1;
		}
		else if(varCharged[i].toUpperCase()=="N")
		{
			document.forms[0].txtprop_charged[i].options.selectedIndex=2;
		}
		else
		{
			document.forms[0].txtprop_charged[i].options.selectedIndex=0;
		}
		if(varAssetType[i].toUpperCase()!="")
			{
			document.forms[0].txtprop_assettype[i].value=varAssetType[i];
			}
		else
			{
			document.forms[0].txtprop_assettype[i].options.selectedIndex=0;
			}
		
		/*if(varAssetType[i].toUpperCase()=="M")
		{
			document.forms[0].txtprop_assettype[i].options.selectedIndex=1;
		}
		else if(varAssetType[i].toUpperCase()=="2")
		{
			document.forms[0].txtprop_assettype[i].options.selectedIndex=2;
		}
		else if(varAssetType[i].toUpperCase()=="3")
		{
			document.forms[0].txtprop_assettype[i].options.selectedIndex=3;
		}
		else if(varAssetType[i].toUpperCase()=="4")
		{
			document.forms[0].txtprop_assettype[i].options.selectedIndex=4;
		}
		else if(varAssetType[i].toUpperCase()=="5")
		{
			document.forms[0].txtprop_assettype[i].options.selectedIndex=5;
		}
		else
		{
			document.forms[0].txtprop_assettype[i].options.selectedIndex=0;
		}*/
		/*if(varLeasedOwned[i].toUpperCase()=="WHETHER LEASED")
		{
			document.forms[0].txtpro_whether_leased[i].options.selectedIndex=1;
		}*/
		if(varLeasedOwned[i].toUpperCase()=="0")
		{
			document.forms[0].txtpro_whether_leased[i].options.selectedIndex=1;
		}
		else if(varLeasedOwned[i].toUpperCase()=="1")
		{
			document.forms[0].txtpro_whether_leased[i].options.selectedIndex=2;
		}
		else
		{
			document.forms[0].txtpro_whether_leased[i].options.selectedIndex=0;
		}
		if(varchkClick[i].toUpperCase()=="Y")
		{
			document.forms[0].chkprop_iscoll[i].checked=true;
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
	if(document.forms[0].txtprop_desc[i].value=="")
	{
		ShowAlert('121','Address Details');
		document.forms[0].txtprop_desc[i].focus();
		return;
	}
		for(;i<12;++i)
		{
		var address=trimtxt(document.forms[0].txtprop_desc[i].value);
		  if(address!="")
		    {
		    	/*if((trimtxt(document.forms[0].txtprop_purchaseval[i].value)=="") || (trimtxt(document.forms[0].txtprop_purchaseval[i].value)=="0.00"))
					{
					ShowAlert('121',' purchase value');
					document.forms[0].txtprop_purchaseval[i].focus();
					return;
					}*/
					if((trimtxt(document.forms[0].txtprop_marketval[i].value)=="")||(trimtxt(document.forms[0].txtprop_marketval[i].value)=="0.00"))
					{
					ShowAlert('121',' Market value');
					document.forms[0].txtprop_marketval[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtprop_valuationdate[i].value)=="")
					{
					ShowAlert('121','Valuation Date');
					document.forms[0].txtprop_valuationdate[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtprop_valuationdoneby[i].value)=="")
					{
					ShowAlert('121','Valuation Field');
					document.forms[0].txtprop_valuationdoneby[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtpro_whether_leased[i].value)=="s")
					{
					ShowAlert('111',' Leaseholder Type');
					document.forms[0].txtpro_whether_leased[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].choprop_applnt[i].value)=="s1")
					{
					ShowAlert('111','Applicant type');
					document.forms[0].choprop_applnt[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtprop_charged[i].value)=="s2")
					{
					ShowAlert('111',' Charged');
					document.forms[0].txtprop_charged[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtprop_assettype[i].value)=="s3")
					{
					ShowAlert('111',' Asset Type');
					document.forms[0].txtprop_assettype[i].focus();
					return;
					}
					
			}
			else
			{
				
					if((trimtxt(document.forms[0].txtprop_purchaseval[i].value)!="")&&(trimtxt(document.forms[0].txtprop_purchaseval[i].value)!="0.00"))
					{
					ShowAlert('121','Address Details');
					document.forms[0].txtprop_desc[i].focus();
					return;
					}
					if((trimtxt(document.forms[0].txtprop_marketval[i].value)!="")&&(trimtxt(document.forms[0].txtprop_marketval[i].value)!="0.00"))
					{
					ShowAlert('121','Address Details');
					document.forms[0].txtprop_desc[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtprop_valuationdate[i].value)!="")
					{
					ShowAlert('121','Address Details');
					document.forms[0].txtprop_desc[i].focus();
					return;
					}
					
					if(trimtxt(document.forms[0].txtprop_valuationdoneby[i].value)!="")
					{
					ShowAlert('121','Address Details');
					document.forms[0].txtprop_desc[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtpro_whether_leased[i].value)!="s")
					{
					ShowAlert('121','Address Details');
					document.forms[0].txtprop_desc[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].choprop_applnt[i].value)!="s1")
					{
					ShowAlert('121','Address Details');
					document.forms[0].txtprop_desc[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtprop_charged[i].value)!="s2")
					{
					ShowAlert('121','Address Details');
					document.forms[0].txtprop_desc[i].focus();
					return;
					}
					if(trimtxt(document.forms[0].txtprop_assettype[i].value)!="s3")
					{
					ShowAlert('121','Address Details');
					document.forms[0].txtprop_desc[i].focus();
					return;
					}
				}
		   
		}
		
		
		
	varsubmit=callinapply();  
	if(varsubmit)
	{
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].hidBeanGetMethod.value="insertProperty";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].action=appURL+"action/perfinancialperpro.jsp";	
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
		document.forms[0].hidBeanGetMethod.value="getProperty";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].action=appURL+"action/perfinancialperpro.jsp";	
		document.forms[0].submit();
	}
}

function doEdit()
{
	document.forms[0].hideditflag.value="Y";
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
			disableCheckBox(false);
			callinapply();
			assignData();
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanGetMethod.value="insertProperty";
			document.forms[0].hidBeanId.value="perfinancial";
			document.forms[0].action=appURL+"action/perfinancialperpro.jsp";	
			document.forms[0].submit();
		}
	}
	else	
	{
		ShowAlert(158);
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

function checkValues(i)
{
	var varprop_desc=trimtxt(document.forms[0].txtprop_desc[i].value);
	var varprop_purchaseval=document.forms[0].txtprop_purchaseval[i].value;
	var varprop_marketval=document.forms[0].txtprop_marketval[i].value;
	var varprop_applnt=trimtxt(document.forms[0].choprop_applnt[i].value);
	if(varprop_desc=="")
	{
		ShowAlert('121','Property Description');
		document.forms[0].txtprop_desc[i].focus();
		return false;
	}
	else if(varprop_purchaseval=="0.00" || varprop_purchaseval=="")
	{
		ShowAlert('121','Purchase Value');
		document.forms[0].txtprop_purchaseval[i].focus();
		return false;
	}
	else if(varprop_marketval=="0.00" || varprop_marketval=="")
	{
		ShowAlert('121','Market Value');
		document.forms[0].txtprop_marketval[i].focus();
		return false;
	}
	else if(varprop_applnt=="")
	{
		ShowAlert('111','Applicant Type');
		document.forms[0].choprop_applnt[i].focus();
		return false;
	}	
}

function callinapply()
{
	var applyboolean=true;	
	for(var i=0;i<document.forms[0].txtprop_desc.length;i++)
	{
		if(applyboolean)
		{
			if(document.forms[0].chkprop_iscoll[i].checked==true)
			{
				document.forms[0].hidprop_iscoll[i].value="Y";
			}
			else
			{
				document.forms[0].hidprop_iscoll[i].value="n";
			}
			var varprop_desc=trimtxt(document.forms[0].txtprop_desc[i].value);
			var varprop_purchaseval=parseFloat(document.forms[0].txtprop_purchaseval[i].value);
			var varprop_marketval=parseFloat(document.forms[0].txtprop_marketval[i].value);
			var varprop_applnt=trimtxt(document.forms[0].choprop_applnt[i].value);			
		}
	}
	return applyboolean;	
}

function doHelp()     
{
  	var hlpvar = appURL+"phlp/loan_appretail_fin_persprop.htm";
  	var title = "PersonalProperties";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}
function callCalender(val)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		 showCal(appURL,val);
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

