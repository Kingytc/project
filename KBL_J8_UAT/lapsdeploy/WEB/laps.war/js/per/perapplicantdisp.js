function loanDetails()
{
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].action=appURL+"action/perloandetails.jsp";
	document.forms[0].submit();
}

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callEmployer()
{
	if(isNaN(document.forms[0].txtperapp_appid.value))
	{
		//alert("no permission");
	}else
	{
		document.forms[0].hidBeanGetMethod.value="getEmployer";
		document.forms[0].action=appURL+"action/peremployerdisp.jsp?applnt=P";
		document.forms[0].submit();
	}

}

function callProposedAsset()
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/perpropertydetails.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}

}


function callIncomeExpenses()
{

	if(isNaN(document.forms[0].txtperapp_appid.value))
	{
		//alert("no permission");
	}else
	{
		document.forms[0].hidBeanGetMethod.value="getIncome";
		document.forms[0].action=appURL+"action/perincexpensesdisp.jsp?applnt=P";
		document.forms[0].submit();
	}

}

function callClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
	id=document.forms[0].hidapplicantid.value;
	appname=document.forms[0].appname.value;
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp?id="+id+"&comapp_compname="+appname+"&hidPageType=EXI";
	
		document.forms[0].submit();
	}

}

function callCoAppGuarantor()
{
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
	document.forms[0].action=appURL+"action/percoappguarantor.jsp";
	document.forms[0].submit();
}
