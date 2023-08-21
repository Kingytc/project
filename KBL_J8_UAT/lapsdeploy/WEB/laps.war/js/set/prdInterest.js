 function callonload()
 {
 	disableFields(true);
 	enableButtons(false, true, true, false); 	 
 } 
 
function setButtons()
{
	document.prdinterestfrm.cmdedit.disabled = false;
	document.prdinterestfrm.cmdsave.disabled = true;
	document.prdinterestfrm.cmdcancel.disabled = true;
	document.prdinterestfrm.cmdclose.disabled = false;
	disableAll();
}

function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function enableButtons(bool1, bool2, bool3, bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
}

function doEdit()
{
	document.forms[0].hidAction.value="INSERT";
	document.prdinterestfrm.hidAction.value="UPDATE";
	disableFields(false);
	enableButtons(true, false, false, true);
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].action=appURL+"action/prodinterest.jsp";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].submit();
	}
}

function checkRetirementAge(obj)
{	
	if(parseFloat(obj.value,10) > 100)
	{
		alert("Retirement Age cannot be greater than 100");
		obj.focus();
		obj.value = "";
		return false;
	}
}

function validatePer(obj)
{
	var str = obj.value;
	if( isNaN(str) )
	{
		alert("Enter valid Number");
		obj.value="";
		obj.focus();
		return false;
	}
	else if( parseFloat(str,10) > 100 )
	{
		ShowAlert(104);
		obj.focus();
		return false;
	}
	else
	{
		return true;
	}
}

function findTotal(fld)
{
	var flag = validatePer(fld);
	if(flag == true)
	{
		var val = fld.value;
		var nam = fld.name;
		var tot = 100 - eval(val);
		if( fld.name == 'prd_collweight')
		{
			document.prdinterestfrm.prd_liqweight.value=tot+".00";
		}
		else if( fld.name == 'prd_ligweight')
		{
			document.prdinterestfrm.prd_collweight.value=tot+".00";
		}
    }
}

function submitme()
{
	if(document.forms[0].prd_intrate.value == '')
		document.forms[0].prd_intrate.value = "0.00";
	if(document.forms[0].prd_addlint.value == '')
		document.forms[0].prd_addlint.value = "0.00";

	if(document.forms[0].prd_totalint.value == '')
		document.forms[0].prd_totalint.value =
			eval(document.forms[0].prd_addlint.value)+
		    eval(document.forms[0].prd_intrate.value);
	document.prdinterestfrm.prd_intrate.disabled = false;
	document.prdinterestfrm.submit();
}

function callOtherTab(url)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
	}
	else
	{
		if(url=="setproducts.jsp" || url=="produsedby.jsp" || url=="prodsanclimit.jsp")
		{
			document.forms[0].hidBeanGetMethod.value="getData";
		}
		if(url=="setprddoc.jsp")
		{
			document.forms[0].hidBeanGetMethod.value="getDocData";
		}
		if(url=="setprdworkflow.jsp")
		{
			document.forms[0].hidBeanGetMethod.value="getWorkflowData";
		}
		if(url=="setprdauth.jsp")
		{
			document.forms[0].hidBeanGetMethod.value = "getAuthorityData";
		}
		if(url=="setprdintterms.jsp")
		{
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].hidBeanGetMethod.value="getIntTermsData";
		}
		 if(url=="prodinterest.jsp")
		 {
			 document.forms[0].hidBeanGetMethod.value="getData";
		 }
		if(url=="prodprocesscharges.jsp")
		{
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].hidBeanGetMethod.value="";
		}
		if(url=="proddocumentcharges.jsp")
		{
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].hidBeanGetMethod.value="";
		}
		if(url=="prodMarginAmount.jsp")
		{
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanGetMethod.value="";
		}
		if(url=="prodrepaycapacity.jsp")
		{
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanGetMethod.value="getIncomeData";
		}
		if(url=="prodrentinsurcharges.jsp")
		{
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].hidBeanGetMethod.value="";
		}
		if(url=="prodjewelappraisalcharges.jsp")
		{
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].hidBeanGetMethod.value="";
		}
		if(url=="prodCollateralSecurity.jsp")
		{
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanGetMethod.value="getCollateralSecurity";
		}
		document.forms[0].action=appURL+"action/"+url;
		document.forms[0].submit();
	}
}

function doSave()
{
	var select=document.getElementById("multiselectId");

	var strAppend = "";
	for(i=0;i<select.options.length;i++)
	{
		if(select.options[i].selected==true)
		{
			strAppend = strAppend + select.options[i].value+"~";
		}
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidselrelation.value=strAppend;
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value="/action/prodinterest.jsp";
	document.prdinterestfrm.submit();
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/setsearchproducts.jsp";
		document.forms[0].submit();
	}
}
function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}