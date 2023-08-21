function disableCommandButtons(new1,edit,save,cancel,del,close,comments)
{
	document.forms[0].cmdnew.disabled=new1;
  	document.forms[0].cmdedit.disabled=edit;
  	document.forms[0].cmdsave.disabled=save;
  	document.forms[0].cmdcancel.disabled=cancel;
  	document.forms[0].cmddelete.disabled=del;
 	document.forms[0].cmdclose.disabled=close;
 	document.forms[0].cmdcomments.disabled=comments;
}
function disableFields(flag)
{	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=flag;		  
		}
	}
}
function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,false,false,false);
	document.forms[0].txt_tot.readOnly = true;
	document.forms[0].hidAction.value="insert";
}
function doEdit()
{	
	
	document.forms[0].hidAction.value="update";
	document.forms[0].hideditflag.value = "Y";
	disableFields(false);
	if(varTenor<=1)
	{
		
		document.forms[0].txt_tot.readOnly=true;
		
	}
	else
	{
	for(var j=0;j<varTenor;j++)
	{
		document.forms[0].txt_tot[j].readOnly=true;		  
	}
	}
	disableCommandButtons(true,true,false,false,true,true,false);
	
}
function doSave()
{	
	//For Making Mandatory while saving the data
	if(trimtxt(document.forms[0].txt_income.value)=="")
	{
	ShowAlert('121','Income Particulars');
	document.forms[0].txt_income.focus();
	return;
	}

	
	//For Making Mandatory in loop while saving the data
	//Commented by Arsath(Instruction given by Prakash)
//	if(trimtxt(document.forms[0].txt_expense.value)=="")
//	{
//	ShowAlert('121','Expense Particulars');
//	document.forms[0].txt_expense.focus();
//	return;
//	}
//	for(var i=0;i<varTenor;i++)
//	{
//	if(trimtxt(document.forms[0].txt_inc[i].value)=="")
//	{
//	ShowAlert('121','Income Values');
//	document.forms[0].txt_inc[i].focus();
//	return;
//	}
//	if(trimtxt(document.forms[0].txt_exp[i].value)=="")
//	{
//	ShowAlert('121',' Expense Values');
//	document.forms[0].txt_exp[i].focus();
//	return;
//	}	
//	}
	//End of Mandatory
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="bankappfi";
	document.forms[0].hidBeanMethod.value="updateExsincotherthancrop";
	document.forms[0].hidBeanGetMethod.value="getExsincotherthancrop";	
	document.forms[0].hidSourceUrl.value="/action/agr_existingincomeotherthancrop.jsp";
	document.forms[0].submit();
	
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{	  
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanGetMethod.value="getExsincotherthancrop"
		document.forms[0].action=appURL+"action/agr_existingincomeotherthancrop.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{	
	var con=ConfirmMsg('100');
	if(con)
	{		
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanMethod.value="updateExsincotherthancrop";
		document.forms[0].hidBeanGetMethod.value="getExsincotherthancrop";	
		document.forms[0].hidSourceUrl.value="/action/agr_existingincomeotherthancrop.jsp";
		document.forms[0].submit();
	}
}

function selectValues(val1)
{
	var varpage = "iframe";
	var appno = auto_appno;
    if(val1!="")
	{	
		document.all.ifrm.src=appURL+"action/iframe_existingincexp.jsp?hidBeanId=bankappfi&appno="+appno+"&gridid="+val1+"&hidBeanGetMethod=getExsincotherthancrop&varpage="+varpage;
	}
    if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
    disableCommandButtons(true,false,true,false,false,false,false);
	}
   
}
function calIncExptot()
{
	if(varTenor<=1)
	{
		
		var varInc = parseFloat(document.forms[0].txt_inc.value);
		var varExp = parseFloat(document.forms[0].txt_exp.value);
		var varIncExpTot = 	roundVal(NanNumber(parseFloat(varInc) - parseFloat(varExp)));
		document.forms[0].txt_tot.value = varIncExpTot;
		document.forms[0].txt_tot.value = roundtxt(document.forms[0].txt_tot);		
		
	}
	else
	{
	for(var i=0;i<varTenor;i++)
	{
		
		var varInc = parseFloat(document.forms[0].txt_inc[i].value);
		var varExp = parseFloat(document.forms[0].txt_exp[i].value);
		var varIncExpTot = 	roundVal(NanNumber(parseFloat(varInc) - parseFloat(varExp)));
		document.forms[0].txt_tot[i].value = varIncExpTot;
		document.forms[0].txt_tot[i].value = roundtxt(document.forms[0].txt_tot[i]);
	}
	}
}
function calIncExptot1()
{
	for(var i=0;i<5;i++)
	{
		
		var varInc = parseFloat(document.forms[0].txt_inc[i].value);
		var varExp = parseFloat(document.forms[0].txt_exp[i].value);
		var varIncExpTot = 	roundVal(NanNumber(parseFloat(varInc) - parseFloat(varExp)));
		document.forms[0].txt_tot[i].value = varIncExpTot;
		document.forms[0].txt_tot[i].value = roundtxt(document.forms[0].txt_tot[i]);
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidDemoId=document.forms[0].hidDemoId.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidDemoId+"&hidCommentPage=existincrop&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}