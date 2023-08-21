function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].cmdsave.disabled)
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
function doEdit()
{
	calldisable(false);
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdsave.disabled = false;
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].hidAction.value="update";
	if(varProductType=="pP")
	{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
	document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
	document.forms[0].hidSourceUrl.value="/action/persource_of_margin.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
	else 
	{
		if(varCostLoan==totalFundValue){
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
		document.forms[0].hidSourceUrl.value="/action/persource_of_margin.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
		}
		else
		{
			alert("Cost of Project amount("+varCostLoan+") and  Source of Margin amount("+totalFundValue+") are not equal");
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
		}
	}
}
function doDelete()
{
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
			document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
			document.forms[0].hidSourceUrl.value="/action/persource_of_margin.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	else
	{
		ShowAlert(158);
	}	
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
		document.forms[0].action=appURL+"action/persource_of_margin.jsp";	
		document.forms[0].submit();
	}
}
function onloading()
{
	totalFunds();
	calldisable(true);
	document.forms[0].cmdedit.disabled = false;
	document.forms[0].cmddelete.disabled = true;
	document.forms[0].cmdcancel.disabled = true;
	document.forms[0].cmdsave.disabled = true;
	//if(varstrFreeze=='Y')
	//{
		//document.forms[0].cmdedit.disabled=true;
		//document.forms[0].cmdsave.disabled=true;
	//}
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
function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}
function totalFunds(){
	var reqVal=0.0;
	var incuredVal=0.0;
	var savingsVal=0.0;
	var othersVal1=0.0;
	var othersVal2=0.0;
	var othersVal3=0.0;
	if(amtReq !=""){
		reqVal=amtReq;
	}else{
		reqVal=0.0;
	}
	if(document.forms[0].txt_costincured.value !=""){
		incuredVal=document.forms[0].txt_costincured.value;
	}else{
		incuredVal=0.0;
	}
	if(document.forms[0].txt_ownsavings.value !=""){
		savingsVal=document.forms[0].txt_ownsavings.value;
	}else{
		savingsVal=0.0;
	}
	if(document.forms[0].txt_others_value1.value !=""){
		othersVal1=document.forms[0].txt_others_value1.value;
	}else{
		othersVal1=0.0;
	}
	if(document.forms[0].txt_others_value2.value !=""){
		othersVal2=document.forms[0].txt_others_value2.value;
	}else{
		othersVal2=0.0;
	}
	if(document.forms[0].txt_others_value3.value !=""){
		othersVal3=document.forms[0].txt_others_value3.value;
	}else{
		othersVal3=0.0;
	}
	totalFundValue=parseFloat(reqVal) + parseFloat(incuredVal) + parseFloat(savingsVal) + parseFloat(othersVal1) + parseFloat(othersVal2) + parseFloat(othersVal3);
	document.forms[0].txt_total_fund.value=parseFloat(totalFundValue);	
}