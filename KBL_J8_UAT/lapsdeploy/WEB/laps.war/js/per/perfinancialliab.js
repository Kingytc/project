function callOnload()
{
	callEnableFields(true);
	document.forms[0].selapptype.value=varApptype;
	//document.forms[0].txtliab_secur.readOnly=true;
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}

function callDisableControls(cmdnew,cmdedit,cmdapply,cmdcancel,cmddel,cmdclose,cmdcomments)
{
	document.forms[0].cmdnew.disabled=cmdnew;
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmdsave.disabled=cmdapply;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmddelete.disabled=cmddel;
	document.forms[0].cmdclose.disabled=cmdclose;
	document.forms[0].cmdcomments.disabled=cmdcomments;
}

function doSave()
{	
	assignData();
	if(trimtxt(document.forms[0].txtliab_inst.value)=="")
	{
		ShowAlert('121','Name of the Institution');
		document.forms[0].txtliab_inst.focus();
		return;
	}
	else if(trimtxt(document.forms[0].choliab_loantype.value)=="")
	{
		ShowAlert('111','Loan Type');
		document.forms[0].choliab_loantype.focus();
		return false;
	}
	else if(document.forms[0].txtliab_loanamt.value=="0.00" || document.forms[0].txtliab_loanamt.value=="")
	{
		ShowAlert('121','Loan Amount(Rs.)');
		document.forms[0].txtliab_loanamt.focus();
		return false;
	}
	else if(document.forms[0].txtliab_balance.value=="0.00" || document.forms[0].txtliab_balance.value=="")
	{
		ShowAlert('121','Outstanding Balance(Rs.)');
		document.forms[0].txtliab_balance.focus();
		return false;
	}
	else if(document.forms[0].txtliab_minpayment.value=="0.00" || document.forms[0].txtliab_minpayment.value=="")
	{
		ShowAlert('121','Monthly/Min Payment (Rs.)');
		document.forms[0].txtliab_minpayment.focus();
		return false;
	}
	
	if(document.forms[0].checkourbank.checked==true)
	{
		document.forms[0].checkourbank.value="Y";
		
	}
	else
	{
		document.forms[0].checkourbank.value="N";
		
	}
	
	callDisableControls(true,true,true,true,true,false,true);
	
	document.forms[0].hidBeanId.value="perfinancial";
	document.forms[0].hidBeanMethod.value="insertLiability";
	document.forms[0].hidBeanGetMethod.value="getLiability";
	document.forms[0].action=appURL+"controllerservlet"
	document.forms[0].hidSourceUrl.value="/action/perfinancialliab.jsp";
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=one;	
		}
						
	}
	if(document.forms[0].checkourbank.checked==true)
	{
		document.forms[0].txtliab_inst.readOnly=true;
	
	}
	document.forms[0].selapptype.disabled=false;
	//document.forms[0].txtliab_secur.readOnly=true;  
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
		document.forms[0].hidBeanGetMethod.value="getLiability";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].action=appURL+"action/perfinancialliab.jsp";	
		document.forms[0].submit();
	}
}

function doNew()
{
	if(document.forms[0].selapptype.value!="")
	{
		document.forms[0].hidAction.value="insert";
	    document.forms[0].hideditflag.value="Y";
    	callEnableFields(false);
		callDisableControls(true,true,false,false,true,true,false);
	}
	else
	{
		ShowAlert('111','Applicant Type');
		document.forms[0].selapptype.focus();
		return;
	}
}

function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	callEnableFields(false);
	callDisableControls(true,true,false,false,true,true,false);
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
    assignData();
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="perfinancial";
	document.forms[0].hidBeanMethod.value="insertLiability";
	document.forms[0].hidBeanGetMethod.value="getLiability";
	document.forms[0].hidSourceUrl.value="/action/perfinancialliab.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="perfinancial";
	document.forms[0].hidBeanGetMethod.value="getLiability";
	document.forms[0].action=appURL+"action/perfinancialliab.jsp";	
	document.forms[0].submit();
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

function checkMinPay(i)
{
	if(eval(document.forms[0].txtliab_minpayment.value) >= eval(document.forms[0].txtliab_balance.value))
	{
		alert("Minimum Payment cannot be greater than balance");
		document.forms[0].txtliab_minpayment .value = "";
		return false;
	}
}

function selectvalues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,i,size)
{
    document.forms[0].hidsno.value=val1;
	document.forms[0].txtliab_inst.value=val2;
  	document.forms[0].choliab_loantype.value=val3;
    document.forms[0].txtliab_loanamt.value=val4;
    document.forms[0].txtliab_balance.value=val5;
    document.forms[0].txtliab_minpayment.value=val6;
    document.forms[0].txtliab_accountno.value=val7;
   	document.forms[0].txtliab_overduesince.value=val8;
   	if(size==1)
   	{
    	document.forms[0].txtliab_secur.value = document.forms[0].hidliab_secur.value;
    }
    else
    {
    	document.forms[0].txtliab_secur.value = document.forms[0].hidliab_secur[i].value;
    }
    if(val9=="Y")
    {
    	document.forms[0].checkourbank.value = val9;
    	document.forms[0].checkourbank.checked=true;
    }
    else
    {
    	document.forms[0].checkourbank.value = val9;
    	document.forms[0].checkourbank.checked=false;
    }
   	document.forms[0].txtliab_overdueamount.value = val10;
   	document.forms[0].txtliab_sancrefno.value = val11;
   	document.forms[0].txtliab_presentstatus.value = val12;
   	if(document.forms[0].btnenable.value=="Y")
   	{
 	  	callDisableControls(true,false,true,false,false,false,false);
   	}
}

function assignData()
{
	document.forms[0].hidAppType.value=document.forms[0].selapptype.options[document.forms[0].selapptype.selectedIndex].text;
	document.forms[0].hid_choliab_loantype.value=document.forms[0].choliab_loantype.options[document.forms[0].choliab_loantype.selectedIndex].text;
}
function doComments()
{
	var hidAppNo = document.forms[0].hidAppNo.value;
	var hidCommentPage = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=no,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage;
	window.open(url,"Comments",prop);
}